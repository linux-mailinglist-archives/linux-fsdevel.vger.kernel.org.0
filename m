Return-Path: <linux-fsdevel+bounces-44164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F81A640CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E83D7A709C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 06:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF45521A425;
	Mon, 17 Mar 2025 06:08:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073721505B;
	Mon, 17 Mar 2025 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191714; cv=none; b=e7ZLLLiLNcZ2g4Df7Z2GnivabpmeqZIXPOW0jNbpdCgIGOyukSwnNojjUqEqRgEU0+9Fzl8DtiTg2exMWpwEpLznY78i4bfV6gbo3wlfc61B1fc5p/8v7/l3/kNWX4a1ReJH/PhPJGi1ebSxdn5Pj8slJHolYN6w+/psAGVJIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191714; c=relaxed/simple;
	bh=uroRYtWv4br4qCnHqbrj+mxa15c9UnoirVWCw2T0U7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEM/4vaG6c6R5QYxcw20N/AJTuvb0t7S67Zs9MQwnLDBSdySyrLYwqn7JUNXk/63EwC4D0Jv1vLG+R4ycJNi/an+Olz4zESugMR4aihHLYSYZB9j74n9gwoQJ4hsfx+N2B7yDN+VELVY6UeKoM0vgu3hB+Qv/qDHyaCqcnalsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C49368D0A; Mon, 17 Mar 2025 07:08:28 +0100 (CET)
Date: Mon, 17 Mar 2025 07:08:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 02/13] iomap: comment on atomic write checks in
 iomap_dio_bio_iter()
Message-ID: <20250317060828.GB27019@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 13, 2025 at 05:12:59PM +0000, John Garry wrote:
>  		if (iter->flags & IOMAP_ATOMIC_HW) {
> +			/*
> +			* Ensure that the mapping covers the full write length,
> +			* otherwise we will submit multiple BIOs, which is
> +			* disallowed.
> +			*/

"disallowed" doesn't really explain anything, why is it disallowed?

Maybe:

			* Ensure that the mapping covers the full write length,
			* otherwise it can't be submitted as a single bio,
			* which is required to use hardware atomics.


