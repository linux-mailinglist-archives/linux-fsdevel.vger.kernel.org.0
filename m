Return-Path: <linux-fsdevel+bounces-27995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE49965C2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 10:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9264EB24B10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B673E16F0DF;
	Fri, 30 Aug 2024 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+bI1gXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBA16EB4C;
	Fri, 30 Aug 2024 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008126; cv=none; b=jVyRW5ILg8PvvKSUwzSrKfBLkhxF2naBndTEWdXC6la2l2meAZaxvwJZrtm3evjIEU8h4vRrXGMi6Ti3SVySmrWGydmcuUMqr5oDWAYrXIVValmnVbEuRV7YIECqaafX8RqhQRdVpYB/RvCehF629xq4OxKTOdEQj6yUe6ELgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008126; c=relaxed/simple;
	bh=1ayrW2KRYSv4VG5vc1pV7HviSsEOCiqIqwNBh+QL/fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Up+XatSw/FJZG8p2qdsARMzPEa0omT9wbL+q2x7s/KlnicspXe094TPkHOt0oheN61L/TLXd9OOZioQmXMlqW1nybZg8pqSAY1cBrJnpPAau1nmFmnyIKuJ1c5derwxXiCj1JaZv5bHSWZsGLrbsMmFBy0QWQFTPHCFyf4EmQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+bI1gXG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a8125458e4so26459985a.3;
        Fri, 30 Aug 2024 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725008122; x=1725612922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrbmTGNNi0W3S9mCcoxI/7kNMrUNDnmdpl0nVBsbYG8=;
        b=F+bI1gXGfvGAIkJMj7JYiOZIFPIaLJf8NUYz2W/AmlM8TF6d/tpyRh5uiSra1xelFh
         rEKdUq5jA4JWh2syiKNKoqOXEPL+Mt/2Yl/qpSF1ebtr9KEOUzKFS7fUrsXJbo3vyKnw
         IvZRTywntMy1C9Vcr6nKqFtw2q50y9+fuhiyUiCCejIX/bJsZwKXyjLo6E47o6RGVZ2r
         H+Sjogt0gzYmc24aASJcC+NkYCyqYxneWYYOqibxizHYf+b+kF0rP+0b1soQ5AtH1QKU
         i2nVYrey4rKJZTtVVdwDEDsat3eWIKXNhh6SC1CtifJX+UMh6KEq6iw/Sb7J1dEJm9h2
         dCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725008122; x=1725612922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrbmTGNNi0W3S9mCcoxI/7kNMrUNDnmdpl0nVBsbYG8=;
        b=SOkl5DbF+9cEW5hg9kU1NeCFh4mBLKPBnqAumVmsSr6+gdN7g94buPrIFWXx0fapDQ
         C+QEFqNH5G9bSQuTn3pv3jbHGafoWJMfVajqxbEjte6S3S2mHUBTMwsZKw4mqEWT7AaO
         RdrtJ2kZmawJM8pjibWMYq55R9Q7Jp0p0BcMnSEXN7kMmy0xpeNTY1UBWLLsxplYiyvN
         tzk99OHGaV4k97rulYiLmbKicvVW2YzKcDzKuqvrb+Rs1x94sSWO4UklPwzxmShTtOGV
         yrhHi1Yp1AdQCuRX/svGaH1uzSEgOINnQx+Ee710t5CVdHw/k6xjma6XpcPOvK/sUyfY
         3BEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBVyS0c/iLYWUvU51ULBa5aL/LYDqB2PkYXSFZY/GPmKPrQFYo+iUEv+H0COQl4dkBjJflhT6VeJz1he3zYQ==@vger.kernel.org, AJvYcCVm62TBF9IVV9F6moAprG27rjyS3cnIOxvbwkRAosCgI4lV1eAsoslY0i66jGhqFxPgGdMgyYSqoT0e@vger.kernel.org, AJvYcCXqUqVHg4MP4nmxMAhF55r6fSuqYj6JPSQWrSIplN+xrUhkP2vXd7ZPffV9xY3lquoEEpLnRojUflePOlMLBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzks1ye+JYIqB/8kFs9s/prfPkkf//9lJpC5LeomQvl4v5Sfupl
	/EwCwICQulsvUccb4CChqKKGfRrHTlN5f5qn8mUhJV7f9KSIEnXuo/A/4MAAIHc6Z/EIr3HT5R/
	b7sxtbqKGoQ6n7O+YUsSpYiyH2Alx9NaXKIM=
X-Google-Smtp-Source: AGHT+IEgASSglc7fCqyUAqgIbS/CgJN8Y1QKd5RBsgX3/p1PKUl0P29QjM+n2Xn3M3qcUlDagsErduSVe2FrEbulU1s=
X-Received: by 2002:a05:620a:240e:b0:7a7:fad0:d916 with SMTP id
 af79cd13be357-7a8041bcbf4mr633010085a.26.1725008121996; Fri, 30 Aug 2024
 01:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723670362.git.josef@toxicpanda.com> <20240829214153.GP6224@frogsfrogsfrogs>
In-Reply-To: <20240829214153.GP6224@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Aug 2024 10:55:10 +0200
Message-ID: <CAOQ4uxh+zD1A18VPyoRHeaBt+XCpt2LB18K6ZHQJR-VqdGrCVw@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] fanotify: add pre-content hooks
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 11:41=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Aug 14, 2024 at 05:25:18PM -0400, Josef Bacik wrote:
> > v3: https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@to=
xicpanda.com/
> > v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@to=
xicpanda.com/
> > v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@to=
xicpanda.com/
> >
> > v3->v4:
> > - Trying to send a final verson Friday at 5pm before you go on vacation=
 is a
> >   recipe for silly mistakes, fixed the xfs handling yet again, per Chri=
stoph's
> >   review.
> > - Reworked the file system helper so it's handling of fpin was a little=
 less
> >   silly, per Chinner's suggestion.
> > - Updated the return values to not or in VM_FAULT_RETRY, as we have a c=
omment
> >   in filemap_fault that says if VM_FAULT_ERROR is set we won't have
> >   VM_FAULT_RETRY set.
> >
> > v2->v3:
> > - Fix the pagefault path to do MAY_ACCESS instead, updated the perm han=
dler to
> >   emit PRE_ACCESS in this case, so we can avoid the extraneous perm eve=
nt as per
> >   Amir's suggestion.
> > - Reworked the exported helper so the per-filesystem changes are much s=
maller,
> >   per Amir's suggestion.
> > - Fixed the screwup for DAX writes per Chinner's suggestion.
> > - Added Christian's reviewed-by's where appropriate.
> >
> > v1->v2:
> > - reworked the page fault logic based on Jan's suggestion and turned it=
 into a
> >   helper.
> > - Added 3 patches per-fs where we need to call the fsnotify helper from=
 their
> >   ->fault handlers.
> > - Disabled readahead in the case that there's a pre-content watch in pl=
ace.
> > - Disabled huge faults when there's a pre-content watch in place (entir=
ely
> >   because it's untested, theoretically it should be straightforward to =
do).
> > - Updated the command numbers.
> > - Addressed the random spelling/grammer mistakes that Jan pointed out.
> > - Addressed the other random nits from Jan.
> >
> > --- Original email ---
> >
> > Hello,
> >
> > These are the patches for the bare bones pre-content fanotify support. =
 The
> > majority of this work is Amir's, my contribution to this has solely bee=
n around
> > adding the page fault hooks, testing and validating everything.  I'm se=
nding it
> > because Amir is traveling a bunch, and I touched it last so I'm going t=
o take
> > all the hate and he can take all the credit.
> >
> > There is a PoC that I've been using to validate this work, you can find=
 the git
> > repo here
> >
> > https://github.com/josefbacik/remote-fetch
> >
> > This consists of 3 different tools.
> >
> > 1. populate.  This just creates all the stub files in the directory fro=
m the
> >    source directory.  Just run ./populate ~/linux ~/hsm-linux and it'll
> >    recursively create all of the stub files and directories.
> > 2. remote-fetch.  This is the actual PoC, you just point it at the sour=
ce and
> >    destination directory and then you can do whatever.  ./remote-fetch =
~/linux
> >    ~/hsm-linux.
> > 3. mmap-validate.  This was to validate the pagefault thing, this is li=
kely what
> >    will be turned into the selftest with remote-fetch.  It creates a fi=
le and
> >    then you can validate the file matches the right pattern with both n=
ormal
> >    reads and mmap.  Normally I do something like
> >
> >    ./mmap-validate create ~/src/foo
> >    ./populate ~/src ~/dst
> >    ./rmeote-fetch ~/src ~/dst
> >    ./mmap-validate validate ~/dst/foo
> >
> > I did a bunch of testing, I also got some performance numbers.  I copie=
d a
> > kernel tree, and then did remote-fetch, and then make -j4
> >
> > Normal
> > real    9m49.709s
> > user    28m11.372s
> > sys     4m57.304s
> >
> > HSM
> > real    10m6.454s
> > user    29m10.517s
> > sys     5m2.617s
> >
> > So ~17 seconds more to build with HSM.  I then did a make mrproper on b=
oth trees
> > to see the size
> >
> > [root@fedora ~]# du -hs /src/linux
> > 1.6G    /src/linux
> > [root@fedora ~]# du -hs dst
> > 125M    dst
> >
> > This mirrors the sort of savings we've seen in production.
> >
> > Meta has had these patches (minus the page fault patch) deployed in pro=
duction
> > for almost a year with our own utility for doing on-demand package fetc=
hing.
> > The savings from this has been pretty significant.
> >
> > The page-fault hooks are necessary for the last thing we need, which is
> > on-demand range fetching of executables.  Some of our binaries are seve=
ral gigs
> > large, having the ability to remote fetch them on demand is a huge win =
for us
> > not only with space savings, but with startup time of containers.
>
> So... does this pre-content fetcher already work for regular reads and
> writes, and now you're looking to wire up page faults?  Or does it only
> handle page faults?  Judging from Amir's patches I'm guessing the
> FAN_PRE_{ACCESS,MODIFY} events are new, so this only sends notifications
> prior to read and write page faults?  The XFS change looks reasonable to
> me, but I'm left wondering "what does this shiny /do/?"
>

I *think* I understand the confusion.

Let me try to sort it out.

This patch set collaboration aims to add the functionality of HSM
service by adding events FS_PRE_{ACCESS,MODIFY} prior to
read/write and page faults.

Maybe you are puzzled by not seeing any new read/write hooks?
This is because the HSM events utilize the existing fsnotify_file_*perm()
hooks that are in place for the legacy FS_ACCESS_PERM event.

So why is a new FS_PRE_ACCESS needed?
Let me first quote commit message of patch 2/16 [1]:
---
The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_PERM,
but it meant for a different use case of filling file content before
access to a file range, so it has slightly different semantics.

Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, same as
we did for FS_OPEN_PERM/FS_OPEN_EXEC_PERM.

FS_PRE_MODIFY is a new permission event, with similar semantics as
FS_PRE_ACCESS, which is called before a file is modified.

FS_ACCESS_PERM is reported also on blockdev and pipes, but the new
pre-content events are only reported for regular files and dirs.

The pre-content events are meant to be used by hierarchical storage
managers that want to fill the content of files on first access.
---

And from my man page draft [2]:
---
       FAN_PRE_ACCESS (since Linux 6.x)
              Create  an  event before a read from a directory or a file ra=
nge,
              that provides an opportunity for the event listener to
modify the content of the object
              before the reader is going to access the content in the
specified range.
              An additional information record of type
FAN_EVENT_INFO_TYPE_RANGE is returned
             for each event in the read buffer.
...
---

So the semantics of the two events is slightly different, but also the
meaning of "an opportunity for the event listener to modify the content".

FS_ACCESS_PERM already provided this opportunity on old kernels,
but prior to "Tidy up file permission hooks" series [3] in v6.8, writing
file content in FS_ACCESS_PERM event context was prone to deadlocks.

Therefore, an application using FS_ACCESS_PERM may be prone
for deadlocks, while an application using FAN_PRE_ACCESS should
be safe in that regard.

Thanks,
Amir.

[1] https://lore.kernel.org/all/a96217d84dfebb15582a04524dc9821ba3ea1406.17=
23670362.git.josef@toxicpanda.com/
[2] https://github.com/amir73il/man-pages/commits/fan_pre_path
[3] https://lore.kernel.org/all/20231122122715.2561213-1-amir73il@gmail.com=
/

