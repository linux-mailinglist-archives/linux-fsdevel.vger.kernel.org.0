Return-Path: <linux-fsdevel+bounces-47895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22988AA6B1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 08:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FEC9865B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCDC267386;
	Fri,  2 May 2025 06:57:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFA53365;
	Fri,  2 May 2025 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169055; cv=none; b=WbGh+zqLmB9xbg6BN8ZTINN2ruVBo1C3AL3oH46aMHW8AI0+LpbNMT5fMfvfPuYXguWjbQT63lV1qEFHHb+zBSBJuWJKh1nUDON8BbWnGS9O8gBxkNDaZnR1Vqg4hM04KvnoJV7Lvol9jNov//xIGwVYEzRMlHuDob8xAwuGw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169055; c=relaxed/simple;
	bh=j0dTsoPuCsvRqpki8IrW3Ym4N1oGu4wOG1OC7leJq9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcY8FyP2Ya1+Rczr5AM/Mi1O2v6OCCB/rJ5EGURWAfxi6b7AK8LXMaV6Yg3FVjsJyJC2qjmU2A9D1MSlntfShBVnsm3fW8JPN/RpoBp9Zu85WLosEXrDrMgtgbYYlsn2R+39q8O8UdowmrAc5vOpz16O65kC4VGNikicRr9rpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65E1C68D0F; Fri,  2 May 2025 08:57:26 +0200 (CEST)
Date: Fri, 2 May 2025 08:57:26 +0200
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
Subject: Re: [PATCH 16/15] xfs: only call xfs_setsize_buftarg once per
 buffer target
Message-ID: <20250502065726.GA8309@lst.de>
References: <20250501165733.1025207-1-john.g.garry@oracle.com> <20250501195208.GF25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501195208.GF25675@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 01, 2025 at 12:52:08PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> It's silly to call xfs_setsize_buftarg from xfs_alloc_buftarg with the
> block device LBA size because we don't need to ask the block layer to
> validate a geometry number that it provided us.  Instead, set the
> preliminary bt_meta_sector* fields to the LBA size in preparation for
> reading the primary super.
> 
> It's ok to lose the sync_blockdev call at buftarg creation time for the
> external log and rt devices because we don't read from them until after
> calling xfs_setup_devices.  We do need an explicit sync for the data
> device because we read the primary super before calling
> xfs_setup_devices.

Should we just it for all of them in open_devices now that the sync
is decoupled from setting the block size?

Otherwise this looks good, but I guess this should go before the atomic
writes series in the end?


