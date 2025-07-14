Return-Path: <linux-fsdevel+bounces-54804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94915B03656
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC633B7BB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 05:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477C20E717;
	Mon, 14 Jul 2025 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMExlB7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A09B22083;
	Mon, 14 Jul 2025 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752472649; cv=none; b=Hq4ii+7qGyZ6FGeQyjq08wZSmCPM4D9It/hkxUndS7jacJSF0pPJZaWzoWq36suBV2tMXmBoVPhT7pS/MO21c3rCaR8jx1SKbiV+eUDt6/RyCaMdW6W0u3PHCEPkmkiNtUGmqeqzrhJHnuF+IpRzizGFZFrC/y3DkIVneRmQJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752472649; c=relaxed/simple;
	bh=6a3AWwwU6xcidstBNP14jsxhtJ19olpyGE6T6+F7OLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFo2KNaxNxDOIDGdkWB4182C9bNiap882MfIgvWzARgJbi9h2seDXshkNlOxiN76a/pAnOVDeAm7u26SxdazjmFHAUnm1CrmjTuBjr0OKG+ZOKhw4taXIOIgF/p6JXHVdOEMJEndFn/4/CMLo2R2DW3tCQ+M0JWiafVGZiye0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMExlB7c; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so7260945a12.0;
        Sun, 13 Jul 2025 22:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752472646; x=1753077446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpqe75/zoP8j3WLvs+UPCDTBjzkRszQf+Epe/yrwD84=;
        b=lMExlB7csvujqSGvG3ohJ0R4Y6nHzj+ZS0GN58ayhIa9R+tiqoCSgjVF+4bYtJFxUO
         4UlKAckIJfA1HPKIhY7h/blu6wbm8VGqp8AOV9SNu1udqFHS4SMZDKR5a7nJApGAB1xT
         +9eppPT84t/WLl9/vl8JDOLgGis+AFpXwSdmIWawLndsiD09pbHBZXg0o2Fyg5BihOJz
         Qt319OM/hqE50uiU3d0gkUcIT8ST4q05JmQ6upSchpj/C0/ee00QElXrOMlBMvBAlVbR
         lDQmWxFDeaa/1XnxW8+bUEDXYibSvY9sOK1WAaido01IQ0hwrndGoNvRngdy7gaBTxI4
         rGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752472646; x=1753077446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpqe75/zoP8j3WLvs+UPCDTBjzkRszQf+Epe/yrwD84=;
        b=WxmcnDrcMyrlrx8nPqYkTyb3jZJMgLdoF5y5NL7ZS9J/5ZX6vB1fgbFwx5XIampF1E
         GUAoczVEb0p6bNbX7wGFuNrO6BTGhdXRWECLmk80BF4OZq6Fwd9K2xv0QlMo++xsY0mC
         3/edmZxoWaf1eSZsDQ2fQZfPbgE9RvNx8uu47ifoVJneX91Ncg83++mK4/7buEc+NsUH
         NVKZuueVYDsCR6kbQCpvPpfNw2+VGBhpoF3TcpB6h0q/EEHNGQXs7gpG3yfZNyFDywTv
         47M5M7OW7wHCeW/OvANAoPKFw/mzwvEB49Ys5HIVw3V2MktcQ9Eu0tAiUPgWt2lsSplj
         3NfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfUKOZ2mFW9frAG/mlyeJU4EoooKRmyc/ssUjBPliwl5FEfW04jtzaq910dHIYoJ/sL+wRc6ftRWdeiL4iEg==@vger.kernel.org, AJvYcCWTCZ7DgCR02I6St9EP1sBHi0HHWd7TJe+8Z9DwCI2n51oR4vLFN3dWTqDKNX8SaFtKZ4OqWbU5kE63oIPe@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3bMesTZ8NNjrdZ3DkJWzTx2GEMh0ee6kTCEyZ5BX216O+RCt
	HR5APS0wBf7lG8ko8FvsfbU4GgyyKsu+Q9n2QCAm61p4SXqxSxS6XyrPQ8pfdrx7/jF8fXFNVF4
	nf4+wZKfUoBjC4bI0A9UIfC6+1vHEwJY=
X-Gm-Gg: ASbGncshSFwktC+x9NqPbAPR+XgO4vTRGwTah8mfFLERGuEbOqtO/Wvt07DjySWd83p
	mczr7B/CcjSvOdn6oZP6tefjRXaMucS2ltTKksfhe3HZXLYchUm/jWU0VmTKQVRlC/zdjvdxWQ7
	37fGXWzwGxSNSjeZ486LHk8igFywuSqRbJu+2MAPlr04VEdlVBQXYvUI/LRUscM1vXYP3OH9mcf
	mM+MbM=
X-Google-Smtp-Source: AGHT+IHDi8siDB3nfUvX2Cnop9pI4wuFXnh5KyneIC3vXdz5pFuFx+JQ7KUp4Y93NKmx6qaXfMTl3/Gq2M9ygxDQYSU=
X-Received: by 2002:a17:907:3fa6:b0:ae6:c7a7:204 with SMTP id
 a640c23a62f3a-ae6fc9fe59cmr1179008966b.5.1752472645371; Sun, 13 Jul 2025
 22:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <CAOQ4uxhC_ARYQ=mPMEX9pLQTeXcBcJGqn8RK-tmE26W8pGChKA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhC_ARYQ=mPMEX9pLQTeXcBcJGqn8RK-tmE26W8pGChKA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 14 Jul 2025 07:57:13 +0200
X-Gm-Features: Ac12FXyiqmQ7gDCN5Uxw_KL4Yg3xeR6szqSFY8XVz5YGBe_wl6QZNiAH6RlKzio
Message-ID: <CAOQ4uxhkAgJR0ALwVjUugYxNyu4JCkYFaZimOE6G--_AJi65mA@mail.gmail.com>
Subject: Re: [PATCH 00/20 v2] ovl: narrow regions protected by i_rw_sem
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[CC vfs maintainers]

On Fri, Jul 11, 2025 at 6:41=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote=
:
> >
> > This is a revised set of patches following helpful feedback.  There are
> > now more patches, but they should be a lot easier to review.
>
> I confirm that this set was "reviewable" :)
>
> No major comments on my part, mostly petty nits.
>
> I would prefer to see parent_lock/unlock helpers in vfs for v3,
> but if you prefer to keep the prep patches internal to ovl, that's fine t=
oo.
> In that case I'd prefer to use ovl_parent_lock/unlock, but if that's too
> painful, don't bother.
>
> Thanks,
> Amir.
>
> >
> > These patches are all in a git tree at
> >    https://github.com/neilbrown/linux/commits/pdirops
> > though there a lot more patches there too - demonstrating what is to co=
me.
> > 0eaa1c629788 ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()
> > is the last in the series posted here.
> >
> > I welcome further review.
> >
> > Original description:
> >
> > This series of patches for overlayfs is primarily focussed on preparing
> > for some proposed changes to directory locking.  In the new scheme we
> > will lock individual dentries in a directory rather than the whole
> > directory.
> >
> > ovl currently will sometimes lock a directory on the upper filesystem
> > and do a few different things while holding the lock.  This is
> > incompatible with the new scheme.
> >
> > This series narrows the region of code protected by the directory lock,
> > taking it multiple times when necessary.  This theoretically open up th=
e
> > possibilty of other changes happening on the upper filesytem between th=
e
> > unlock and the lock.  To some extent the patches guard against that by
> > checking the dentries still have the expect parent after retaking the
> > lock.  In general, I think ovl would have trouble if upperfs were being
> > changed independantly, and I don't think the changes here increase the
> > problem in any important way.
> >
> > I have tested this with fstests, both generic and unionfs tests.  I
> > wouldn't be surprised if I missed something though, so please review
> > carefully.
> >
> > After this series (with any needed changes) lands I will resubmit my
> > change to vfs_rmdir() behaviour to have it drop the lock on error.  ovl
> > will be much better positioned to handle that change.  It will come wit=
h
> > the new "lookup_and_lock" API that I am proposing.
> >

Slightly off topic. As I know how much ovl code currently depends on
(perhaps even abuses) the directory inode lock beyond its vfs uses
(e.g. to synchronize internal ovl dir cache changes) just an idea that
came to my head for your followup patches -
Consider adding an assertion in WRAP_DIR_ITER() that disallows
i_op->no_dir_lock.
Not that any of the current users of WRAP_DIR_ITER() are candidates
for parallel dir ops (?), but its an easy assertion to add.

Thanks,
Amir.

