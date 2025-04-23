Return-Path: <linux-fsdevel+bounces-47109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D68A9944A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 18:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023AF1BC03A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586ED292927;
	Wed, 23 Apr 2025 15:46:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417D176AC8;
	Wed, 23 Apr 2025 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423183; cv=none; b=tiyott2uZN+pIVjRiMokVobfHExQ2vRXX1VXN3o/IRq3dzL9bD5Esu9dmlKfT0Cw20d3dswqT1YMB5egNZOXrcwf27tyJKwjq7c+t6DFC0SvRpQiFvmpWi62wh1ycNBzd5Rni5PNyMHMm/0Ifj06dJWj5sj6lcqvmqsELvMVelo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423183; c=relaxed/simple;
	bh=Bs2vkrYkdLBN+hEWYlKD6nWHngnhzbBykaskkdjOSbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz5mARTMAVjGSRLdbtZSFJ2IHJ+P0WFYm/iqqxaUPdt04kpaFYe19kvnJNz0eBLlPh1hgfjXTABJz/YvWaXykh5oRod+lo+20noaGJHPtonTPq7oRtP3oiowf7hqfNmyIrckojX0Wr2iKB8fmcnJB8e1bfT8/jAqi0dhiw4P4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8483368C4E; Wed, 23 Apr 2025 17:46:15 +0200 (CEST)
Date: Wed, 23 Apr 2025 17:46:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 05/15] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250423154615.GA31899@lst.de>
References: <20250422122739.2230121-1-john.g.garry@oracle.com> <20250422122739.2230121-6-john.g.garry@oracle.com> <20250423003823.GW25675@frogsfrogsfrogs> <f467a921-e7dd-4f5b-ac9f-c6e8c043143c@oracle.com> <20250423081055.GA28307@lst.de> <f27ea8f7-700a-4fb1-b9cd-a0cba04c9e47@oracle.com> <20250423083317.GB30432@lst.de> <20250423151224.GC25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423151224.GC25675@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 23, 2025 at 08:12:24AM -0700, Darrick J. Wong wrote:
> I disagree, leaving the hardware awu_min/max in the buftarg makes more
> sense to me because the buftarg is our abstraction for a block device,
> and these fields describe the atomic write units that we can use with
> that block device.

Yeah.  If you want to keep it I'd suggest we go back to my earlier
suggestion.


