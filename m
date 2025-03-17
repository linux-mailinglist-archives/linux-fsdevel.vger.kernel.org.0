Return-Path: <linux-fsdevel+bounces-44196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C3EA64C99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 12:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6557A89E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A905236A72;
	Mon, 17 Mar 2025 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RY+zgO+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507121A436;
	Mon, 17 Mar 2025 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210928; cv=none; b=FOKHw9pRV7g/5FvaV8kt+GbOp0o3E5irbV0cf729qNFODXF8C0c9euHM5xFnJCZVaFBHxIeXyNqLx+rgP2aQWfbXO4RRQ7HdSsp/lqZwPcD4sN1yLdMrvUYA8rRY/PfCVORDXgZSGA1oPTXOqhVq4j5NO0wq3rf+v1JM/mKAowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210928; c=relaxed/simple;
	bh=FC4O9tm3YFWce731qeTdXX80qYH/Cyc/IrhzkKcagGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MxQNKkSI12xjLYpHdw/7hYsTsF9JxupagwPmap08OmPX4v3iD71kK2hZNrt9embZZtRql3VM3Duf/qn2gRQnVfZ+Xf6rcOWsjOg0Sf2C0J8ro7M/z3lU2Di67xB5CB5NvpMKCYYAoBWR9M6XcHrqVTwWjVGKfx4RQjBTbpcCZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RY+zgO+X; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0lmpLddf6AyAGpTdvDFL9bsut9x3XseQ5VFnbQYT/CY=; b=RY+zgO+XCGR4mz2jedAmx2SVhi
	RZPi/vHqxTTLtZ/FW9XjOpZX6V/HLhq8REsT0IbaZIlUyt51sPS3jPjW4BC8qeeOSa+OcOVC0cJLL
	cUaY4UfBU/kmeEV0XkqSsh7TV7LKMT2ruZhb+xOz6Xtc5A2VaFY+g/4nUBXJxhbYRyZE8ZklKmxAi
	pw3KR7qXTa/dCAHVkmRjW+L8UyaCggQAMPAvInvWhLcvHVnxaWADAamakvSV+KIXivC7+n8hbYpRH
	15ScAHqs5FL+H/ZnB29I4UMybXlBCA1wrWJaciXIg5jvV394yeZRiSoH2bpLYmoeA2XVTUYk4ldGu
	gxaqWcgA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tu8dy-002CXJ-6A; Mon, 17 Mar 2025 12:28:30 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Laura Promberger <laura.promberger@cern.ch>, Bernd Schubert
 <bschubert@ddn.com>,  Dave Chinner <david@fromorbit.com>,  Matt Harvey
 <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation
 behaviour
In-Reply-To: <CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
	(Miklos Szeredi's message of "Mon, 10 Mar 2025 17:42:53 +0100")
References: <20250226091451.11899-1-luis@igalia.com>
	<87msdwrh72.fsf@igalia.com>
	<CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
Date: Mon, 17 Mar 2025 11:28:29 +0000
Message-ID: <875xk7zyjm.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

[ adding Laura to CC, something I should have done before ]

On Mon, Mar 10 2025, Miklos Szeredi wrote:

> On Fri, 7 Mar 2025 at 16:31, Luis Henriques <luis@igalia.com> wrote:
>
>> Any further feedback on this patch, or is it already OK for being merged?
>
> The patch looks okay.  I have ideas about improving the name, but that ca=
n wait.
>
> What I think is still needed is an actual use case with performance numbe=
rs.

As requested, I've run some tests on CVMFS using this kernel patch[1].
For reference, I'm also sharing the changes I've done to libfuse[2] and
CVMFS[3] in order to use this new FUSE operation.  The changes to these
two repositories are in a branch named 'wip-notify-inc-epoch'.

As for the details, basically what I've done was to hack the CVMFS loop in
FuseInvalidator::MainInvalidator() so that it would do a single call to
the libfuse operation fuse_lowlevel_notify_increment_epoch() instead of
cycling through the inodes list.  The CVMFS patch is ugly, it just
short-circuiting the loop, but I didn't want to spend any more time with
it at this stage.  The real patch will be slightly more complex in order
to deal with both approaches, in case the NOTIFY_INC_EPOCH isn't
available.

Anyway, my test environment was a small VM, where I have two scenarios: a
small file-system with just a few inodes, and a larger one with around
8000 inodes.  The test approach was to simply mount the filesystem, load
the caches with 'find /mnt' and force a flush using the cvmfs_swissknife
tool, with the 'ingest' command.

[ Disclosure: my test environment actually uses a fork of upstream cvmfs,
  but for the purposes of these tests that shouldn't really make any
  difference. ]

The numbers in the table below represent the average time (tests were run
100 times) it takes to run the MainInvalidator() function.  As expected,
using the NOTIFY_INC_EPOCH is much faster, as it's a single operation, a
single call into FUSE.  Using the NOTIFY_INVAL_* is much more expensive --
it requires calling into the kernel several times, depending on the number
of inodes on the list.

|------------------+------------------+----------------|
|                  | small filesystem | "big" fs       |
|                  | (~20 inodes)     | (~8000 inodes) |
|------------------+------------------+----------------|
| NOTIFY_INVAL_*   | 330 us           | 4300 us        |
| NOTIFY_INC_EPOCH | 40 us            | 45 us          |
|------------------+------------------+----------------|

Hopefully these results help answering Miklos questions regarding the
cvmfs use-case.

[1] https://lore.kernel.org/all/20250226091451.11899-1-luis@igalia.com/
[2] https://github.com/luis-henrix/libfuse
[3] https://github.com/luis-henrix/cvmfs

Cheers,
--=20
Lu=C3=ADs

