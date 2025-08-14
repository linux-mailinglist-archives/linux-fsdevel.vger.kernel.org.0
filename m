Return-Path: <linux-fsdevel+bounces-57890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B667B26700
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CAC586A2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8110E2FE07C;
	Thu, 14 Aug 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZETqsRz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8615E8B;
	Thu, 14 Aug 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177648; cv=none; b=qwqArTh2KKLEFdkNVEgYdDnz6jXORyH5IiEueL8KNF3C+Mvt48lel8TSvukLGWVDMAH36ZgtnGtgHXzYbyiJPd90cSSbg6dPrQ5eWqntb/sBj3SyNAUC8eqqGXE1RlTbu+es89kkuyB6raCV7lVSK4sEI2nY4rLx9KQyMxbwvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177648; c=relaxed/simple;
	bh=q4+priH6gljab/J8mgG1DxZQtBqWjW5pnBRof8Dg5i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D71BavqK/JKUekrmjuKvi4kfP0JFCATcbaietG8b++cGBMXI5avQipNOtqbU+k79zjzn/7XwJCnMYSq2PuCDoHFgGyReCKoqCuoWCogQNxcHnzls4KhfSeWGejD7m8RBp+ley2Vjc6i6EvO91az0ZSfLW8LGJ3FIwaQbT/CCzXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZETqsRz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61868d83059so3513397a12.0;
        Thu, 14 Aug 2025 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177645; x=1755782445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oSiPPEStsj1x1w8YAY/e/N9xuWfKRjEsWVuQUnCX8I=;
        b=FZETqsRzCD6yyeVuWkghutfgyTrL4zlkmV7DtE5No8M5LIiabPEbIDGZeKKRWgVBv6
         CqzedQT4u7w/cDc5xy+kL04B/4RZucrmpk1xeEKrfyvewBAzrMv+ZchN2zmKWdsQCzUh
         AEjPoLVzp/pbmC+Ahe2vSak1TRpaenQguDFRrVW07c1zwAuibwy1h/6bOeaS+d1hnpi5
         laIqWRdRIdYf6dFnv23mYgNzMHliPcPZbTajuoXONIRz3W3AZSYfGtc4inBJ6Ku8qpjz
         oSWd5H7RfZyvz4RKd9qBlX9qGSPc5Z5w8C3JGP217K4MdyKUOFaDAlAzr7h0RACXhwBf
         C8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177645; x=1755782445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oSiPPEStsj1x1w8YAY/e/N9xuWfKRjEsWVuQUnCX8I=;
        b=nWt/z54dX/q+8S4V3zjuabiDDDtgPkbmTJylTMsKsdoOS/6z6+HGcu7jxg6s85LvN8
         Aykh6LRJjIeLlc2VE5MJ7s8SpuKMdZKz37VSxtTUbYNlQu8mtb72Ez7K31ptVctJyqRy
         xM6Y0FKfU9mbR8XzAE5Q/TQiSD0QGJqKn3I1XB0P9tsnBaw1LETLKm50NLMpTG9FxgFs
         OtkStkEMxfU0EuB22/VYFto5/o/bgSk8KoplrBrXFUd5mgQBNAHgMTPpQf24AMCz7oZc
         YQZ3fmmK62To3UHaM6xo2s4gvKhV0YYjwqPuryRLxLSanO7+lafibJF7KCgYuCdBlY+V
         SMZw==
X-Forwarded-Encrypted: i=1; AJvYcCVx0GADwDEtHDbC23IhKLVD7K1PLJsFB7BKuzBWX+v+8tdmWOyyFDOG/rI5/G/RSEiHEMOq/McrhdeOcbzH@vger.kernel.org, AJvYcCXIe27J1gVb+Po3cOvJBSvkpEcGbTmVOIlqeWUIVK7CDuQyJPb9yHcdJQfEZZ0MPSXYky/AVEquXeYPmjVzpg==@vger.kernel.org, AJvYcCXskeys9Zhb+LTGLPQSf4bDWiZWTVeDF9Gujn55AxBnj2eB44Md6apeG2DLb9gpXLga/lks9g80EPlEXvbK@vger.kernel.org
X-Gm-Message-State: AOJu0YwgdcfdQQOdMRu8zk1iAqUoVmiSpCsswCY8aINf31mbcLQ5AOXN
	AujChMaw5dhuEjgrIRJ3SBkyC8GVEpRbKwX/ihQLbQcb5rjvEVocUEjPNFvQ24eUNUU89xz5hyE
	Mnx47mImM9u3o8B6z5bFCa5M0IFIqKhE=
X-Gm-Gg: ASbGncvURtDYdMHZTKNobtVB7vi1EVhG6v51lRpKKzko83aqzsUiHJyl/xPDv0bwDI6
	ZjOg+MoO/3SCp8Qhuh3/em46hxUSV99aO3lWML/7K9BgGXut6Pl8HIoFRefRnNgw0TLGmhFMkYL
	Z8ABYTeh4QxB7Sl/GdSii6jNmXfchySqJY90BGar4lvMPtTOdDDxqQcIaN59LV1ho38GLMJ3TDS
	3gJExg=
X-Google-Smtp-Source: AGHT+IHG0GOQiZna7JR/3ExbU7vrUCRVs0EM1wwTcwB9b7gEF5avpy6V09Zl8+BtGdNATMNltq88wefwfCuy0mBt6dw=
X-Received: by 2002:a05:6402:27cf:b0:613:5257:6cad with SMTP id
 4fb4d7f45d1cf-618920d9331mr2321918a12.11.1755177644475; Thu, 14 Aug 2025
 06:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
 <20250813-tonyk-overlayfs-v4-3-357ccf2e12ad@igalia.com> <CAOQ4uxgDw5SVaoSJNzt2ma4P+XkVcvaJZoKmd1AmrTuqDxHc6A@mail.gmail.com>
 <22a794e8-39c1-4f30-80c4-989a81c6b968@igalia.com>
In-Reply-To: <22a794e8-39c1-4f30-80c4-989a81c6b968@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 15:20:33 +0200
X-Gm-Features: Ac12FXw-rOblpO1pJUs_vqUP1bE5j28K8hnVVOjyQM8mL7HqY5UWAFO7b7zzXms
Message-ID: <CAOQ4uxiYdbr8X5uFxTdqw6ba7E+6KZY0mhQYw2_t875gw4vfiw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] ovl: Create ovl_casefold() to support casefolded strncmp()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 3:02=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Hi Amir,
>
> Em 14/08/2025 09:53, Amir Goldstein escreveu:
> > On Thu, Aug 14, 2025 at 12:37=E2=80=AFAM Andr=C3=A9 Almeida <andrealmei=
d@igalia.com> wrote:
> >>
> >> To add overlayfs support casefold filesystems, create a new function
> >> ovl_casefold(), to be able to do case-insensitive strncmp().
> >>
> >> ovl_casefold() allocates a new buffer and stores the casefolded versio=
n
> >> of the string on it. If the allocation or the casefold operation fails=
,
> >> fallback to use the original string.
> >>
> >> The case-insentive name is then used in the rb-tree search/insertion
> >> operation. If the name is found in the rb-tree, the name can be
> >> discarded and the buffer is freed. If the name isn't found, it's then
> >> stored at struct ovl_cache_entry to be used later.
> >>
> >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >> ---
>
> [...]
>
> >> +       }
> >>
> >>          INIT_LIST_HEAD(list);
> >>   }
> >> @@ -260,12 +311,28 @@ static bool ovl_fill_merge(struct dir_context *c=
tx, const char *name,
> >>   {
> >>          struct ovl_readdir_data *rdd =3D
> >>                  container_of(ctx, struct ovl_readdir_data, ctx);
> >> +       struct ovl_fs *ofs =3D OVL_FS(rdd->dentry->d_sb);
> >> +       const char *aux =3D NULL;
> >
> > It looks strange to me that you need aux
> > and it looks strange to pair <aux, cf_len>
> > neither here or there...
> >
>
> The reason behind this `aux` var is because I need a `const char`
> pointer to point to the `name` argument, and `cf_name` can't be const
> because it goes through ovl_casefold(). I tried a couple approaches here
> to get rid of the compiler warning regarding const, and the only way I
> managed to was using a third variable like that.
>

I see. In that case, I'd just use these cleaner var names:

@@ -260,12 +311,28 @@ static bool ovl_fill_merge(struct dir_context
*ctx, const char *name,
 {
        struct ovl_readdir_data *rdd =3D
                container_of(ctx, struct ovl_readdir_data, ctx);
+       struct ovl_fs *ofs =3D OVL_FS(rdd->dentry->d_sb);
+       char *cf_name =3D NULL;
+       const char *c_name;
+       int c_len =3D 0;
+
+       if (ofs->casefold)
+               c_len =3D ovl_casefold(rdd->map, name, namelen, &cf_name);
+
+       if (c_len <=3D 0) {
+               c_name =3D name;
+               c_len =3D namelen;
+       } else {
+               c_name =3D cf_name;
+       }

Thanks,
Amir.

