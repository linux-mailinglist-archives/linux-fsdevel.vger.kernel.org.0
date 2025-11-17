Return-Path: <linux-fsdevel+bounces-68739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DECCEC6497B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6034B4F051A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 14:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2637330337;
	Mon, 17 Nov 2025 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="OYPZ68Aj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A523ABA7
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388657; cv=none; b=GGPmlU9x4EQBZ9Uj2oDb04f0FikQ43Am0EdRabFlok+f9OKNh+TKC4uIzSPhRPWhLSRDD+Psg1V+siAJ7BQT4H/7qXhJPHhO5bYNx00cDzexc3kBRUxq9V6oRNFD+8gCNLN3xd5JbB3mTmvKPx0ljcTrVZnM4COvKDrGXCg5K8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388657; c=relaxed/simple;
	bh=F2Ua36tXeKfRdmHPae8b9CvhsWDEBwQq83nyEUZ4THw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAOKKTtHUVaMVxJMX8KX91jPwuIcvIPwzw6z2Pj7eIEagdKvWuQTMyeFiGGAx8kWJUhzNCNn2lK70HIuvLbKNkpeZZogBzR+o3kxt8PBwsZWbs+azSPosjab53/h9Lh9K1+2mTIzkjL+o7zPayMYTbH5M2lFiBE1vIEuXj7ClrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=OYPZ68Aj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-298145fe27eso57073625ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 06:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1763388654; x=1763993454; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IGIlUhwcW4Oy871xAlA/Pf+rhr+iZnkvTchf2PcaDVU=;
        b=OYPZ68Ajp119S5diDB4/wWhM+ebE4R0TRquaD0sO2yvq9NRytEycpryexBuRTnXCrn
         c+wKr/H96dPwi1BfoZoxwvJqHWlQoiG/w4oGDyleSRj+mHhlLHua8bUsYsr46v1xHt/a
         cRWYhkn3nG5jymoQ7IlI0Vx4lroVm8bEFTSy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763388654; x=1763993454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGIlUhwcW4Oy871xAlA/Pf+rhr+iZnkvTchf2PcaDVU=;
        b=iEBLYnNTK5O+GKvXT7cRKCrsQYVmhmYaNQjN4JDbgVIAJ+qzaran8L++xw/XuEVueJ
         Rf5Y4HtWHdp+GtMNcy4LXNBPEuJ74VP9MJwirg41WQnXMtcXLmy3xD+5/iYIEb9SS6B8
         DQP2lfYHvFdneBkkl55Ty7RfNyJbr7j6NEujf38jGy9xh0Cc46UXCAsj9RdxmiYOLD7W
         lvgyLBmyUYYmoiyR8fBNaSsis8Qtz8KxCu9/w0tKansEYVLnZi40XfAiL2jfVr1WX8Yu
         6Gx75D2NKy4O/hbJSdGg5GBYWFGJNNH+iNrCzg/y0QE6/jyKoZvLUD6Ho4XHRwsDEp30
         sacA==
X-Forwarded-Encrypted: i=1; AJvYcCU8xQvDXsWz8mXFg76DhwjKyNHdfJs4JGn2cAKOjrS4MHnie9kpbFTdOFI6UflxyF4wkRfGZbg+CGt7RXHg@vger.kernel.org
X-Gm-Message-State: AOJu0YwD5SgOCuoUDRTIet52qBwxxLg3sCTgzwRS9Mq/p/ww6GfSLM1R
	lqIPVFkij4NSZyd4Yz5/ttoO+EpADe9yDnWaoMD/HQV+Ye83P1ZX4Mz4Oc79YVtVIdc=
X-Gm-Gg: ASbGnct0g3s/iD6OP9Z+vBMLftLIV8Zv86YvmPmcNmNfVD5fbExVTmKhVf/Eg8QqGe0
	lT01cRF3cSnVjcsZ2WWZJWqOf/th3g3x36GyVDK6VZY/CPddLCZhXzUlbpErXcjUx6FETl2+Aw+
	BXCNLk/Air2Gyckgnuw5GSDQmqgT5PCOEkQGnfGBWP5RPOfXvc9yeOcGFIBnxFsCByUD2YcuS21
	Mc+k9J/a+cYgK4ygCTRVmKEypAyIEjd79CLTuXkmBcqZVpiQUYN8QMpkWidHkIkxiP34tVmWCbB
	Jos9j2ctXOzwzSUlvLA6EuIWvAplh+BmJL9MTOLVR9z7YKqiqu5IREmIsgA3xRCDeO2cy4cJZUl
	1wkspMv0PbHIt378WwO7YhLmz/S9ltiYtNJj6BQYxkHDCZFO1X1fmnpq48OSTAmz/RoaO+U9Qjb
	wqPAft0HSw91x0j0YwDRz4ExFK1NL3aqYzREGuYWQi/Lib3W5y
X-Google-Smtp-Source: AGHT+IGpmjetQdMYOQuuR7kG1GZkoPWMou40quIaqM1bcw0cREwgl582S5zRn/xRIwFNmTYkE5eDqQ==
X-Received: by 2002:a17:902:c405:b0:295:596f:8507 with SMTP id d9443c01a7336-2986a5fbf9fmr167840905ad.0.1763388654266;
        Mon, 17 Nov 2025 06:10:54 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx ([2405:201:31:d869:ee61:77ad:1f3e:2b12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm139768835ad.47.2025.11.17.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 06:10:53 -0800 (PST)
Date: Mon, 17 Nov 2025 19:40:45 +0530
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, eddyz87@gmail.com,
	andrii@kernel.org, ast@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in
 do_read_cache_folio()
Message-ID: <aRsqwndQ459VN8I9@ranegod-HP-ENVY-x360-Convertible-13-bd0xxx>
References: <20251114193729.251892-1-ssranevjti@gmail.com>
 <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>

On Sun, Nov 16, 2025 at 10:32:12PM +0000, Matthew Wilcox wrote:
> First, some process things ;-)
> 
> 1. Thank you for working on this.  Andrii has been ignoring it since
> August, which is bad.  So thank you for picking it up.
> 
> 2. Sending a v2 while we're having a discussion is generally a bad idea.
> It's fine to send a patch as a reply, but going as far as a v2 isn't
> necessary.  If conversation has died down, then a v2 is definitely
> warranted, but you and I are still having a discussion ;-)
> 
> 3. When you do send a v2 (or, now that you've sent a v2, send a v3),
> do it as a new thread rather then in reply to the v1 thread.  That plays
> better with the tooling we have like b4 which will pull in all patches
> in a thread.
>
Apologies for the process errors regarding the v2 submission. I appreciate the guidance on the workflow and threading; I will ensure the next version is sent as a clean, new thread once we have agreed on the technical solution.
> With that over with, on to the fun technical stuff.
> 
> On Sun, Nov 16, 2025 at 11:13:42AM +0530, SHAURYA RANE wrote:
> > On Sat, Nov 15, 2025 at 2:14 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sat, Nov 15, 2025 at 01:07:29AM +0530, ssrane_b23@ee.vjti.ac.in wrote:
> > > > When read_cache_folio() is called with a NULL filler function on a
> > > > mapping that does not implement read_folio, a NULL pointer
> > > > dereference occurs in filemap_read_folio().
> > > >
> > > > The crash occurs when:
> > > >
> > > > build_id_parse() is called on a VMA backed by a file from a
> > > > filesystem that does not implement ->read_folio() (e.g. procfs,
> > > > sysfs, or other virtual filesystems).
> > >
> > > Not a fan of this approach, to be honest.  This should be caught at
> > > a higher level.  In __build_id_parse(), there's already a check:
> > >
> > >         /* only works for page backed storage  */
> > >         if (!vma->vm_file)
> > >                 return -EINVAL;
> > >
> > > which is funny because the comment is correct, but the code is not.
> > > I suspect the right answer is to add right after it:
> > >
> > > +       if (vma->vm_file->f_mapping->a_ops == &empty_aops)
> > > +               return -EINVAL;
> > >
> > > Want to test that out?
> > Thanks for the suggestion.
> > Checking for
> >     a_ops == &empty_aops
> > is not enough. Certain filesystems for example XFS with DAX use
> > their own a_ops table (not empty_aops) but still do not implement
> > ->read_folio(). In those cases read_cache_folio() still ends up with
> > filler = NULL and filemap_read_folio(NULL) crashes.
> 
> Ah, right.  I had assumed that the only problem was synthetic
> filesystems like sysfs and procfs which can't have buildids because
> buildids only exist in executables.  And neither procfs nor sysfs
> contain executables.
> 
> But DAX is different.  You can absolutely put executables on a DAX
> filesystem.  So we shouldn't filter out DAX here.  And we definitely
> shouldn't *silently* fail for DAX.  Otherwise nobody will ever realise
> that the buildid people just couldn't be bothered to make DAX work.
> 
> I don't think it's necessarily all that hard to make buildid work
> for DAX.  It's probably something like:
> 
> 	if (IS_DAX(file_inode(file)))
> 		kernel_read(file, buf, count, &pos);
> 
> but that's just off the top of my head.
> 
> 
I agree that DAX needs proper support rather than silent filtering.
However, investigating the actual syzbot reproducer revealed that the issue extends beyond just DAX. The crash is actually triggering on tmpfs (shmem).I verified via debug logging that the crashing VMA is backed by `shmem_aops`. Looking at `mm/shmem.c`, tmpfs legitimately lacks a `.read_folio` implementation by design.
It seems there are several "real" filesystems that can contain executables/libraries but lack `.read_folio`:
1. tmpfs/shmem
2. OverlayFS (delegates I/O)
3. DAX filesystems
Given that this affects multiple filesystem types, handling them all correctly via `kernel_read` might be a larger scope than fixing the immediate crash. I worry about missing edge cases in tmpfs or OverlayFS if we try to implement the fallback immediately in this patch.
> I really don't want the check for filler being NULL in read_cache_folio().
> I want it to crash noisily if callers are doing something stupid.
I propose the following approach for v3. It avoids the silent failure you are concerned about, but prevents the kernel panic:

1. Silent reject for `empty_aops` (procfs/sysfs), as they legitimately can't contain build IDs.
2. Loud warning + Error for other cases (DAX, tmpfs, OverlayFS).

The code would look like this:

    /* pseudo-filesystems */
    if (vma->vm_file->f_mapping->a_ops == &empty_aops)
        return -EINVAL;

    /* Real filesystems missing read_folio (DAX, tmpfs, OverlayFS, etc.) */
    if (!vma->vm_file->f_mapping->a_ops->read_folio) {
        /*
         * TODO: Implement kernel_read() fallback for DAX/tmpfs.
         * For now, fail loudly so we know what we are missing.
         */
        pr_warn_once("build_id_parse: filesystem %s lacks read_folio support\n",
                     vma->vm_file->f_path.dentry->d_sb->s_type->name);
        return -EOPNOTSUPP;
    }

This highlights exactly which filesystems are missing support in the logs without crashing the machine
Thanks,
Shaurya

