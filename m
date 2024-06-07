Return-Path: <linux-fsdevel+bounces-21166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D8B8FFC15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 08:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4BB1C20FAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 06:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996F329CE1;
	Fri,  7 Jun 2024 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6w66ZT0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1301BC2F;
	Fri,  7 Jun 2024 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741069; cv=none; b=QWugc8cPlkXUsABLc7BoO/K60tZVEOZv2vMvMF3NwVS144u8rDNstjMYn4Qf0npk0iK+KU76V08VtIgGPAvfAWjgnCO+kyNU5wpfKCnKro8GH1arTZRdOpkbKihL5ooRRA06XjaAMF03m9TSIbAol0MYBDmNc+p3KVebGy57j6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741069; c=relaxed/simple;
	bh=dFhnXTuFhcPGbC5RdO3RlyAEksvW4vfRvB/ArJrZHH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzX36Jhfz9hxuNLPjhznCtjvh32tINMGfdb3kDGz/4UHLL/jLD1Aor/Je8j7qOkUvVR5Xkw9J2YvWfT2a7KDuLL9eaq0JQiiH1FAzCzZTn/+Z806HI7XxAbvIRAaRWJHpHYKAWc83cIZnYgNAauyM7uCaPrIlkLDBdOBNOxWavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6w66ZT0; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f938c18725so1083551a34.1;
        Thu, 06 Jun 2024 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717741066; x=1718345866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvJC0MUVYlfew8euTODGE/fyHK2X4xCRlVW3U2IH814=;
        b=i6w66ZT0eJtU4zEoZDEmtcNpaa54oHQbGdXLun8Ie+0/g49ueUQFZIdAIS/EiJn58x
         6wt6ihuAFEAnR26d+UZ1ps5eL/LgCn5UgCpRNRT8c91mHK605Tg1KWsqYOsEoiGyGorn
         0bkIwUHa9PJrOPXv4hxWamuMhwjmbP/8Tquk1rVIxZK1A5gkucknZhyodDQ2S7gkWLka
         wvE4P6oeBVy0YwKervpCHWItjhQAnLudv+cwP663usp8Qc68dGZ9C/f+3qoEFdDP0nj6
         RXCIYEGlhRe7pWKYvP3ojQREl6E46Z6kL/1nOYVZmOdfn6KpCd7yhOSRhYsOZQj8tLpP
         lncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717741066; x=1718345866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvJC0MUVYlfew8euTODGE/fyHK2X4xCRlVW3U2IH814=;
        b=mNR/ZPrrtkohxj5y+UrSeKNLPqxWeJIgWtdG15+2mA260dLyoKD00umHLhucTEQmGx
         fXweDWwRgpTPCeArvwKcAwD5IgtzXPobe+3vzaTpFpMZOAec3m3dUHhaktkrosbvk7OO
         dh50QxKQpi+VIWA+7tVXOJTKC55LlRw1PTQiVhlsWsj3YVM3CbhXIFp+cr5in+AUABhO
         5VniskXWvw/0RzGqfC+b5Q7j4sYBgchGZrK/JLSQzmlZ5xNKnrbVdtFH0ko7FQv1u3DF
         qcrmBnYA84DsH+MhfIAk3vOGzVo/76S8ITIYr6vbobnEFPtVwHzXBtbnUl69WTmalf6m
         ROrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoZv6kPzy9/8grSNtP/da2LAo0h1ncmR0fHLOhmMUo/OWns4rsxNRd+KmiJXYE4v9fXBXqck0U8ok771s+mjt0JwRAyLI33DV1TxDUv7/xehuF9pVNE6QC6qUn3k6uSDBPqvXQwoMXZA==
X-Gm-Message-State: AOJu0YwGFkhI9rehm1OxliVCDV3qOqJ+mh8De4kxMRzAbg/vFnIbDF7p
	RLG7+Cxv6OA904Kfh1iNpC4kR6DLKSaM2hTp5GxcIjDSfzapGq9z9fEtkraNjK3Y+6SP0Boea7H
	M9vop6tYuvVzMxNkJm4j7Kj/sbWg=
X-Google-Smtp-Source: AGHT+IErVPUvfa7FPveK4gqnv2VsPauJIiIaa2g+pRmfRsiGQ7Ucpv1Sqtjb0uQf/10rjJryVJFvPyo51Xn8Cd9j8ZU=
X-Received: by 2002:a9d:7545:0:b0:6f9:3fab:f9b8 with SMTP id
 46e09a7af769-6f9572c7cd8mr1559661a34.25.1717741066365; Thu, 06 Jun 2024
 23:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523074828.7ut55rhhbawsqrn4@quack3> <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
 <20240524161101.yyqacjob42qjcbnb@quack3> <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3> <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs> <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs> <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
 <ZmEemh4++vMEwLNg@dread.disaster.area>
In-Reply-To: <ZmEemh4++vMEwLNg@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Jun 2024 09:17:34 +0300
Message-ID: <CAOQ4uxgV5V0TmbZk1vqn=bYfSsdLofDRKvBT4O60zU+jXo0YMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and FS_IOC_FSGETXATTRAT
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:27=E2=80=AFAM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Wed, Jun 05, 2024 at 08:13:15AM +0300, Amir Goldstein wrote:
> > On Wed, Jun 5, 2024 at 3:38=E2=80=AFAM Darrick J. Wong <djwong@kernel.o=
rg> wrote:
> > > On Tue, Jun 04, 2024 at 10:58:43AM +0200, Jan Kara wrote:
> > > > On Mon 03-06-24 10:42:59, Darrick J. Wong wrote:
> > > > > I do -- allowing unpriviledged users to create symlinks that cons=
ume
> > > > > icount (and possibly bcount) in the root project breaks the entir=
e
> > > > > enforcement mechanism.  That's not the way that project quota has=
 worked
> > > > > on xfs and it would be quite rude to nullify the PROJINHERIT flag=
 bit
> > > > > only for these special cases.
> > > >
> > > > OK, fair enough. I though someone will hate this. I'd just like to
> > > > understand one thing: Owner of the inode can change the project ID =
to 0
> > > > anyway so project quotas are more like a cooperative space tracking=
 scheme
> > > > anyway. If you want to escape it, you can. So what are you exactly =
worried
> > > > about? Is it the container usecase where from within the user names=
pace you
> > > > cannot change project IDs?
> > >
> > > Yep.
> > >
> > > > Anyway I just wanted to have an explicit decision that the simple s=
olution
> > > > is not good enough before we go the more complex route ;).
> > >
> > > Also, every now and then someone comes along and half-proposes making=
 it
> > > so that non-root cannot change project ids anymore.  Maybe some day t=
hat
> > > will succeed.
> > >
> >
> > I'd just like to point out that the purpose of the project quotas featu=
re
> > as I understand it, is to apply quotas to subtrees, where container sto=
rage
> > is a very common private case of project subtree.
>
> That is the most modern use case, yes.
>
> [ And for a walk down history lane.... ]
>
> > The purpose is NOT to create a "project" of random files in random
> > paths.
>
> This is *exactly* the original use case that project quotas were
> designed for back on Irix in the early 1990s and is the original
> behaviour project quotas brought to Linux.
>
> Project quota inheritance didn't come along until 2005:
>
> commit 65f1866a3a8e512d43795c116bfef262e703b789
> Author: Nathan Scott <nathans@sgi.com>
> Date:   Fri Jun 3 06:04:22 2005 +0000
>
>     Add support for project quota inheritance, a merge of Glens changes.
>     Merge of xfs-linux-melb:xfs-kern:22806a by kenmcd.
>
> And full support for directory tree quotas using project IDs wasn't
> fully introduced until a year later in 2006:
>
> commit 4aef4de4d04bcc36a1461c100eb940c162fd5ee6
> Author: Nathan Scott <nathans@sgi.com>
> Date:   Tue May 30 15:54:53 2006 +0000
>
>     statvfs component of directory/project quota support, code originally=
 by Glen.
>     Merge of xfs-linux-melb:xfs-kern:26105a by kenmcd.
>
> These changes were largely done for an SGI NAS product that allowed
> us to create one great big XFS filesystem and then create
> arbitrarily sized, thin provisoned  "NFS volumes"  as directory
> quota controlled subdirs instantenously. The directory tree quota
> defined the size of the volume, and so we could also grow and shrink
> them instantenously, too. And we could remove them instantenously
> via background garbage collection after the export was removed and
> the user had been told it had been destroyed.
>
> So that was the original use case for directory tree quotas on XFS -
> providing scalable, fast management of "thin" storage for a NAS
> product. Projects quotas had been used for accounting random
> colections of files for over a decade before this directory quota
> construct was created, and the "modern" container use cases for
> directory quotas didn't come along until almost a decade after this
> capability was added.
>

Cool. Didn't know all of this.
Lucky for us, those historic use cases are well distinguished from
the modern subtree use case by the opt-in PROJINHERIT bit.
So as long as PROJINHERIT is set, my assumptions mostly hold(?)

> > My point is that changing the project id of a non-dir child to be diffe=
rent
> > from the project id of its parent is a pretty rare use case (I think?).
>
> Not if you are using project quotas as they were originally intended
> to be used.
>

Rephrase then:

Changing the projid of a non-dir child to be different from the projid
of its parent, which has PROJINHERIT bit set, is a pretty rare use case(?)

> > If changing the projid of non-dir is needed for moving it to a
> > different subtree,
> > we could allow renameat2(2) of non-dir with no hardlinks to implicitly
> > change its
> > inherited project id or explicitly with a flag for a hardlink, e.g.:
> > renameat2(olddirfd, name, newdirfd, name, RENAME_NEW_PROJID).
>
> Why?
>
> The only reason XFS returns -EXDEV to rename across project IDs is
> because nobody wanted to spend the time to work out how to do the
> quota accounting of the metadata changed in the rename operation
> accurately. So for that rare case (not something that would happen
> on the NAS product) we returned -EXDEV to trigger the mv command to
> copy the file to the destination and then unlink the source instead,
> thereby handling all the quota accounting correctly.
>
> IOWs, this whole "-EXDEV on rename across parent project quota
> boundaries" is an implementation detail and nothing more.
> Filesystems that implement project quotas and the directory tree
> sub-variant don't need to behave like this if they can accurately
> account for the quota ID changes during an atomic rename operation.
> If that's too hard, then the fallback is to return -EXDEV and let
> userspace do it the slow way which will always acocunt the resource
> usage correctly to the individual projects.
>
> Hence I think we should just fix the XFS kernel behaviour to do the
> right thing in this special file case rather than return -EXDEV and
> then forget about the rest of it. Sure, update xfs_repair to fix the
> special file project id issue if it trips over it, but other than
> that I don't think we need anything more. If fixing it requires new
> syscalls and tools, then that's much harder to backport to old
> kernels and distros than just backporting a couple of small XFS
> kernel patches...
>

I assume that by "fix the XFS behavior" you mean
"we could allow renameat2(2) of non-dir with no hardlinks to implicitly
 change its inherited project id"?
(in case the new parent has the PROJINHERIT bit)
so that the RENAME_NEW_PROJID behavior would be implicit.

Unlike rename() from one parent to the other, link()+unlink()
is less obvious.

The "modern" use cases that I listed where implicit change of projid
does not suffice are:

1. Share some inodes (as hardlinks) among projects
2. Recursively changing a subtree projid

They could be implemented by explicit flags to renameat2()/linkat() and
they could be implemented by [gs]etfsxattrat(2) syscalls.

Thanks,
Amir.

