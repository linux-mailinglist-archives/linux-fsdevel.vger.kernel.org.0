Return-Path: <linux-fsdevel+bounces-30880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BF098EFF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B811F24586
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD348199935;
	Thu,  3 Oct 2024 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="dXy/8Ps6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C902197554
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960608; cv=none; b=ecI0PVvz6K8vEEmuaA76YCJFYMJheQehCOKgjUb/Z3zHu/HbNIlLKuh3yz4PvfnKGtwdJNfVSTihaWx6hrl29F68qcSFUzFRXHCEeeEBnP4PQNnUwgvkaRdsJSoCc2+ApoTRSxBw6/SYy+dqkhwh9m0X7LjhY7o3PO88QwtiIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960608; c=relaxed/simple;
	bh=cFecOIy8+7/6v3XpNNPKZuX5SpWYIpwMGimiHsJvsjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cbvmgd5ZFgwp5cjhIp1VyudDRZgkzsJPwW1pKijw9xNvDFGtNruB/pW1gIcJJP2Vk7OwhBj0i7jtGj+i089nd4Q2Fg2gWkKJ35KutsOh1fO3PeihLQluhskHuRyGPQultWfcxjwrmMuCgnjmG54uSwSrfBG9P6yrLf76P4/OPjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=dXy/8Ps6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b95359440so7573455ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727960606; x=1728565406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6WsCn5kQnr/M8pyra1nEENH4i5MfxsBdvPAgp8YWfY=;
        b=dXy/8Ps6wW60z17VLFkeDIortaYCVEwIQMt7xYkrfB93puA0ibNaYc9zyneco8kLHz
         b1+NyDd/YEpUHUgCmMFVfLV3yhqeFHn3jlgyfwdI3eE76n5K9jmCOq+EbGg+m2uoWz0E
         ILV3/zPd7yxQ5mwQbJexmkKY2Of8RIOOxAClu4+tvBP/iLNdr6fd7FZKwYZA1xHs30kU
         ndC0822XtE076rLqzCEiMD1zyOjPwJrOXpdVioGDNOwamUHd44Xck37kJH8mRgvEg3ji
         CoIRKKGn1ciaWQtCIA/+k7qzXD5Yvm2jYA3DFadjlpBkdIEUBrIAhR2Ba1M1ma9/LaEg
         xxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960606; x=1728565406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6WsCn5kQnr/M8pyra1nEENH4i5MfxsBdvPAgp8YWfY=;
        b=AgdhEOWUtjAzkfBrrOhc438TTS5XzJ+m6qgsqQm01SqJOO92E8aSArAcTmcL4oCDPH
         CkSdCmDyjmFdkU1JsLVr+zYQJDCK2oKFfgTECSupmapSbJ5vAdEdQ+VDih0skDfYemp5
         RCg87397yDr1xftkCX9c7X2AESV0iYmP8X+p8FlWOmZorEC19kd8RY7yDTcr5USDlaPk
         LCFDQ+HVcOIMLPIOCluUiD4rtwsZa265n8/aU/BHfwCESRDRQENds8iYCFMXUzsGXk3w
         Mr8oUpM0rCTsCCtM6fUZx4/emLuQB+jUEV/sJy0VuBKDWwCv8/ef0V5oZTA04sPrYWVw
         FjPA==
X-Gm-Message-State: AOJu0YzeoJ5koZWYZmtb7hXsZaxU5D1EDdJGE5yHaUErXes0xOr1P5MZ
	xezo7TK10VzhxGKq8hGS7WDPLOmnPLv1fj7R8yMNX0+KW7ZmXL28F0q6rw/YTXwKWzjUn9lX25Q
	r
X-Google-Smtp-Source: AGHT+IEiwb3qcvI21LtzL2rMLicqK87raMpVn88xvdwX6PVd2P5nGiqQOFJ7fHf8sEPKX8HgqeiYJA==
X-Received: by 2002:a17:902:e743:b0:20b:7e1e:7337 with SMTP id d9443c01a7336-20bc5a0a46bmr106414435ad.13.1727960605658;
        Thu, 03 Oct 2024 06:03:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead29b9sm8710455ad.22.2024.10.03.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:03:25 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1swLUI-00DOXS-2V;
	Thu, 03 Oct 2024 23:03:22 +1000
Date: Thu, 3 Oct 2024 23:03:22 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <Zv6WGoNWMsnTWxza@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241003114555.bl34fkqsja4s5tok@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003114555.bl34fkqsja4s5tok@quack3>

On Thu, Oct 03, 2024 at 01:45:55PM +0200, Jan Kara wrote:
> Hi Dave!
> 
> On Wed 02-10-24 11:33:17, Dave Chinner wrote:
> > There are two superblock iterator functions provided. The first is a
> > generic iterator that provides safe, reference counted inodes for
> > the callback to operate on. This is generally what most sb->s_inodes
> > iterators use, and it allows the iterator to drop locks and perform
> > blocking operations on the inode before moving to the next inode in
> > the sb->s_inodes list.
> > 
> > There is one quirk to this interface - INO_ITER_REFERENCE - because
> > fsnotify iterates the inode cache -after- evict_inodes() has been
> > called during superblock shutdown to evict all non-referenced
> > inodes. Hence it should only find referenced inodes, and it has
> > a check to skip unreferenced inodes. This flag does the same.
> 
> Overall I really like the series. A lot of duplicated code removed and
> scalability improved, we don't get such deals frequently :) Regarding
> INO_ITER_REFERENCE I think that after commit 1edc8eb2e9313 ("fs: call
> fsnotify_sb_delete after evict_inodes") the check for 0 i_count in
> fsnotify_unmount_inodes() isn't that useful anymore so I'd be actually fine
> dropping it (as a separate patch please).
> 
> That being said I'd like to discuss one thing: As you have surely noticed,
> some of the places iterating inodes perform additional checks on the inode
> to determine whether the inode is interesting or not (e.g. the Landlock
> iterator or iterators in quota code) to avoid the unnecessary iget / iput
> and locking dance.

Yes, but we really don't care. None of these cases are performance
critical, and I'd much prefer that we have a consistent behaviour.

> The inode refcount check you've worked-around with
> INO_ITER_REFERENCE is a special case of that. Have you considered option to
> provide callback for the check inside the iterator?

I did. I decided that it wasn't necessary just to avoid the
occasional iget/iput. It's certainly not necessary for the
fsnotify/landlock cases where INO_ITER_REFERENCE was used because
at that point there are only landlock and fsnotify inodes left in
the cache. We're going to be doing iget/iput on all of them
anyway.

Really, subsystems should be tracking inodes they have references to
themselves, not running 'needle in haystack' searches for inodes
they hold references to. That would get rid of both the fsnotify and
landlock iterators completely...

> Also maybe I'm went a *bit* overboard here with macro magic but the code
> below should provide an iterator that you can use like:
> 
> 	for_each_sb_inode(sb, inode, inode_eligible_check(inode)) {
> 		do my stuff here
> 	}

As I explained to Kent: wrapping the existing code in a different
iterator defeats the entire purpose of the change to the iteration
code.

> that will avoid any indirect calls and will magically handle all the
> cleanup that needs to be done if you break / jump out of the loop or
> similar. I actually find such constructs more convenient to use than your
> version of the iterator because there's no need to create & pass around the
> additional data structure for the iterator body, no need for special return
> values to abort iteration etc.

I'm not introducing the callback-based iterator function to clean
the code up - I'm introducing it as infrastructure that allows the
*iteration mechanism to be completely replaced* by filesystems that
have more efficient, more scalable  inode iterators already built
in.

This change of iterator model also allows seamless transition of
indivudal filesystems to new iterator mechanisms. Macro based
iterators do not allow for different iterator implementations to
co-exist, but that's exactly what I'm trying to acheive here.
I'm not trying to clean the code up - I'm trying to lay the
ground-work for new functionality....


-Dave.
-- 
Dave Chinner
david@fromorbit.com

