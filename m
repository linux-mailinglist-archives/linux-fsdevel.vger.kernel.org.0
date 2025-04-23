Return-Path: <linux-fsdevel+bounces-47032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A60A97E3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8933D178B38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 05:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB55266B56;
	Wed, 23 Apr 2025 05:42:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040A10F9;
	Wed, 23 Apr 2025 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745386979; cv=none; b=Z3wIxYDnyJKFeBKBrMgJQvM/M36ZM2Ssh0P2HBAMejVanPBXiC6vk0Nc5cN6kq89xFT/2GLeHT/0+bpnGtAF7lxXWxs9FZCLfMiR2Pd0DGwhUt6AG2npMCxHzySv3mrnjGQdAft8M2eLQMdNB8TH3yjBJsWLLrasZQs01IeeQ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745386979; c=relaxed/simple;
	bh=+l0FuQIc0lCvF16sd2Yyx8QSF+mh8dOsifKokWEXbyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3fymWmOZzk+ztHrgrW5y/GTvwX3iDgAuJUjek3TZKEDR3vYkH3T9w8+8FauBXBdU5REk8BVE02KgnVTjt5y5kukAR6+QlwIRpw6g1Ts6Gg58cC8mCPHsGtw7mqGeGdYcowwTXnyevLrGBcmIn9MyBlofDf9H5jKvbMhpRFz/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B3CB68AFE; Wed, 23 Apr 2025 07:42:52 +0200 (CEST)
Date: Wed, 23 Apr 2025 07:42:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
Message-ID: <20250423054251.GA23087@lst.de>
References: <20250415121425.4146847-1-john.g.garry@oracle.com> <20250415121425.4146847-12-john.g.garry@oracle.com> <20250421040002.GU25675@frogsfrogsfrogs> <2467484b-382b-47c2-ae70-4a41d63cf4fc@oracle.com> <20250421164241.GD25700@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421164241.GD25700@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 21, 2025 at 09:42:41AM -0700, Darrick J. Wong wrote:
> Well it turns out that was a stupid question -- zoned=1 can't be enabled
> with reflink, which means there's no cow fallback so atomic writes just
> plain don't work:

Exactly.  It is still on my todo list to support it, but there are a
few higher priority items on it as well, in addition to constant
interruptions for patch reviews :)

> I /think/ all you'd have to do is create an xfs_zoned_end_atomic_io
> function that does what xfs_zoned_end_io but with a single
> tr_atomic_ioend transaction; figure out how to convey "this is an
> atomic out of place write" to xfs_end_ioend so that it knows to call
> xfs_zoned_end_atomic_io; and then update the xfs_get_atomic_write*
> helpers.

Roughly, yes.


