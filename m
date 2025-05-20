Return-Path: <linux-fsdevel+bounces-49512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C275ABDB55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139E48C3ABA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC69246335;
	Tue, 20 May 2025 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx45h8lm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3482451C8;
	Tue, 20 May 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749834; cv=none; b=mGQL4IztQz4AsbEN965klx30wbKoc9XkytLjl+XkvSov3IHYEiMJ5NOad/bWBygFf5QBWE5VU+U4a21FP9YRD2e/WL+5UL2n6+BeGrm71784xMDE2XHwqJ3N6AKVMUySj9JofORFp3/hP5Xhm+Bxoy6yEyQokM3z6lnYQ5LHetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749834; c=relaxed/simple;
	bh=IcCFDPG77OlZjEgIjjDB2bRXDlnHVq+Ldim/1iPjTPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOoOMqE3KfUUYEI9iqMUPyseG7TQqa+NEx8UoFKUl/BBhskxL2uQNd3t52MM2mR8dsFl7kjHSXODsOT9pGWQUWd1l7/PoVa3Votu026r/VYDoHKasH+lYyt83bzzDKElPgy1qkbaDexO5QPgLVkrM11siGspb34P/zt/mFOZd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx45h8lm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so975147866b.2;
        Tue, 20 May 2025 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747749831; x=1748354631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ0rdBfXMUZ8U2eRjck/E3HjWX9UiG8rswZWTn9WFnY=;
        b=Wx45h8lmMT64dr/ULJFL6/PR892zoercloTRP5X3RWw+mOvF7Rm90ZI2gKKikURgEd
         lsQpnMfloBB3iXxBkxY8wsCvP7qnrseETZ40W3scv3JIg9KMpcXDHaoEeCyaedTHfmS/
         494RHXSUKPYBvhGTTabrBLi3LtTgI6+1DMAug+tph8LRBtGvhDdmKsVXCGMohfd6irPR
         xXAErVrGkeoyECxuv1xH1+7h7z8RtbmGBL6UplyCsgZWZKPz5/dPRQ2te0051YVt7q77
         aIsrcCdxrtarDxnj1OTzbJnbILw2Q9AGZ+xFJMfQu/FV1+VVdk1e15h24SFFCykUDyBp
         5kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747749831; x=1748354631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQ0rdBfXMUZ8U2eRjck/E3HjWX9UiG8rswZWTn9WFnY=;
        b=J9AAIhl/07jTla5PhyQqKiXiUeQKquQcnGwi57SJ0/IezgM3oUlo8+yJiGKvzQap4P
         jW6cIA6Ia+XoL0VooLb6c2Bs+lNx3U6aFoZ/dSr9QwPQ8saGyeWXVSDfeoZgidWjVBCy
         4qI5HN/HW8K+G+KMRcUANwp8tONOifM66qpeq+oD1mU9HxdcgQyw+OF3uLapSWnCwU+7
         uWo/8RHoWSkSTMFvRgNkAOyLFsTqexDD00EhBkqVzQxOslnZG05zmbXXFteEo7OGQTP9
         Lzb/yLfl/ZiVVQR0qXqIP7y9XdKIuy3VsEThGzql4U5HSDRf45lViWdz1D5Awmb7zLL0
         iRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkVpo7PaFOeXZh9Xg3LeECWcwBbvOHW+2bP9nl7M83YcIm0UYkLu8TQEKodhixl2fQTYsQaZUe3qB8I/Ow@vger.kernel.org, AJvYcCUnAm2fytmNnP/MmJTcFWngln1bhR8r1Vj9A8wt3BI+Q82zyqxBYmaVccxnO+6jfR4inAIcQudOGbacE8ay/w==@vger.kernel.org, AJvYcCWdJvIYfqS29mUTsqPQ+EsYFPj1rgfwucplbQvcFAe2q/n+0GUgQbH2KPQ3NOiYSPnrn1kWsvBAQg9npRBvGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc/iEopzhZj9D/LCC8Je2I7O60e/qbL7HpwOa177D8PVOpKA7X
	nCEqQrTJaJTN5dQNY9g0VP3hgUBcbxPlFK5mOQpgl5x3TlPFhbUAZ8kJmJLYo1iy6H76c+ogtTf
	KvveJ4F6T+91p6l+8CwuaHyfs2vz5m3oeBPFlO9c=
X-Gm-Gg: ASbGncsEhKRbttMHReNkrRZoh42eqMXhCh/S/yji/vx6DP+tcijWkKSX5wBHdOqZliP
	zwtWAhAoIpmlACkCvtKI1y7pKZoO7XWCxo6bJIQf/29WwBLll1gTqkmAf0Enzb4d1yDIp0rCnDQ
	Cw82Sh6+DCrJ/ShXLDwhk7rgupOAj+XuAn
X-Google-Smtp-Source: AGHT+IEdeyFHYW0SNMyWZuhCmindrwYHs5f/JSkPu7flNDXf2/ftSHPNpgz/O7amdZuTyXJECQImb26edR0KQfrsFDE=
X-Received: by 2002:a17:907:1c0a:b0:ad5:2473:3ed5 with SMTP id
 a640c23a62f3a-ad52d45ad21mr1499049366b.11.1747749818897; Tue, 20 May 2025
 07:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
 <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com> <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
In-Reply-To: <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 May 2025 16:03:27 +0200
X-Gm-Features: AX0GCFvCIMtRXENvsaBy40e6wywMcPFrLFIrdQybzyfeddMULbtr3wzqLrifaNo
Message-ID: <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 2:43=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, May 20, 2025 at 02:40:07PM +0200, Amir Goldstein wrote:
> > On Tue, May 20, 2025 at 2:25=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Tue, May 20, 2025 at 10:05:14AM +0200, Amir Goldstein wrote:
> > > > On Tue, May 20, 2025 at 7:16=E2=80=AFAM Kent Overstreet
> > > > <kent.overstreet@linux.dev> wrote:
> > > > >
> > > > > This series allows overlayfs and casefolding to safely be used on=
 the
> > > > > same filesystem by providing exclusion to ensure that overlayfs n=
ever
> > > > > has to deal with casefolded directories.
> > > > >
> > > > > Currently, overlayfs can't be used _at all_ if a filesystem even
> > > > > supports casefolding, which is really nasty for users.
> > > > >
> > > > > Components:
> > > > >
> > > > > - filesystem has to track, for each directory, "does any _descend=
ent_
> > > > >   have casefolding enabled"
> > > > >
> > > > > - new inode flag to pass this to VFS layer
> > > > >
> > > > > - new dcache methods for providing refs for overlayfs, and filesy=
stem
> > > > >   methods for safely clearing this flag
> > > > >
> > > > > - new superblock flag for indicating to overlayfs & dcache "files=
ystem
> > > > >   supports casefolding, it's safe to use provided new dcache meth=
ods are
> > > > >   used"
> > > > >
> > > >
> > > > I don't think that this is really needed.
> > > >
> > > > Too bad you did not ask before going through the trouble of this im=
plementation.
> > > >
> > > > I think it is enough for overlayfs to know the THIS directory has n=
o
> > > > casefolding.
> > >
> > > overlayfs works on trees, not directories...
> >
> > I know how overlayfs works...
> >
> > I've explained why I don't think that sanitizing the entire tree is nee=
ded
> > for creating overlayfs over a filesystem that may enable casefolding
> > on some of its directories.
>
> So, you want to move error checking from mount time, where we _just_
> did a massive API rework so that we can return errors in a way that
> users will actually see them - to open/lookup, where all we have are a
> small fixed set of error codes?

That's one way of putting it.

Please explain the use case.

When is overlayfs created over a subtree that is only partially case folded=
?
Is that really so common that a mount time error justifies all the vfs
infrastructure involved?

Thanks,
Amir.

