Return-Path: <linux-fsdevel+bounces-53573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87DAAF036F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 21:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F3A1C07722
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1E6281353;
	Tue,  1 Jul 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axXbWcki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F427E7CF;
	Tue,  1 Jul 2025 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397101; cv=none; b=kaU30D17eOfVujg6oCRa4/bjgqtr7PYa8zOCX4FnRLTaI/X2g6Sm3SmmsrIJUl8yxH2bWdyQBrAXnDRamRMnkmd97LOG/OTV/2alPBr4RCs8gw+dBKbALC05fbuSEmi959K7/Vscn+zQQoeQ9/mszLRSpRWWPhZ2iM76K9RN5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397101; c=relaxed/simple;
	bh=vfrKJybgzwjpgw+TJOq6H2Fh67XbF07HjXoZ7cu5IM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SARYjZo7EVlYAK8Q1Z5Sx9HxePSZsnuqpdOvFt49aQH3b9jR4f3toO01d6Vq4g8zchXR04mX0UFv/vpRTUrfdethFEti+e3YBwIIoh1r+uNBWjqLx+/Kh13bdrDfH6HbtZSzH6xWnePSLY1mtqEf2mj/DKDpeVUGXa0/gco9XvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axXbWcki; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso1389385866b.0;
        Tue, 01 Jul 2025 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751397098; x=1752001898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjzoNhUidVgZHP9QlhU4SH9c2JyuaDfBZkeqDe+rudE=;
        b=axXbWckiGJUtuLvTow6+NCvzQO/IWp6X/weX0z47K5Mvw9pbJkX9ir1z8UAXwxGQCy
         gNTWFn+cUz9bldUWI8n3Te9cMENOtfc9csQJJReG7/vbtKYoRvGTTYEV8qvO38Qp0Pvw
         dPS9vSBLVlv5qhrv7tBlumpe/+PWKLcRUtjvG+S6ufpzqxVygYME+OxywDdF2AAI91hl
         a25lXY/Das1UhRpVaif8cAmj7Xkl7Gkf5CFaKlZgc7LYAmQnC+HmDhr4Yt+J3c1kQ2X3
         ham8rW5gowdt3KBFJuQk3cDYDKa+9h1HcuwG4O3RNzWNP+Oa0oEciY/WOGg1NQp6R1M5
         QDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751397098; x=1752001898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjzoNhUidVgZHP9QlhU4SH9c2JyuaDfBZkeqDe+rudE=;
        b=i/tj3rEm0zRLoo6b6O5M1gx16Cnd7uV3yoSYz05IhM0uKjfTqryNLzWh8NqJVEKRuo
         s/Nb3P6FwhnecPtVIYKCCUHKvzOSXelvU4Dsej+P2hUtS1OworSKC/F2WH9fURMOCg/H
         ZUw5axiVdIe+DnsypdcB7UyClM76d0uhRMIP2yt3DCE9R04CBfU5oCj4uap/umijZtHj
         VvelUO80MNUl3+xp34w+bjYtCUUX5l5UwBC8cJdSdRqhl6bSxDhSZiSkSAv2xOfvYUFD
         R1k1S160PkDEzXJeudaecPWk/6pwyPnpF6+nGsXYb0/6cA9dKc35Y/o91DYF63Jn+8zM
         nisQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVO0QYv8je+vLjtkwAYpPNPDSmr2MNTE5OMUtx9M1TkyAXogis2Gm3gm/8Oh8cbGXXT9jTZuyjaYHGgZ5ftQ==@vger.kernel.org, AJvYcCW2tXtkCmriByUkAP1fWY7Ad26kE/nkyY1QGTfBVfC1uuml21tAkCqDo8++9IwspyE1qXYqmpT5sQYw5GH0@vger.kernel.org
X-Gm-Message-State: AOJu0YzihLcXTHpqEAVj+vvU7vjrqXQxrCNe+BTgA3hXJvUjlWWp1dqL
	POG8AIY0ej/U4ZN6Yituj++i5dnx3FeH+0Min1L83P5Ba7u4nZVFnA5qybbsExzuercK4H/lMRm
	0mz7BRAdk0X4/TxiO2WgjBPhCRJdDA0NsbnkVoxw=
X-Gm-Gg: ASbGncvj6ahcrnUg17nNSvr4EXPJ7SN2sX6x29m1TTOKPzhOzhgo1YclbrmBUj94q8f
	jYpyBG2j2D8p++Z/fljeGKmpgsmVNm8F5sBCe4JNVXoZ7I8GA0Zdk9aROCO/hIT3241JoPTsAuM
	5qq8lM/mWTJUL/rPfLSRBc1sRO9B6lDPjzh3vJ1LdEgiQ=
X-Google-Smtp-Source: AGHT+IGhoAtZ0nPpwrGpHsxUvERoXprnTWRhp/mrbBB9hf0usVRtrc8KBMAymCzAXIijLekld9yz3eRERBye6x5PP9I=
X-Received: by 2002:a17:907:95a4:b0:ae0:573f:40bd with SMTP id
 a640c23a62f3a-ae3c179c182mr26858466b.11.1751397097290; Tue, 01 Jul 2025
 12:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701142930.429547-1-amir73il@gmail.com> <CAJfpegvjpcsbNq6dpu5pdpfMUqcaKoqY5gAy62jq2V_rU55J5w@mail.gmail.com>
In-Reply-To: <CAJfpegvjpcsbNq6dpu5pdpfMUqcaKoqY5gAy62jq2V_rU55J5w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 1 Jul 2025 21:11:26 +0200
X-Gm-Features: Ac12FXyHjCkgSaxD32AfHlpauRy7bb_rinBdUaszueDSnTFbOw7zjwSrYEv_is4
Message-ID: <CAOQ4uxjZ+EaJCNfCqx+jVNXumstNfKQZL6WOB61uA+EG3v6C0w@mail.gmail.com>
Subject: Re: [PATCH] fuse: return -EOPNOTSUPP from ->fileattr_[gs]et() instead
 of -ENOTTY
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 7:41=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Tue, 1 Jul 2025 at 16:29, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > index 6f0e15f86c21..92754749f316 100644
> > --- a/fs/overlayfs/inode.c
> > +++ b/fs/overlayfs/inode.c
> > @@ -722,7 +722,7 @@ int ovl_real_fileattr_get(const struct path *realpa=
th, struct fileattr *fa)
> >
> >         err =3D vfs_fileattr_get(realpath->dentry, fa);
> >         if (err =3D=3D -ENOIOCTLCMD)
> > -               err =3D -ENOTTY;
> > +               err =3D -EOPNOTSUPP;
>
> This doesn't make sense, the Andrey's 4/6 patch made vfs_fileattr_get
> return EOPNOTSUPP instead of ENOIOCTLCMD.  So why is it being checked
> here?

You are right.
I was trying to demonstrate the change in fuse/ovl independent of
Ansrey's patch, but don't worry after squashing this patch,
there is no remaining conversion in ovl_real_fileattr_get().

I verified that with Christian.

Thanks,
Amir.

