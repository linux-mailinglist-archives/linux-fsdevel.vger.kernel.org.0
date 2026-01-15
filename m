Return-Path: <linux-fsdevel+bounces-73934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB463D257A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB2C9309EE1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068143B530C;
	Thu, 15 Jan 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HguNlUr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6537E2EB;
	Thu, 15 Jan 2026 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491787; cv=none; b=t4045dLLoOBEwvkXuMJy+7O2IUqOfzUZLXh0athxUIbqjcMtItmRWGeFej4WSN7N9+g0BIz4isj0Tih6b2nfL7zz3xXmnKq1eDn70lLWnixLKaiT5kMQM63CNplQYm/Qe1z/O/zKxgl/dC6GrKvE+Pd2GRK4d0WWLiWW9LwAsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491787; c=relaxed/simple;
	bh=rUEcB7TOUQxUA2rPuRw81Bl6Sk+qHwI2NjU4Pq9USqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYW2yEQTChx6DyixLbAj6jyUJacufPPn1lvvuBiyEJAK3vI5Rds/PHbkdu8WrBxmHmFoBq5XqPK6YH/LfEmwACltGrLcrRpenxsRna5PzWtXDXtnOMAU9vdbZQbJZmEob3VPKnxx/9dxqQNFucdeeR3UBrNfSzfoqZpyrwNiSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HguNlUr0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cxcJJIvDm/hgUftodX3R1dDrr90bvmh2id0jz8mp7T4=; b=HguNlUr0JGNrv7hpUSfHspXJq4
	mlYKL5oYPiG7yRQgwO0+ibsRK7Kt2sYlvhBjf4UULcPdCv0103Gru8r9ON5FIiVHy4XXOu+PJfP0P
	2aSRz2jKp+ReL27N/HPTbpn7WF0VycCbQ+NMIur14gNveWXjV6oHEG9In5DCZaNBL5ewsNFSKW8Uo
	YHhIgcPTdD5ni+5T9xXp1Gl0/a4VWADcu1kctpGjP1mfEN3lwE4JJOoSSFBUwABQOVRpdexXuH1IH
	mdA79g/RvX47tKL9KGlUZjc0ZejZu4OYCGb9nWsa6QVY6kJa4xNWdGuf0k0x7IbM5+2ZTwhHuQJW/
	uwge2iMA==;
Received: from [177.139.22.247] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vgPUd-005nio-C4; Thu, 15 Jan 2026 16:42:39 +0100
Message-ID: <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
Date: Thu, 15 Jan 2026 12:42:33 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Carlos Maiolino <cem@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, kernel-dev@igalia.com
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de>
 <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de>
 <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260115072311.GA10352@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 15/01/2026 04:23, Christoph Hellwig escreveu:

[...]

> 
> I still wonder what the use case is here.  Looking at André's original
> mail it states:
> 
> "However, btrfs mounts may have volatiles UUIDs. When mounting the exact same
> disk image with btrfs, a random UUID is assigned for the following disks each
> time they are mounted, stored at temp_fsid and used across the kernel as the
> disk UUID. `btrfs filesystem show` presents that. Calling statfs() however
> shows the original (and duplicated) UUID for all disks."
> 
> and this doesn't even talk about multiple mounts, but looking at
> device_list_add it seems to only set the temp_fsid flag when set
> same_fsid_diff_dev is set by find_fsid_by_device, which isn't documented
> well, but does indeed seem to be done transparently when two file systems
> with the same fsid are mounted.
> 
> So André, can you confirm this what you're worried about?  And btrfs
> developers, I think the main problem is indeed that btrfs simply allows
> mounting the same fsid twice.  Which is really fatal for anything using
> the fsid/uuid, such NFS exports, mount by fs uuid or any sb->s_uuid user.
> 

Yes, I'm would like to be able to mount two cloned btrfs images and to 
use overlayfs with them. This is useful for SteamOS A/B partition scheme.

>> If so, I think it's time to revert the behavior before it's too late.
>> Currently the main usage of such duplicated fsids is for Steam deck to
>> maintain A/B partitions, I think they can accept a new compat_ro flag for
>> that.
> 
> What's an A/B partition?  And how are these safely used at the same time?
> 

The Steam Deck have two main partitions to install SteamOS updates 
atomically. When you want to update the device, assuming that you are 
using partition A, the updater will write the new image in partition B, 
and vice versa. Then after the reboot, the system will mount the new 
image on B.

Android used to support A/B scheme as well: 
https://source.android.com/docs/core/ota/ab

