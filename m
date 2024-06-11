Return-Path: <linux-fsdevel+bounces-21442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78DE903EED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 16:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA7C1C22E35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E600217D8AC;
	Tue, 11 Jun 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDLB1L26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4911228E37;
	Tue, 11 Jun 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116512; cv=none; b=suSRVgUNGnRBZsIvzn2y4+bNWt8+foExCh/Ehlk+boPO2bI8kDJt1uA43jEHKNTiIMsUbYJyYZZYNQ3YG/stlknOzgZWL8Vrt6USnGKyH0sYd0IE6f9tRG2P0eggtYD5NU/ZlN2/2QOqNJ4KkC5PdgkA/VAWNd2K3qoEJMO+lJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116512; c=relaxed/simple;
	bh=2p+bKisyVsF4x+rjbIUXwa6vK01xzvwWdi8ZNTUWA+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt4YQQp6Bk8VL0/nhm+AJ7mFkySQVgPQb1MI80ugBQA3BUvXUom6YI8txHLw3zb17G6zoQ6zIgUJEWRKhbm5zYxS6xtBYiLtTW4Q5DBr/BnYzwuZvezXoN+bGrstqEko7bFHAEE53EQMfF25LYH8TAemSq0KltM8aUZRSWakivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDLB1L26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83EFC2BD10;
	Tue, 11 Jun 2024 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718116511;
	bh=2p+bKisyVsF4x+rjbIUXwa6vK01xzvwWdi8ZNTUWA+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDLB1L26mROxSN5Osvk8KPy0pi6Whe3xSQamqRFiViQqvdZAxfLdmME87zRZsqBDq
	 GFTWI7dGzbC29XnwSo+l5b+5Qov56FBnQoGJJDaaeOto/NCbrozwkyaN2wJWsu0lZk
	 FcmUAExX/OfsmhkcMSpn2IEz/r9MsNGO1j/jN7+OoJRT2zAqDR6uZJ5XHIlqKznM4n
	 95ViaR53UxCa9Jv09j8B3v48en6LvfKwt4ahR9CE7oBMtZY5eKalq9aSKKCG2XRhLK
	 Xz1Ob/1QzpLgEGAYvXLCetrHq4C6QohVqEEqZfm//ox7yJAMiggNhjoVb61W08kyKk
	 kz5n5lLQZgdag==
Date: Tue, 11 Jun 2024 07:35:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 4/5] _require_debugfs(): simplify and fix for debian
Message-ID: <20240611143511.GH52977@frogsfrogsfrogs>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-5-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611030203.1719072-5-mcgrof@kernel.org>

On Mon, Jun 10, 2024 at 08:02:01PM -0700, Luis Chamberlain wrote:
> Using findmnt -S debugfs arguments does not really output anything on
> debian, and is not needed, fix that.

AH, right, -S filter the "source" column in /proc/mounts.  That's
unimportant for fstests, because we really just want to know that the
*fstype* is debugfs, which is what -o FSTYPE does.

Ignoring my previous questions on this matter,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> Fixes: 8e8fb3da709e ("fstests: fix _require_debugfs and call it properly")
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 18ad25662d5c..30beef4e5c02 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3025,7 +3025,7 @@ _require_debugfs()
>  	local type
>  
>  	if [ -d "$DEBUGFS_MNT" ];then
> -		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
> +		type=$(findmnt -rncv -T $DEBUGFS_MNT -o FSTYPE)
>  		[ "$type" = "debugfs" ] && return 0
>  	fi
>  
> -- 
> 2.43.0
> 
> 

