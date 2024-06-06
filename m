Return-Path: <linux-fsdevel+bounces-21077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F16C8FDCB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 04:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D901C20F20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 02:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CDD1B950;
	Thu,  6 Jun 2024 02:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Fp7tuXZm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856318C08
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640864; cv=none; b=n+xlVIOQiwlm1mZlPsfyRhVnAgKy6p+iY0qWLEWM0v01HrQUgKsgfACAaxBQymacF66hAa8OZTA5fwW9uv3xL2eVtYzG9U7GmZ1liF4Sb5vwtdnSfE06STzBE3HOGhysjMTbKxfLLsoyLXddxgrLM09zGta1xjaA3Wj3twBw0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640864; c=relaxed/simple;
	bh=1LDL86QubPpmoCbk76dksUFSkh9K84fHfc7HHJImPGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJzTKhlVyL6w6HE6tlmrkaSMVtldaNPF8vfoJVCZl5FXBbBMq9Ub3Ma9kfpDJImSdpXKG/GWlcIahgM2fhu5TaH6sYlqrG9wArLJK3W4PBfIim1z6fQrN8cmSUKn9+D2fM5m4eW7TRFhI2CsjjaOEGg+HI+ZgpijXjguj9i85Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Fp7tuXZm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70245b22365so362551b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 19:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717640862; x=1718245662; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5TJAdD8GmJxvj8pKuF8QnnhaTXzIe7Tat0a8Ot2Rm1I=;
        b=Fp7tuXZm1xkj8VT/ICSRidbJrnvv0Z+TEgqrFSXzp7lMQTlRKYIqIR0h3520DJos96
         YPCbyaXE9QY/C7z9xlycFK3D6w0C6U5rU63nEBDJtXemZLUUMxQj1fUS4noT2Hns/4rW
         CZk+YwqLIloR3h9QIrpC1rUZ5jgod0BfAiGeZ/i8JttRCFRh8/P1r0bdv90DNkH6sFg+
         VkNlBuKX2wzvd4gz2bSMdsFFsqPZU3C2EQ7nwswDZV3bsGv9vFIiI3NbEZDScxDH3jDv
         Mq9W37ebrOww5EbL54LtFKDwd8RwGp2qVcJQO2PBDpDKXMlQsTKd6LYVXyZAnq3hc2QY
         qtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717640862; x=1718245662;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TJAdD8GmJxvj8pKuF8QnnhaTXzIe7Tat0a8Ot2Rm1I=;
        b=jGfR1B1YcK03vkLvZahdaxgsbP0PxePNMv4RUo9vXb5Ywl+Wfnr1aEA8MZA+Ox0hPG
         /4AMZ6JTT1ibXJOnrQ77EwPTSeOYY/XsCaS5w+BINGg7qdxn9+BVRAap5qzmHLWXk4++
         HhKUcBYm5zhWdv5IAVgdf+OlT+aVdXXvbbsEf44LoPwzVIlLzFe9hMeUm0EJkeQTfA7e
         lC9MQFfwFuQgGKBiIztzoDIfgegh1P764eu5+iSK+kSiM/i8RJf/W8c0TKAx77ZTN8Ym
         AK3Dntxk0QMqwKM7gnUSTLGezXyz620Sv0IyHwvAwOssXiRjcCWEqc7e5dOUENCUBo0l
         +Eug==
X-Forwarded-Encrypted: i=1; AJvYcCUMoH6PHbwOE3EtgRBQdau5XJ4CWJv94DKFmOa2K51lB83YKvlNzUwdJ9E+x4rKcJB7HwG7w0r7TYm16FICN1Po4hEIXHBO6YheQD0tFw==
X-Gm-Message-State: AOJu0YzaSeV9j1I1XlDd++uuRkw2mcDR7motNPDH+774BpH5lO8efCpQ
	WaG/qCR2jcWOngmeGbqhffFgxxNzTL1ysaMKWND8DeS7Ofs82YeO3BNRnezU9Nyl/yLjWhmdrLc
	3
X-Google-Smtp-Source: AGHT+IFOvqMOhYBsTyN+11L2HRn+hiKCTEcw/AH1ihwa0CkjXcJ8VasEd4Lj0Q7OqcxYZKylvjJcqQ==
X-Received: by 2002:a05:6a20:7488:b0:1b2:66c6:7787 with SMTP id adf61e73a8af0-1b2b7019e45mr5171795637.35.1717640862099;
        Wed, 05 Jun 2024 19:27:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd52b623sm179184b3a.207.2024.06.05.19.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 19:27:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sF2qo-005rfQ-2A;
	Thu, 06 Jun 2024 12:27:38 +1000
Date: Thu, 6 Jun 2024 12:27:38 +1000
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <ZmEemh4++vMEwLNg@dread.disaster.area>
References: <20240523074828.7ut55rhhbawsqrn4@quack3>
 <xne47dpalyqpstasgoepi4repm44b6g6rsntk2ln3aqhn4putw@4cen74g6453o>
 <20240524161101.yyqacjob42qjcbnb@quack3>
 <20240531145204.GJ52987@frogsfrogsfrogs>
 <20240603104259.gii7lfz2fg7lyrcw@quack3>
 <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs>
 <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs>
 <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>

On Wed, Jun 05, 2024 at 08:13:15AM +0300, Amir Goldstein wrote:
> On Wed, Jun 5, 2024 at 3:38 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > On Tue, Jun 04, 2024 at 10:58:43AM +0200, Jan Kara wrote:
> > > On Mon 03-06-24 10:42:59, Darrick J. Wong wrote:
> > > > I do -- allowing unpriviledged users to create symlinks that consume
> > > > icount (and possibly bcount) in the root project breaks the entire
> > > > enforcement mechanism.  That's not the way that project quota has worked
> > > > on xfs and it would be quite rude to nullify the PROJINHERIT flag bit
> > > > only for these special cases.
> > >
> > > OK, fair enough. I though someone will hate this. I'd just like to
> > > understand one thing: Owner of the inode can change the project ID to 0
> > > anyway so project quotas are more like a cooperative space tracking scheme
> > > anyway. If you want to escape it, you can. So what are you exactly worried
> > > about? Is it the container usecase where from within the user namespace you
> > > cannot change project IDs?
> >
> > Yep.
> >
> > > Anyway I just wanted to have an explicit decision that the simple solution
> > > is not good enough before we go the more complex route ;).
> >
> > Also, every now and then someone comes along and half-proposes making it
> > so that non-root cannot change project ids anymore.  Maybe some day that
> > will succeed.
> >
> 
> I'd just like to point out that the purpose of the project quotas feature
> as I understand it, is to apply quotas to subtrees, where container storage
> is a very common private case of project subtree.

That is the most modern use case, yes.

[ And for a walk down history lane.... ]

> The purpose is NOT to create a "project" of random files in random
> paths.

This is *exactly* the original use case that project quotas were
designed for back on Irix in the early 1990s and is the original
behaviour project quotas brought to Linux.

Project quota inheritance didn't come along until 2005:

commit 65f1866a3a8e512d43795c116bfef262e703b789
Author: Nathan Scott <nathans@sgi.com>
Date:   Fri Jun 3 06:04:22 2005 +0000

    Add support for project quota inheritance, a merge of Glens changes.
    Merge of xfs-linux-melb:xfs-kern:22806a by kenmcd.

And full support for directory tree quotas using project IDs wasn't
fully introduced until a year later in 2006:

commit 4aef4de4d04bcc36a1461c100eb940c162fd5ee6
Author: Nathan Scott <nathans@sgi.com>
Date:   Tue May 30 15:54:53 2006 +0000

    statvfs component of directory/project quota support, code originally by Glen.
    Merge of xfs-linux-melb:xfs-kern:26105a by kenmcd.

These changes were largely done for an SGI NAS product that allowed
us to create one great big XFS filesystem and then create
arbitrarily sized, thin provisoned  "NFS volumes"  as directory
quota controlled subdirs instantenously. The directory tree quota
defined the size of the volume, and so we could also grow and shrink
them instantenously, too. And we could remove them instantenously
via background garbage collection after the export was removed and
the user had been told it had been destroyed.

So that was the original use case for directory tree quotas on XFS -
providing scalable, fast management of "thin" storage for a NAS
product. Projects quotas had been used for accounting random
colections of files for over a decade before this directory quota
construct was created, and the "modern" container use cases for
directory quotas didn't come along until almost a decade after this
capability was added.

> My point is that changing the project id of a non-dir child to be different
> from the project id of its parent is a pretty rare use case (I think?).

Not if you are using project quotas as they were originally intended
to be used.

> If changing the projid of non-dir is needed for moving it to a
> different subtree,
> we could allow renameat2(2) of non-dir with no hardlinks to implicitly
> change its
> inherited project id or explicitly with a flag for a hardlink, e.g.:
> renameat2(olddirfd, name, newdirfd, name, RENAME_NEW_PROJID).

Why?

The only reason XFS returns -EXDEV to rename across project IDs is
because nobody wanted to spend the time to work out how to do the
quota accounting of the metadata changed in the rename operation
accurately. So for that rare case (not something that would happen
on the NAS product) we returned -EXDEV to trigger the mv command to
copy the file to the destination and then unlink the source instead,
thereby handling all the quota accounting correctly.

IOWs, this whole "-EXDEV on rename across parent project quota
boundaries" is an implementation detail and nothing more.
Filesystems that implement project quotas and the directory tree
sub-variant don't need to behave like this if they can accurately
account for the quota ID changes during an atomic rename operation.
If that's too hard, then the fallback is to return -EXDEV and let
userspace do it the slow way which will always acocunt the resource
usage correctly to the individual projects.

Hence I think we should just fix the XFS kernel behaviour to do the
right thing in this special file case rather than return -EXDEV and
then forget about the rest of it. Sure, update xfs_repair to fix the
special file project id issue if it trips over it, but other than
that I don't think we need anything more. If fixing it requires new
syscalls and tools, then that's much harder to backport to old
kernels and distros than just backporting a couple of small XFS
kernel patches...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

