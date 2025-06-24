Return-Path: <linux-fsdevel+bounces-52784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE6DAE6996
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 16:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B653ADBF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CEF2D8DB3;
	Tue, 24 Jun 2025 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FddPh5E2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B58A2D320B;
	Tue, 24 Jun 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775660; cv=none; b=K9k/pTlWmavBfWT5UwggzoRWlBddYaXKz1Hu+mNeS8xtslDeG1PW01jEf70Gu5aWvcNGM2enuqfmp3d9B0uW/IG4dpl0ub3RF934bgr0raWvP1sudCyRwvCiMn//YqcoHiqBoYm3rB1Ldgj6z0YXxfUwVLqMWVPtAr4u2LLpHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775660; c=relaxed/simple;
	bh=mR8OZjaMltFqfuK+fSedOmSOvyWySTkyTjF8bS4Ya0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5y9YrWYzdTQlj0CC+u3vN4BkUjVsko9RM6E+52yYr4TdHzeuQU6/lVFDfn5W1/UGwnIZx5aNKhTwlgp3CrSp4R6tzW6sneKdcbNrP6X/jeqrUK85b39Er3OUE3trrNo1+Yywhrm2WwHXEN36+b0MgUiM+u1aJGHKroRe3hSYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FddPh5E2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adeaa4f3d07so1058894866b.0;
        Tue, 24 Jun 2025 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750775656; x=1751380456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72qxCVAhxG0l1ojddF5BY3xEQejP5YLVLQXixIgXXwI=;
        b=FddPh5E29cJXJOSAlxGiyCte3d4+t13XlxAFFrj9CggtNN6D5RS/O6gaM+UoBd1oeK
         eTVOkk0KWW3CRG+CmABBFjTIR2jKDb3WvPLc26csUZJN1BdhPYYgOxd9fpGmsUCdGtI+
         XhL/7OW9FEhm2ChdKUghBAF4oojY6dzTzPt6h+YpnzrhvFLklsBm3MvKFHEPXXZyqiHt
         K2vClKrG457NxIm47oTAqHrM2OJuGEkp9p5Z/2N0lBNowf1MDzWEoYsCPad9T8IHtXU2
         o4sNmVsmUMPN18QuLkXhMifQQoS8+KGi4POwJSgIQI3qTSTLuG7o/mrNH6uXo07cTCI3
         7Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775656; x=1751380456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72qxCVAhxG0l1ojddF5BY3xEQejP5YLVLQXixIgXXwI=;
        b=jytYzEzpOEfL0R5XSODZW1BKmEinQiY++PYEilxDkLXUq65jH/wDtc0jcwK8DOTkkO
         45l/6xAtsn/ovM2C8mEl5onM4qfQDLGSEw3fQkLVA5VrH2BAU/GLtIy8GhtrHlBRUvKT
         RKUR4aNbe9ylLSFeHh3rAj0gtvKkm2GrQSwa3CqZ6+bGeywMvPi53co+ysHiC3d+ookt
         pvne7xygS+cEUYoEDxJg3TTQlrTA099YufEDJOCDoeQi3LXBkKne7Y/Rl3bCJmVNvWTY
         D9tBrXKp9F2nZxEXIrEtAhvRQhk1UKP4V9QLAfnGuIIABB8NU5tESwStFma896dV7Qmq
         NPsw==
X-Forwarded-Encrypted: i=1; AJvYcCWDSODxdV48lxiUKN97nVhtTOqBat0AycQEMe6h5KLmloSyZvlLIMTyxZF2FJiH65HTKjati0bav8yC@vger.kernel.org, AJvYcCX5DlobilIsUxamV417x2cju3iQBu3YeBDq0N+ixWBqVLxn5rXpWULC1aTkwGTXnKU93M7mvpMR2EaU1mxG@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTGOuwbxBnVKfmLNkL+MrrQQMv/+1xPgbLtRnYREgQjvp/B49
	Hj6KFlNTY4MCVozFbtyTrXqOuZnLUBQsA2rrLloZIomOnPntUr8rotk91a7BPj70K+lzuT6eb5i
	T+QDJ9PET8T464eSeynd65ueqQQFWqAU=
X-Gm-Gg: ASbGncv7jfERt4HIfAuaeNW7CAnGg+pxj7Ml6SYFooOAp2aBGA78m+pgd2vJA3rrvGL
	XzPm394cQbyj6GphNFivqovsdFEgHUvwDMGu0T01/KUIaw9h2i02KKRg0+TTjkL7QV/MEj9t7gl
	zGe36JWcwSC6Y2S4Z3EOjkkjiqAUHKtNCFNj+CFUG6AqU=
X-Google-Smtp-Source: AGHT+IGRwrmvqkKRfM+vE7XjMxLEjIXa685VUZ8kxquV/RL8afyI1J6wUucsGZgyCL/xRUHS2Qmd4EJLHDvCkiPpzEY=
X-Received: by 2002:a17:906:6a03:b0:ade:17b0:9f48 with SMTP id
 a640c23a62f3a-ae057d81821mr1680953566b.23.1750775655231; Tue, 24 Jun 2025
 07:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-teestube-noten-cbe0aa9542e1@brauner> <z4gavwmwinr6me7ufmwk7y6vi7jfwwbv5bksrk4v4saochb3va@zxchg3jqz2x4>
In-Reply-To: <z4gavwmwinr6me7ufmwk7y6vi7jfwwbv5bksrk4v4saochb3va@zxchg3jqz2x4>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 16:34:04 +0200
X-Gm-Features: AX0GCFu632aNyjBhs5EBhUhpdUNSOWvptURmLbUPGEMmcnOYw1q4QVaZmUkr2k0
Message-ID: <CAOQ4uxiX2pMB2Nj34iNADFoUnOustJ=tB-CPNx53EbHVBokE5w@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] fhandle, pidfs: allow open_by_handle_at() purely
 based on file handle
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 4:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 24-06-25 12:59:26, Christian Brauner wrote:
> > > For pidfs this means a file handle can function as full replacement f=
or
> > > storing a pid in a file. Instead a file handle can be stored and
> > > reopened purely based on the file handle.
> >
> > One thing I want to comment on generally. I know we document that a fil=
e
> > handle is an opaque thing and userspace shouldn't rely on the layout or
> > format (Propably so that we're free to redefine it.).
> >
> > Realistically though that's just not what's happening. I've linked Amir
> > to that code already a few times but I'm doing it here for all of you
> > again:
> >
> > [1]: https://github.com/systemd/systemd/blob/7e1647ae4e33dd8354bd311a7f=
7f5eb701be2391/src/basic/cgroup-util.c#L62-L77
> >
> >      Specifically:
> >
> >      /* The structure to pass to name_to_handle_at() on cgroupfs2 */
> >      typedef union {
> >              struct file_handle file_handle;
> >              uint8_t space[offsetof(struct file_handle, f_handle) + siz=
eof(uint64_t)];
> >      } cg_file_handle;
> >
> >      #define CG_FILE_HANDLE_INIT                                     \
> >              (cg_file_handle) {                                      \
> >                      .file_handle.handle_bytes =3D sizeof(uint64_t),   =
\
> >                      .file_handle.handle_type =3D FILEID_KERNFS,       =
\
> >              }
> >
> >      #define CG_FILE_HANDLE_CGROUPID(fh) (*CAST_ALIGN_PTR(uint64_t, (fh=
).file_handle.f_handle))
> >
> >      cg_file_handle fh =3D CG_FILE_HANDLE_INIT;
> >      CG_FILE_HANDLE_CGROUPID(fh) =3D id;
> >
> >      return RET_NERRNO(open_by_handle_at(cgroupfs_fd, &fh.file_handle, =
O_DIRECTORY|O_CLOEXEC));
> >
> > Another example where the layout is assumed to be uapi/uabi is:
> >
> > [2]: https://github.com/systemd/systemd/blob/7e1647ae4e33dd8354bd311a7f=
7f5eb701be2391/src/basic/pidfd-util.c#L232-L259
> >
> >      int pidfd_get_inode_id_impl(int fd, uint64_t *ret) {
> >      <snip>
> >                      union {
> >                              struct file_handle file_handle;
> >                              uint8_t space[offsetof(struct file_handle,=
 f_handle) + sizeof(uint64_t)];
> >                      } fh =3D {
> >                              .file_handle.handle_bytes =3D sizeof(uint6=
4_t),
> >                              .file_handle.handle_type =3D FILEID_KERNFS=
,
> >                      };
> >                      int mnt_id;
> >
> >                      r =3D RET_NERRNO(name_to_handle_at(fd, "", &fh.fil=
e_handle, &mnt_id, AT_EMPTY_PATH));
> >                      if (r >=3D 0) {
> >                              if (ret)
> >                                      *ret =3D *CAST_ALIGN_PTR(uint64_t,=
 fh.file_handle.f_handle);
> >                              return 0;
> >                      }
>
> Thanks for sharing. Sigh... Personal note for the future: If something
> should be opaque blob for userspace, don't forget to encrypt the data
> before handing it over to userspace. :-P
>
> > In (1) you can see that the layout is assumed to be uabi by
> > reconstructing the handle. In (2) you can see that the layout is assume=
d
> > to be uabi by extrating the inode number.
> >
> > So both points mean that the "don't rely on it"-ship has already sailed=
.
> > If we get regressions reports for this (and we surely would) because we
> > changed it we're bound by the no-regression rule.
>
> Yep, FILEID_KERNFS is pretty much set in stone. OTOH I don't expect these
> kinds of hacks to be very widespread (I guess I'm naive ;) so if we reall=
y
> need to change it we could talk to systemd folks.
>
> > So, for pidfs I'm very tempted to explicitly give the guarantee that
> > systemd just assumes currently.
> >
> > The reason is that it will allow userspace to just store the 64-bit
> > pidfs inode number in a file or wherever they want and then reconstruct
> > the file handle without ever having to involve name_to_handle_at(). Tha=
t
> > means you can just read the pid file and see the inode number you're
> > dealing with and not some binary gunk.
>
> Well, you could just fprintf() the fhandle into the pid file if you don't
> like binary gunk. Those numbers would be telling about as much as the pid=
fs
> inode number tells you, don't they? I mean I'm still not at the point whe=
re
> I would *encourage* userspace to decode what's supposed to be opaque blob
> ;). But maybe I'll get used to that idea...

As I was also writing a similar response, I will share my somewhat
duplicate feedback ;)

I still hold the option that as a rule, we should try not to encourage
crafting file handles in userspace.
Exceptions to the rule are easier to accept for non-persistent pseudo
filesystems and especially in the case that the handle format
is simply the u64 inode number.

But if you want to hand craft the pidfs file handles, I get that
the addition of FILEID_IS_AUTONOMOUS flag is a nuisance,
because you'd want something as simple as the examples you quoted
and not more complicated encodings.

Therefore, see my suggestion to toss the FILEID_IS_AUTONOMOUS flag
as well as the new FILEID_PIDFS type and opt-in to opening fd
without a path fd with FD_PIDFS_ROOT instead, so systemd can continue
to use the same simple hand crafted file handles.

Thanks,
Amir.

