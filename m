Return-Path: <linux-fsdevel+bounces-32174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620899A1CF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 10:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279312842EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 08:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255711C2447;
	Thu, 17 Oct 2024 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU+8jLH+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64AF42056;
	Thu, 17 Oct 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153131; cv=none; b=A4oRE9TFsQpvwKMQEHc3BJcEVN+a5bCRK9QiT3uZyqmgR626MIwHTa37TgMlsN7NeqvKG22zrmO6NtnnoCNEAPmN18KMRQE60UX6p+TvES87hF96CRnzmk8dxn8FnB83dx99tDkOHu66gxblDol1I+wtlSXwsCi5vq4QXpS/1J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153131; c=relaxed/simple;
	bh=4KWFVMDI3jHOIxJ1eJYtmG43GekF6zpcFJJbcQ06EaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeMq4p1NYAfar04QBpyWh9h22+yUKaZheVnJb3lRm11kC8vfGQp8d1OynQ6uIG0qGPD58DWqx2mK1d2HIH++LhV8JJA2+G7nZ3SBbNFQKZXOwo3bdzwWghwIayG26yxoBCKOwyrdoymGERcOf7iFpollFbxW4xFrGSC1CrJAJ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU+8jLH+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1363c7977so72431185a.1;
        Thu, 17 Oct 2024 01:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729153126; x=1729757926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahmJ6aNDC27qVSG1vtGyjgtWbZrKFJhZb+Y+SNRFD0c=;
        b=FU+8jLH+BBz3fYBPXLb2NzjGVGq/MyLPvJnhv8F8F/gXaJfF4CrQSTcs9tIoUHD4Dc
         PRYjW48D0fTy/wiLtRoQYxzTtiM33Q7OJg22Bc9rdkYDV5OUMBjKJznmb4exJNtbwVKj
         3l42JVxsSHym2tT38TGJxkWOed5vp84ttLRRbPiG9/387rX6i3UlxNhC9FNRhVRwuBwb
         W5hMmkPUorBZ/XVxR1gJW3Tcx60xrrR/56CwbzADQsmqOs3xXs3dBMAg7QI7CmdU2E6Q
         dn8ZyjfAv1jf1mHYHkzDgb4Eh1CX2X5JnLTMHINWqiofKEjkrKI8aO8ujLvyvOQZOeL3
         tR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729153126; x=1729757926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahmJ6aNDC27qVSG1vtGyjgtWbZrKFJhZb+Y+SNRFD0c=;
        b=IKWAn50ztJ4sjSzO8Sn4EG//bC2EhVCcWDCv+Ke4SUmFtZsqiv8wRmGhrRFKCg4o+o
         ubw35Vb+wMwZh+F4z+bR0gGD0KEOPN7gtS+TmLWoQudziVQu+OJhM2E/kl3HVSiYVZQD
         3fK7nNaK015aXnI6ayzsZL/gU9KVZ1kE70ATfnVF7fE2Co3UA8t4hejYIcYBhAxYT2Vv
         FoGTYg3+Qo1P4/rPh1c+Sh7VQSSm4bad9MX47cA8h3RkfVAQIyFw8xGw2qVwuncsLKGE
         WuxUofuINtnmxHtF/u4ilBfDUh3BPQ+Hrrkw0NpKZSbEbPm98/7RuRTJ/1Om/XozIIHY
         DmiA==
X-Forwarded-Encrypted: i=1; AJvYcCX/It5MgIlFkXxgzFD/ZarO+SlbwoUmHAikLVAWBQz5EohVMUNpwg+1+T/7WyHS0jsFJiyu+ea1Dv8A82M2@vger.kernel.org, AJvYcCXm16zER2n8NjhKfN8YDZWvfQ5wUCVgl8pKzYALOkCjjRIfn8NWm4KLZ8H216HEUSrTowuS735pTwGX65YoJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoz7embUGcT0ps1zmvpmKD0mKTENnbePIzYPvoTF2lvV/mMUJx
	pZCu+PTJN9Lq+vAbx7iLjpSBHFKsJr07ptTN1kJTOB9xmYbnDt+BRzfHvfNQZrh4seUOUN2uPk5
	lD6hRqsAU126BxXLJfUJFCbTgUTCO4sSq+MQ=
X-Google-Smtp-Source: AGHT+IFb7Ok9DEsooBii039F6/gJ+nybi9DbNTpZniOWUR+ty/w6wrFHYT68P+HUGarsZDGSEv9nxQzQCQU12L5dckI=
X-Received: by 2002:a05:620a:4116:b0:7b1:4aa3:d3c9 with SMTP id
 af79cd13be357-7b14aa3d704mr440802885a.61.1729153126411; Thu, 17 Oct 2024
 01:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007141925.327055-1-amir73il@gmail.com> <20241017045231.GJ4017910@ZenIV>
In-Reply-To: <20241017045231.GJ4017910@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 17 Oct 2024 10:18:35 +0200
Message-ID: <CAOQ4uxh-P91UN4=jM-CgdGfD929PskvTVbuY0hFAU9N61cUuRA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Store overlay real upper file in ovl_file
To: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 6:52=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Mon, Oct 07, 2024 at 04:19:20PM +0200, Amir Goldstein wrote:
> > Hi all,
> >
> > This is v3 of the code to avoid temporary backing file opens in
> > overlayfs, taking into account Al's and Miklos' comments on v2 [1].
> >
> > If no further comments, this is going for overlayfs-next.
>
> BTW, looking through the vicinity of that stuff:
>
> int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wd=
entry)
> {
>         int err;
>
>         dget(wdentry);
>         if (d_is_dir(wdentry))
>                 err =3D ovl_do_rmdir(ofs, wdir, wdentry);
>         else
>                 err =3D ovl_do_unlink(ofs, wdir, wdentry);
>         dput(wdentry);
>
>         if (err) {
>                 pr_err("cleanup of '%pd2' failed (%i)\n",
>                        wdentry, err);
>         }
>
>         return err;
> }
>
> What the hell are those dget()/dput() doing there?  Not to mention an
> access after dput(), both vfs_rmdir() and vfs_unlink() expect the
> reference to dentry argument to be held by the caller and leave it
> for the caller to dispose of.  What am I missing here?

It has been like that since the first upstream version.
My guess is that it is an attempt to avoid turning wdentry
into a negative dentry, which is not expected to be useful in
ovl_clear_empty() situations, but this is just a guess.

Miklos?

Thanks,
Amir.

