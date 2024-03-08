Return-Path: <linux-fsdevel+bounces-13959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910A6875B8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 01:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9F41C20E37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 00:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107EC63B3;
	Fri,  8 Mar 2024 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OieBQGA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E2B648
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857868; cv=none; b=AJwje1qmaeBYRoSlAC+GTXl6utoHUhtZ4WNMFd/s42Catk1uxrQ2lMM416u/jA2JdBEVk4DpLMVLoZrqyB9m2cCk5nTParvNbKJKhkkTD8VG2RLIFIumIiYa5/K1QkUiGeMlJ41Za18vY3e73692R9X90K3woUNZ2/btUDQwuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857868; c=relaxed/simple;
	bh=SzIS662EPeWv7yqvHJdh90JkAyL/FQHeOD06E9YGru8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7Ncx+H9NOQpHJL6uMfzd4fWzdbLHl9oThry1SefP1rDcjkBKeiLRk4am8/wA4FDggcL9FSlxRUkgwcXIPIvwxjWOnUTDfSXgbdm7En6sajEDjjA81v/TU+ttO1HaambjfQEi/U47NmrNHjGRVsWQNsBRRTGgkCdiSIyOxFLwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OieBQGA+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd59b95677so2331785ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 16:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709857866; x=1710462666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnZ3tBwaZXoylG2SFNYdOOEOqwLdH+SjpSM6FLsNMac=;
        b=OieBQGA+ZQXWPElFetRVG6CxIIS+C9jl1DMwf/qcGUhjvc4QKAaE6YaDLBbU2Py918
         NnFYyzwrBE9HuLdDPwHizDagDyhT8MRV35XnYGOl5XnMBQkexQAX1P/D/dBH9W9aTKGn
         MYTzd2olkwdDtEZjUEHgqONvK/gHvs7qNHhpM6wvSJTHdjkGgIIrclZfurUXIku+zzaA
         5lYvHH1t8HlP3HvdZ8AZioM2g2AvNL7mus40HgRgZJmf0eqeaYgsaCoLze5X7u5pxedy
         RYEdFRaYP7wRNLaRz7S6uihoENCYFQF9pJk30qdgskgsI3hdnUQ/Al+Mwd9UnipDtFaO
         F2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857866; x=1710462666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnZ3tBwaZXoylG2SFNYdOOEOqwLdH+SjpSM6FLsNMac=;
        b=MkxCCavuczUvwbff1wpwr6p4XzOlAWISVg6YhIMRWyC4PlTTA6wY5sRlGMbmJ8b7ue
         J5QIx2eACIsPm46NQVIXobxf8S0bqifdjuLVSADQeNmzeYXC6DnroV1uOAWH/ZXJaSbu
         3RvUzLxOSd8uASHNrMqLZQtPqyZd6TuE+3wV16mNZfjxnF/4D3hKpOWfdtJeVjq6p+xA
         jpu4P+uKvLrYd3SSZORpOuKCcq6Y/ALVndFY3CIeOvwHBxUBtxFg9XcyBP/FG5d1FseS
         5kYZZ9oFLHVvy9YOA/w23YkpRu+Tb0FoWY/Y9S8K708slpD6QcCMMM4JAUhj1GtGF2YF
         /Pyg==
X-Forwarded-Encrypted: i=1; AJvYcCV7h6i/gK6pDBE35e/gDRV/lvHaWB+7HjcBaIQZ3c3E6MHKS/WTHLKGf4SCZRnC7TkgCJmm0Yvf1QMGNDxlTWFS+LVlxTvB4H//46jJ5Q==
X-Gm-Message-State: AOJu0YyLfP/jSy5J05Jfkxk2CpVRo/Da+Xq0byEs7e+HJgew9/oPIY+f
	qUSeGrEF8/pI+3h91UVhguBKNYGRpw97jQyoLkAkXXi6e3YECnukiIYpLX2himk=
X-Google-Smtp-Source: AGHT+IGKNa7b6IYWmb8DS0yFUW3faKhcXzfDR//R7x9fGOYIgk6GoqrddekRUykYqyAuMKSW5n2txQ==
X-Received: by 2002:a17:903:41cc:b0:1dc:abe7:a1a6 with SMTP id u12-20020a17090341cc00b001dcabe7a1a6mr11455357ple.17.1709857865625;
        Thu, 07 Mar 2024 16:31:05 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id f13-20020a170903104d00b001dc96292774sm15159215plc.296.2024.03.07.16.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 16:31:04 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1riO8c-00GTyv-0l;
	Fri, 08 Mar 2024 11:31:02 +1100
Date: Fri, 8 Mar 2024 11:31:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: akiyks@gmail.com, cmaiolino@redhat.com, corbet@lwn.net,
	dan.carpenter@linaro.org, dchinner@redhat.com, djwong@kernel.org,
	hch@lst.de, hsiangkao@linux.alibaba.com, hughd@google.com,
	kch@nvidia.com, kent.overstreet@linux.dev, leo.lilong@huawei.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	longman@redhat.com, mchehab@kernel.org, peterz@infradead.org,
	sfr@canb.auug.org.au, sshegde@linux.ibm.com, willy@infradead.org
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 75bcffbb9e75
Message-ID: <ZepcRgdO39xIrXG2@dread.disaster.area>
References: <87r0gmz82t.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0gmz82t.fsf@debian-BULLSEYE-live-builder-AMD64>

On Thu, Mar 07, 2024 at 03:16:56PM +0530, Chandan Babu R wrote:
> Hi folks,
> 
> The for-next branch of the xfs-linux repository at:
> 
> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> 
> has just been updated.
> 
> Patches often get missed, so please check if your outstanding patches
> were in this update. If they have not been in this update, please
> resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> the next update.
> 
> The new head of the for-next branch is commit:
> 
> 75bcffbb9e75 xfs: shrink failure needs to hold AGI buffer
> 
> 201 new commits:

[snip list of all commits in for-next]

Hi Chandan,

I'm finding it difficult to determine what has changed from one
for-next update to the next because there's only a handful of new
commits being added to this list.

In this case, I think there's only 1 new commit in this update:

>       [75bcffbb9e75] xfs: shrink failure needs to hold AGI buffer

And I only found that out when rebasing my local tree and that patch
did not apply.

When I was doing these for-next tree updates, I tried to only send
out the list of commits that changed since the last for-next tree
update rather than the whole lot since the base kernel it was
started from. That made it easy for everyone to see what I'd just
committed, as opposed to trying to find whether their outstanding
patches were in a big list already committed patches...

Up to you, but I'm bringing it up because I am finding it difficult
to track when one of my patches has been committed to for-next right
now...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

