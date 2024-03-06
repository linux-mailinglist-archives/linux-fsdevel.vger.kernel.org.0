Return-Path: <linux-fsdevel+bounces-13733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B68733E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F38E28DF0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B2604CA;
	Wed,  6 Mar 2024 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elNUmwcn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD77E5F875;
	Wed,  6 Mar 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720324; cv=none; b=od4B1baj50CsgXFV2ZliBs8jo5JOMwSqHn55hgujvsVo96FhV1lic0CESc5XMEmsTSQ51Sg3p5bRF0BAvXUxcMJyvBZbrNj40i8aH3HX1If75up+NqF6KVjNPDU0M36+Kyrv6fgu9pPmST8ij7/9pbBfTun+2qFkTcf0P++Rfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720324; c=relaxed/simple;
	bh=MiV92D8QQ10iCFVjAYyqrMSdVcuAQDEXW8pDK0EnXn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWqqTC6/Ov+vvSO2JkwE3BViOFqt+hL1iQeNcL/mpygAWjD5T0KSFNTdhvNYmjZcoKpVqIS+kTLwa/6D7JUMtAAcQhmrBi3RiU7c0hoXwEG+ZJB/ivsHvZgxdEbBTDElVR1atLFOLnO60s8dlrZ+pDHYi4togMahkZkZHYXpyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elNUmwcn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-788412a4b78so12105585a.1;
        Wed, 06 Mar 2024 02:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709720321; x=1710325121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IydbtLNEns7eyBLFSHBBwsU4SBsF7XwijLy2alncJ1Q=;
        b=elNUmwcnYWoTzgCxP4NqMZEXsuZtlAF93OD+xH6bA8ywGRw0Cj0DF/rEdHYdK2m9Q2
         uLvbokCVzrxXvcP26qd055ln6IxtTMT2AzUfzugVTViNduJdhPP0d48DevzRn/4VSyVq
         P+7ayBADYqe8ULg350TIA3+qL5Z+u4n6tBrthB4i7UrpvvbFL2o1M4QuAopeq5me1M17
         jdlLhHNId3Vsrczb2t+2dFhb7Z3mjSepN05p/ORqjjcLIfhm7ReHnxddDIvfi82xes/X
         DuLISaOnmuJqaL6Tgx9SZwjCjOoQpzw6AIn/zxUNqulY+8dwr85mMHydOV9S3zwhn6vq
         /6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720321; x=1710325121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IydbtLNEns7eyBLFSHBBwsU4SBsF7XwijLy2alncJ1Q=;
        b=galU5v1l8FqRyn6aS2C0AYAvMnTI5sjasxqRgAsR4gT6lQpDRIRG283y60THnLnWbm
         23pMMCYy9Bj6aJkRdGNLvxaYclUgzxMfZpGqRqtvPNDshWqaxRTwRC2fraipJ2+dvm+U
         NuT82lAznfFFBAFq6UtisOydlU7Lgq45bwosyFtfBqH/QwPTRb+qVUGHFU+xo536Ow6N
         TTjQb5bsAZkOugzn2WBAKVNM9y1tiCqLCLVwkvGj4TuF42FBiBS/OZOa1z6k/gqQjyo5
         Hh1G16GxfpV5XERd2qMYm+H4Zy1wJFFJHmn0oresr//KmzhUGyNMksw5fxpFhpaIolKO
         zdTw==
X-Forwarded-Encrypted: i=1; AJvYcCXXTZp/G23BYfE200ObVuaDPhwommA/UZOzWey4ofLWqVB3463loRyQILllP2XLtqrg+n9tPrDiwk+qlg5EKFcrDFKQfVe7CaL2+526SZEvniCSZNYsAYD+lACv+8yy4ghLLsQsdRnYMhDFGcoiz/sOvfxj2RrBC26uDt5CqTvogcFl7O4x8B5zljK2yNI4jR1VsTl6HoM8Kw+l0TvLA8f1
X-Gm-Message-State: AOJu0YxmfSQnZb9vdHW6E0fVqHeoBdT9+sgwsVMBiuAag6xD5fHD7K1A
	hcMgZeUx79gL8pZoduWVt+Bfgtu7pdOWIzPxQG5PsZ9XHNI6TKTLnL2aAj11u778ofVTIQYWwD2
	BRO/2Fj0AaN3ben1UQRl7ViNpW0U=
X-Google-Smtp-Source: AGHT+IHW6oZqvty15XrJ2DNJ5oMpfau2ujxE87nPT87XVsw4x/NwTWBqmm8aG2hKskrpAVNPp0ONKFA97bj38GJtmgk=
X-Received: by 2002:a05:622a:1045:b0:42e:e19a:cb5a with SMTP id
 f5-20020a05622a104500b0042ee19acb5amr4914503qte.47.1709720321541; Wed, 06 Mar
 2024 02:18:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204021436.GH2087318@ZenIV> <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-11-viro@zeniv.linux.org.uk> <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
 <CAJfpegtJtrCTeRCT3w3qCLWsoDopePwUXmL5O9JtJfSJg17LNg@mail.gmail.com>
 <CAOQ4uxhBwmZ1LDcWD6jdaheUkDQAQUTeSNNMygRAg3v_0H5sDQ@mail.gmail.com> <CAJfpegtQ5+3Fn8gk_4o3uW6SEotZqy6pPxG3kRh8z-pfiF48ow@mail.gmail.com>
In-Reply-To: <CAJfpegtQ5+3Fn8gk_4o3uW6SEotZqy6pPxG3kRh8z-pfiF48ow@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 6 Mar 2024 12:18:30 +0200
Message-ID: <CAOQ4uxgi8sL3Dxznrq2tM76yMz_wTxh2PLzMd_Y-8ahWAhz=JQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] fuse: fix UAF in rcu pathwalks
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 2:43=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Mon, 4 Mar 2024 at 15:36, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Note that fuse_backing_files_free() calls
> > fuse_backing_id_free() =3D> fuse_backing_free() =3D> kfree_rcu()
> >
> > Should we move fuse_backing_files_free() into
> > fuse_conn_put() above fuse_dax_conn_free()?
> >
> > That will avoid the merge conflict and still be correct. no?
>
> Looks like a good cleanup.
>
> Force-pushed to fuse.git#for-next.
>

FYI, the version that you pushed will generate a minor conflict with

                }
-               fc->release(fc);
+               call_rcu(&fc->rcu, delayed_release);
        }
 }
 EXPORT_SYMBOL_GPL(fuse_conn_put);

If you move fuse_backing_files_free() to the start of the function,
I think merge conflict will be avoided:

 void fuse_conn_put(struct fuse_conn *fc)
 {
        if (refcount_dec_and_test(&fc->count)) {
                struct fuse_iqueue *fiq =3D &fc->iq;
                struct fuse_sync_bucket *bucket;

+               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+                       fuse_backing_files_free(fc);
                if (IS_ENABLED(CONFIG_FUSE_DAX))
                        fuse_dax_conn_free(fc);


Thanks,
Amir.

