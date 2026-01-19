Return-Path: <linux-fsdevel+bounces-74503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A93D3B451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 777B2311C3B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942A31AAB8;
	Mon, 19 Jan 2026 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="d85uxIci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148F2DFA40;
	Mon, 19 Jan 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841829; cv=none; b=pyPKJ3WPohBMtEvSj90uazm0OT+gu1lGX9dIoulfLW/87QbNdmjeQQ8RMSHCgwHHiUu8sjgRECtt/K3oU/oKBg9XKh9tdRxMk4qKGAon9UTc8V3SSzR3+SymIQJUl7qSwrKg/FtM3FQwH9z4DR9uP8lY7m5LAPug2VvA3g26X5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841829; c=relaxed/simple;
	bh=MGyFqH8L+YjLuBcfjOJFi3mIAQwqi18e46X6Vl525qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0s+wt3O8/27oJz4m/UfsGpvKDSpkEDpi2aCNBGXRf0MfaDtAb5G9AlGK49dXu33YXwGyprBRjDzlBkav+ltBlVJfqBdldnyHelG4LQjpamkWMdid4yprDho8XnMQOmRLoooRZqU114GN7rcCoHN2JOmQZ7sPQ91+qNblDtVMMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=d85uxIci; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P88t41E8krgosvMB/MCVHfZybEjwTBXqed9m6H1WG6c=; b=d85uxIciOlWnBSKk0pPQaN2N6P
	MDQYopqIeTRKkxj+QaVKJ9AoWIt4929zZgGSr+r1Md50skhrHSXPbg4RzJVXtFgU52jMjF0fIn2iD
	BtdMGwR6JOLkm5hD7hGtOAQ/8e8lsqswQbIUh8DiVt9cMrsqbY+4nUAJPvxwf7R0UhECnAXie1aOH
	ImYT9zQ4OdWAEjZXOnqzFusqQ4QuMF2QA0x4REGVZtB+DCuhVolLJvx9LLBZaBg+AlhJtY+i4+mKR
	1rw0phHBec+pMUsx9iLLYUl3mGCNE1DNOb9KmexI0bmxgWRQaXDO6KAAMhSzurHXY0u2Jmw5bMpf1
	y+EtolGg==;
Received: from [177.139.22.247] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vhsYP-007EXi-GW; Mon, 19 Jan 2026 17:56:37 +0100
Message-ID: <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com>
Date: Mon, 19 Jan 2026 13:56:30 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, kernel-dev@igalia.com, vivek@collabora.com,
 Ludovico de Nittis <ludovico.denittis@collabora.com>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de>
 <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de>
 <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de>
 <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com>
 <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com>
 <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 16/01/2026 14:06, Amir Goldstein escreveu:
> On Fri, Jan 16, 2026 at 2:28 PM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> [+CC SteamOS developers]
>>
>> Em 16/01/2026 06:55, Amir Goldstein escreveu:
>>> On Thu, Jan 15, 2026 at 7:55 PM André Almeida <andrealmeid@igalia.com> wrote:
>>>>
>>>> Em 15/01/2026 13:07, Amir Goldstein escreveu:
>>>>> On Thu, Jan 15, 2026 at 4:42 PM André Almeida <andrealmeid@igalia.com> wrote:
>>>>>>
>>>>>> Em 15/01/2026 04:23, Christoph Hellwig escreveu:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>
>>>>>>> I still wonder what the use case is here.  Looking at André's original
>>>>>>> mail it states:
>>>>>>>
>>>>>>> "However, btrfs mounts may have volatiles UUIDs. When mounting the exact same
>>>>>>> disk image with btrfs, a random UUID is assigned for the following disks each
>>>>>>> time they are mounted, stored at temp_fsid and used across the kernel as the
>>>>>>> disk UUID. `btrfs filesystem show` presents that. Calling statfs() however
>>>>>>> shows the original (and duplicated) UUID for all disks."
>>>>>>>
>>>>>>> and this doesn't even talk about multiple mounts, but looking at
>>>>>>> device_list_add it seems to only set the temp_fsid flag when set
>>>>>>> same_fsid_diff_dev is set by find_fsid_by_device, which isn't documented
>>>>>>> well, but does indeed seem to be done transparently when two file systems
>>>>>>> with the same fsid are mounted.
>>>>>>>
>>>>>>> So André, can you confirm this what you're worried about?  And btrfs
>>>>>>> developers, I think the main problem is indeed that btrfs simply allows
>>>>>>> mounting the same fsid twice.  Which is really fatal for anything using
>>>>>>> the fsid/uuid, such NFS exports, mount by fs uuid or any sb->s_uuid user.
>>>>>>>
>>>>>>
>>>>>> Yes, I'm would like to be able to mount two cloned btrfs images and to
>>>>>> use overlayfs with them. This is useful for SteamOS A/B partition scheme.
>>>>>>
>>>>>>>> If so, I think it's time to revert the behavior before it's too late.
>>>>>>>> Currently the main usage of such duplicated fsids is for Steam deck to
>>>>>>>> maintain A/B partitions, I think they can accept a new compat_ro flag for
>>>>>>>> that.
>>>>>>>
>>>>>>> What's an A/B partition?  And how are these safely used at the same time?
>>>>>>>
>>>>>>
>>>>>> The Steam Deck have two main partitions to install SteamOS updates
>>>>>> atomically. When you want to update the device, assuming that you are
>>>>>> using partition A, the updater will write the new image in partition B,
>>>>>> and vice versa. Then after the reboot, the system will mount the new
>>>>>> image on B.
>>>>>>
>>>>>
>>>>> And what do you expect to happen wrt overlayfs when switching from
>>>>> image A to B?
>>>>>
>>>>> What are the origin file handles recorded in overlayfs index from image A
>>>>> lower worth when the lower image is B?
>>>>>
>>>>> Is there any guarantee that file handles are relevant and point to the
>>>>> same objects?
>>>>>
>>>>> The whole point of the overlayfs index feature is that overlayfs inodes
>>>>> can have a unique id across copy-up.
>>>>>
>>>>> Please explain in more details exactly which overlayfs setup you are
>>>>> trying to do with index feature.
>>>>>
>>>>
>>>> The problem happens _before_ switching from A to B, it happens when
>>>> trying to install the same image from A on B.
>>>>
>>>> During the image installation process, while running in A, the B image
>>>> will be mounted more than once for some setup steps, and overlayfs is
>>>> used for this. Because A have the same UUID, each time B is remouted
>>>> will get a new UUID and then the installation scripts fails mounting the
>>>> image.
>>>
>>> Please describe the exact overlayfs setup and specifically,
>>> is it multi lower or single lower layer setup?
>>> What reason do you need the overlayfs index for?
>>> Can you mount with index=off which should relax the hard
>>> requirement for match with the original lower layer uuid.
>>>
>>
>> The setup has a single lower layer. This is how the mount command looks
>> like:
>>
>> mount -t overlay -o
>> "lowerdir=${DEV_DIR}/etc,upperdir=${DEV_DIR}/var/lib/overlays/etc/upper,workdir=${DEV_DIR}/var/lib/overlays/etc/work"
>> none "${DEV_DIR}/etc"
>>
>> They would rather not disable index, to avoid mounting the wrong layers
>> and to avoid corner cases with hardlinks.
> 
> IIUC you have all the layers on the same fs ($DEV_DIR)?
> 
> See mount option uuid=off, created for this exact use case:
> 
> Documentation/filesystems/overlayfs.rst:
> Note: the mount option uuid=off can be used to replace UUID of the underlying
> filesystem in file handles with null, and effectively disable UUID checks. This
> can be useful in case the underlying disk is copied and the UUID of this copy
> is changed. This is only applicable if all lower/upper/work directories are on
> the same filesystem, otherwise it will fallback to normal behaviour.
> 
> commit 5830fb6b54f7167cc7c9d43612eb01c24312c7ca
> Author: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Date:   Tue Oct 13 17:59:54 2020 +0300
> 
>      ovl: introduce new "uuid=off" option for inodes index feature
> 
>      This replaces uuid with null in overlayfs file handles and thus relaxes
>      uuid checks for overlay index feature. It is only possible in case there is
>      only one filesystem for all the work/upper/lower directories and bare file
>      handles from this backing filesystem are unique. In other case when we have
>      multiple filesystems lets just fallback to "uuid=on" which is and
>      equivalent of how it worked before with all uuid checks.
> 
>      This is needed when overlayfs is/was mounted in a container with index
>      enabled ...
> 
>      If you just change the uuid of the backing filesystem, overlay is not
>      mounting any more. In Virtuozzo we copy container disks (ploops) when
>      create the copy of container and we require fs uuid to be unique for a new
>      container.
> 
> TBH, I am trying to remember why we require upper/work to be on the
> same fs as lower for uuid=off,index=on and I can't remember.
> If this is important I can look into it.
> 

Actually they are not in the same fs, upper and lower are coming from 
different fs', so when trying to mount I get the fallback to 
`uuid=null`. A quick hack circumventing this check makes the mount work.

If you think this is the best way to solve this issue (rather than 
following the VFS helper path for instance), please let me know how can 
I safely lift this restriction, like maybe adding a new flag for this?

> Thanks,
> Amir.


