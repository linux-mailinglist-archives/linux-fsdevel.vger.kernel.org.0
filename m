Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE803326D69
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 15:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhB0OiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 09:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhB0OiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 09:38:16 -0500
X-Greylist: delayed 565 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 27 Feb 2021 06:37:26 PST
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FB6C06174A
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 06:37:26 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1614436079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bsDSw9BgjJ/C6NPrb4yEztvaawRb3eDI47Izv+gaBJ4=;
        b=Lz4U39A2gmtURI8ssmrLHnv0M51YbbVpxb9SugJ/HglgjtMDakVyBreY6NSR2sjZSWpFDc
        cFnDgEPYUmZLJ0KCJEBKP8zt2XfRTOrCrQUKIMUjum70ryKMLeDFxhhlXDWrmMxDX9C4gN
        aeaWT02Q/+3VoF6olc1DIczrke+m30JPaUwyb+yOUY+sI+PmoW6e3mo04xp4kyjms1Zr47
        s5t3SJU3+Oac27PFsN7/GvfOb00mF/7VakrL0lzi3JtKdvagfP4WhMYnIAKLVna+oS3sM2
        jOPePitAZgwFYUSF9h4Hld8U08zxd8ix7uKJKrft6ECQJaQAhdql2Sxy5poa3A==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Feb 2021 09:27:57 -0500
Message-Id: <C9KDTRDMTBR4.2JFWCA79LXA9X@taiga>
Subject: openat, mkdirat, and TOCTOU for directory creation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     <linux-fsdevel@vger.kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hiya! I'm looking into the mkdirat and openat syscalls, and I noticed
that there's no means of implementing TOCTOU (time-of-check to
time-of-use, a technique for preventing race conditions) on directory
creation.

To create a directory and obtain a dirfd for it, you have to (1)
mkdirat, then (2) openat with O_DIRECTORY, and if the directory is
removed in between, the latter will fail.

One possibly straightforward solution is to support openat with the
O_DIRECTORY and O_CREAT flags specified.

The present behavior of this flag combination is to create a file and
return ENOTDIR. The appropriate behavior is probably to create a
directory as proposed, or, at a minimum, to return EINVAL and not create
the file.
