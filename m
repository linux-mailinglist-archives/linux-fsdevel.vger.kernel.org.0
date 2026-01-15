Return-Path: <linux-fsdevel+bounces-73992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A77D27DA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97AF130428C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6093D1CDE;
	Thu, 15 Jan 2026 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KC+OAuUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1181D3D1CCF;
	Thu, 15 Jan 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503357; cv=none; b=i5nMEZP1CaoX2lpJ0z/eMXBQc8DMnSormophwnDDdduaEUbV+DKqXj4yYTNlfwBuyigcBKK62rXjHqiGlBWb4k713ZZA+O/iYTQ449Kq0ttHq6TgRcolN+uykAE+GgPbUnjvo9gzInlox8WHI50F2mJkxiaQB572hw/qSMydgl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503357; c=relaxed/simple;
	bh=x7tV2Kg6T6yguuR4G+iuaiQWXGoeovKBD2Ho4ravFDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwHtpHsf59Sw8fd1uB5fyC2Uz8B5mCNir3u7TULtvNHO8Nch/q/O6wnSQzWoXMBMqftb4/3yG4oTanztEP/kDaHgSS05xVwxsB9o4zP7uxzrWAkSn12Msx+RPaQTC4Wbd0mhppbCpOwbgIUW0AmeFRdGGfbFpU95vx08hKLQsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KC+OAuUW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tezj/QPgefijpDh5A49YjiGfEhluXoplws9cLThVWEU=; b=KC+OAuUWjc1CzO51ISKH+bjJKq
	+3Vit+dKYS0cWzzGslXgaCPEzbEi7FrpMRxR2IpqrtIpPpCkxSBW41LlIoc34AO1A2qd9Qu11KgNu
	wuE/M4y98Y1H3TzXKD8KmPVLQfvNtRFAAdv6BnVsgZY9Ci5VMeqDFP5/9Mywz0p6QU3F65tgpw4Ur
	eL2cH+LdY/yC1PN2fn8bACQxVFMt44hm/ZYmjk20mMRCoYGNLLSBA6lD2yCv7KCtKKTrHEWej3A36
	txiN4FWn4s+qwXvyTMN1PISBIjVigUyDcDa5Z1cMDpUS5+n/tqJKbBY9p5KS4CJEiDCO/NXPll1Xb
	1cE64arg==;
Received: from [177.139.22.247] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vgSVB-005ru5-3N; Thu, 15 Jan 2026 19:55:25 +0100
Message-ID: <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com>
Date: Thu, 15 Jan 2026 15:55:15 -0300
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
 linux-unionfs@vger.kernel.org, kernel-dev@igalia.com
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de>
 <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de>
 <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de>
 <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 15/01/2026 13:07, Amir Goldstein escreveu:
> On Thu, Jan 15, 2026 at 4:42 PM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> Em 15/01/2026 04:23, Christoph Hellwig escreveu:
>>
>> [...]
>>
>>>
>>> I still wonder what the use case is here.  Looking at André's original
>>> mail it states:
>>>
>>> "However, btrfs mounts may have volatiles UUIDs. When mounting the exact same
>>> disk image with btrfs, a random UUID is assigned for the following disks each
>>> time they are mounted, stored at temp_fsid and used across the kernel as the
>>> disk UUID. `btrfs filesystem show` presents that. Calling statfs() however
>>> shows the original (and duplicated) UUID for all disks."
>>>
>>> and this doesn't even talk about multiple mounts, but looking at
>>> device_list_add it seems to only set the temp_fsid flag when set
>>> same_fsid_diff_dev is set by find_fsid_by_device, which isn't documented
>>> well, but does indeed seem to be done transparently when two file systems
>>> with the same fsid are mounted.
>>>
>>> So André, can you confirm this what you're worried about?  And btrfs
>>> developers, I think the main problem is indeed that btrfs simply allows
>>> mounting the same fsid twice.  Which is really fatal for anything using
>>> the fsid/uuid, such NFS exports, mount by fs uuid or any sb->s_uuid user.
>>>
>>
>> Yes, I'm would like to be able to mount two cloned btrfs images and to
>> use overlayfs with them. This is useful for SteamOS A/B partition scheme.
>>
>>>> If so, I think it's time to revert the behavior before it's too late.
>>>> Currently the main usage of such duplicated fsids is for Steam deck to
>>>> maintain A/B partitions, I think they can accept a new compat_ro flag for
>>>> that.
>>>
>>> What's an A/B partition?  And how are these safely used at the same time?
>>>
>>
>> The Steam Deck have two main partitions to install SteamOS updates
>> atomically. When you want to update the device, assuming that you are
>> using partition A, the updater will write the new image in partition B,
>> and vice versa. Then after the reboot, the system will mount the new
>> image on B.
>>
> 
> And what do you expect to happen wrt overlayfs when switching from
> image A to B?
> 
> What are the origin file handles recorded in overlayfs index from image A
> lower worth when the lower image is B?
> 
> Is there any guarantee that file handles are relevant and point to the
> same objects?
> 
> The whole point of the overlayfs index feature is that overlayfs inodes
> can have a unique id across copy-up.
> 
> Please explain in more details exactly which overlayfs setup you are
> trying to do with index feature.
> 

The problem happens _before_ switching from A to B, it happens when 
trying to install the same image from A on B.

During the image installation process, while running in A, the B image 
will be mounted more than once for some setup steps, and overlayfs is 
used for this. Because A have the same UUID, each time B is remouted 
will get a new UUID and then the installation scripts fails mounting the 
image.

