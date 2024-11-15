Return-Path: <linux-fsdevel+bounces-34872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCF49CDA0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 08:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8162833CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B04118A6BC;
	Fri, 15 Nov 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8ACBon8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A21DFFD;
	Fri, 15 Nov 2024 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657045; cv=none; b=h1IStl5weA7fRvKU3N49WEdoCGGBvgMtiwM9W7JwLXfDG/FrWJbbJFr9lRK0mOz6vE+jdSgaV/kWRhGMYRu7IWuJjffowpqm49JFaD905cgFbQ10nQOkpYeQRZuWmMx4hHqj3dT2vS7Q7d1pdc73IbXYtbLVXPH6jK/4zsvtagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657045; c=relaxed/simple;
	bh=lklE/h3tDzXVoR6ngV+NqfpBcWmdTi9t9s8wjTuCeGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YozC1Ru4PFacftRlhsk6SYc5ppgOc9/nSubAExt7GCH4QMg1ur0NwLLb9OagJFRpjUG+QEKydz8WLmVpuXXVkEJ+/82byU9iSyeY0S2ft6ggb87iSyy5UoBx++1WT4KYLq95W55qPZvy6omVxyIpNTX00FmueXHvUSZctn2aG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8ACBon8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ec267b879so76827066b.2;
        Thu, 14 Nov 2024 23:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731657042; x=1732261842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSCELLkG6SqRQfxY54OPgk4TIjdd+v1bnFxBYGVAXQA=;
        b=g8ACBon8WVH5PrCzEK8qdlM0c3x4ryskNaoT09762j5NbyFYtKZG/oPn72tlZ0mUwz
         ar4vyr07JVjN+qJwY2wfi9KejnsLryuxeqzpmAGlOhjaXfNjIp6rsMxhUbeCV7m2Jn+s
         LFC+7nsxItwj9zNALqkc1Q2FlKd2ER/1wF1d+GSjnWcu30SChhDf0NmdGe+bdgt+BINI
         pndYUH5wwsKHkoy6gJxOTqIg+fZmNSiEedVd2ij13A7qTZmDVkprLxU/QhfzhzIykstv
         v1+lOGvJBP5i0+X1J0aVQ5lK8rB19WESN/3fZ5u7D2yUZ1eHqFHw7AYYIyV7hTk6pvY1
         R+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657042; x=1732261842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSCELLkG6SqRQfxY54OPgk4TIjdd+v1bnFxBYGVAXQA=;
        b=KBM5oJUjaMlCNUBow5OwcyVcx3sOxjl0GGlu/JSztBEPeQW23aYtYjLG1h9DEkunqN
         8/b0oH/o2KOFtLvAavd6d2rwIVqN3tw06zUjvtGOKTshfOJhtBukNq1vC8gy5SaFKwwt
         rODbKQ2CAePskpyqJUFQVdDI+U+CMV4Or27Jn1u9ifzSKld8FU3L41M/kLrMN3s0Ld6R
         DkHuSmn/ssbqHyWAYWxV6DFBjhoPFuV+7pWrSXIkJ9Lg/SgLLUhVMGe8+FlaPOl7y5rD
         vxUgZ/LAvF3Vh+dwsmycaL8xqhkf46S7Wt/EYpX+HZsubh0q2Zc11HS4gh9TX9ba3OTb
         ZaXg==
X-Forwarded-Encrypted: i=1; AJvYcCUlZOI12p1PHeemHIETkBpTUfm36RpdAKKuc4HVYn9LMyohA3K3Tb2dr1HKbtCRPpOidC59CRJSO68fUk0P@vger.kernel.org, AJvYcCUrAU6ZPOvBBzRWkK8Iumoqm54680doveZzOEn5AJblwBwP7divUbTYYqVPTisCOeIY37JMTvazFxyx@vger.kernel.org, AJvYcCVBxtZ2xLPd4tGBUr1FQ8kHxWiVK/3/kHZJ0cZOgwO4KVEXXaVXwIrNKXGbH2vqmkDgcUCKgFXSpao+jf9h@vger.kernel.org
X-Gm-Message-State: AOJu0YzGywJgrr8OBFKHTYFsqYrSBDlYIUhwW31hN1Lz2YwggMd98Dwp
	1NohkHgI70gutYGZkXapUll7XX2niMmfeIL7OmYYF4hKADAeOIfLJWQbCPJZgjxeEEdpAiWiP7l
	kdZ6v689ITk/DPXl9tjitU5OKs8cMYMdmons=
X-Google-Smtp-Source: AGHT+IEi3bcFpS5EBdh9BX9bznABAMyAWwxnKMRIdw/iNJL8JS0W2vQeO8MtkFnuX9eM8/QDG4g9uAC7+XPhZfXCTMw=
X-Received: by 2002:a17:906:dc8f:b0:a9e:b0a6:6e13 with SMTP id
 a640c23a62f3a-aa483469563mr138192866b.30.1731657041921; Thu, 14 Nov 2024
 23:50:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu> <20241113-pidfs_fh-v2-3-9a4d28155a37@e43.eu>
 <20241114-erhielten-mitziehen-68c7df0a2fa2@brauner> <1128f3cd-38de-43a0-981e-ec1485ec9e3b@e43.eu>
 <20241114-monat-zehnkampf-2b1277d5252d@brauner> <b4353823-16ef-4a14-9222-acbe819fdce8@e43.eu>
In-Reply-To: <b4353823-16ef-4a14-9222-acbe819fdce8@e43.eu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Nov 2024 08:50:30 +0100
Message-ID: <CAOQ4uxhP9_WPinm2wM6uW+L0rH_xwwrw=qAUd_YjzbFCJBf0+g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pidfs: implement file handle support
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 11:51=E2=80=AFPM Erin Shepherd <erin.shepherd@e43.e=
u> wrote:
>
> On 14/11/2024 15:13, Christian Brauner wrote:
>
> > On Thu, Nov 14, 2024 at 02:13:06PM +0100, Erin Shepherd wrote:
> >> These two concerns combined with the special flag make me wonder if pi=
dfs
> >> is so much of a special snowflake we should just special case it up fr=
ont
> >> and skip all of the shared handle decode logic?
> > Care to try a patch and see what it looks like?
>
> The following is a completely untested sketch on top of the existing patc=
h series.
> Some notes:
>
> - I made heavy use of the cleanup macros. I'm happy to convert things bac=
k to
>   goto out_xx style if preferred - writing things this way just made bash=
ing out
>   the code without dropping resources on the floor easier

Your cleanup is very welcome, just please! not in the same patch as refacto=
ring
and logic changes. Please do these 3 different things in different commits.
This patch is unreviewable as far as I am concerned.

> - If you don't implement fh_to_dentry then name_to_handle_at will just re=
turn an error
>   unless called with AT_HANDLE_FID. We need to decide what to do about th=
at

What's to decide? I did not understand the problem.

> - The GET_PATH_FD_IS_NORMAL/etc constants don't match (what I see as) usu=
al kernel style
>   but I'm not sure how to conventionally express something like that

I believe the conventional way to express a custom operation is an
optional method.

For example:

static int exportfs_get_name(struct vfsmount *mnt, struct dentry *dir,
                char *name, struct dentry *child)
{
        const struct export_operations *nop =3D dir->d_sb->s_export_op;
        struct path path =3D {.mnt =3D mnt, .dentry =3D dir};

        if (nop->get_name)
                return nop->get_name(dir, name, child);
        else
                return get_name(&path, name, child);
}

There are plenty of optional custom inode, file, sb, dentry
operations with default fallback. some examples:

        if (dir_inode->i_op->atomic_open) {
                dentry =3D atomic_open(nd, dentry, file, open_flag, mode);

        if (!splice && file_out->f_op->copy_file_range) {
                ret =3D file_out->f_op->copy_file_range(file_in, pos_in,
                                                      file_out, pos_out,
                                                      len, flags);
        } else if (!splice && file_in->f_op->remap_file_range && samesb) {
                ret =3D file_in->f_op->remap_file_range(file_in, pos_in,

So I think the right model for you to follow is a custom optional
s_export_op->open_by_handle() operation.

Thanks,
Amir.

