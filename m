Return-Path: <linux-fsdevel+bounces-70632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07882CA2D95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 09:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22FE2301E15C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391BB330D28;
	Thu,  4 Dec 2025 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U55/RsT8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63B326930
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764837617; cv=none; b=QYUlw6OhYq2T/nYZ9b8iOWDQsyniojJJyvtnkZUT9GlfFtzPq0f+W32Rj/D2iGozS1NjTolh+dpAYhSZXx90s8e72DWubfzBg+MEUEsaJsT/2bheE8WD+adl0O+Np2RwWcE8DCUi9FZGcW9nhxhNMqP2f/KlmgpTBiGmU0JFesQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764837617; c=relaxed/simple;
	bh=FroCwkTNZSbRQ7TU99YyvaiIjh/ta9/hGMaO6hX8Pms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/uj/q79qxcubCARCwoUtkLz7mAhz2f4NxFJj9NAxKU0n2sPWAqM3GGSEiLSdklgdjl5Nh/5BGXMKv8CSs1sdMu2QBftYB4P0jxDVSRoLvr4bSpT3hEzDl+ycUWejoTINwh/stWyeqMEIheOHWz1AsvYM7lXaj6yAfheC/HP5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U55/RsT8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-644fcafdce9so1058927a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 00:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764837614; x=1765442414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRRLPG76m6Du1ADzYb/YIlc2W//pdAMonfFY/36m1Uc=;
        b=U55/RsT8X8Rodbd14P6Gwp1cQ0/NlnP1tOasTfKEd0VWjFNPawRIWV03MbPNXL6ijY
         QQ+Wo+3aRejPxmZVQpq1qVmTqvKm0jUJecHtZ33yf78Bj74u0VxxB0nU4ouL8yz+jM4N
         k1Wua+bzWP2xZruNXGdA41LCkSPNltmitYLUKS+x9RElz83YVzBkCJK2trfJHNC9ziuV
         RzSI5SP/TSa3PyEcaRUMJbn6vWeyDrbCXey530J9rm6Ff2ftgEo5DWTIThP/51oizQL7
         UEwxxwW6790Asujno52QYk22Dr4OHbUw61LC15gPl6crM8V0H8m6xyH48KXpWj/xqomV
         oqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764837614; x=1765442414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRRLPG76m6Du1ADzYb/YIlc2W//pdAMonfFY/36m1Uc=;
        b=PL8RYspn3DbsvQLsgur2zdt8QMdoalB8ccepnuV+3W6Ngh8t8F0IDlYhjcomX/HV1C
         ZGPSgPtih8FDn+C3Da31wGt1ZVbS0aVn92MlQCOEnzdj7LLh+N4/Rd/HA0Pyy5Dsmldm
         EVPSiA+9cXEMXKmveVaDZF0+oCEcHZxVVUXMGdgUyLmpxQ8suFTw5JhWp4M/C4DP5vXq
         5ueJn+dIKAwi1tBs6Eie2gcgi3XnuZMTX6K83QYI2YPk2gnIarIqXAqediAW3+8n1V6B
         X/FrxrIhm1ahw0GaIZdM0/Q3Ds3nmBuuAselc4d8Q3gS8v0yux+0oVJIOYFzz6E7zIW/
         v8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPxnnH60dONXn+/w2xi2eaVGFw0QLKVtG0Zh90CGKLLImI/A7lmTxCX19R9oJU88b0d9GTtgHzk4Gj10+d@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Zxb+oQfe+2yjmeoOAn6S3UTGOOlLF2ajV2hbzKVy0DxYXdNL
	akzVM1Fbqnulrw1bzIL+FVQLy6pvLOubQd237TA1Uc8kBraBi3OiUx9WdEGWYVNQqZp5zYHWpj2
	JcY9sdFtdnEXEdU2cB5AFb6KjQcZwVCk=
X-Gm-Gg: ASbGncsv1EO3gnNhTDO7kXsUdf63ERCsohO32Vip+nkVOayredDC0R4OAV59HRj1VyV
	Bn33mLWlw3QopAeKFNpEKbCXfXCO0P0cTRiBqo2k742obMNs3sYnF4Y0KmFUs3RB7jEEPBWqbNZ
	3DMh8Kkvu4SNyWujJEnYtoMmMyI+3NyDec204vYa9i3Yu9VG68YS9xNF40sCs5tPs5k/DZfLiW0
	n9eBN3ayqusAtbwda+Bdq3l1fm8v/2CsPHfalPPuPaSFJerhovDm7nQ5t2ARi+wsJU3V2oOZDE/
	oG0nlIHWfoXCetPLBlx4elnZyr1LvwPTsqzL
X-Google-Smtp-Source: AGHT+IGlFWje4U/u/Ih/ONo6YwiZd7raWA7THK9IcGYx+25tDvWlw2E3FAkL0bv0Df4dVPXNv3OSYE+s0HYI7vSQfuo=
X-Received: by 2002:a05:6402:234a:b0:634:ce70:7c5 with SMTP id
 4fb4d7f45d1cf-647abdcf6camr1736379a12.17.1764837613800; Thu, 04 Dec 2025
 00:40:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com> <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
 <20251204082156.GK1712166@ZenIV>
In-Reply-To: <20251204082156.GK1712166@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 4 Dec 2025 09:40:01 +0100
X-Gm-Features: AWmQ_bmNCQYBKlBK115x3hqZe8lwJ60rwoZL8UAGeBOKbtZYBd__aUpRO-CzYk8
Message-ID: <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>, 
	brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 9:21=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Dec 04, 2025 at 08:45:08AM +0100, Mateusz Guzik wrote:
>
> > Or to put it differently, lookup got entered with a bogus state of a
> > dentry claiming it is a directory, with an inode which is not. Per the
> > i_mode reported in the opening mail it is a regular file instead.
> >
> > While I don't see how this can happen,
>
> ->i_op set to something with ->lookup !=3D NULL, ->i_mode - to regular.
> Which is to say, bogus ->i_mode change somewhere.
>
> Theoretically it should bail out, having detected the type change
> (on inode_wrong_type()).  I'd suggest slapping
>         BUG_ON(inode_wrong_type(inode, new_i_mode_value));
> in front of all reassignments (ocfs2_populate_inode() is the initializati=
on
> and thus exempt; all other stores to ->i_mode of struct inode in there
> are, in principle, suspect.  Something like inode->i_mode &=3D ~S_ISUID
> doesn't need checking - we obviously can't change the type there.
> Unpleasant part is that struct ocfs2_dinode also has a member called
> i_mode (__le16, that one), so stores to that clutter the grep results...

Now that I wrote this I suspect there is at least one way, regardless
of whether ocfs2 is culprit.

Suppose you are in rcu-walk and someone continuously issues mkdir,
rmdir, creat, unlink on the same pathname. Affected dentry will keep
flipping between directory, negative entry and regular.

While such fuckery will be caught with seq changes, perhaps the
intermediate state can indeed result in finding such a mismatch but
only because of a race.

I'm going to have to chew on it, I don't know if I';ll have time today
to deal with it. Worst case the fix will be to check if this is a dir
in lookup_inode_permission_may_exec instead of merely asserting on it.

