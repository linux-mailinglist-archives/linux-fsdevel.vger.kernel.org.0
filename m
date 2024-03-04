Return-Path: <linux-fsdevel+bounces-13479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FCA870451
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6003B26877
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A445022;
	Mon,  4 Mar 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Prx35QaI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916C83CF68;
	Mon,  4 Mar 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563020; cv=none; b=TQ2h56SvD/Ku+Bpxnc3X2MKPmgAjoEXJPyZL6Fh+rusd/PeFtGvCC4ZPwoWEXZlxjzv6DUbdUoDRNh7fYGQ26ZS5T50bEVfBblaQw7Qevqrq0+CAZB65VWnl8FA7poiHuFNWlhRkI4h4EefbUxOT77EUX4+QFghLgOlPK1hGEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563020; c=relaxed/simple;
	bh=7Q8u//I0NChFb/SG3nPqpu2hUZlVNJ0AXcNfX8C2AG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDlJH8Wmfp7lDJsoJzjDI32dxZ0lrjrlBDSNOLYWqEdQyb7sR5MwCxcYTzlem/qIfu3lcq8Tv8+aKWFmdHjHSivlYtNcFnT4eOvWLAUXnU1PQvchPz4UjGIlPjzFQg0i5Mcu4No7TG+KegjPHIUWKNkh8PEaoHaG5FjxQ2C7aG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Prx35QaI; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42e8758fd52so34266951cf.1;
        Mon, 04 Mar 2024 06:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709563017; x=1710167817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ueg1LzXX/gmckj0YGtUgOHDVn1Q5Y8WQ6pvHjt3CJBY=;
        b=Prx35QaIQB1wnZH/u+yaDhzUv3T+PMePLJatRTyQuy/7fIGvZgTd4NDYTwq0GfUjgp
         wKmWpb+1L0MkHGvBdgUox13Q3LvEkIMhenxPva8HqY6Q6OWM0eT6jZOZ3vJv0NKVwm7u
         DcnGjE2sc0Iiz9e/1nAu+B+rgY0hqmUkSNtNMe/tisECw90KqyJvlGA6mJdzdbeUeAEX
         Wp88abgbC/5eINlom2F/wQjNTKF5HqDIszetg7lOb90kzuI5JvEWmGtrD45FFHhW6dvt
         jd0ciKtXTWnOBt1SMOm8jjTvgH1fdptNAoz+P2D+i/B6ShC7bEMl+Aft6CbodbHMXLUo
         oV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709563017; x=1710167817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ueg1LzXX/gmckj0YGtUgOHDVn1Q5Y8WQ6pvHjt3CJBY=;
        b=YmEJiSEizrJgG/EsFYTFPEFtzoYIRxei3b+5dHZZTyW9vWTDPIhS7jUV/ZUOSAZpjT
         BtKOWXjWUbWJK32TbfPck+DvKAR31AbY/2ksqigfxes3xPLTo5wqFOM7rGn8BpoBobXK
         5QB5grCb3DDW5MqszOlHX+ueaihnTkvu8FHYssLRB8hewdHv+TPEu6i9lOUvfqVYe+vr
         VtY4CEnArlT5IDEeU4p6kFGEz3k6dj826Epvk6OHn9n8pWuRvVG+93EAZPEHMn/VYmRe
         Lr07tzIU+nfPVxPjFGEoUT7dlkLYifCt+GJL34F9nDJOVBR0z8WZWQKFavrzniCsHbcj
         s4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtwi1tZu/f69wfqcCMEt542e97TzLOYfPudA2kvtjxQ9F+UnEef8EpSm7owTT8p2mJBUWs6+yWOPuDHB88mW9jxeY6jOC/2/ScqIX/ZQSKUMPSF7uwj9veixL6uCXLtxUntzG7BS/ZD6z3ZSFW6Srdo2GW0srLKvN4SAsGSltyhaoXjR+sgNb6/4ZzydD6EyeP8cxEWFauttemq261Y/Fw
X-Gm-Message-State: AOJu0Yyd4kCb7fs3nKoG026reYWPDbcNaqxc4/ztgmAQ8j1gncIFl0HP
	Zbgz2LV71DMVU6BDclohx3N5BrnQNW0bAzV86cLZFFy8O5ipy+T3qBqFmQ1hVbmBCzJbdhHjgRN
	Sl1UGpyeE6zqFC4NOyI+AgBJNMBZypf3ihWg=
X-Google-Smtp-Source: AGHT+IHz5+H37MGVV7IGn2MGmA63Pt/2gNaEx+CQKMOYep0lh2b/cdqPyygE9RKmyqzM791YiilhqAporHp9m7ClBYg=
X-Received: by 2002:ac8:5e46:0:b0:42e:f4aa:e737 with SMTP id
 i6-20020ac85e46000000b0042ef4aae737mr2336629qtx.50.1709563017482; Mon, 04 Mar
 2024 06:36:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204021436.GH2087318@ZenIV> <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-11-viro@zeniv.linux.org.uk> <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
 <CAJfpegtJtrCTeRCT3w3qCLWsoDopePwUXmL5O9JtJfSJg17LNg@mail.gmail.com>
In-Reply-To: <CAJfpegtJtrCTeRCT3w3qCLWsoDopePwUXmL5O9JtJfSJg17LNg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Mar 2024 16:36:46 +0200
Message-ID: <CAOQ4uxhBwmZ1LDcWD6jdaheUkDQAQUTeSNNMygRAg3v_0H5sDQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] fuse: fix UAF in rcu pathwalks
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 3:52=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Mon, 5 Feb 2024 at 13:31, Christian Brauner <brauner@kernel.org> wrote=
:
> >
> > On Sun, Feb 04, 2024 at 02:17:37AM +0000, Al Viro wrote:
> > > ->permission(), ->get_link() and ->inode_get_acl() might dereference
> > > ->s_fs_info (and, in case of ->permission(), ->s_fs_info->fc->user_ns
> > > as well) when called from rcu pathwalk.
> > >
> > > Freeing ->s_fs_info->fc is rcu-delayed; we need to make freeing ->s_f=
s_info
> > > and dropping ->user_ns rcu-delayed too.
> > >
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> >
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
>
> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
>

Miklos,

FYI, this is now merged and conflicts with:

dc076c73b9f9 ("fuse: implement ioctls to manage backing files")

from fuse/for-next:

--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@@ -1373,7 -1398,9 +1405,13 @@@ EXPORT_SYMBOL_GPL(fuse_send_init)
  void fuse_free_conn(struct fuse_conn *fc)
  {
        WARN_ON(!list_empty(&fc->devices));
++<<<<<<< HEAD
 +      kfree(fc);
++=3D=3D=3D=3D=3D=3D=3D
+       if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+               fuse_backing_files_free(fc);
+       kfree_rcu(fc, rcu);
++>>>>>>> fuse/for-next
  }
  EXPORT_SYMBOL_GPL(fuse_free_conn);

Note that fuse_backing_files_free() calls
fuse_backing_id_free() =3D> fuse_backing_free() =3D> kfree_rcu()

Should we move fuse_backing_files_free() into
fuse_conn_put() above fuse_dax_conn_free()?

That will avoid the merge conflict and still be correct. no?

Thanks,
Amir.

