Return-Path: <linux-fsdevel+bounces-11709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A0856518
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63CB292246
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8511A131E35;
	Thu, 15 Feb 2024 13:57:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a3.inai.de (a3.inai.de [88.198.85.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A2130AE4;
	Thu, 15 Feb 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.85.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005429; cv=none; b=A4iGb3EEZvPEac8Isddr3COrcKNh4xAsTNLtDXDBN6MqLNL2wsLJT77PwePgPmdPnu2y6THs3O5aLM6ctJqC+bz9HM0NyduVEqnFIx3z664hYLUL+frnZ7wfGJQd9UwC2D9kPNQaTSbEXBX2pfjLIgJWV7+WvI5LdD06EeROGsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005429; c=relaxed/simple;
	bh=Wh4bOwnargYdv/GvL9AV2H7QprWdShDQzFcxk36J9XM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=WrTipMxJvFuLj/nfEyPudxdtmZLbokLDa28icGeBUvrhl+OEtPmhbB0rWuRTkjx7L4PVpbbPMApSeQBCBf8mPdJV/RFdNsT1FGbyTIC4EODyfpDCoZr5F2wUdjnVGXm2V58Gruex2C7X7s9ILcvV3YqXhw89ZH+zGs+fMu9MPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=88.198.85.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 109B9586EEDC9; Thu, 15 Feb 2024 14:49:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 0E19960C1F6D1;
	Thu, 15 Feb 2024 14:49:05 +0100 (CET)
Date: Thu, 15 Feb 2024 14:49:05 +0100 (CET)
From: Jan Engelhardt <jengelh@inai.de>
To: linux-fsdevel@vger.kernel.org
cc: linux-man@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>
Subject: sendfile(2) erroneously yields EINVAL on too large counts
Message-ID: <38nr2286-1o9q-0004-2323-799587773o15@vanv.qr>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


Observed:
The following program below leads to sendfile returning -1 and setting 
errno=EINVAL.

Expected:
Return 0.

System: Linux 6.7.4 amd64 glibc-2.39

Rationale:

As per man-pages 6.60's sendfile.2 page:

       EINVAL Descriptor is not valid or locked, or an mmap(2)-like 
              operation is not available for in_fd, or count is 
              negative.

(Invalid descriptors should yield EBADF instead, I think.)
mmap is probably functional, since the testcase works if write() calls 
are removed.
count is not negative.

It appears that there may be a `src offset + count > SSIZE_MAX || dst offset +
count > SSIZE_MAX` check in the kernel somewhere, which sounds an awful lot
like the documented EOVERFLOW behavior:

       EOVERFLOW
              count is too large, the operation would result in exceeding the maximum size of ei‐
              ther the input file or the output file.

but the reported error is EINVAL rather than EOVERFLOW. Moreover, the (actual) result
from this testcase does not go above a few bytes anyhow, so should not signal
an overflow anyway.

#define _GNU_SOURCE 1
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/sendfile.h>
int main(int argc, char **argv)
{
        int src = open(".", O_RDWR | O_TMPFILE, 0666);
        write(src, "1234", 4);
        int dst = open(".", O_RDWR | O_TMPFILE, 0666);
        write(src, "1234", 4);
        ssize_t ret = sendfile(dst, src, NULL, SSIZE_MAX);
        printf("%ld\n", (long)ret);
        if (ret < 0)
                printf("%s\n", strerror(errno));
        return 0;
}

As it stands, a sendfile() user just wanting to shovel src to dst
cannot just "fire-and-forget" but has to compute a suitable count 
beforehand.
Is this really what we want?

