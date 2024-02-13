Return-Path: <linux-fsdevel+bounces-11316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A62852978
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3CC1C2388C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D27F17562;
	Tue, 13 Feb 2024 06:56:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939981754E;
	Tue, 13 Feb 2024 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807407; cv=none; b=VNaU90bPaO9ArxVeIjxla8+z4l8r5nNCDUfhAb8v7KZKYA9FO6QUO2Q4UZZEsaACcIzm76Sauh3M91ATXTvgLVTLlVVjR1HHjrDJorbjPnEpCeYEOL8chbFBYPx/KV4s+woK+i4QsJrLRPd7Vq4dn4iiHGJYSwe75dMshP5yVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807407; c=relaxed/simple;
	bh=a2QC0Pjef2Sr79QLLamY8jdt4h6OiJtLS5yJ+xXtDj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwcNabTQp3HORh+LabpGR5k18hNBgu8/BsWQ9C+eHHAkbvAf2RTTL14IMEroBRYn8BxhAXc3vOuboPeCQrF8kqQa+s7lSHCdvXcE6vr46LxGhe5z64dfSZWxFavkexpvVtSg7UTXs061FuHbqJupqXlMt/PL7mk5bQJI9J5BY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A569B227A87; Tue, 13 Feb 2024 07:56:36 +0100 (CET)
Date: Tue, 13 Feb 2024 07:56:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, chandan.babu@oracle.com, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH 2/6] fs: Add FS_XFLAG_ATOMICWRITES flag
Message-ID: <20240213065636.GB23539@lst.de>
References: <20240124142645.9334-1-john.g.garry@oracle.com> <20240124142645.9334-3-john.g.garry@oracle.com> <20240202175701.GI6184@frogsfrogsfrogs> <28399201-e99f-4b03-b2c0-b66cc0d21ce6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28399201-e99f-4b03-b2c0-b66cc0d21ce6@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 05, 2024 at 12:58:30PM +0000, John Garry wrote:
> To me that sounds like "try to use DAX for IO, and, if not possible, fall 
> back on some other method" - is that reality of what that flag does?

Yes.  Of course for a fallback on XFS we need Darrick's swapext log
item.  Which would be good to have..


