Return-Path: <linux-fsdevel+bounces-59900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4713B3ED7F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 19:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37BF201DF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB6930648B;
	Mon,  1 Sep 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7ztE2f/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDA32747B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756748887; cv=none; b=TgkxXwkVH4FW2SgcWmnlVlsLGYMFY6T+QwhXXvXRS3MwDFVsYE6Q2qrR29mNAiOJmkZq0GaVzRbfD/g+eZ35+5cqla3ASbnoWPdrGeeZLu34RU0RiWoIcEblQFqP4/dssYeVqNKsNc6duzEaAXSl5Gw2JuaJxnrhbpA0IAemhWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756748887; c=relaxed/simple;
	bh=g0l4uwVOsPeSvQHccCSvF6iYgw1HvqV/dlWGoKL0qYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+w4W/UGl3S+HjLzI7KwoZchd+nhF2QtOBGqG7/2xe72p7pTYdVPvRNa1EDL3hVf+76X6rBhLL3S2FVexcx0aBfh2aQla6k0Y2eK92MSm6Xxe7WmFD4t+N7OdLlr3fP+DtH6JXUCefqZdap94xjCYX5LD2cfqWye+hB/HJZoTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7ztE2f/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cdab7eee8so6193359a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756748884; x=1757353684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DxT2LcCz2ame1IexbusV9I+Zgj/JpryrRoYPhMYYDI=;
        b=W7ztE2f/f7zrSq+lpLhdxq0B3OL7vUPOU2bVjqoBrLmNzHbQmgEHmi5St4uqJkvby+
         tu59+AJGwVd9vRWiSDzNbh0sQIxX5m6MyC9TZOHjIax6fGj79xuFZN3ruD+PhItqySKO
         crLzTiK1gn18a57fXiw9D+dHoQEoM2+3NegtOl2OYmVIcSjiqRirxNGCAkmIeokIwQas
         W9oVLvh+ZTzTtWlZOxLoa2q/snA3Y7tKjl2JVoQyzcObCP9dxtqjpqYF1Au5PAT3Nwr6
         1tJtpdqH79ycjrYfm/fHJaSHx90La2aZckK27t/8wUESHgoNNrgHlNGoU9rii4tLsR1q
         FEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756748884; x=1757353684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DxT2LcCz2ame1IexbusV9I+Zgj/JpryrRoYPhMYYDI=;
        b=SRTFGkUZtbCd7NfSzHi7YoL9RM/3AAY1IoHU4pENJ5YRUvh8kVKebT6sBlAGp/e8fi
         KFFoM7vKbQA1+Tr+aewycHSI4FyvqbLzrlBKjuiqzRSnalScLMVgu+zqmNw1CBXE+0CN
         FXGikQs+j7NE7c3247UUpb6yxrNDfbbY0vnAxtai7a06c1Bg/zHjpnnhVG1uGZhC9kr4
         WF7NfFi26WyldYQiRYFJ3hoNOln7OZ1dU4fiNEKo9JrSgKYo9whAoRsEwVL1j0/6moSL
         Ghihrw3/MV0CW/wfv2lfBNSy1K0hJXHTOSp4uZiw7B0s1XScdC0mF8X2VMVpr0NbQvZV
         rmUg==
X-Forwarded-Encrypted: i=1; AJvYcCV/58PPGvwItNJy72icGdZN7FWjWXC4jcqLsh/mJJtEUz8hVrFownRzmXli4A1AdCNSl3WcSTO5hbDgw+Cm@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMgE9qEVYkCtiBfx9DG6Kj9KwMGJnYs9QgYEL6bu0rVFi9wdk
	B4Ssh+nbG5WK0p3OBlOjm6VkG/262EJKIcM+D4JFX8ashiUg1+G7O4ARE8Hybic2Q7bBjYCmyC/
	t3nslkyidgCnmV0rTJV2zkoxz4xd/nK4=
X-Gm-Gg: ASbGncu9Y1SIIU+u6elxATg26QKEkB61lYlqSgQpT4KCmFvBcRTfAtoLeaNngdVF5iC
	mASBSPz5yjZ0RLW8YGiIk/KfXlZqWUhxYCctOs8JpTKXzqEmgd5Ga01kjELW8XawS0EskUchTLE
	zHpwQT4V1+cDDQyXqkMz4gcJE5dFTrYjyH1SIevxpftfYyR8cnf8bSrcKSOMFVwXn7RlsSfROE1
	7hpsMA=
X-Google-Smtp-Source: AGHT+IEF4hy67IkgyPfbeRtE+ystVs1MH1Uc+Le1igbGjF5y9gNCB5rHEMZyNzAFgdL1R4x2kh7DnzdI1DaWoI2ZahU=
X-Received: by 2002:a05:6402:5255:b0:61d:b8e:194b with SMTP id
 4fb4d7f45d1cf-61d269881d5mr7666444a12.4.1756748883484; Mon, 01 Sep 2025
 10:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827194309.1259650-1-amir73il@gmail.com> <xdvs4ljulkgkpdyuum2hwzhpy2jxb7g55lcup7jvlf6rfwjsjt@s63vk6mpyp5e>
 <CAOQ4uxi_3nzGf74vi1E3P9imatLv+t1d5FE=jm4YzyAUVEkNyA@mail.gmail.com> <6eyx4x65awtemsx7h63ghh2txuswg4wct4lt5nig3hmz2owter@ezhzwu4t6uwh>
In-Reply-To: <6eyx4x65awtemsx7h63ghh2txuswg4wct4lt5nig3hmz2owter@ezhzwu4t6uwh>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 1 Sep 2025 19:47:51 +0200
X-Gm-Features: Ac12FXxBFYG2NhFytzr0mimEHh9LRSsFA0oBf17317bOEGgv6gh-xzxSxpnMPEk
Message-ID: <CAOQ4uxij+V4mPRwZQ6UgKy=m-Nove1YsawTCmFG5ORzk=SvKaQ@mail.gmail.com>
Subject: Re: [PATCH] fhandle: use more consistent rules for decoding file
 handle from userns
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:44=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 29-08-25 14:55:13, Amir Goldstein wrote:
> > On Fri, Aug 29, 2025 at 12:50=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 27-08-25 21:43:09, Amir Goldstein wrote:
> > > > Commit 620c266f39493 ("fhandle: relax open_by_handle_at() permissio=
n
> > > > checks") relaxed the coditions for decoding a file handle from non =
init
> > > > userns.
> > > >
> > > > The conditions are that that decoded dentry is accessible from the =
user
> > > > provided mountfd (or to fs root) and that all the ancestors along t=
he
> > > > path have a valid id mapping in the userns.
> > > >
> > > > These conditions are intentionally more strict than the condition t=
hat
> > > > the decoded dentry should be "lookable" by path from the mountfd.
> > > >
> > > > For example, the path /home/amir/dir/subdir is lookable by path fro=
m
> > > > unpriv userns of user amir, because /home perms is 755, but the own=
er of
> > > > /home does not have a valid id mapping in unpriv userns of user ami=
r.
> > > >
> > > > The current code did not check that the decoded dentry itself has a
> > > > valid id mapping in the userns.  There is no security risk in that,
> > > > because that final open still performs the needed permission checks=
,
> > > > but this is inconsistent with the checks performed on the ancestors=
,
> > > > so the behavior can be a bit confusing.
> > > >
> > > > Add the check for the decoded dentry itself, so that the entire pat=
h,
> > > > including the last component has a valid id mapping in the userns.
> > > >
> > > > Fixes: 620c266f39493 ("fhandle: relax open_by_handle_at() permissio=
n checks")
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Yeah, probably it's less surprising this way. Feel free to add:
> > >
> >
> > BTW, Jan, I was trying to think about whether we could do
> > something useful with privileged_wrt_inode_uidgid() for filtering
> > events that we queue by group->user_ns.
> >
> > Then users could allow something like:
> > 1. Admin sets up privileged fanotify fd and filesystem watch on
> >     /home filesystem
> > 2. Enters userns of amir and does ioctl to change group->user_ns
> >     to user ns of amir
> > 3. Hands over fanotify fd to monitor process running in amir's userns
> > 4. amir's monitor process gets all events on filesystem /home
> >     whose directory and object uid/gid are mappable to amir's userns
> > 5. With properly configured systems, that we be all the files/dirs unde=
r
> >     /home/amir
> >
> > I have posted several POCs in the past trying different approaches
> > for filtering by userns, but I have never tried to take this approach.
> >
> > Compared to subtree filtering, this could be quite pragmatic? Hmm?
>
> This is definitely relatively easy to implement in the kernel. I'm just n=
ot
> sure about two things:
>
> 1) Will this be easy enough to use from userspace so that it will get use=
d?
> Mount watches have been created as a "partial" solution for subtree watch=
es
> as well. But in practice it didn't get very widespread use as subtree wat=
ch
> replacement because setting up a mountpoint for subtree you want to watch=
 is
> not flexible enough. Setting up userns and id mappings and proper inode
> ownership seems like a similar hassle for anything else than a full home
> dir as well...

I would not suggest this if it were not for systemd-mountfsd which is
designed to allow non-root users to mount "trusted" images (e.g. ext4).

I don't think this feature is already implemented, but an image auto
generated for the user per demand by mkfs, should also be "trusted".

In theory, as user jack, you should be able to spawn an unpriv userns
wherein user jack is uid 0 and get a mount of a freshly formatted ext4 fs
idmapped in a way that only uids from the userns private range could
write to that fs.

*if* this is possible and useful to users, then we will start seeing in the=
 wild
filesystems where all the inodes are owned by a private range of uids,
all mappable to a specific userns.

But TBH, I am not sure if this is already a reality or a likely future or n=
ot.
I need to dig some more to understand the future plans for
systemd-mountfsd use cases.

>
> 2) Filtering all events on the fs only by inode owner being mappable to
> user ns looks somewhat dangerous to me. Sure you offload the responsibili=
ty
> of the safe setup to userspace but the fact that this completely bypasses
> any permission checks means that configuring the system so that it does n=
ot
> leak any unintended information (like filenames or facts that some things
> have changed user otherwise wouldn't be able to see) might be difficult.
> Consider if e.g. maildir is on your monitored fs and for some reason the
> UID of the postfix is mapped to your user ns (e.g. because the user needs
> access to some file/dir managed by postfix). Then you could monitor all
> fs activity of postfix possibly learning about emails to other persons in
> the system.
>

Well, the rule should be that the user setting group->user_ns is ADMIN
in that userns.

If someone has creates a userns where user amir is uid 0 and also
mapped user postfix into the userns of amir, then that gives user amir
full privs to access and modify user postfix owned files, so the privilege
escalation, to the best of my understanding, has already happened way
before user amir started the fanotify monitor.

> > The difference from subtree filtering is that it shifts the responsibil=
ity
> > of making sure that /home/amir and /home/jack have files with uid,gid
> > in different ranges to the OS/runtime, which is a responsibility that
> > some systems are already taking care of anyway.
>
> At this point I'm not convinced there are that many systems where this wa=
y
> of filtering would be useful but I could be wrong. The fact that some ID =
is
> mappable in a namespace looks as kind of weak restriction because you may
> need to map into the namespace various external "system" ids AFAIU. But I
> can see that e.g. for containers the idea of restricting events to inodes
> whose owners are in a range of UIDs may be attractive.

I think that for "system containers" (i.e. a nested OS) this could be
attractive, but I don't feel that I know enough to make an authoritative
statement about this.

Thanks,
Amir.

