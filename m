Return-Path: <linux-fsdevel+bounces-25530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C919394D204
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F38028307F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DE9197549;
	Fri,  9 Aug 2024 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="b5ZlDEow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF91196C86
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213117; cv=none; b=lQUBLOMjOcrgXrv4wC9OKXyfD4ur5fex9W/tMIWEYqqftdn/6tAtykev2a3UaSWIz9nTzPsCk73/YJG2lMiN6ZtnqfJB0MaEYaZmDdbnlJSuEqg2d/oSrUONVsu+caZUPp5UHINM85YUDqYFRHr7pv0UbzeQqKiWun5QJBU1UQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213117; c=relaxed/simple;
	bh=J9j7gMV4crRAcUtqWBUJMylJA4Ai3Rzd9IGiwUvJZAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOEbgHZJB2rnMDaHB+fD33712Gz5HY69tIB8+kpEMW8AB/T5YYIjdmyFlb+sorjb0TFd82bPrnYwT6buJNtmWgG8Q2AJXIIkAxGmYNPh1sP2a7MjIKVehyYIpV6iwJkmLAjjBC3POuTho+jOkEhhZMXUme6/DlhhDaOAHmNy1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=b5ZlDEow; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70949118d26so1467037a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723213114; x=1723817914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=liW8GHsvLv8ceoO61HYCI66vuCvp9tZBQZ53iocvxUo=;
        b=b5ZlDEow7DXVyHI/iHQmnIMnQp6zaOeO8k6StfuwT8ukPXYn2lZu/idZQh/lvZjHA8
         QN6YOptnv+LBXcVAEj4cHrvO4+DnBbXwbja15FVlcC76JyOW0cmjxqY5MLb/fxJ829TM
         iCAeBTl5d64iqwyHX8heXIstA1AVrQMHgNwpu7gEOrF97fChiKPFJi6KvJnAEqPWVVrE
         +kmmVlpKQOe9ZDz4yLbw4DjXYQ5T+A1DJ0jOF48OIZ6M9CW0uHnDWMQdc8mItm3ZMwSd
         MMEXcaPwTTL82p8XERwFw4B64i2qwzqh4hfepuncmMIPJe3ORsdIR2hNt6qlZ5eVgtlc
         usZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723213114; x=1723817914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liW8GHsvLv8ceoO61HYCI66vuCvp9tZBQZ53iocvxUo=;
        b=MIrpk/nieOIHZB1VSQonYHeW66e5FA0vJlP9ooLOYg8qJl4KBksk/p/qYSjWcKFa7L
         iSw8zkITKE/TATD99XbbzQKYZPySOTq/Va76rXYiBi3D9VmiIcHe6o1T1ET0VgjbGtvn
         gXdMXwfuQn6AiHWnp5wGraflpBJ9RLeAuYjkQ8nlKAgWVSI83ADaAOLYiFDaQe/oTQa0
         jG1tWsI7kvm1KPOXC8A9diBv1qULiCfO74M9m0CmgTugJIjp63PIgy4sNtk1OXUjy10G
         LmVl4fcQc5SZujyqa4n48Ug/unwf0DnTQNZUryGMENBmbuP+0JrSeC1WueANmRo8AOvd
         B2oA==
X-Forwarded-Encrypted: i=1; AJvYcCVEUqfSBRMq93VHmrqpMf5Ibgr+J3wLIm07yam6QR0zYUbMON3uL2rWo8AAFxyaVKqVVWtnua1MR4p/JAI8t9VU76ZU4o34zeJ6GmmrWQ==
X-Gm-Message-State: AOJu0YzwT/lgwGAKAfub0+JETS82hNcN5hAVBzvNLhAk1yZwaz13UI9O
	U7cgUS+I38zfhFHFAEoq7q42jy9lccEeb77m51xbgCWDuYQGyzeLT6XXs87TUfk=
X-Google-Smtp-Source: AGHT+IEbfmB6veVV29hCIlFv/K0n+2+LP+bWfuPduu/7XMySHRK1soLeThSwWNY+t90YhXvHM8NPyQ==
X-Received: by 2002:a05:6830:911:b0:709:4fb0:957 with SMTP id 46e09a7af769-70b6b3019b9mr2269913a34.7.1723213113854;
        Fri, 09 Aug 2024 07:18:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786c1ed5sm266250485a.118.2024.08.09.07.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:18:33 -0700 (PDT)
Date: Fri, 9 Aug 2024 10:18:32 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Dave Chinner <david@fromorbit.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 00/16] fanotify: add pre-content hooks
Message-ID: <20240809141832.GC645452@perftesting>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <ZrVDm+Tjuv6tWlY3@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrVDm+Tjuv6tWlY3@dread.disaster.area>

On Fri, Aug 09, 2024 at 08:15:55AM +1000, Dave Chinner wrote:
> On Thu, Aug 08, 2024 at 03:27:02PM -0400, Josef Bacik wrote:
> > v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/
> > 
> > v1->v2:
> > - reworked the page fault logic based on Jan's suggestion and turned it into a
> >   helper.
> > - Added 3 patches per-fs where we need to call the fsnotify helper from their
> >   ->fault handlers.
> > - Disabled readahead in the case that there's a pre-content watch in place.
> > - Disabled huge faults when there's a pre-content watch in place (entirely
> >   because it's untested, theoretically it should be straightforward to do).
> > - Updated the command numbers.
> > - Addressed the random spelling/grammer mistakes that Jan pointed out.
> > - Addressed the other random nits from Jan.
> > 
> > --- Original email ---
> > 
> > Hello,
> > 
> > These are the patches for the bare bones pre-content fanotify support.  The
> > majority of this work is Amir's, my contribution to this has solely been around
> > adding the page fault hooks, testing and validating everything.  I'm sending it
> > because Amir is traveling a bunch, and I touched it last so I'm going to take
> > all the hate and he can take all the credit.
> 
> Brave man. :)
> 
> > There is a PoC that I've been using to validate this work, you can find the git
> > repo here
> > 
> > https://github.com/josefbacik/remote-fetch
> > 
> > This consists of 3 different tools.
> > 
> > 1. populate.  This just creates all the stub files in the directory from the
> >    source directory.  Just run ./populate ~/linux ~/hsm-linux and it'll
> >    recursively create all of the stub files and directories.
> > 2. remote-fetch.  This is the actual PoC, you just point it at the source and
> >    destination directory and then you can do whatever.  ./remote-fetch ~/linux
> >    ~/hsm-linux.
> > 3. mmap-validate.  This was to validate the pagefault thing, this is likely what
> >    will be turned into the selftest with remote-fetch.  It creates a file and
> >    then you can validate the file matches the right pattern with both normal
> >    reads and mmap.  Normally I do something like
> > 
> >    ./mmap-validate create ~/src/foo
> >    ./populate ~/src ~/dst
> >    ./rmeote-fetch ~/src ~/dst
> >    ./mmap-validate validate ~/dst/foo
> 
> This smells like something that should be added to fstests.
> 
> FWIW, fstests used to have a whole "fake-hsm" infrastructure
> subsystem in it for testing DMAPI events used by HSMs. They were
> removed in this commit:
> 
> commit 6497ede7ad4e9fc8e5a5a121bd600df896b7d9c6
> Author: Darrick J. Wong <djwong@kernel.org>
> Date:   Thu Feb 11 13:33:38 2021 -0800
> 
>     fstests: remove DMAPI tests
> 
>     Upstream XFS has never supported DMAPI, so remove the tests for this
>     feature.
> 
>     Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>     Acked-by: Christoph Hellwig <hch@lst.de>
>     Signed-off-by: Eryu Guan <guaneryu@gmail.com>
> 
> See ./dmapi/src/sample_hsm/ for the HSM test code that was removed
> in that patchset - it might provide some infrastructure that can be
> used to test the fanotify HSM event infrastructure without
> reinventing the entire wheel...

Yup as soon as this is merged into a tree my first stop is LTP, which is where
all the fanotify tests currently exist.  It won't cost me anything to add it to
fstests as well, so I'll follow up with that.

Generally I'd post the tests at the same time, but since it's dependent on what
we settle on for the implementation behavior I'm holding that stuff back.
Thanks,

Josef

