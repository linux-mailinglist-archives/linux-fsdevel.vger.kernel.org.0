Return-Path: <linux-fsdevel+bounces-54944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1CEB058E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75CA97B71C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327702DEA84;
	Tue, 15 Jul 2025 11:30:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB42DE708;
	Tue, 15 Jul 2025 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579000; cv=none; b=jNfd/xMs5jeEcvGhzqic7scBO5wVACCsD+zeGOoHLpLKcSfeXS32cahOlZLe43FwDO98g/U3iGrKo0Q/RPpnJJTA+CwasJXYG9zfByEiwKtI/a7YWl3EXJ9yL1Rc1gU6J4eSFgc1EDZH+vjKKUYNiCJjIX+JwgJJBCreKIKP2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579000; c=relaxed/simple;
	bh=VXwmsqgSfWxVX5uChNhzzWPLyJcdsR25XqZonD2JA+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdbWQs3qdX8TrIvhDlldeOQSuOWIBTgSfWqxxu+PJi0V5gHxxw/7vIyZj5jGfKRSdhueltNZPgzgNPBcwI3UGybqaHI1MHKpfIZTx+ZFVwi8iqs5K3Jk4PNEeYrobM6bExjtKQ6lFQRWVX/Ul3dZWXWhwiaTr9uYw+Ks8am5Sq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CB097227AB3; Tue, 15 Jul 2025 13:29:52 +0200 (CEST)
Date: Tue, 15 Jul 2025 13:29:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715112952.GA23935@lst.de>
References: <20250714131713.GA8742@lst.de> <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com> <aHULEGt3d0niAz2e@infradead.org> <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com> <20250715060247.GC18349@lst.de> <20250715-rundreise-resignieren-34550a8d92e3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-rundreise-resignieren-34550a8d92e3@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 15, 2025 at 12:02:06PM +0200, Christian Brauner wrote:
> > I'm not sure a XFLAG is all that useful.  It's not really a per-file
> > persistent thing.  It's more of a mount option, or better persistent
> > mount-option attr like we did for autofsck.
> 
> If we were to make this a mount option it would be really really ugly.
> Either it is a filesystem specific mount option and then we have the
> problem that we're ending up with different mount option names
> per-filesystem.

Not that I'm arguing for a mount option (this should be sticky), but
we've had plenty of fs parsed mount options with common semantics.

> It feels like this is something that needs to be done on the block
> layer. IOW, maybe add generic block layer ioctls or a per-device sysfs
> entry that allows to turn atomic writes on or off. That information
> would then also potentially available to the filesystem to e.g.,
> generate an info message during mount that hardware atomics are used or
> aren't used. Because ultimately the block layer is where the decision
> needs to be made.

The block layer just passes things through.

