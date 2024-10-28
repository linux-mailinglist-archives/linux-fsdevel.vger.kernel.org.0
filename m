Return-Path: <linux-fsdevel+bounces-33041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826379B28F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 08:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275511C213A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 07:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCBB1DF24C;
	Mon, 28 Oct 2024 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AzhcYC6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115531DDC2F;
	Mon, 28 Oct 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100756; cv=none; b=tHRg3vyg5vVQkVemwT3W+bn9ZD+ULkK+7CxZ7Qg81ZLCI9/X/pkP9EOnBRxZz87QbcnF8jwh6dV9+WN+2zUTOaL0ZRqZwCdYGqClLO987EdjRlvH8CnjPRTzHLFmD8M3hG+tZrW/ei/urzd5Y5m7MPv+CxZWPjegnh5UaAIIM2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100756; c=relaxed/simple;
	bh=b8rN5jukIB89Ture5JcwzyK+DYVFdzxbru/AhKTctKM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=U20tww0mmdFiOHMuidhvcgBLJZZO68r8So1GB60WCUZlXZBNEVw9n9qu/NHowaOQ7c9RLDnLinc2n3PsRC1E1SRr17RxxTGZ157CQghqUsBtnTYQMjKEDYsrp2TXXx7EprC8mqw4G6GUahNWZgYXtyZz+/fH05rujafWujWZAM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AzhcYC6P; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730100744; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	bh=MaLmEPnvSmkHSWZfd0+NYCm/fmpEXYLkvKtg3wuFR20=;
	b=AzhcYC6PUpmW5YTh92dtOzz89U3YSCtstrAZpxt5574Q9GXtYZ+BP3WwMPtOaF5QoyZyr3FwLkAefG3yXHTqBQP1w1EExDFVsXEJZKgpjNMhEKXswZpkYHbiF5bJO+Jh+H8ce2eAL7g326YrL0en8v1OdOuYiiJVrul+6pxGDKc=
Received: from 30.221.148.132(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WI0h6S9_1730100742 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 15:32:23 +0800
Message-ID: <0365d4f7-29b7-45be-956f-57555d1b1648@linux.alibaba.com>
Date: Mon, 28 Oct 2024 15:32:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 hliang@linux.alibaba.com
From: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: fuse: auto_inval_data in writethrough mode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi FUSE folks,

I'd like to share and discuss an issue of fuse's auto_inval_data feature
in writethrough mode.

auto_inval_data is introduced since v3.6 commit
eed2179efe1aac145bf6d54b925b750976380fa6 ("fuse: invalidate inode
mapping if mtime changes"), which invalidates the page cache
automatically when a changed mtime timestamp is detected.  This is used
to help the cache consistency when the fuse file could be modified by
bypass, e.g. the backing file is modified directly through the backing
filesystem (e.g. the backing ext4) rather than fuse mountpoint.  For
example, when the file data is modified not through FUSE filesystem, the
mtime of the file will be changed; when the FUSE filesystem is doing a
file operation that relying on the latest attribute, it will update the
file attribute (calling fuse_update_attributes()) and (in some
conditions) send a FUSE_GETATTR to server to refresh the cached
attribute.  When the FUSE_GETATTR is replied, fuse client will find that
the latest mtime is different with the one cached in kernel, which is a
hint that the file data has been modified without kernel noticing this.
And then the fuse client will invalidate the whole address space, so
that the following data accessing will re-initiate FUSE_READ request to
fetch latest data from fuse server.

We noticed an interesting phenomenon when auto_inval_data works in
writethrough mode.  In writethrough mode, the local cached mtime (in
kernel) is not trusted, instead the fuse server is the only one trusted
to maintain mtime (see commit b36c31ba95f0fe0a03c727300d9c4c54438a5636
("fuse: don't update file times")).  Thus a generic write(2) routine in
writethrough mode won't update the local cached mtime in kernel
(inode->i_mtime).  When processing FUSE_WRITE requests, the fuse server
will update file's mtime.  Assuming there's no modification to the file
from other than the fuse client, a later file access to the fuse file
will found a new mtime (retrieved from fuse server) and auto_inval_data
is triggered.

In above example, the file is modified only from fuse filesystem, but an
*extra* redundant invalidation is always required when doing a read
following a write.

I'm not sure if this is a known issue or not, neither if it's a
deliberate design, or actually we could optimize this (if there's any
good solution to it).


-- 
Thanks,
Jingbo

