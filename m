Return-Path: <linux-fsdevel+bounces-10393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB7D84AA60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 00:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF551F2759C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C14A990;
	Mon,  5 Feb 2024 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tgmig1Xj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129348780
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174956; cv=none; b=CDJlrkU7E6KbOQNzC77lieFVdiNYjQ4/DAL5+anUaVGRRQ15aIBTX/jYjxWz6fdBqYmXgHDxPTT7fRFLkgrDLUj2/krZRbKCGGl4QvQEmo/yIiWf9hyBq0TSfhJ4R0kfxy1iqDV/pBMxm2MefaSV3EjrgTxX9XzwykBVszmdGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174956; c=relaxed/simple;
	bh=l+qBRd0uhtVCBi7FglZtnBJV6a/zqeKohi35eaar3og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNtEAj6HT2OO5CwhXefneJz90CRVnOobSEs5DymJiMea7ZKfeUwzPEcLKNNHyDVBgWk7QLboTnFWl5OtoNT1SO1UwhXFa2VnhQ47WSc458hxf1tMpmJ20bL4qf8gToyWpqLIbD0SfGhC2DG+VpyoL3+g9yfXzSgdlKcRpwHR2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=tgmig1Xj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8ef977f1eso37844495ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 15:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707174954; x=1707779754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLDVauXDb3SkVjlIiWsDawP2Lrkb7uN8ijdb1ZnT3GM=;
        b=tgmig1XjpNVt8fwZ0rBr+vT+Au5hruM0C3p7k7fB+5NqvqEAWaXANSbNvoqZnHqCHL
         keZJLMuwTtrtOoUvsZRcWg72EfAwHhPn9tDtrv/cZ+Uav0u+NvU5B3GmDmGDpzeqSnhM
         FzkUc0MQa35dtE+cRymfw0gT1sRIe731Os53KO+w6gyfxWtJQhWc9Kw7LyyngBGD5sop
         yBboql/alkdugIkDIlnoWg2xpt2521sFCTyFyopiPnojFbN7pXvwAhjFUWoaUYJQ3WOn
         bAnPYSURGzIs8G1+h4TYKUohYydq53deqF0GXZ+ooVBOabyrBg5lxxETbAfPsEFbymYE
         mecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707174954; x=1707779754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLDVauXDb3SkVjlIiWsDawP2Lrkb7uN8ijdb1ZnT3GM=;
        b=qsq9q5dWa0KKUlQ8W6gB7kZiQp7sALJVsn29DRtDWTXetRYnJh9iod3gVuW/bR9+Ev
         rAa7wnFO87pNlKY807Z5KGpN3Iw5do+OrBJE56r/PJOiByklbhBtASgg/VF+/yfPCnpe
         bIcrzcIeIzZ3GzufD5v6XAQKaYpZ/wsvK3ZYYK9cUGDBwPccUo49vcuZuAmr3s/n2UIk
         Ue00VUhXp4kZHtjW/3lgffDhOkdIqsAL78R449Yi89XAf8ow8nbWDFllTMUg+CKiu2qa
         KXNN9JFj7FawlYvFXGZMMuoF7oxexPWNicLythlWcBC8AVeljlFJ+1ouD8HjB4LLXBRX
         g2EA==
X-Gm-Message-State: AOJu0YzC4B6VFrQh/G/PWhn8gjx49sEg5+2L8H/Ztv+PAfHSNwYOrLAs
	vVn4krPBwYyzpohD7NC2EHy7xRudhoGYESp/PHNbcrx0A5xUpw6oaToaUlDs+xk=
X-Google-Smtp-Source: AGHT+IE3RZklDuPK3RsSAT5nJ3BuQdhvpthhno9atwmUQdGKYtEs6vhTfLTEZnZ/CbvGV5USvqDzoA==
X-Received: by 2002:a17:903:1cf:b0:1d9:a4bb:29f2 with SMTP id e15-20020a17090301cf00b001d9a4bb29f2mr720650plh.46.1707174954062;
        Mon, 05 Feb 2024 15:15:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVg6EM1UWxQB4eSbUussRDKlEYCp9GsHdJ+mKzLNkffYzCq4qGIbm5Fa52ygPxyd12ROmIDr0EhKABFTm7jL0VxvipPjnimMW7859kFnuVmsGOH1hLbPjZQjmD4favBOWTRXCbwPbdTuHneqwjMlmz7qW5Xuseul9RRVQmJA+/UXci5wEhQo68jzK+qP2gUwQzkjB/BPgZng8GYtOhm8L8KdYuqbyW1WOC0qwew+olLEgsRbxzEtWnhVC6GsID24vXEwv50ASkcgyXy9OlkxOJb7nEsvNKjVfySPWR5jthwWt8j6Bm9ZFYf
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id kb13-20020a170903338d00b001d9606aac46sm419329plb.212.2024.02.05.15.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:15:53 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rX8Bq-002aEM-3D;
	Tue, 06 Feb 2024 10:15:51 +1100
Date: Tue, 6 Feb 2024 10:15:50 +1100
From: Dave Chinner <david@fromorbit.com>
To: JonasZhou <jonaszhou-oc@zhaoxin.com>
Cc: willy@infradead.org, CobeChen@zhaoxin.com, JonasZhou@zhaoxin.com,
	LouisQi@zhaoxin.com, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false
 sharing with i_mmap.
Message-ID: <ZcFsJvUOVMc8e0yO@dread.disaster.area>
References: <Zb1DVNGaorZCDS7R@casper.infradead.org>
 <20240205062229.5283-1-jonaszhou-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205062229.5283-1-jonaszhou-oc@zhaoxin.com>

On Mon, Feb 05, 2024 at 02:22:29PM +0800, JonasZhou wrote:
> > On Fri, Feb 02, 2024 at 03:03:51PM +0000, Matthew Wilcox wrote:
> > > On Fri, Feb 02, 2024 at 05:34:07PM +0800, JonasZhou-oc wrote:
> > > > In the struct address_space, there is a 32-byte gap between i_mmap
> > > > and i_mmap_rwsem. Due to the alignment of struct address_space
> > > > variables to 8 bytes, in certain situations, i_mmap and
> > > > i_mmap_rwsem may end up in the same CACHE line.
> > > > 
> > > > While running Unixbench/execl, we observe high false sharing issues
> > > > when accessing i_mmap against i_mmap_rwsem. We move i_mmap_rwsem
> > > > after i_private_list, ensuring a 64-byte gap between i_mmap and
> > > > i_mmap_rwsem.
> > > 
> > > I'm confused.  i_mmap_rwsem protects i_mmap.  Usually you want the lock
> > > and the thing it's protecting in the same cacheline.  Why is that not
> > > the case here?
> >
> > We actually had this seven months ago:
> >
> > https://lore.kernel.org/all/20230628105624.150352-1-lipeng.zhu@intel.com/
> >
> > Unfortunately, no argumentation was forthcoming about *why* this was
> > the right approach.  All we got was a different patch and an assertion
> > that it still improved performance.
> >
> > We need to understand what's going on!  Please don't do the same thing
> > as the other submitter and just assert that it does.
> 
> When running UnixBench/execl, each execl process repeatedly performs 
> i_mmap_lock_write -> vma_interval_tree_remove/insert -> 
> i_mmap_unlock_write. As indicated below, when i_mmap and i_mmap_rwsem 
> are in the same CACHE Line, there will be more HITM.

As I expected, your test is exercising the contention case rather
than the single, uncontended case. As such, your patch is simply
optimising the structure layout for the contended case at the
expense of an extra cacheline miss in the uncontended case.

I'm not an mm expert, so I don't know which case we should optimise
for.

However, the existing code is not obviously wrong, it's just that
your micro-benchmark exercises the pathological worst case for the
optimisation choices made for this structure. Whether the contention
case is worth optimising is the first decision that needs to be
made, then people can decide if hacking minor optimisations into the
code is better than reworking the locking and/or algorithm to avoid
the contention altogether is a better direction...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

