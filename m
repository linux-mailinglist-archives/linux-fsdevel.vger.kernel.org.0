Return-Path: <linux-fsdevel+bounces-61095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6854BB5533E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 17:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EC9BA2F0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8129922DF9E;
	Fri, 12 Sep 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Uj5B2MNX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gidU8oEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1750B22126D;
	Fri, 12 Sep 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690465; cv=none; b=H7PmbyIwhKPIu1F8cGdlCqZWCEFEqurOtXvW8X9JML9PXRNiti+PLQSnj7ngrgFFZ7leZIqM48en5hKSvhjE+ZLInV/NdF/UlqMpeifTneFSmat5O1WqcROLjfXpGMPALgVSPcQMwZlWZomgTNIGm2Op1qza3UDbvBgPv53GdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690465; c=relaxed/simple;
	bh=HSFBscSSczcz3S7Wqrp9sgL8dc+A4pMZfkBFeIctCvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DE5Yk2okum5QLL+HcipkllgcAqQytGukSU9kzAIfwDzmKyvga4jxC3mMVALuyE5uISngZqXwXBBKcA32NXARkwwPgdHfWLgFjSkZKjyMQCrnI7dmz1RDjv7uhmTCknj26SKloMA3dZAsMoPew0fZX7Sg/JlqZgiOZXDnJq4ThpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Uj5B2MNX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gidU8oEf; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40A9B1400463;
	Fri, 12 Sep 2025 11:21:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 12 Sep 2025 11:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757690462;
	 x=1757776862; bh=/umB4IHM99Z/OS6bb2qw7wz6i5KaWIGiJiO6b8ffqWU=; b=
	Uj5B2MNXLqtVohi+SKRGRs9wpNMaqGfKFDaM+UDquRiI3LNp+SnW8TD0RWmaoU3q
	ZGiNOuSlmkyf9nfJ+8vgzMH6YT8y1hA/NKP1eWT5IGpZThqeZTjyAj8tU+sa7Bdw
	WMnnrcezJz4VcPzLtkokhTGJFGX1W4y6QehkDX2IN/KLmmytAsP9aRpRN2tAJwZB
	AOPS8exn4nSmbQKwEwrXoR1w/KDRN6e8wbdqqB4UOAjd7hqRsKMASxRz3IcNFdS4
	Uo8hhfot/p0+El104u5nQbhJv+kc+Xai9s6txuiJcaxFAO1bHtOiK0DRuo9LHlpn
	tpS4fHDOBUDdFzZ70Uzv3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757690462; x=
	1757776862; bh=/umB4IHM99Z/OS6bb2qw7wz6i5KaWIGiJiO6b8ffqWU=; b=g
	idU8oEfSZ1y5uXn2ovpnUVZKdCLgDjCvEP8hjZmPNlaVgoCeKDqYfpRpzmnUqMKx
	yj8ttYOFYVMnkWaaW/zATlt3apW3FjECoVuy/Cf474TGOwcPlaHIHEZJCe2x4iQI
	fzrz8ivL+h73pq2ezgV0ue0c7WZLZqrAqWBGZz7Q4dR87MKKadvyYbr3TSIjGXr/
	vpFcaf0AWA8JSFKA54LmGAMx/wflXZgDbVeS4J+nTuWicWlzTjrFInuMyXiRFGAY
	vW77wVPauZMQU4dN5tUnrijhyIgdRW+k+lvoThWjgIxUDcR5YAoCWdfCOV495xzV
	6l65DUDyf30W9vmAiGkqA==
X-ME-Sender: <xms:XTrEaKFlpY6GQLpLdF191FogEctFRB05b2X_wTQKvne-fki8nGn98A>
    <xme:XTrEaF8bpyXbgaD-gxTR9T4tKW6AttGzCNDx9T03N79c1NEg7RGbeSOiVPGYqO5w3
    DHog-hOx8KNrX96>
X-ME-Received: <xmr:XTrEaKK389mL1gLftomo2wqShOUaEu3nHwuoAvOb4XyIkGe2h82F7RLWQs9GAIYHWepVzl-jClbp0Drz4CfHm8_xA6dI2m7Mo1UZhrshGQKgF3NRWR7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnheptdeuvdeuudeltddukefhueeludduieejvdevveevteduvdefuedvkeffjeel
    ueeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegujh
    ifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheplhhuihhssehighgrlhhirgdrtghomhdprhgtphhtth
    hopehthihtshhosehmihhtrdgvughupdhrtghpthhtohepmhhikhhlohhssehsiigvrhgv
    ughirdhhuhdprhgtphhtthhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehktghhvghnseguughnrdgtohhm
X-ME-Proxy: <xmx:XTrEaDu4H1KbwXMta5APYdwEZ1CVpIf-7zEp4vyKuJl_zZiFBe6xSg>
    <xmx:XTrEaBBaNu8ACe7fb2JR1kOw3LwxX6i5BIouhgjyGWnWPsAFWn-vVQ>
    <xmx:XTrEaLPxdAkNjDE1b_taK154Ywmj_RzlGXVnDTpGEXruM_fCXJ5izA>
    <xmx:XTrEaJC8alO1PCn9aec6s5Ep8ktBX5h4zJAgwBg81Qz23uaWKZY05A>
    <xmx:XjrEaM0nm3AW3GuvlgDjLYlHyFgEf3z-o0rVBwjxPTjrWanJSQdNxqfJ>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 11:21:00 -0400 (EDT)
Message-ID: <5a25a7da-1204-49a5-a897-de457a7c304b@bsbernd.com>
Date: Fri, 12 Sep 2025 17:20:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Another take at restarting FUSE servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>,
 Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
References: <8734afp0ct.fsf@igalia.com>
 <20250729233854.GV2672029@frogsfrogsfrogs> <20250731130458.GE273706@mit.edu>
 <20250731173858.GE2672029@frogsfrogsfrogs> <8734abgxfl.fsf@igalia.com>
 <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
 <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
 <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>
 <20250912145857.GQ8117@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250912145857.GQ8117@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/12/25 16:58, Darrick J. Wong wrote:
> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
>>
>>
>> On 9/12/25 13:41, Amir Goldstein wrote:
>>> On Fri, Sep 12, 2025 at 12:31 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/1/25 12:15, Luis Henriques wrote:
>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
>>>>>
>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
>>>>>>>>
>>>>>>>> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
>>>>>>>> could restart itself.  It's unclear if doing so will actually enable us
>>>>>>>> to clear the condition that caused the failure in the first place, but I
>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
>>>>>>>> aren't totally crazy.
>>>>>>>
>>>>>>> I'm trying to understand what the failure scenario is here.  Is this
>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
>>>>>>> is supposed to happen with respect to open files, metadata and data
>>>>>>> modifications which were in transit, etc.?  Sure, fuse2fs could run
>>>>>>> e2fsck -fy, but if there are dirty inode on the system, that's going
>>>>>>> potentally to be out of sync, right?
>>>>>>>
>>>>>>> What are the recovery semantics that we hope to be able to provide?
>>>>>>
>>>>>> <echoing what we said on the ext4 call this morning>
>>>>>>
>>>>>> With iomap, most of the dirty state is in the kernel, so I think the new
>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
>>>>>> would initiate GETATTR requests on all the cached inodes to validate
>>>>>> that they still exist; and then resend all the unacknowledged requests
>>>>>> that were pending at the time.  It might be the case that you have to
>>>>>> that in the reverse order; I only know enough about the design of fuse
>>>>>> to suspect that to be true.
>>>>>>
>>>>>> Anyhow once those are complete, I think we can resume operations with
>>>>>> the surviving inodes.  The ones that fail the GETATTR revalidation are
>>>>>> fuse_make_bad'd, which effectively revokes them.
>>>>>
>>>>> Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
>>>>> but probably GETATTR is a better option.
>>>>>
>>>>> So, are you currently working on any of this?  Are you implementing this
>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
>>>>> look at fuse2fs too.
>>>>
>>>> Sorry for joining the discussion late, I was totally occupied, day and
>>>> night. Added Kevin to CC, who is going to work on recovery on our
>>>> DDN side.
>>>>
>>>> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
>>>> server restart we want kernel to recover inodes and their lookup count.
>>>> Now inode recovery might be hard, because we currently only have a
>>>> 64-bit node-id - which is used my most fuse application as memory
>>>> pointer.
>>>>
>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-sends
>>>> outstanding requests. And that ends up in most cases in sending requests
>>>> with invalid node-IDs, that are casted and might provoke random memory
>>>> access on restart. Kind of the same issue why fuse nfs export or
>>>> open_by_handle_at doesn't work well right now.
>>>>
>>>> So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
>>>> would not return a 64-bit node ID, but a max 128 byte file handle.
>>>> And then FUSE_REVALIDATE_FH on server restart.
>>>> The file handles could be stored into the fuse inode and also used for
>>>> NFS export.
>>>>
>>>> I *think* Amir had a similar idea, but I don't find the link quickly.
>>>> Adding Amir to CC.
>>>
>>> Or maybe it was Miklos' idea. Hard to keep track of this rolling thread:
>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
>>
>> Thanks for the reference Amir! I even had been in that thread.
>>
>>>
>>>>
>>>> Our short term plan is to add something like FUSE_NOTIFY_RESTART, which
>>>> will iterate over all superblock inodes and mark them with fuse_make_bad.
>>>> Any objections against that?
> 
> What if you actually /can/ reuse a nodeid after a restart?  Consider
> fuse4fs, where the nodeid is the on-disk inode number.  After a restart,
> you can reconnect the fuse_inode to the ondisk inode, assuming recovery
> didn't delete it, obviously.
> 
> I suppose you could just ask for refreshed stat information and either
> the server gives it to you and the fuse_inode lives; or the server
> returns ENOENT and then we mark it bad.  But I'd have to see code
> patches to form a real opinion.
> 
> It's very nice of fuse to have implemented revoke() ;)


Assuming you would run with an attr cache timeout equal 0 the existing
NOTIFY_RESEND would be enough for fuse4fs? 


Thanks,
Bernd

