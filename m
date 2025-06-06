Return-Path: <linux-fsdevel+bounces-50875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6A9AD0A22
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFC53B349E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981A723D290;
	Fri,  6 Jun 2025 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="q1ildbes"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784081624DD
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749251071; cv=none; b=asgPh3F20mdWQmfp07UBNuTr8ChjAdedHUzPabbkB1jKTfU3ZMy4qovM4mujlTISwVilQ6DThUEi4eL5Fmh8ISx6lFhIB3N+kUyCN//RZxnE7JSZH0VISc9H2qQkyV0A/vTNHS3rXgkbR6N4Ax737Y1uGPDQJSij/bW+XIokLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749251071; c=relaxed/simple;
	bh=4X7+R7jwq77/ubtkj7/N31xao0hfvdEgbePF/+mSQrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rHIDhMm6tcTW4ZEh3Uo38q7tZPgEoT0+pu9XG+e/l9WY7EDAvAAo1sWsKF/BDYK1h6+eSDCZ7dv7Xao8sZ2YINU68jBfjyCmQljQr5Qrf4WQKJQAb3VF+8w8Z1p51E5vGkbjqgeb7oWtOVywNFfMUf9nc0R4EDPTrkxDV/pmmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=q1ildbes; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235a3dd4f0dso19012405ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1749251069; x=1749855869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=++XM+L+lyfF5/P8LN+hWODPGqYMWkpCaCgDaYnM3pxo=;
        b=q1ildbesg99UFLeQeGMNKqs3NUUJQWbAjvzy1zJUTQEKb1d7zndX61MqCmWFGawRSi
         4k5RzofvVL1tHGiUqH60gBD+xwRd+9KhR2WikeWmnH6GMCK/FsLOhcnEDuwevUUmyRSD
         /fGO2X603KwmRWZRWXZbvK7LVwNqhfSyglvk9F9/tHS43CHTXMq+h0Z4589TjiI4lhH+
         6ihgUQ3SfEjX8ML7pqrHqzgitt81IVpYpdR981pmDb7Fv+MhumjVSDoGJDhON6y9AWdo
         QKIiWfNaUIHgoqXx8VyZKnXoCDgX2vojshWDiLm2gIeb8DfPjSmgwRF0igjj3O7VRq/h
         vRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749251069; x=1749855869;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++XM+L+lyfF5/P8LN+hWODPGqYMWkpCaCgDaYnM3pxo=;
        b=sWB+7qsSP1dI1RhxYFDQ6qJKcQGUQSr8ZQJI1lxDlNOiawbu6ez7Rgz33KRG5ho1GO
         vuB2UNwg8dTE2UNmr4vXbShPCRe6v0aBrfO13pfmIFvYzCQnGC7c/OLJD4yGmCqwt9Su
         C95uW+1sEYOd0SnaKqDftJFiyq3+01pVzUdewNiD7IiwaNwF8xakP6+Iot65kgwDemjZ
         jgJSVvEGHTbGLQspRhQTywOHKyrEw+/boKGXVcSwfYX/iOsEyNi/JTwLI3hn6LN4tTXc
         eDM4diqnkU3sBDYeBmR9LRcMyuxfkiTdcxvcDMxH0R6mXx5JanDWLTcnsFp6J1VtjQ2b
         egsg==
X-Gm-Message-State: AOJu0YzrDNKbPd9Ovpg3i9dY86tIJi+R0ht3X0Y0dh1RVUGUkOSpNEFg
	MdfGU90nh7jIcJb9e30w6VsJR72oKz6HvqESQeEP2hUpQv/fCJJXZiMhxFvWQqFmlaA=
X-Gm-Gg: ASbGncvl63kvgEXiz9jaLxdXAvBXX9VufTdaketfL945j74whUEkwrYRtdZalQ0/I4k
	T8nNvZolD459ay8ytgY04FnDR3CcwOv3JZDsUxd6zmk61ihz5RPuOGH70HctWVtF/OwGLY378qR
	vVpsHrLr8MakFqqQ9DJWEcdqrBPvewLl6WX9SEDLRRZMeQFUs2cPHPnFOqaPGmyN5KMEJekwg8A
	aqi3i3XMsrhK0KCOMrnoYJlqafOPCMSQ9V/5tp98vwXlNbHK2C+FRrek8d1GWncjd3tUpA4L0V/
	4k6HWAWsYGp0fVcns75oHNJSKGxkfJzx1cOXsrJC+QWu9AptjNyuMQcxsOVNRk5uTIDThE0TjIV
	v5QhCQDY26Ag2SQ0pL/X3+I1EhL6T6lMweDr9eg1z1g==
X-Google-Smtp-Source: AGHT+IErrEOX3SQ4qNWG/f8KC6Mxs0KmkBlsimkRf9M34lhQh/x1x3Q9dDuaUnHkI2JzMeKaRWL8Ww==
X-Received: by 2002:a17:902:f54a:b0:234:d679:72e3 with SMTP id d9443c01a7336-23601ec4b8bmr62952805ad.42.1749251068694;
        Fri, 06 Jun 2025 16:04:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:77a3:4e60:32de:3fd? ([2600:1700:6476:1430:77a3:4e60:32de:3fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603078941sm17573635ad.7.2025.06.06.16.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:04:28 -0700 (PDT)
Message-ID: <f0cd74e12a678b80b8920ebc2fe7226f40c43cd8.camel@dubeyko.com>
Subject: Re:  [PATCH v2] hfsplus: remove mutex_lock check in
 hfsplus_free_extents
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>, 
 "syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com"	
 <syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com>, Viacheslav Dubeyko
	 <Slava.Dubeyko@ibm.com>, "frank.li@vivo.com" <frank.li@vivo.com>, 
 "glaubitz@physik.fu-berlin.de"	 <glaubitz@physik.fu-berlin.de>,
 "ernesto.mnd.fernandez@gmail.com"	 <ernesto.mnd.fernandez@gmail.com>,
 "akpm@linux-foundation.org"	 <akpm@linux-foundation.org>
Date: Fri, 06 Jun 2025 16:04:27 -0700
In-Reply-To: <2f17f8d98232dec938bc9e7085a73921444cdb33.camel@ibm.com>
References: <20250529061807.2213498-1-frank.li@vivo.com>
	 <2f17f8d98232dec938bc9e7085a73921444cdb33.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Christian,

Could you please pick up the patch?

Thanks,
Slava.

On Thu, 2025-05-29 at 18:34 +0000, Viacheslav Dubeyko wrote:
> On Thu, 2025-05-29 at 00:18 -0600, Yangtao Li wrote:
> > Syzbot reported an issue in hfsplus filesystem:
> >=20
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 4400 at fs/hfsplus/extents.c:346
> > 	hfsplus_free_extents+0x700/0xad0
> > Call Trace:
> > <TASK>
> > hfsplus_file_truncate+0x768/0xbb0 fs/hfsplus/extents.c:606
> > hfsplus_write_begin+0xc2/0xd0 fs/hfsplus/inode.c:56
> > cont_expand_zero fs/buffer.c:2383 [inline]
> > cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
> > hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
> > generic_cont_expand_simple+0x151/0x250 fs/buffer.c:2347
> > hfsplus_setattr+0x168/0x280 fs/hfsplus/inode.c:263
> > notify_change+0xe38/0x10f0 fs/attr.c:420
> > do_truncate+0x1fb/0x2e0 fs/open.c:65
> > do_sys_ftruncate+0x2eb/0x380 fs/open.c:193
> > do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> > entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >=20
> > To avoid deadlock, Commit 31651c607151 ("hfsplus: avoid deadlock
> > on file truncation") unlock extree before hfsplus_free_extents(),
> > and add check wheather extree is locked in hfsplus_free_extents().
> >=20
> > However, when operations such as hfsplus_file_release,
> > hfsplus_setattr, hfsplus_unlink, and hfsplus_get_block are executed
> > concurrently in different files, it is very likely to trigger the
> > WARN_ON, which will lead syzbot and xfstest to consider it as an
> > abnormality.
> >=20
> > The comment above this warning also describes one of the easy
> > triggering situations, which can easily trigger and cause
> > xfstest&syzbot to report errors.
> >=20
> > [task A]			[task B]
> > ->hfsplus_file_release
> > =C2=A0 ->hfsplus_file_truncate
> > =C2=A0=C2=A0=C2=A0 ->hfs_find_init
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->mutex_lock
> > =C2=A0=C2=A0=C2=A0 ->mutex_unlock
> > 				->hfsplus_write_begin
> > 				=C2=A0 ->hfsplus_get_block
> > 				=C2=A0=C2=A0=C2=A0 ->hfsplus_file_extend
> > 				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->hfsplus_ext_read_extent
> > 				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->hfs_find_init
> > 					=C2=A0 ->mutex_lock
> > =C2=A0=C2=A0=C2=A0 ->hfsplus_free_extents
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(mutex_is_locked) !!!
> >=20
> > Several threads could try to lock the shared extents tree.
> > And warning can be triggered in one thread when another thread
> > has locked the tree. This is the wrong behavior of the code and
> > we need to remove the warning.
> >=20
> > Fixes: 31651c607151f ("hfsplus: avoid deadlock on file truncation")
> > Reported-by: syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com
> > Closes:
> > https://lore.kernel.org/all/00000000000057fa4605ef101c4c@google.com/
> > =C2=A0
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> > =C2=A0fs/hfsplus/extents.c | 3 ---
> > =C2=A01 file changed, 3 deletions(-)
> >=20
> > diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> > index a6d61685ae79..b1699b3c246a 100644
> > --- a/fs/hfsplus/extents.c
> > +++ b/fs/hfsplus/extents.c
> > @@ -342,9 +342,6 @@ static int hfsplus_free_extents(struct
> > super_block *sb,
> > =C2=A0	int i;
> > =C2=A0	int err =3D 0;
> > =C2=A0
> > -	/* Mapping the allocation file may lock the extent tree */
> > -	WARN_ON(mutex_is_locked(&HFSPLUS_SB(sb)->ext_tree-
> > >tree_lock));
> > -
>=20
> Makes sense to me. Looks good.
>=20
> But I really like your mentioning of reproducing the issue in
> generic/013 and
> really nice analysis of the issue there. Sadly, we haven't it in the
> comment. :)
>=20
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>=20
> Thanks,
> Slava.
>=20
> > =C2=A0	hfsplus_dump_extent(extent);
> > =C2=A0	for (i =3D 0; i < 8; extent++, i++) {
> > =C2=A0		count =3D be32_to_cpu(extent->block_count);

