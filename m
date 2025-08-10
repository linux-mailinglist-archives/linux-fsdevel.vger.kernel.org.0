Return-Path: <linux-fsdevel+bounces-57231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A9B1FA11
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 15:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5823C3B7023
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2330524BD03;
	Sun, 10 Aug 2025 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5x6GaxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BF1C683;
	Sun, 10 Aug 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754830955; cv=none; b=TPqbKU7Z/YYVY6yQjBLR+oOhPPWp3Qtay7UCDSp0XT9P+M/bii5voAyl8PWjcC1HwMuNqqucjvGuedsDl+NOmY52hpf/fNXvVEfWhETfwDWg6otLCjoDzPhWWhB57vVJAimrJSKgkfN9eMNJTlN6m9KPv6PuIGASeYuFIlJPFiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754830955; c=relaxed/simple;
	bh=7vETKwtpidENX53WjwI6MHM6eVFOckiWgacFT/qG6FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fl4MDNWKxcSeDyX9fGiD3qYEfAY3f8vWVJlxs8NrVEyjzIyin/oaXZjWGLJoijUSkpYpzn8lfXy4ScTa9V2R8lXXpvyTe7vNyuX55hLQvNDlm/HmMXaGEasGBIkmaM8BKUpJykNKoqAhzx7MAUEB9cju9QKuqi9DF66UnaCzrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5x6GaxY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af98b77d2f0so660647066b.3;
        Sun, 10 Aug 2025 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830952; x=1755435752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSlOOEhHSp0QmqGAVt0Ofk92yXA+aQmJze++Vd3SO3g=;
        b=A5x6GaxYRh9k6qmp5rI3dT/W1fNYdHygpTq9FZOkjs4ur1PMpqvCoIE+R8CAh+NJ1N
         U/ubZ+2T3KT/ED0yDs0Ok0a93IcbgZRQ0e5S1qb94GO0RPC2eDv2e00C4uH/WO6iDM4u
         IvhYOnIbMsIXnh8U3IvE49PhAf/HDRzN6pwHvXs0Zmb9tEYRgHTlM735mzkkgqzIwSq0
         OCxnnONIGFU21b14mYgXBbUC/tzuZvzb5f1xumV6Nwo1qkRaMvO4ekDJ9zUhQJHzfJM6
         Pal6iuqmkZZ3E6XSVeTPutOeE2FC53IMqhKYDArsXx7CYnUcDyQApv9Que54rs+q2ZmV
         2hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830952; x=1755435752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSlOOEhHSp0QmqGAVt0Ofk92yXA+aQmJze++Vd3SO3g=;
        b=T1MJVp2Cgp4Yx/An4kkdNZx9TWnalEP9DLwJGUsH7oOTsfbBKu5Nu/eTIzDtc6pMT2
         XfOFO+pJOwlfQYBS/qL2zGISUorwNQdDagRNMuVv4d7Y/995iY8lAJ90mcH05ydI07m5
         iHo36g17NO5AM8KtegwYIzf9J4NRZftDLRExgFIEABVTLdkaiQKS8QdyCVzdNnWiIyhf
         ZOPDKe9ryK39ZGWw1cspP4YFOHBSG2CCPqRe6r/27zKorypl6mGa/ejqFpveoj7YB3CH
         bgueCgzDGUOO29TEmMvn/kPd3OZ/3CCtk5Y/2JMTgFOEmF9/lMRrCC/pMyE5JjuVr599
         j6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUC9hv1TYBBQmE7lJMm2Se/nSzw88TiZl+ZthezESdcJkI8O0AvGhSw7piNhZbJj8xNYUQYmbTcK/hU/BoT@vger.kernel.org, AJvYcCUh2u3regHOZTnbZoXORDB13c0NECUiIgW/2bUWNVIFBlz1QAUKOpqq/1Pmk8DNMo22J5BPdtWK1OdurHFphw==@vger.kernel.org, AJvYcCVpWqG3Tz5zWdogboKLTBUexBlMbCUPBIE+TXA8nM26qDTW6Zq45r3FMySJuxoGas5vy6EqoUQREDufbMMY@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhLu44rIWbYKiO1KSyV93HXbsG/LFwSFRmTnWmEPXPPyCMRSe
	WTCZqaGa0oDPHayQ4+kC6oTjXpD65yr7mbqNo0WS48q0px5gknOrIePUY2lMmd4/G+NvwrWFgop
	ITnU/2yf+jgVjR2B7nkl5WSTRLouye4s=
X-Gm-Gg: ASbGnctG6dnL6AAt+YgIV6N28RjybKwVFTWUEKBuKa0c0fWsWfmJ8oQtEfy53yZOqX8
	fAKPWiYZDGM52lWhDL3ZrX3EUMv2TJXOMCWtumpFF3LQu+biXpHYMz6Gel+/xYY8qNWDn8B8ttR
	+2zQQWiJN5OGcLA5L0uBa0HOFVgxG543FkxiZVe5WrDdhnsVw2PN49ACIFgr5RHnBI96QuIVX8Y
	iDcnRY=
X-Google-Smtp-Source: AGHT+IGc1LjBDs581anLLqxndQtaeysDoGVU+r3AisBDGvFqnux7ki0lPq5hSFTSlEIgP20ONz/YoIpX6TnfSC527jk=
X-Received: by 2002:a17:906:9f8b:b0:ae6:f087:953 with SMTP id
 a640c23a62f3a-af9c63b0a87mr823318466b.12.1754830951730; Sun, 10 Aug 2025
 06:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
 <20250808-tonyk-overlayfs-v3-6-30f9be426ba8@igalia.com> <CAOQ4uxiDtq4LF-OVtQ6ufmcAZqLn-jqynM06RgHLgUYOW-uHHA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiDtq4LF-OVtQ6ufmcAZqLn-jqynM06RgHLgUYOW-uHHA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 10 Aug 2025 15:02:20 +0200
X-Gm-Features: Ac12FXz3sd9nkTZqSLTKZCKnaQeDmVdIW_6sTRxrlBzilIXPWIRh2FNlF3TnYpg
Message-ID: <CAOQ4uxg326bEDdfKCKnoV0MnBBgRbxPEgN_41kBJv9HUdb-5dg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 6/7] ovl: Add S_CASEFOLD as part of the inode flag
 to be copied
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 11:51=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Aug 8, 2025 at 10:59=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@i=
galia.com> wrote:
> >
> > To keep ovl's inodes consistent with their real inodes, add the
> > S_CASEFOLD flag as part of the flags that need to be copied.
> >
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > ---
> > Changes from v2:
> > - Instead of manually setting the flag if the realpath dentry is
> >   casefolded, just add this flag as part of the flags that need to be
> >   copied.
> > ---
> >  fs/overlayfs/overlayfs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index bb0d7ded8e763a4a7a6fc506d966ed2f3bdb4f06..8a9a67d2933173c61b0fa0a=
f5634d91e092e00b2 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -822,7 +822,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
> >  void ovl_copyattr(struct inode *to);
> >
> >  /* vfs inode flags copied from real to ovl inode */
> > -#define OVL_COPY_I_FLAGS_MASK  (S_SYNC | S_NOATIME | S_APPEND | S_IMMU=
TABLE)
> > +#define OVL_COPY_I_FLAGS_MASK  (S_SYNC | S_NOATIME | S_APPEND | S_IMMU=
TABLE | S_CASEFOLD)
> >  /* vfs inode flags read from overlay.protattr xattr to ovl inode */
> >  #define OVL_PROT_I_FLAGS_MASK  (S_APPEND | S_IMMUTABLE)
> >
>
> Ok, this is simpler, but it's too simple.
> OVL_COPY_I_FLAGS_MASK is used in copy up with the assumption that
> all copied i_flags are related to fileattr flags, so you need something l=
ike:
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 27396fe63f6d..66bd43a99d2e 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -670,7 +670,7 @@ static int ovl_copy_up_metadata(struct
> ovl_copy_up_ctx *c, struct dentry *temp)
>         if (err)
>                 return err;
>
> -       if (inode->i_flags & OVL_COPY_I_FLAGS_MASK &&
> +       if (inode->i_flags & OVL_FATTR_I_FLAGS_MASK &&
>             (S_ISREG(c->stat.mode) || S_ISDIR(c->stat.mode))) {
>                 /*
>                  * Copy the fileattr inode flags that are the source of a=
lready

Which reminds me that you also need to verify that a copied up directory
conforms to the ofs->casefold expectation, because there is no code
to make the copied up directory casefolded.

We can assume that layers check has already verified that upperdir/workdir
are casefold correct, but we need to verify that $workdir/work/$tmpdir crea=
ted
by ovl_create_temp() has inherited the expected casefolding.

Same goes for ovl_mkdir(), we must verify that the new created dentry/inode
conform to the expected ofs->casefold.

I think this check in ovl_create_real() should cover both cases:

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 70b8687dc45e..be8c5d02302d 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -187,6 +187,11 @@ struct dentry *ovl_create_real(struct ovl_fs
*ofs, struct dentry *parent,
                        /* mkdir is special... */
                        newdentry =3D  ovl_do_mkdir(ofs, dir, newdentry,
attr->mode);
                        err =3D PTR_ERR_OR_ZERO(newdentry);
+                       /* expect to inherit casefolding from
workdir/upperdir */
+                       if (!err && ofs->casefold !=3D
ovl_dentry_casefolded(newdentry)) {
+                               dput(newdentry);
+                               err =3D -EINVAL;
+                       }
                        break;

Thanks,
Amir.

