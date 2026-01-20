Return-Path: <linux-fsdevel+bounces-74564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEDAD3BDD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 04:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6674340D94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 03:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3E314B83;
	Tue, 20 Jan 2026 03:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vlFNnZ2i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B7D314B62;
	Tue, 20 Jan 2026 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768878475; cv=none; b=E/iTuSNBGgZS0nhHtsMrFNjG4x6YdZNFkRLlhBq0WtilJdOgxp6TrdukgJpWdrLbgTidQl3zPPKTcnW5eZTkJEfYt++4SimpKrhKB/Xvznl1CIdcMSXbv3VAX5fqpUNCH4x+4q07MS/Wg9+ZPuIdlginDnoABHmBsnsg1w44W4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768878475; c=relaxed/simple;
	bh=zhr5f0TcEfzh4OmxNMTboNZtg4+pOssRY//ARHCKqOw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hTeSWnQ6WCDVXqfQ4xYc32DFViFbXpuX+Dmz5Gahy8Vv5o8tcYen6ij4Ubaz3mJstbJoxukQS9kREZ9+HxiQvy5ZSeEuV+XiJXCSeCYBN+PvD6MIXNERFv6Fd2E1duRcBZ2/RQYjG85pVw52/jqEmj9jo+aCmLS+23ccsp7wTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vlFNnZ2i; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768878469; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Cix8RfjAm/j7o5j7yv9VEqavN9i3fefTuACkIfVQRNA=;
	b=vlFNnZ2irVpl+R8rmS3u4xG1iZEd8QPW5zT/9sVkJBnX8Pjb52315+hnqReXZxOoyDTKfVJOUSD5CjL7jAdswzrwtmxLiGYtp0v64Qo6C+VBOYOO81IrCn1Y2ssmnyDEWqwoYJpC4FJMQKNqaLu7jstHfocqaonJtllQw/B75pY=
Received: from 30.221.131.31(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxSfb8._1768878468 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Jan 2026 11:07:49 +0800
Message-ID: <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
Date: Tue, 20 Jan 2026 11:07:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, oliver.yang@linux.alibaba.com
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
In-Reply-To: <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Christoph,

Sorry I didn't phrase things clearly earlier, but I'd still
like to explain the whole idea, as this feature is clearly
useful for containerization. I hope we can reach agreement
on the page cache sharing feature: Christian agreed on this
feature (and I hope still):

https://lore.kernel.org/linux-fsdevel/20260112-begreifbar-hasten-da396ac2759b@brauner

First, let's separate this feature from mounting in user
namespaces (i.e., unprivileged mounts), because this feature
is designed specifically for privileged mounts.

The EROFS page cache sharing feature stems from a current
limitation in the page cache: a file-based folio cannot be
shared across different inode mappings (or the different
page index within the same mapping; If this limitation
were resolved, we could implement a finer-grained page
cache sharing mechanism at the folio level). As you may
know, this patchset dates back to 2023, and as of 2026; I
still see no indication that the page cache infra will
change.

So that let's face the reality: this feature introduces
on-disk xattrs called "fingerprints." --- Since they're
just xattrs, the EROFS on-disk format remains unchanged.

A new compat feature bit in the superblock indicates
whether an EROFS image contains such xattrs.

=====
In short: no on-disk format changes are required for
page cache sharing -- only xattrs attached to inodes
in the EROFS image.

Even if finer-grained page cache sharing is implemented
many many years later, existing images will remain
compatible, as we can simply ignore those xattrs.
=====

At runtime, the feature is explicitly enabled via a new
mount option: `inode_share`, which is intended only for
privileged mounters. A `domain_id` must also be specified
to define a trusted domain. This means:

  - For regular EROFS mounts (without `inode_share`;
    default), no page cache sharing happens for those
    images;

  - For mounts with `inode_share`, page cache sharing is
    allowed only among mounts with the same `domain_id`.

The `domain_id` can be thought of as defining a federated
super-filesystem: data of the unique "fingerprints" (e.g.,
secure hashes or UUIDs) may come from any of the
participating filesystems, but page cache is the only one.



EROFS is an immutable, image-based golden filesystem: its
(meta)data is generated entirely in userspace. I consider
it as a special class of disk filesystem, so traditional
assumptions about generic read-write filesystems don't
always apply; and the image filesystem (especially for
containers) can also have unique features according to
image use cases against typical local filesystems.

As for unpriviledged mounts, that is another story (clearly
there are different features at least at runtime), first
I think no one argues whether mounting in the user space
is useful for containers: I do agree it should have a formal
written threat model in advance. While I'm not a security
expert per se, I'll draft one later separately.

My rough thoughts are:

  - Let's not focusing entirely on the random human bugs,
    because I think every practical subsystem should have bugs,
    the whole threat model focuses on the system design, and
    less code doesn't mean anything (buggy or even has system
    design flaw)

  - EROFS only accesses the (meta)data from the source blobs
    specified at mount time, even with multi-device support:

     mount -t erofs -odevice=[blob],device=[blob],... [source]

    An EROFS mount instance never accesses data beyond those
    blobs.  Moreover, EROFS holds reference counts on these
    blobs for the entire lifetime of the mounted filesystem
    (so even if a blob is deleted, blobs remain accessible as
    orphan/deleted inodes).

  - As a strictly immutable filesystem, EROFS never writes to
    underlying blobs/devices and thus avoids complicated space
    allocation, deallocation, reverse mapping or journaling
    writeback consistency issues from its design in writable
    filesystems like ext4, XFS, or BTRFS.  However, it doesn't
    mean EROFS cannot bear random (meta)data change from
    modifing blobs directly from external users.

  - External users can modify underlay blobs/devices only when
    they have permission to the blobs/devices, so there is no
    privilege escalation risk; so I think "Sneaking in
    unexpected data" isn't meaningful here -- you need proper
    permissions to alter the source blobs;

    So then the only question is whether EROFS's on-disk design
    can safely handle arbitrary (even fuzzed) external
    modifications. I believe it can: because EROFS don't
    have any redundant metadata especially for space allocation
    , reverse mapping and journalling like EXT4, XFS, BTRFS.

    Thus, it avoids the kinds of severe inconsistency bugs
    seen in generic readwrite filesystems; if you say corruption
    or inconsientcy, you should define the corruption.  Almost
    all severe inconsientcy issue cannot be seen as inconsientcy
    from EROFS on-disk design itself, also see:
    https://erofs.docs.kernel.org/en/latest/imagefs.html

  - Of course, unprivileged kernel EROFS mounts should start
    from a minimal core on-disk format, typically the following:
    https://erofs.docs.kernel.org/en/latest/core_ondisk.html

    I'll clarify this together with the full security model
    later if this feature really gets developped;

  - In the end, I don't think various wild non-technical
    assumptions makes any sense to form out the correct design
    of unprivileged mounts, if a real security threat exists, it
    should first have a potential attack path written in words
    (even in theory), but I can't identify any practical one
    based on the design in my mind.

All in all, I'm open to hear and discuss any potential
threat or valid argument and find the final answers, but I do
think we should keep discussion in the technical way rather
than purely in policy as in the previous related threads.

Thanks,
Gao Xiang

