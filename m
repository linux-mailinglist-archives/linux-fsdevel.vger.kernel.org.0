Return-Path: <linux-fsdevel+bounces-21014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA18FC2EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 07:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8F6285884
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 05:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB813AA5C;
	Wed,  5 Jun 2024 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL5Mq06L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3261FCC;
	Wed,  5 Jun 2024 05:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564410; cv=none; b=kO69LZiAKfnWlbjX/o+/MqL6FLzJ6zOYKic/NWUAsTDVlcm2G2BL/0kmlNQxrqoT88KplgO47fGg48d5PZC7tDgG7aexN154wa9MIDZ6znTSzkgaj5/WeMg4oZPBvNDl7VzqgWZXCVDmPZ7wzorCbFThGm1pphm9ZWcVg7vN6JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564410; c=relaxed/simple;
	bh=/WVRDzCHg3spCSYzjmwfS99jR3K/kGEpHbQyQHzTcBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt9jZZ0cBE46+iOzzJDbT8uTAdAl8VX+jHUrwvU/6TGFzYbT5obdoGyQ9Xqhg9WcG7uYDGgMJv9jtfPABj0vhRAOA3zEXEedwQHRJ69UYsy0wtXOVNN1Kj1ZdHUdwAX7jmjEfwlIF/gyrRgYF0zjgKS6H4xK9amgsYyTvpMh3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL5Mq06L; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-795186ae3e9so90575285a.0;
        Tue, 04 Jun 2024 22:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717564408; x=1718169208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj8i7BUJHGXOxgUitUFf3swEznue+es0pSHh18YprwA=;
        b=iL5Mq06LIRGymN3mU1+QbDE8MRjAuUPdy4e6N6r3KIbjn/aFWQFQTy/4ociY1nIF+/
         AagrnSTE/rLVut1U/Te45WXKVLkvNWwNyUDy6hjntEQyQ6z9YKWpseezAx6rajX33k47
         micP5ILr+23sFNToQqQbUujIS2ALR/CIP9/ZCjtKp+MfACVcjpxL0nTARIOiG7Zy+hWe
         s0SpcLChOGi+U95ktZkGq+k0GFjMsuLVkNdcsrfacMebwSU6d5YId0cmygTexMkXbGnj
         cK6geslFJuB8ZSQKetm25mkpo1PmgKYGqNKjERK+atuXHCsN9uf8bpPLfUahceTjBgQq
         KoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717564408; x=1718169208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bj8i7BUJHGXOxgUitUFf3swEznue+es0pSHh18YprwA=;
        b=EUt760DFwc2A6T1pkQjHoeFXSkPEeEFkCt+poudwq5ENCw5wXrCpZb9rFoKwxNhr3L
         UH+nmKoZW2dB2C9abaQ9A1N48gnCd/NdF4yKIkQ3ZlNCCQKi/B5zpn6HmhN4dUz79u+Q
         wcEg7s+L0U0rpsGPWLo8UoorSgdPACw1Ogpc7c3ZTsomj0Dw17T+PpQVRsF7GSn0bZVE
         ZhZWXOghzCy4sYzuwbWCU8FKQTmXy3obFXr6clSATmCTl6WMw5BW6R3dIMpXn2kvmvtJ
         oafNyIRh0j7MzJbAmpNvVmgiB9kH9LJUjXoIbQB0aCMdOhcVMTn4Lrs6jm7K1ylNd2IB
         f5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVdayPzqJQxyJhpI8mdn1Eaq7T2BG7a4qWbS7sVf3tZ2WtBc4ReXepJJScTqz2OTWDyEuI6+d4AaHhoeHVJ3VpF57iyJu28U0kdF9UM3fRvGVZ8s5cOFMba0t3e1RWbDxHYQl8GpobT8Q==
X-Gm-Message-State: AOJu0Yylk5s96k7ml0opgFehRo+vL4IfoDtStvzfIFuD8zFsW7aNPY6y
	1tQ5/v4HRNWX/7k69JuV//kHQD3AsWQTWoPznm4tQGthtNT4ojvaGL7+KRx30r/haAxc/1dfQvg
	cblqA74JNJK/iXG50gIYh4mcOSic=
X-Google-Smtp-Source: AGHT+IEEkpCi9Lb2dXtRVSV4paKGuy9g5zjd45iq/bGDj3XkX5dBWF9gcv8hwRL+C0jcL37HnWuBavOC2Ommo4XDwqE=
X-Received: by 2002:a05:620a:40c9:b0:792:9248:c2e9 with SMTP id
 af79cd13be357-79523ec257bmr203705785a.48.1717564407378; Tue, 04 Jun 2024
 22:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522100007.zqpa5fxsele5m7wo@quack3> <snhvkg3lm2lbdgswfzyjzmlmtcwcb725madazkdx4kd6ofqmw6@hiunsuigmq6f>
 <20240523074828.7ut55rhhbawsqrn4@quack3> <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
 <20240524161101.yyqacjob42qjcbnb@quack3> <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3> <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs> <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs>
In-Reply-To: <20240605003756.GH52987@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 5 Jun 2024 08:13:15 +0300
Message-ID: <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and FS_IOC_FSGETXATTRAT
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 3:38=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Tue, Jun 04, 2024 at 10:58:43AM +0200, Jan Kara wrote:
> > On Mon 03-06-24 10:42:59, Darrick J. Wong wrote:
> > > On Mon, Jun 03, 2024 at 06:28:47PM +0200, Andrey Albershteyn wrote:
> > > > On 2024-06-03 12:42:59, Jan Kara wrote:
> > > > > On Fri 31-05-24 07:52:04, Darrick J. Wong wrote:
> > > > > > On Fri, May 24, 2024 at 06:11:01PM +0200, Jan Kara wrote:
> > > > > > > On Thu 23-05-24 13:16:48, Andrey Albershteyn wrote:
> > > > > > > > On 2024-05-23 09:48:28, Jan Kara wrote:
> > > > > > > > > Hi!
> > > > > > > > >
> > > > > > > > > On Wed 22-05-24 12:45:09, Andrey Albershteyn wrote:
> > > > > > > > > > On 2024-05-22 12:00:07, Jan Kara wrote:
> > > > > > > > > > > Hello!
> > > > > > > > > > >
> > > > > > > > > > > On Mon 20-05-24 18:46:21, Andrey Albershteyn wrote:
> > > > > > > > > > > > XFS has project quotas which could be attached to a=
 directory. All
> > > > > > > > > > > > new inodes in these directories inherit project ID =
set on parent
> > > > > > > > > > > > directory.
> > > > > > > > > > > >
> > > > > > > > > > > > The project is created from userspace by opening an=
d calling
> > > > > > > > > > > > FS_IOC_FSSETXATTR on each inode. This is not possib=
le for special
> > > > > > > > > > > > files such as FIFO, SOCK, BLK etc. as opening them =
returns a special
> > > > > > > > > > > > inode from VFS. Therefore, some inodes are left wit=
h empty project
> > > > > > > > > > > > ID. Those inodes then are not shown in the quota ac=
counting but
> > > > > > > > > > > > still exist in the directory.
> > > > > > > > > > > >
> > > > > > > > > > > > This patch adds two new ioctls which allows userspa=
ce, such as
> > > > > > > > > > > > xfs_quota, to set project ID on special files by us=
ing parent
> > > > > > > > > > > > directory to open FS inode. This will let xfs_quota=
 set ID on all
> > > > > > > > > > > > inodes and also reset it when project is removed. A=
lso, as
> > > > > > > > > > > > vfs_fileattr_set() is now will called on special fi=
les too, let's
> > > > > > > > > > > > forbid any other attributes except projid and nexte=
nts (symlink can
> > > > > > > > > > > > have one).
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.=
com>
> > > > > > > > > > >
> > > > > > > > > > > I'd like to understand one thing. Is it practically u=
seful to set project
> > > > > > > > > > > IDs for special inodes? There is no significant disk =
space usage associated
> > > > > > > > > > > with them so wrt quotas we are speaking only about th=
e inode itself. So is
> > > > > > > > > > > the concern that user could escape inode project quot=
a accounting and
> > > > > > > > > > > perform some DoS? Or why do we bother with two new so=
mewhat hairy ioctls
> > > > > > > > > > > for something that seems as a small corner case to me=
?
> > > > > > > > > >
> > > > > > > > > > So there's few things:
> > > > > > > > > > - Quota accounting is missing only some special files. =
Special files
> > > > > > > > > >   created after quota project is setup inherit ID from =
the project
> > > > > > > > > >   directory.
> > > > > > > > > > - For special files created after the project is setup =
there's no
> > > > > > > > > >   way to make them project-less. Therefore, creating a =
new project
> > > > > > > > > >   over those will fail due to project ID miss match.
> > > > > > > > > > - It wasn't possible to hardlink/rename project-less sp=
ecial files
> > > > > > > > > >   inside a project due to ID miss match. The linking is=
 fixed, and
> > > > > > > > > >   renaming is worked around in first patch.
> > > > > > > > > >
> > > > > > > > > > The initial report I got was about second and last poin=
t, an
> > > > > > > > > > application was failing to create a new project after "=
restart" and
> > > > > > > > > > wasn't able to link special files created beforehand.
> > > > > > > > >
> > > > > > > > > I see. OK, but wouldn't it then be an easier fix to make =
sure we *never*
> > > > > > > > > inherit project id for special inodes? And make sure inod=
es with unset
> > > > > > > > > project ID don't fail to be linked, renamed, etc...
> > > > > > > >
> > > > > > > > But then, in set up project, you can cross-link between pro=
jects and
> > > > > > > > escape quota this way. During linking/renaming if source in=
ode has
> > > > > > > > ID but target one doesn't, we won't be able to tell that th=
is link
> > > > > > > > is within the project.
> > > > > > >
> > > > > > > Well, I didn't want to charge these special inodes to project=
 quota at all
> > > > > > > so "escaping quota" was pretty much what I suggested to do. B=
ut my point
> > > > > > > was that since the only thing that's really charged for these=
 inodes is the
> > > > > > > inodes itself then does this small inaccuracy really matter i=
n practice?
> > > > > > > Are we afraid the user is going to fill the filesystem with s=
ymlinks?
> > > > > >
> > > > > > I thought the worry here is that you can't fully reassign the p=
roject
> > > > > > id for a directory tree unless you have an *at() version of the=
 ioctl
> > > > > > to handle the special files that you can't open directly?
> > > > > >
> > > > > > So you start with a directory tree that's (say) 2% symlinks and=
 project
> > > > > > id 5.  Later you want to set project id 7 on that subtree, but =
after the
> > > > > > incomplete change, projid 7 is charged for 98% of the tree, and=
 2% are
> > > > > > still stuck on projid 5.  This is a mess, and if enforcement is=
 enabled
> > > > > > you've just broken it in a way that can't be fixed aside from r=
ecreating
> > > > > > those files.
> > > > >
> > > > > So the idea I'm trying to propose (and apparently I'm failing to =
explain it
> > > > > properly) is:
> > > > >
> > > > > When creating special inode, set i_projid =3D 0 regardless of dir=
ectory
> > > > > settings.
> > > > >
> > > > > When creating hardlink or doing rename, if i_projid of dentry is =
0, we
> > > > > allow the operation.
> > > > >
> > > > > Teach fsck to set i_projid to 0 when inode is special.
> > > > >
> > > > > As a result, AFAICT no problem with hardlinks, renames or similar=
. No need
> > > > > for special new ioctl or syscall. The downside is special inodes =
escape
> > > > > project quota accounting. Do we care?
> > > >
> > > > I see. But is it fine to allow fill filesystem with special inodes?
> > > > Don't know if it can be used somehow but this is exception from
> > > > isoft/ihard limits then.
> > > >
> > > > I don't see issues with this approach also, if others don't have
> > > > other points or other uses for those new syscalls, I can go with
> > > > this approach.
> > >
> > > I do -- allowing unpriviledged users to create symlinks that consume
> > > icount (and possibly bcount) in the root project breaks the entire
> > > enforcement mechanism.  That's not the way that project quota has wor=
ked
> > > on xfs and it would be quite rude to nullify the PROJINHERIT flag bit
> > > only for these special cases.
> >
> > OK, fair enough. I though someone will hate this. I'd just like to
> > understand one thing: Owner of the inode can change the project ID to 0
> > anyway so project quotas are more like a cooperative space tracking sch=
eme
> > anyway. If you want to escape it, you can. So what are you exactly worr=
ied
> > about? Is it the container usecase where from within the user namespace=
 you
> > cannot change project IDs?
>
> Yep.
>
> > Anyway I just wanted to have an explicit decision that the simple solut=
ion
> > is not good enough before we go the more complex route ;).
>
> Also, every now and then someone comes along and half-proposes making it
> so that non-root cannot change project ids anymore.  Maybe some day that
> will succeed.
>

I'd just like to point out that the purpose of the project quotas feature
as I understand it, is to apply quotas to subtrees, where container storage
is a very common private case of project subtree.

The purpose is NOT to create a "project" of random files in random
paths.

My point is that changing the project id of a non-dir child to be different
from the project id of its parent is a pretty rare use case (I think?).

If changing the projid of non-dir is needed for moving it to a
different subtree,
we could allow renameat2(2) of non-dir with no hardlinks to implicitly
change its
inherited project id or explicitly with a flag for a hardlink, e.g.:
renameat2(olddirfd, name, newdirfd, name, RENAME_NEW_PROJID).

Which leaves us only with the use cases of:
1. Share some inode (as hardlinks) among projects
2. Recursively changing a subtree projid

#1 could be allowed with a flag to linkat(2) or hardlink within a shared
project subtree and rename the hardlink out of the shared project
subtree with renameat2(2) and explicit flag, e.g.:
renameat2(olddirfd, name, newdirfd, name, RENAME_OLD_PROJID).

#2 *could technically* be done by the same rename flag that
will allow rename to the same path, e.g:
renameat2(dirfd, name, dirfd, name, RENAME_NEW_PROJID).

It's not pretty and I personally prefer the syscall solution.
Just wanted to put it out there.

Thanks,
Amir.

