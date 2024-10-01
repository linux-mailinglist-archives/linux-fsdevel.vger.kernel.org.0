Return-Path: <linux-fsdevel+bounces-30444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733B298B744
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032EFB24A20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013D219D084;
	Tue,  1 Oct 2024 08:41:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00019CD1D;
	Tue,  1 Oct 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772069; cv=none; b=hjS13x/sk7u471jI7W0h/PfmMEIs/y6cyz2n0SAOWgjGwAHBpefm+EvlaTGha8Sev5Kuht1vx3RL1FM4an+Z/JVC3KuR431CEo7hRs8WdRSPl9RARwBanC2OVrKe8D9OqWJq2I+T6dmqts/o+O1KpVfZ+fYFaubTBlVqffA50lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772069; c=relaxed/simple;
	bh=Tl5D1BWZJfkmZM5z8Nnhir01xKOZ3z8ohE2QLtuzAuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlqAiwMaS8mb2oP6BEZoxrQ3vplbEpAFeCe8P09M0s2PielsD97u8sjs6hXSWK6iGJ3gagutxytlqM3obidr482QLLwl1jqQ2u1Ppu/E9ooCkmGG17Gw3SVdvxoEeZIqaVLUdas676y39vFRQJUhTO7ae6VsGqA7mj78dBw1Apk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83511227AAE; Tue,  1 Oct 2024 10:41:02 +0200 (CEST)
Date: Tue, 1 Oct 2024 10:41:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v6 4/7] xfs: Support FS_XFLAG_ATOMICWRITES
Message-ID: <20241001084102.GB20648@lst.de>
References: <20240930125438.2501050-1-john.g.garry@oracle.com> <20240930125438.2501050-5-john.g.garry@oracle.com> <20240930160349.GN21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930160349.GN21853@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 30, 2024 at 09:03:49AM -0700, Darrick J. Wong wrote:
> If we're only allowing atomic writes that are 1 fsblock or less, then
> copy on write will work correctly because CoWs are always done with
> fsblock granularity.  The ioend remap is also committed atomically.
> 
> IOWs, it's forcealign that isn't compatible with reflink and you can
> drop this incompatibility.

That was my thought as well when reading through this patch.


