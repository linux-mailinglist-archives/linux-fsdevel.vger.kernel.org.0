Return-Path: <linux-fsdevel+bounces-7046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C8820B19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DB31F213DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 10:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F13D70;
	Sun, 31 Dec 2023 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve3Pfsvz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386833D1;
	Sun, 31 Dec 2023 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f911e9ac4so65798606d6.3;
        Sun, 31 Dec 2023 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704019508; x=1704624308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym5PQGYqMktC4T1S3eQaZFoa+im01ZODGDdyF9/BuxA=;
        b=Ve3PfsvzUsTHJI3c/x2xgvro9H7NU8ZzEwnvzDMrhspbTRmdna/5Hcslk/XxrFB5WK
         yLvt9W4LYd0vKfc3ktpy3QITtjEj1RGlpR3H4Vl+VMQHJXvb/Dx2yWe8nqxlxdLkgsy8
         PNmd7I6IuXKFxzGDYgIKNJiJrWrIj1Nka3ATUWr//j6up2mbS4smMTN06M9BCrIq1jnR
         aFE+Mns0/xcK97sA1GTHYIp/+bvJWw26tcwWiT6gUI33lU3iyTZBAQMAAlkMayFHhKFV
         HNcshbq4IXlarHPyWJk1Vr3ZrT/j7So/aY4rXhkZh7g24yEeut5MWcUZRC7PzCcJTEq8
         wi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704019508; x=1704624308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym5PQGYqMktC4T1S3eQaZFoa+im01ZODGDdyF9/BuxA=;
        b=nCjr5oISNVSc7ERBwVwZWxjG5jIo3XuXb2QomKnP8bB2USo4c1fxr/rsxhRKmVJDio
         hy8/B96OYna6XWPwzV8kuw0IlFQJwn4nok8hcxf2xOPaZEZGiYIzFk0N6N68dZi8dmgE
         h6+UwG+5MW9shaL+iU1KOnpstHjR/2caMDxkbHMKoAOgwtTPuoP1+YHIfYAQELjd685r
         zVok71YyO6ti8lMp+jPxHaCz/sOfAlVk+i/VXrRcj4ZMbow0n5I5H/UvvNpir5q9fq8T
         u2QRVVDISqE1CU/ocKPbiaZ8jA0IMhXDgB+v/WjOJJrGHKEAWamlJtD7rFen02DJVfWW
         uRgQ==
X-Gm-Message-State: AOJu0YxbmkjvK+NWyGrbq79h8jww5/mPtaHDOA+Z2zr8scLbRZBv17/J
	eQwBPWIfzHAIGIQzsv+BvtPnR2MsQnoKWkSSd0aqlEy/3U8=
X-Google-Smtp-Source: AGHT+IG1k+h6CNfcg/k9X5WAbncAu3fIfr5JKgb1+xmA3YcQLOI3yoAqnSW2Z2fjCB1pob6WqC+lhhNxbyA+nYCWGqo=
X-Received: by 2002:a05:6214:2128:b0:67f:c76:e9e8 with SMTP id
 r8-20020a056214212800b0067f0c76e9e8mr28339330qvc.16.1704019508461; Sun, 31
 Dec 2023 02:45:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228201510.985235-1-trondmy@kernel.org> <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
 <ZY7ZC9q8dGtoC2U/@tissot.1015granger.net> <CAOQ4uxh1VDPVq7a82HECtKuVwhMRLGe3pvL6TY6Xoobp=vaTTw@mail.gmail.com>
 <ZY9WPKwO2M6FXKpT@tissot.1015granger.net> <a14bca2bb50eb0a305efc829262081b9b262d888.camel@hammerspace.com>
 <CAOQ4uxgcCajCD_bNKSLJp2AG1Q=N0CW9P-h+JMiun48mY0ZyDQ@mail.gmail.com> <9c4867cf1f94a8e46c2271bfd5a91d30d49ada70.camel@hammerspace.com>
In-Reply-To: <9c4867cf1f94a8e46c2271bfd5a91d30d49ada70.camel@hammerspace.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 31 Dec 2023 12:44:57 +0200
Message-ID: <CAOQ4uxh5xpJSvmYxWRKe_i=h1PRPy+nEA=vAcCD0rCJQKnm1Ww@mail.gmail.com>
Subject: Re: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 9:36=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Sat, 2023-12-30 at 08:23 +0200, Amir Goldstein wrote:
> > On Sat, Dec 30, 2023 at 1:50=E2=80=AFAM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Fri, 2023-12-29 at 18:29 -0500, Chuck Lever wrote:
> > > > On Fri, Dec 29, 2023 at 07:44:20PM +0200, Amir Goldstein wrote:
> > > > > On Fri, Dec 29, 2023 at 4:35=E2=80=AFPM Chuck Lever
> > > > > <chuck.lever@oracle.com> wrote:
> > > > > >
> > > > > > On Fri, Dec 29, 2023 at 07:46:54AM +0200, Amir Goldstein
> > > > > > wrote:
> > > > > > > [CC: fsdevel, viro]
> > > > > >
> > > > > > Thanks for picking this up, Amir, and for copying
> > > > > > viro/fsdevel. I
> > > > > > was planning to repost this next week when more folks are
> > > > > > back,
> > > > > > but
> > > > > > this works too.
> > > > > >
> > > > > > Trond, if you'd like, I can handle review changes if you
> > > > > > don't
> > > > > > have
> > > > > > time to follow up.
> > > > > >
> > > > > >
> > > > > > > On Thu, Dec 28, 2023 at 10:22=E2=80=AFPM <trondmy@kernel.org>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > > > >
> > > > > > > > The fallback implementation for the get_name export
> > > > > > > > operation
> > > > > > > > uses
> > > > > > > > readdir() to try to match the inode number to a filename.
> > > > > > > > That filename
> > > > > > > > is then used together with lookup_one() to produce a
> > > > > > > > dentry.
> > > > > > > > A problem arises when we match the '.' or '..' entries,
> > > > > > > > since
> > > > > > > > that
> > > > > > > > causes lookup_one() to fail. This has sometimes been seen
> > > > > > > > to
> > > > > > > > occur for
> > > > > > > > filesystems that violate POSIX requirements around
> > > > > > > > uniqueness
> > > > > > > > of inode
> > > > > > > > numbers, something that is common for snapshot
> > > > > > > > directories.
> > > > > > >
> > > > > > > Ouch. Nasty.
> > > > > > >
> > > > > > > Looks to me like the root cause is "filesystems that
> > > > > > > violate
> > > > > > > POSIX
> > > > > > > requirements around uniqueness of inode numbers".
> > > > > > > This violation can cause any of the parent's children to
> > > > > > > wrongly match
> > > > > > > get_name() not only '.' and '..' and fail the d_inode
> > > > > > > sanity
> > > > > > > check after
> > > > > > > lookup_one().
> > > > > > >
> > > > > > > I understand why this would be common with parent of
> > > > > > > snapshot
> > > > > > > dir,
> > > > > > > but the only fs that support snapshots that I know of
> > > > > > > (btrfs,
> > > > > > > bcachefs)
> > > > > > > do implement ->get_name(), so which filesystem did you
> > > > > > > encounter
> > > > > > > this behavior with? can it be fixed by implementing a
> > > > > > > snapshot
> > > > > > > aware ->get_name()?
> > > > > > >
> > > > > > > > This patch just ensures that we skip '.' and '..' rather
> > > > > > > > than
> > > > > > > > allowing a
> > > > > > > > match.
> > > > > > >
> > > > > > > I agree that skipping '.' and '..' makes sense, but...
> > > > > >
> > > > > > Does skipping '.' and '..' make sense for file systems that
> > > > > > do
> > > > >
> > > > > It makes sense because if the child's name in its parent would
> > > > > have been "." or ".." it would have been its own parent or its
> > > > > own
> > > > > grandparent (ELOOP situation).
> > > > > IOW, we can safely skip "." and "..", regardless of anything
> > > > > else.
> > > >
> > > > This new comment:
> > > >
> > > > +     /* Ignore the '.' and '..' entries */
> > > >
> > > > then seems inadequate to explain why dot and dot-dot are now
> > > > never
> > > > matched. Perhaps the function's documenting comment could expand
> > > > on
> > > > this a little. I'll give it some thought.
> > >
> > > The point of this code is to attempt to create a valid path that
> > > connects the inode found by the filehandle to the export point. The
> > > readdir() must determine a valid name for a dentry that is a
> > > component
> > > of that path, which is why '.' and '..' can never be acceptable.
> > >
> > > This is why I think we should keep the 'Fixes:' line. The commit it
> > > points to explains quite concisely why this patch is needed.
> > >
> >
> > By all means, mention this commit, just not with a fixed tag please.
> > IIUC, commit 21d8a15ac333 did not introduce a regression that this
> > patch fixes. Right?
> > So why insist on abusing Fixes: tag instead of a mention?
>
> I don't see it as being that straightforward.
>
> Prior to commit 21d8a15ac333, the call to lookup_one_len() could return
> a dentry (albeit one with an invalid name) depending on whether or not
> the filesystem lookup succeeds. Note that knfsd does support a lookup
> of "." and "..", as do several other NFS servers.
>
> With commit 21d8a15ac333 applied, however, lookup_one_len()
> automatically returns an EACCES error.
>
> So while I agree that there are good reasons for introducing commit
> 21d8a15ac333, it does change the behaviour in this code path.
>

I feel that we are miscommunicating.
Let me explain how I understand the code and please tell me where I am wron=
g.

The way I see it, before 21d8a15ac333, exportfs_decode_fh_raw() would
call lookup_one() and may get a dentry (with invalid name), but then the
sanity check following lookup_one() would surely fail, because no fs should
allow a directory to be its own parent/grandparent:

                        if (unlikely(nresult->d_inode !=3D result->d_inode)=
) {
                                dput(nresult);
                                nresult =3D ERR_PTR(-ESTALE);
                        }

The way I see it, the only thing that commit 21d8a15ac333 changed in
this code is the return value of exportfs_decode_fh_raw() from -ESTALE
to -EACCES.

exportfs_decode_fh() converts both these errors to -ESTALE and
so does nfsd_set_fh_dentry().

Bottom line, if I am reading the code correctly, commit 21d8a15ac333 did
not change the behaviour for knfsd nor any user visible behavior for
open_by_handle_at() for userspace nfsd.

Your fix is good because:
1. It saves an unneeded call to lookup_one()
2. skipping "." and ".." increases the chance of finding the correct child
    name in the case of non-unique ino

So I have no objection to your fix in generic code, but I do not see
it being a regression fix.

Where are we miscommunicating? What am I missing?

Thanks,
Amir.

