Return-Path: <linux-fsdevel+bounces-68279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F6C57E0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A9A1344576
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135827990A;
	Thu, 13 Nov 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjRy/Ggi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D3A128816
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043427; cv=none; b=VRSVlf/ggawPzhZurKYAbRsAcpFMZWnoEdqXPKA7SLdRNRrdR134G5QCtf7MNGwpP776zF13fPshIad7X3CllLV0eukuE/gvbYNoPNc4jHtJcCi4xC56K+N4FsVYhTDPdC1RLcKA5cFTaCdANHuYei2bcT05jAohY2kJtUJJmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043427; c=relaxed/simple;
	bh=ifIKSHrKuO2Pld3ZI0baMsAtJwYUfHddyW3/tMDWO5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFttNhmaHhz8BAd+szLjFWWy7sGH3oiYPVGx9s17gDKIISepSzJdEqDXHawMLuzypxGw6dJLniTCgzkmU4zK4O/sKfAY9kqcoZFc3OSNUqu2llRnXrqdC7L1Ank3fRHeHOoJNel1FPfcB9tWr3P/80nMgL4h1Jo00cGsoYydZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjRy/Ggi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so1440386a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 06:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763043424; x=1763648224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kf7ThiMraNwXowWFJz0pBJSyHZFbZPMESpkLpsWy2Sk=;
        b=VjRy/GgiHqFxuipWKjxvjbx0Y/98PGSrUSpkRnt+CK7HUiKOdqkPQP4EKki7QH5TEj
         marXrnuSJx/zkB+r5krSWkRMddn9eBHyWvSR9/HP8z4BqDPcyzI/DFGBow3Q3gvsGW9t
         toRyiOAmqJT8oV7O7RudIyzRfNctUm/WGA3AO9t7kKkEugs1E28F4YaP/KYUUlqYsSIC
         EadCm0kfnHd24nxvB9wmcQYDd9V+q2czwmtYejtAHtWffFESKFR/dvyRAYyh0uoQvdeP
         0zrBOahQ+QfOHMGrPeij8PexmOUjab4oignII28MDPPCtXGfyQpwfKZBHD/o/KaZX4pv
         oeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043424; x=1763648224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kf7ThiMraNwXowWFJz0pBJSyHZFbZPMESpkLpsWy2Sk=;
        b=ruVzRchYs1K8vr1WYmRgEr+Fnt9hNXerNivI1B25fo6pCt6IgufBu/AeoigiBjO/o8
         D/6Z0MkjDtNWwKFRch/qeh0g9Bu/LzjkZhtedTxRLglzwymuGrFDbcMg8vTFGXQCtV5E
         HqlgA1xQnqXuaTXV+q/5SEA5iNx2s00vyFp42gfEuXpDZEGDh7YVgsHumMnB7CrfF7/y
         5SnZP7qlYgXEOZEf38W9GeTbrILiTT9S2D8VYEa5nnyMgj+QMpfpWzQSTBa56NK3U9hw
         kc2obPR+ZZxU75lSuHPFMEubaNqtNswDv0OO+au3x03XVH1ZOy37rhz+RjzDYCGPE1eZ
         lSuw==
X-Forwarded-Encrypted: i=1; AJvYcCXgTQy4IVH1CBlF7a/pP1jMi3ROEIxOpfNIZhYqvpamblnNq2KgqMStGtjS63268dHitnfKCy11SZqjtS1f@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNAJJ7vgS1+6WD7My4qysTfBAywbD/L6JmvVFVtehZqeM/7cO
	rcEz2PWe5aGW4gxZvlKONRpTjXDv/ZspSnPpWpSNYOa3xxXc8xO49jf0Ix4aEBOLLe2eBbpa4DG
	r/arAI0prBC7RfMD3lE8IL+OpYgPiqLU=
X-Gm-Gg: ASbGncsrNV53eaVhTrYcRKBX1IAiNgiI4lT+TrPDrlpWaC59CF8/rfiA/dH/1xWOt2B
	0SdqdAilJVgjfDMnFGoRQFPmQPqsVcb7nBsgU3SletqmtfRog2yKlCTCnUBmCC6nGtMUMPykY+d
	gGej11NUIFlocAIxnm3C4HbXeYfymrWckZ7aNpizB768PjfgzC3Km1V9E1Yhqu+r60y2v6sDCt4
	r+hjngdEmJb9ZFIzh45r/99WLRZUoBw4erOr4if47vTZX6U9U34T6IKYY4h+kzFleiLLNBPjeUt
	qc5YKB0oshU5d2matmg=
X-Google-Smtp-Source: AGHT+IHrMpN3dAJN01UM4KDGYImAmUKLICqul1xRJJTCBTR0/RZhatHzml6fh8lgTpLMp0+E4abJcnCzzxNfFslHWII=
X-Received: by 2002:a17:906:6a1b:b0:b70:df0d:e2e9 with SMTP id
 a640c23a62f3a-b7331aa2724mr682956066b.44.1763043423337; Thu, 13 Nov 2025
 06:17:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
 <20251113-work-ovl-cred-guard-v1-3-fa9887f17061@kernel.org>
 <CAJfpegt9LQe_L=Ki0x6G+OMuNhzof3i4KAcGWGrDNDq3tBfMtA@mail.gmail.com> <20251113-laufleistung-anbringen-831f25218d61@brauner>
In-Reply-To: <20251113-laufleistung-anbringen-831f25218d61@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Nov 2025 15:16:52 +0100
X-Gm-Features: AWmQ_bk0g7Zh7feMbKmFC_jX1W9SvL7N2ZAFWsrsyXhWa-GhNehAwVb0sghOIFU
Message-ID: <CAOQ4uxhRaYZALD0o46-=nP+VP2BY7Egtp+j33vrMDGfOV7beQQ@mail.gmail.com>
Subject: Re: [PATCH RFC 03/42] ovl: port ovl_create_or_link() to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 2:45=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Nov 13, 2025 at 02:31:27PM +0100, Miklos Szeredi wrote:
> > On Thu, 13 Nov 2025 at 14:02, Christian Brauner <brauner@kernel.org> wr=
ote:
> > >
> > > Use the scoped ovl cred guard.
> >
> > Would it make sense to re-post the series with --ignore-space-change?
>
> Yeah, I can do that for sure!

While on the subject of making patches easier to review, I often use forwar=
d
declarations in refactoring patches like this one:

+struct ovl_renamedata {
+       struct renamedata;
+       struct dentry *opaquedir;
+       struct dentry *olddentry;
+       struct dentry *newdentry;
+       bool cleanup_whiteout;
+};
+
+static int do_ovl_rename(struct ovl_renamedata *ovlrd, struct list_head *l=
ist);
+
 static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
                      struct dentry *old, struct inode *newdir,
                      struct dentry *new, unsigned int flags)
 {
        int err;
-       struct dentry *old_upperdir;
-       struct dentry *new_upperdir;
-       struct dentry *olddentry =3D NULL;
-       struct dentry *newdentry =3D NULL;
-       struct dentry *trap, *de;
-       bool old_opaque;
-       bool new_opaque;
-       bool cleanup_whiteout =3D false;
        bool update_nlink =3D false;
...
+static int do_ovl_rename(struct ovl_renamedata *ovlrd, struct list_head *l=
ist)
+{
+       struct dentry *old =3D ovlrd->old_dentry;
+       struct dentry *new =3D ovlrd->new_dentry;
+       struct ovl_fs *ofs =3D OVL_FS(old->d_sb);
+       unsigned int flags =3D ovlrd->flags;
+       struct dentry *old_upperdir =3D ovl_dentry_upper(ovlrd->old_parent)=
;
+       struct dentry *new_upperdir =3D ovl_dentry_upper(ovlrd->new_parent)=
;
+       bool samedir =3D ovlrd->old_parent =3D=3D ovlrd->new_parent;



To make review of refactoring much easier.
Otherwise, the refactoring patch review becomes a review of deleted
and added code which is
not easy at all.

Thanks,
Amir.

