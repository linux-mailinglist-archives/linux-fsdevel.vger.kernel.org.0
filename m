Return-Path: <linux-fsdevel+bounces-34296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA79C4726
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39BC5B29C37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC41ACDE8;
	Mon, 11 Nov 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAt4bhwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5C19CC0C;
	Mon, 11 Nov 2024 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356849; cv=none; b=uLtHCpgXHObMCW882SHQN8FK9ixFIZ3dcK1iSjRpmW55i1QF4hmJ9Vx+v19UGNBHBPlnUazGwiNkziikphuwAt/JDlz6tgk4V/1PyEifEshp263gY1ksjrFxqGgP+Obf5wTHf9N84cmmfzn0nnVcWP32Wndyoc0GB7J2gw6tuMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356849; c=relaxed/simple;
	bh=ewhC3vF3LWIoycpEaD/sb388FFWGUOEk/tHs10zyeA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dc+F6LBh1whnYnTad9hFJSSUVsA8I7war+U47IkzrqxgclQf4rpHJDqADxHZmK6QebhnlP40eMRpQhJD6SBReMIQ42JgknvJnesrane8G2+RyQXk0Gmydh7OsS15BjnLsjqubSazM8muMdT2Y5O+LOmidZIsjCUSLHopCQIswWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAt4bhwp; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ee3e12b191so2057720eaf.0;
        Mon, 11 Nov 2024 12:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731356845; x=1731961645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9QaPRaGh7bw5bqPaGITtEPnNR2LGGuZCaS4WqMgl5c=;
        b=kAt4bhwpLEPJ/4L9IDM6Y2nygmw4qzU7ocJipRKaLCMvbOo9VjnyjgcUZCfspVzPw/
         GrdnXB9/v0KfBQTFbmvB0+HgotW+DJKrAnwSKEpBxLkeOC5uUy9L5B5Cy4GckkXPR4Sr
         QMsLSO5vg0d7MwULp3/lmI/mRqmB904j/VDZe5Ndh6tp1C9O/gwBgOVWI0uNxn2J3Nze
         UtsXl57WgrFE4vSncSedPTMtmoaKwfKhmhzRPZehG+0Zzi3p5C3vgsCGIfOySEn+DGhe
         PaoYfs4pl/AdNxJQj5xX72sqSZ7o/1+JbMVnd2vyEN9zz9LfAqPF+MjMUnqUY7oVYxMg
         pH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356845; x=1731961645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9QaPRaGh7bw5bqPaGITtEPnNR2LGGuZCaS4WqMgl5c=;
        b=DIezBNupcBucLyMxrfwhm9iviLWpidT+av3Tu6fc96UbtmXC8P3jrEDins1At3IXt3
         z9wkj3PKdhgJHJuHysF+8mdHQ8dXb9HattK4SvxNh5WdRGr5M3wSS9ZKJbxra71DGiHM
         WxqwqUg3fbA+2dyj5rmJtB9c48zFT23XbWcF4ba2b48VHiiVKzxRSgpmSDye8rSTi6MB
         MknOhKiLtzJBG20QmQEnM8yz8QJx0oQzBpFrtDHEqPZBCPuJOOW4ZoCO0I6DE5CLDGI0
         a25SdbuwCf+90GVwnoqsMoYCUoRd5DfUK+ph69zveQpf+T1+pEs7taMu8bv+Hzm03mbi
         4vmw==
X-Forwarded-Encrypted: i=1; AJvYcCVI0pQ1iQv9DJec9xbX1+U3kVXv0RtogPMy1DkAFpobmlmR3wFkhXbxRLfreRNER54a9Hw4ZJ0/YE0nFXbnAw==@vger.kernel.org, AJvYcCVqDKdnRs3P2T2no5+6Bh0DGBNixq1GB8oaaGAlrcjMpretO7vJFKP9mnB/XLkpGO2fh+mtCLSKSLB9@vger.kernel.org, AJvYcCW01Juz/nCddPNQF6EEDwu2N1yO7OyDFx1ye8+RhoItzJj/9eUtJ6pyig0k0sgDEe3lJVLWJHWy8FY/uQ==@vger.kernel.org, AJvYcCXiPYJnxtPoCuzui0zs8sYNIMWhWtxrdwcr2n8qdXRID8+HyC5YWuoQadxozobznUSTfNZX/bG4xB0x4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH8e/4jGgaipzXyR0z+xVuRXzzMxllTMvDqjTJ2WmeMTuG0yBl
	5+C8kvZvdnkeKsO28C6naPwtRyJ91FUuGZw0tCDwkEjBCSbKnNect4qLvlq3kh+vVCt9cEFq6u9
	pubWXaKCnLYLdLi4nROpmVKwmyw4=
X-Google-Smtp-Source: AGHT+IEoThJIKWhSy1sVjVdrSYHS9PPvCysBXmyjm3/91owWrpCqZeqALU/ivnY0aIfruV13lp3Y2ax4AW9B7wKddTQ=
X-Received: by 2002:a05:6358:4b50:b0:1bc:2d00:84ad with SMTP id
 e5c5f4694b2df-1c641e83bd0mr576865055d.3.1731356844814; Mon, 11 Nov 2024
 12:27:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com>
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 11 Nov 2024 21:27:13 +0100
Message-ID: <CAOQ4uxitBcDpe+1t7Jf5UaMJS2=qAZVCqzKESZJyOwXaX6omww@mail.gmail.com>
Subject: Re: [PATCH v6 00/17] fanotify: add pre-content hooks
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	brauner@kernel.org, torvalds@linux-foundation.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 9:19=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> v5: https://lore.kernel.org/linux-fsdevel/cover.1725481503.git.josef@toxi=
cpanda.com/
> v4: https://lore.kernel.org/linux-fsdevel/cover.1723670362.git.josef@toxi=
cpanda.com/
> v3: https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxi=
cpanda.com/
> v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxi=
cpanda.com/
> v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxi=
cpanda.com/
>
> v5->v6:
> - Linus had problems with this and rejected Jan's PR
>   (https://lore.kernel.org/linux-fsdevel/20240923110348.tbwihs42dxxltabc@=
quack3/),
>   so I'm respinning this series to address his concerns.  Hopefully this =
is more
>   acceptable.
> - Change the page fault hooks to happen only in the case where we have to=
 add a
>   page, not where there exists pages already.
> - Amir added a hook to truncate.
> - We made the flag per SB instead of per fstype, Amir wanted this because=
 of
>   some potential issues with other file system specific work he's doing.

Not me :) it for the upcoming ps > bs patch set for xfs.
It would be easiest to opt-out of this config for HSM to begin with.

> - Dropped the bcachefs patch, there were some concerns that we were doing
>   something wrong, and it's not a huge deal to not have this feature for =
now.
> - Unfortunately the xfs write fault path still has to do the page fault h=
ook

As Jan corrected me, this is only for the DAX page faults in xfs, so we sho=
uld
be ok with fsnotify hook called on every fault in this case.

>   before we know if we have a page or not, this is because of the locking=
 that's
>   done before we get to the part where we know if we have a page already =
or not,
>   so that's the path that is still the same from last iteration.
> - I've re-validated this series with btrfs, xfs, and ext4 to make sure I =
didn't
>   break anything.

Thanks!
Amir.

>
> v4->v5:
> - Cleaned up the various "I'll fix it on commit" notes that Jan made sinc=
e I had
>   to respin the series anyway.
> - Renamed the filemap pagefault helper for fsnotify per Christians sugges=
tion.
> - Added a FS_ALLOW_HSM flag per Jan's comments, based on Amir's rough ske=
tch.
> - Added a patch to disable btrfs defrag on pre-content watched files.
> - Added a patch to turn on FS_ALLOW_HSM for all the file systems that I t=
ested.
> - Added two fstests (which will be posted separately) to validate everyth=
ing,
>   re-validated the series with btrfs, xfs, ext4, and bcachefs to make sur=
e I
>   didn't break anything.
>
> v3->v4:
> - Trying to send a final verson Friday at 5pm before you go on vacation i=
s a
>   recipe for silly mistakes, fixed the xfs handling yet again, per Christ=
oph's
>   review.
> - Reworked the file system helper so it's handling of fpin was a little l=
ess
>   silly, per Chinner's suggestion.
> - Updated the return values to not or in VM_FAULT_RETRY, as we have a com=
ment
>   in filemap_fault that says if VM_FAULT_ERROR is set we won't have
>   VM_FAULT_RETRY set.
>
> v2->v3:
> - Fix the pagefault path to do MAY_ACCESS instead, updated the perm handl=
er to
>   emit PRE_ACCESS in this case, so we can avoid the extraneous perm event=
 as per
>   Amir's suggestion.
> - Reworked the exported helper so the per-filesystem changes are much sma=
ller,
>   per Amir's suggestion.
> - Fixed the screwup for DAX writes per Chinner's suggestion.
> - Added Christian's reviewed-by's where appropriate.
>
> v1->v2:
> - reworked the page fault logic based on Jan's suggestion and turned it i=
nto a
>   helper.
> - Added 3 patches per-fs where we need to call the fsnotify helper from t=
heir
>   ->fault handlers.
> - Disabled readahead in the case that there's a pre-content watch in plac=
e.
> - Disabled huge faults when there's a pre-content watch in place (entirel=
y
>   because it's untested, theoretically it should be straightforward to do=
).
> - Updated the command numbers.
> - Addressed the random spelling/grammer mistakes that Jan pointed out.
> - Addressed the other random nits from Jan.
>
> --- Original email ---
>
> Hello,
>
> These are the patches for the bare bones pre-content fanotify support.  T=
he
> majority of this work is Amir's, my contribution to this has solely been =
around
> adding the page fault hooks, testing and validating everything.  I'm send=
ing it
> because Amir is traveling a bunch, and I touched it last so I'm going to =
take
> all the hate and he can take all the credit.
>
> There is a PoC that I've been using to validate this work, you can find t=
he git
> repo here
>
> https://github.com/josefbacik/remote-fetch
>
> This consists of 3 different tools.
>
> 1. populate.  This just creates all the stub files in the directory from =
the
>    source directory.  Just run ./populate ~/linux ~/hsm-linux and it'll
>    recursively create all of the stub files and directories.
> 2. remote-fetch.  This is the actual PoC, you just point it at the source=
 and
>    destination directory and then you can do whatever.  ./remote-fetch ~/=
linux
>    ~/hsm-linux.
> 3. mmap-validate.  This was to validate the pagefault thing, this is like=
ly what
>    will be turned into the selftest with remote-fetch.  It creates a file=
 and
>    then you can validate the file matches the right pattern with both nor=
mal
>    reads and mmap.  Normally I do something like
>
>    ./mmap-validate create ~/src/foo
>    ./populate ~/src ~/dst
>    ./rmeote-fetch ~/src ~/dst
>    ./mmap-validate validate ~/dst/foo
>
> I did a bunch of testing, I also got some performance numbers.  I copied =
a
> kernel tree, and then did remote-fetch, and then make -j4
>
> Normal
> real    9m49.709s
> user    28m11.372s
> sys     4m57.304s
>
> HSM
> real    10m6.454s
> user    29m10.517s
> sys     5m2.617s
>
> So ~17 seconds more to build with HSM.  I then did a make mrproper on bot=
h trees
> to see the size
>
> [root@fedora ~]# du -hs /src/linux
> 1.6G    /src/linux
> [root@fedora ~]# du -hs dst
> 125M    dst
>
> This mirrors the sort of savings we've seen in production.
>
> Meta has had these patches (minus the page fault patch) deployed in produ=
ction
> for almost a year with our own utility for doing on-demand package fetchi=
ng.
> The savings from this has been pretty significant.
>
> The page-fault hooks are necessary for the last thing we need, which is
> on-demand range fetching of executables.  Some of our binaries are severa=
l gigs
> large, having the ability to remote fetch them on demand is a huge win fo=
r us
> not only with space savings, but with startup time of containers.
>
> There will be tests for this going into LTP once we're satisfied with the
> patches and they're on their way upstream.  Thanks,
>
> Josef
>
> Amir Goldstein (9):
>   fanotify: rename a misnamed constant
>   fanotify: reserve event bit of deprecated FAN_DIR_MODIFY
>   fsnotify: introduce pre-content permission events
>   fsnotify: pass optional file access range in pre-content event
>   fsnotify: generate pre-content permission event on open
>   fsnotify: generate pre-content permission event on truncate
>   fanotify: introduce FAN_PRE_ACCESS permission event
>   fanotify: report file range info with pre-content events
>   fanotify: allow to set errno in FAN_DENY permission response
>
> Josef Bacik (8):
>   fanotify: don't skip extra event info if no info_mode is set
>   fanotify: add a helper to check for pre content events
>   fanotify: disable readahead if we have pre-content watches
>   mm: don't allow huge faults for files with pre content watches
>   fsnotify: generate pre-content permission event on page fault
>   xfs: add pre-content fsnotify hook for write faults
>   btrfs: disable defrag on pre-content watched files
>   fs: enable pre-content events on supported file systems
>
>  fs/btrfs/ioctl.c                   |   9 +++
>  fs/btrfs/super.c                   |   5 +-
>  fs/ext4/super.c                    |   3 +
>  fs/namei.c                         |  10 ++-
>  fs/notify/fanotify/fanotify.c      |  33 ++++++--
>  fs/notify/fanotify/fanotify.h      |  15 ++++
>  fs/notify/fanotify/fanotify_user.c | 120 +++++++++++++++++++++++------
>  fs/notify/fsnotify.c               |  18 ++++-
>  fs/open.c                          |  31 +++++---
>  fs/xfs/xfs_file.c                  |   4 +
>  fs/xfs/xfs_super.c                 |   2 +-
>  include/linux/fanotify.h           |  19 +++--
>  include/linux/fs.h                 |   1 +
>  include/linux/fsnotify.h           |  73 ++++++++++++++++--
>  include/linux/fsnotify_backend.h   |  59 +++++++++++++-
>  include/linux/mm.h                 |   1 +
>  include/uapi/linux/fanotify.h      |  18 +++++
>  mm/filemap.c                       |  90 ++++++++++++++++++++++
>  mm/memory.c                        |  22 ++++++
>  mm/readahead.c                     |  13 ++++
>  security/selinux/hooks.c           |   3 +-
>  21 files changed, 491 insertions(+), 58 deletions(-)
>
> --
> 2.43.0
>

