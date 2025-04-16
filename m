Return-Path: <linux-fsdevel+bounces-46585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83171A90C51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 21:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600423A9713
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B1522538F;
	Wed, 16 Apr 2025 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp4SGGLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C576224250;
	Wed, 16 Apr 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831679; cv=none; b=Qt2FxiS4s9ARz03MGEFv86GxuH/abzIViZVscASN2AXqAZ19YixOjjtD6J5EM2is+iXqxs2LcB/jsyHiJ5s4RIys8Y1FEtB2LZO4KazQGXNVZaAcsUBOEGjIRg5KGcQm7kDNMRFMKat/a0tU/lQ+ixKYJyp9QztSZWSEZitNzXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831679; c=relaxed/simple;
	bh=XH5BFbpOH07XYn9dfTAjIgoCoLGv9FMrkKS2XgAYvoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Blz5AHhxInod0TwDaOK+UsOdmNsPUoltiTHLUL9BzvbYat1iFfzZAtz3dc7+4Oa9H6b3RQbt7HzvDY7tyNpUNql2aeAiGqoVRyVApJBoB/YRy7l8KL4xNQkkMG7+BeQtsrDuu7+y0xsSb6lktTWqFFYpa6j4uVLarMeL52RT7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp4SGGLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839D2C4CEE2;
	Wed, 16 Apr 2025 19:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744831678;
	bh=XH5BFbpOH07XYn9dfTAjIgoCoLGv9FMrkKS2XgAYvoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tp4SGGLQREAiPkkEKFVxZd1k/XeW6At6uioB//5nPm80VYSQ7o7FZW0AQQ+QNCKJA
	 2AGPDyqUqPND8kRXWRweTxTPZC14Keela2Sql68pb+J5oKBWSprznM1svUoiv178ew
	 sSJazYli091wwKZeJYLoINkX5IfeCaMWrZpLpCD0G/nAeBIzx78inZzCUaYFTQ0WNl
	 oDOALCoyICdKuwjm2+51JAllSU4wDndt+UFPE4kHnNpdSN/hUUNBQEcx8zJlJPDYsC
	 sMVBDZJlDUAwJbuPoRyfEfyO1F+kKptiWVIYdk7CAkNlA/yLWGenjdLvJxhhm4phEp
	 LNm174QjbkWvQ==
Date: Wed, 16 Apr 2025 12:27:57 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	brauner@kernel.org, willy@infradead.org, hare@suse.de,
	djwong@kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next 0/7] fs/buffer: split pagecache lookups into atomic
 or blocking
Message-ID: <aAAEvcrmREWa1SKF@bombadil.infradead.org>
References: <20250415231635.83960-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231635.83960-1-dave@stgolabs.net>

On Tue, Apr 15, 2025 at 04:16:28PM -0700, Davidlohr Bueso wrote:
> Hello,
> 
> This is a respin of the series[0] to address the sleep in atomic scenarios for
> noref migration with large folios, introduced in:
> 
>       3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")
> 
> The main difference is that it removes the first patch and moves the fix (reducing
> the i_private_lock critical region in the migration path) to the final patch, which
> also introduces the new BH_Migrate flag. It also simplifies the locking scheme in
> patch 1 to avoid folio trylocking in the atomic lookup cases. So essentially blocking
> users will take the folio lock and hence wait for migration, and otherwise nonblocking
> callers will bail the lookup if a noref migration is on-going. Blocking callers
> will also benefit from potential performance gains by reducing contention on the
> spinlock for bdev mappings.
> 
> It is noteworthy that this series is probably too big for Linus' tree, so there are
> two options:
> 
>  1. Revert 3c20917120ce61, add this series + 3c20917120ce61 for next. Or,

Reverting due to a fix series is odd, I'd advocate this series as a set
of fixes to Linus' tree because clearly folio migration was not complete
for buffer_migrate_folio_norefs() and this is part of the loose bits to help
it for large folios. This issue was just hard to reproduce. The enabler
of large folios on the block device cache is actually commit
47dd67532303 ("block/bdev: lift block size restrictions to 64k") which
goes later after 3c20917120ce61.

Jan Kara, since you've already added your Reviewed-by for all patches
do you have any preference how this trickles to Linus?

>  2. Cherry pick patch 7 as a fix for Linus' tree, and leave the rest for next.
>     But that could break lookup callers that have been deemed unfit to bail.
> 
> Patch 1: carves a path for callers that can block to take the folio lock.
> Patch 2: adds sleeping flavors to pagecache lookups, no users.
> Patches 3-6: converts to the new call, where possible.
> Patch 7: does the actual sleep in atomic fix.
> 
> Thanks!

kdevops has tested this patch series and compared it to the baseline [0]
and has found no regressions on ext4.

Tested-by: kdevops@lists.linux.dev

Detailed test results below:

Comparing commits:
Baseline:      a74831cc4300 | linux-ext4-kpd: Linux 6.15-rc2
Test:          6b337686249b | 6.15-rc2 + these patches

Baseline Kernel:6.15.0-rc2-g8ffd015db85f
Test Kernel:   6.15.0-rc2-00006-g89e084d709fc

Verbose Test Results Comparison:
================================================================================

Profile: ext4_1k
                    | BASELINE     | TEST        
-------------------|--------------|--------------
ext4/034            | [fail]       | [fail]       
ext4/055            | [fail]       | [fail]       
generic/082         | [fail]       | [fail]       
generic/219         | [fail]       | [fail]       
generic/223         | [fail]       | [fail]       
generic/230         | [fail]       | [fail]       
generic/231         | [fail]       | [fail]       
generic/232         | [fail]       | [fail]       
generic/233         | [fail]       | [fail]       
generic/235         | [fail]       | [fail]       
generic/381         | [fail]       | [fail]       
generic/382         | [fail]       | [fail]       
generic/566         | [fail]       | [fail]       
generic/587         | [fail]       | [fail]       
generic/600         | [fail]       | [fail]       
generic/601         | [fail]       | [fail]       
generic/681         | [fail]       | [fail]       
generic/682         | [fail]       | [fail]       
generic/741         | [fail]       | [fail]       

Profile: ext4_2k
                    | BASELINE     | TEST        
-------------------|--------------|--------------
ext4/034            | [fail]       | [fail]       
ext4/055            | [fail]       | [fail]       
generic/082         | [fail]       | [fail]       
generic/219         | [fail]       | [fail]       
generic/223         | [fail]       | [fail]       
generic/230         | [fail]       | [fail]       
generic/231         | [fail]       | [fail]       
generic/232         | [fail]       | [fail]       
generic/233         | [fail]       | [fail]       
generic/235         | [fail]       | [fail]       
generic/381         | [fail]       | [fail]       
generic/382         | [fail]       | [fail]       
generic/566         | [fail]       | [fail]       
generic/587         | [fail]       | [fail]       
generic/600         | [fail]       | [fail]       
generic/601         | [fail]       | [fail]       
generic/681         | [fail]       | [fail]       
generic/682         | [fail]       | [fail]       
generic/741         | [fail]       | [fail]       

Profile: ext4_4k
                    | BASELINE     | TEST        
-------------------|--------------|--------------
ext4/034            | [fail]       | [fail]       
ext4/055            | [fail]       | [fail]       
generic/082         | [fail]       | [fail]       
generic/219         | [fail]       | [fail]       
generic/223         | [fail]       | [fail]       
generic/230         | [fail]       | [fail]       
generic/231         | [fail]       | [fail]       
generic/232         | [fail]       | [fail]       
generic/233         | [fail]       | [fail]       
generic/235         | [fail]       | [fail]       
generic/381         | [fail]       | [fail]       
generic/382         | [fail]       | [fail]       
generic/566         | [fail]       | [fail]       
generic/587         | [fail]       | [fail]       
generic/600         | [fail]       | [fail]       
generic/601         | [fail]       | [fail]       
generic/681         | [fail]       | [fail]       
generic/682         | [fail]       | [fail]       
generic/741         | [fail]       | [fail]       

Profile: ext4_advanced_features
                    | BASELINE     | TEST        
-------------------|--------------|--------------
ext4/034            | [fail]       | [fail]       
ext4/055            | [fail]       | [fail]       
generic/082         | [fail]       | [fail]       
generic/219         | [fail]       | [fail]       
generic/223         | [fail]       | [fail]       
generic/230         | [fail]       | [fail]       
generic/231         | [fail]       | [fail]       
generic/232         | [fail]       | [fail]       
generic/233         | [fail]       | [fail]       
generic/235         | [fail]       | [fail]       
generic/270         | [fail]       | [fail]       
generic/381         | [fail]       | [fail]       
generic/382         | [fail]       | [fail]       
generic/477         | [fail]       | [fail]       
generic/566         | [fail]       | [fail]       
generic/587         | [fail]       | [fail]       
generic/600         | [fail]       | [fail]       
generic/601         | [fail]       | [fail]       
generic/681         | [fail]       | [fail]       
generic/682         | [fail]       | [fail]       
generic/741         | [fail]       | [fail]       

Profile: ext4_bigalloc1024k_4k
                    | BASELINE     | TEST        
-------------------|--------------|--------------
ext4/033            | [fail]       | [fail]       
ext4/034            | [fail]       | [fail]       
ext4/045            | [fail]       | [fail]       
ext4/055            | [fail]       | [fail]       
generic/075         | [fail]       | [fail]       
generic/082         | [fail]       | [fail]       
generic/091         | [fail]       | [fail]       
generic/112         | [fail]       | [fail]       
generic/127         | [fail]       | [fail]       
generic/219         | [fail]       | [fail]       
generic/230         | [fail]       | [fail]       
generic/231         | [fail]       | [fail]       
generic/232         | [fail]       | [fail]       
generic/233         | [fail]       | [fail]       
generic/234         | [fail]       | [fail]       
generic/235         | [fail]       | [fail]       
generic/251         | [fail]       | [fail]       
generic/263         | [fail]       | [fail]       
generic/280         | [fail]       | [fail]       
generic/365         | [fail]       | [fail]       
generic/381         | [fail]       | [fail]       
generic/382         | [fail]       | [fail]       
generic/435         | [fail]       | [fail]       
generic/566         | [fail]       | [fail]       
generic/587         | [fail]       | [fail]       
generic/600         | [fail]       | [fail]       
generic/601         | [fail]       | [fail]       
generic/614         | [fail]       | [fail]       
generic/629         | [fail]       | [fail]       
generic/634         | [fail]       | [fail]       
generic/635         | [fail]       | [fail]       
generic/643         | [fail]       | [fail]       
generic/681         | [fail]       | [fail]       
generic/682         | [fail]       | [fail]       
generic/698         | [fail]       | [fail]       
generic/732         | [fail]       | [fail]       
generic/738         | [fail]       | [fail]       
generic/741         | [fail]       | [fail]       
generic/754         | [fail]       | [fail]       

Profile: ext4_bigalloc16k_4k
                    | BASELINE     | TEST        
-------------------|--------------|--------------
ext4/033            | [fail]       | [fail]       
ext4/034            | [fail]       | [fail]       
ext4/055            | [fail]       | [fail]       
generic/075         | [fail]       | [fail]       
generic/082         | [fail]       | [fail]       
generic/091         | [fail]       | [fail]       
generic/112         | [fail]       | [fail]       
generic/127         | [fail]       | [fail]       
generic/219         | [fail]       | [fail]       
generic/223         | [fail]       | [fail]       
generic/230         | [fail]       | [fail]       
generic/231         | [fail]       | [fail]       
generic/232         | [fail]       | [fail]       
generic/233         | [fail]       | [fail]       
generic/234         | [fail]       | [fail]       
generic/235         | [fail]       | [fail]       
generic/263         | [fail]       | [fail]       
generic/280         | [fail]       | [fail]       
generic/381         | [fail]       | [fail]       
generic/382         | [fail]       | [fail]       
generic/566         | [fail]       | [fail]       
generic/587         | [fail]       | [fail]       
generic/600         | [fail]       | [fail]       
generic/601         | [fail]       | [fail]       
generic/681         | [fail]       | [fail]       
generic/682         | [fail]       | [fail]       
generic/741         | [fail]       | [fail]       

Profile: ext4_bigalloc2048k_4k
                    | BASELINE     | TEST        
-------------------|--------------|--------------
ext4/033            | [fail]       | [fail]       
ext4/034            | [fail]       | [fail]       
ext4/045            | [fail]       | [fail]       
ext4/055            | [fail]       | [fail]       
generic/075         | [fail]       | [fail]       
generic/082         | [fail]       | [fail]       
generic/091         | [fail]       | [fail]       
generic/112         | [fail]       | [fail]       
generic/127         | [fail]       | [fail]       
generic/219         | [fail]       | [fail]       
generic/230         | [fail]       | [fail]       
generic/231         | [fail]       | [fail]       
generic/232         | [fail]       | [fail]       
generic/233         | [fail]       | [fail]       
generic/234         | [fail]       | [fail]       
generic/235         | [fail]       | [fail]       
generic/251         | [fail]       | [fail]       
generic/263         | [fail]       | [fail]       
generic/280         | [fail]       | [fail]       
generic/365         | [fail]       | [fail]       
generic/381         | [fail]       | [fail]       
generic/382         | [fail]       | [fail]       
generic/435         | [fail]       | [fail]       
generic/471         | [fail]       | [fail]       
generic/566         | [fail]       | [fail]       
generic/587         | [fail]       | [fail]       
generic/600         | [fail]       | [fail]       
generic/601         | [fail]       | [fail]       
generic/614         | [fail]       | [fail]       
generic/629         | [fail]       | [fail]       
generic/634         | [fail]       | [fail]       
generic/635         | [fail]       | [fail]       
generic/643         | [fail]       | [fail]       
generic/645         | [fail]       | [fail]       
generic/676         | [fail]       | [fail]       
generic/681         | [fail]       | [fail]       
generic/682         | [fail]       | [fail]       
generic/698         | [fail]       | [fail]       
generic/732         | [fail]       | [fail]       
generic/736         | [fail]       | [fail]       
generic/738         | [fail]       | [fail]       
generic/741         | [fail]       | [fail]       
generic/754         | [fail]       | [fail]       

Profile: ext4_bigalloc32k_4k
                    | BASELINE     | TEST        
-------------------|--------------|--------------
ext4/033            | [fail]       | [fail]       
ext4/034            | [fail]       | [fail]       
ext4/055            | [fail]       | [fail]       
generic/075         | [fail]       | [fail]       
generic/082         | [fail]       | [fail]       
generic/091         | [fail]       | [fail]       
generic/112         | [fail]       | [fail]       
generic/127         | [fail]       | [fail]       
generic/219         | [fail]       | [fail]       
generic/223         | [fail]       | [fail]       
generic/230         | [fail]       | [fail]       
generic/231         | [fail]       | [fail]       
generic/232         | [fail]       | [fail]       
generic/233         | [fail]       | [fail]       
generic/234         | [fail]       | [fail]       
generic/235         | [fail]       | [fail]       
generic/263         | [fail]       | [fail]       
generic/280         | [fail]       | [fail]       
generic/381         | [fail]       | [fail]       
generic/382         | [fail]       | [fail]       
generic/566         | [fail]       | [fail]       
generic/587         | [fail]       | [fail]       
generic/600         | [fail]       | [fail]       
generic/601         | [fail]       | [fail]       
generic/681         | [fail]       | [fail]       
generic/682         | [fail]       | [fail]       
generic/741         | [fail]       | [fail]       

Profile: ext4_bigalloc64k_4k
                    | BASELINE     | TEST        
-------------------|--------------|--------------
ext4/033            | [fail]       | [fail]       
ext4/034            | [fail]       | [fail]       
ext4/055            | [fail]       | [fail]       
generic/075         | [fail]       | [fail]       
generic/082         | [fail]       | [fail]       
generic/091         | [fail]       | [fail]       
generic/112         | [fail]       | [fail]       
generic/127         | [fail]       | [fail]       
generic/219         | [fail]       | [fail]       
generic/223         | [fail]       | [fail]       
generic/230         | [fail]       | [fail]       
generic/231         | [fail]       | [fail]       
generic/232         | [fail]       | [fail]       
generic/233         | [fail]       | [fail]       
generic/234         | [fail]       | [fail]       
generic/235         | [fail]       | [fail]       
generic/263         | [fail]       | [fail]       
generic/280         | [fail]       | [fail]       
generic/381         | [fail]       | [fail]       
generic/382         | [fail]       | [fail]       
generic/566         | [fail]       | [fail]       
generic/587         | [fail]       | [fail]       
generic/600         | [fail]       | [fail]       
generic/601         | [fail]       | [fail]       
generic/681         | [fail]       | [fail]       
generic/682         | [fail]       | [fail]       
generic/741         | [fail]       | [fail]       

Profile: ext4_defaults
                    | BASELINE     | TEST        
-------------------|--------------|--------------
ext4/034            | [fail]       | [fail]       
ext4/055            | [fail]       | [fail]       
generic/082         | [fail]       | [fail]       
generic/219         | [fail]       | [fail]       
generic/223         | [fail]       | [fail]       
generic/230         | [fail]       | [fail]       
generic/231         | [fail]       | [fail]       
generic/232         | [fail]       | [fail]       
generic/233         | [fail]       | [fail]       
generic/235         | [fail]       | [fail]       
generic/270         | [fail]       | [fail]       
generic/381         | [fail]       | [fail]       
generic/382         | [fail]       | [fail]       
generic/566         | [fail]       | [fail]       
generic/587         | [fail]       | [fail]       
generic/600         | [fail]       | [fail]       
generic/601         | [fail]       | [fail]       
generic/681         | [fail]       | [fail]       
generic/682         | [fail]       | [fail]       
generic/741         | [fail]       | [fail]       

Summary:
  - Total regressions: 0
  - Total fixes: 0
  - Unchanged failures: 261

[0] https://lore.kernel.org/all/Z__vQcCF9xovbwtT@bombadil.infradead.org/

  Luis

