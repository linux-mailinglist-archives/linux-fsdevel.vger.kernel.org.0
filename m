Return-Path: <linux-fsdevel+bounces-69481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEBCC7D6E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 20:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC1093495DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D8D2BE05E;
	Sat, 22 Nov 2025 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="onBr+qFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBDA1D435F
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763841071; cv=none; b=qizmtnVvsCV3ffyJqnEYdqfpqiyKdygPAuwoGu+0xe/jtkzu+o7qAksuCPEoV5Q4+wYqhdUsHAGGSSndpF5UyVwOiqwS+QB9fmzgAFGhJNnOcSSKnkKWBYlxPwM2HLAuYF0FHN4QpUdI/KWr1EaSs8JJcj+BnqBW03JgxwO9Evo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763841071; c=relaxed/simple;
	bh=tViIDwLo3b01k+1cKTPtZaoQOJV+AGij51+6fwgbnqc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YogeedH9uotG6IbtVcHXeF6htpK+J5RmBI4vrr8YWxOMZqogcsFU7RCrZ1mE6n4xMQFpaLsIHN3d+xDkst9hINGA1JVIiEHm4nhZM0KSvS9VbQhqvJV7/VpAmHK24ywAyIWDh8/m86QqEqDEXMM0ac3mKUPRsXwkILRRWDPre44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=onBr+qFA; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: fd27d30c-c7dc-11f0-9e68-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id fd27d30c-c7dc-11f0-9e68-005056994fde;
	Sat, 22 Nov 2025 20:54:00 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 916fa8d9-c7dc-11f0-99bf-0050569977a2;
	Sat, 22 Nov 2025 20:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=tViIDwLo3b01k+1cKTPtZaoQOJV+AGij51+6fwgbnqc=;
	b=onBr+qFAV9GpnUAtorud0HarzNumqOn4OjXyiJ2BwZpcj0/inMVQTVk1i9jHyDTU2KU6CbuZsUS1V
	 OF83ZRK+wIUdl6+oazJEgk092jHquN10DKAL7tcdFwk+c8gZe5PRKT+eLzW4IWe/z/xcfRtKNkynui
	 KZdHet6xlvQUA4EWO72vihwYfj4Mi055s6Hnt+G/XeYVvIT8MxGAHtxpdVOCmOdC1Y1FDbvQkfF/mg
	 YvRuA5RKBvfGrewtBWQK7UwdOht6a+JxfGBKR2tUKBNV+ll9BteYHR2VpRglml0g1Sw3HYFiv4VD0H
	 3H7a+zYiX7Y5tBvGUG9xFgVVC7N4xuQ==
X-KPN-MID: 33|OmhzZ70PtJMGVPneBe5WQGqlNh4Nt3H0gkcY6o09AAX9CX/nlWwNFkXt5SyyKpv
 GJzCLZeof1KAoBpuuYvRmK1/nrLsqn4qRzSzfL7eezms=
X-CMASSUN: 33|VPmAajFa7MkOnUamitacN17HkWWHdyBxJxCdAiHVdUcLodyCn3Oda4QOFyVE/20
 k3ILLA6VTVix+4We8NVkN5w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 9154e3d9-c7dc-11f0-b8d7-005056995d6c;
	Sat, 22 Nov 2025 20:50:59 +0100 (CET)
Date: Sat, 22 Nov 2025 20:50:59 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"david.shane.hunter@gmail.com" <david.shane.hunter@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Message-ID: <1287044022.2349785.1763841059344@kpc.webmail.kpnmail.nl>
In-Reply-To: <54e47f6ae96b4ed9bc30bd8c58487fa4d5cb6538.camel@dubeyko.com>
References: <20251103131023.2804655-1-jkoolstra@xs4all.nl>
 <54e47f6ae96b4ed9bc30bd8c58487fa4d5cb6538.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: Replace BUG_ON with error handling in
 hfs_new_inode()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal


>=20
> I am terribly sorry, I've missed the patch. But, please, please,
> please, add prefix 'hfs:' to the topic. This is the reason why I've
> missed the patch. I expected to see something like this:
>=20
> hfs: Replace BUG_ON with error handling in hfs_new_inode()
>=20
> I need to process dozens emails every day. So, if I don't see proper
> keyword in the topic, then I skip the emails.

My bad, I didn't know this convention. Is this LKML-wide? Because I have
also been waiting for a few weeks on feedback on jfs patches. Normally,
it would not matter, but I am in the Linux Foundation Kernel Mentorship
Program and we need to get several patches in before the deadline to
succeed :)

> OK. I see. You have modified the hfs_new_inode() with the goal to
> return error code instead of NULL.
>=20
> Frankly speaking, I am not sure that inode is NULL, then it means
> always that we are out of memory (-ENOMEM).
>=20

I think this is correct. See for instance fs/ext4/ialloc.c at __ext4_new_in=
ode.

>=20
> Why do we use -ENOSPC here? If next_id > U32_MAX, then it doesn't mean
> that volume is full. Probably, we have corrupted volume, then code
> error should be completely different (maybe, -EIO).
>

ext4 uses EFSCORRUPTED which is defined as EUCLEAN, I can change that.

I wasn't exactly sure of the limits in place in hfs. But looking more close=
ly,
there can only be 65,535 allocation blocks, and I think you need at least o=
ne
per inode. But then why are the CNID, max files, max directories 32-bit val=
ues
in the MBD? What limits indicate corruption?


> The 'hfs:' prefix is not necessary here. It could be not only file but
> folder ID too. So, maybe, it makes sense to mention "next CNID". The
> whole comment needs to be on one line. Also, I believe it makes sense
> to recommend run FSCK tool here.
>=20

Will fix this.

> > =C2=A0
> > =C2=A0void hfs_delete_inode(struct inode *inode)
> > @@ -251,7 +271,6 @@ void hfs_delete_inode(struct inode *inode)
> > =C2=A0
> > =C2=A0=09hfs_dbg("ino %lu\n", inode->i_ino);
> > =C2=A0=09if (S_ISDIR(inode->i_mode)) {
> > -=09=09BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) >
> > U32_MAX);
>=20
> I don't agree with complete removal of this check. Because, we could
> have bugs in file system logic that can increase folder_count
> wrongfully above U32_MAX limit.
>=20
> So, I prefer to have this check in some way. Error code sounds good.
>=20

Will add these back with error handling instead of BUG_ON.

>=20
> Thanks,
> Slava.
>=20

Thank-you for the extended response!

Jori.

