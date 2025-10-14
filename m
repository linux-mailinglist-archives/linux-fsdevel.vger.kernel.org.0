Return-Path: <linux-fsdevel+bounces-64076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1981BD7523
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630304224EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 04:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B25530CDBE;
	Tue, 14 Oct 2025 04:52:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9335530BB89;
	Tue, 14 Oct 2025 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417565; cv=none; b=CHEKS8u7HmIVmLsElex+PvZUUdwFDB81poyirFnRKEixJmQ0iMH7grzI1XnETcq1itDMAWfrmaueOpwVz+vDytpRbS1UFao/F2eEfJlC2BtXfjSvu1ozHYq5GU0jpPd1LuHGfQOnS01Iel4NiLD7IcK2tah8eTKz6/63tT6Lypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417565; c=relaxed/simple;
	bh=1Sa6+1YPcU+XRcR73T5IqK/4H93tZJ4/84XKW/+56PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCyX+nXTn73KeRDPCQine6j/FDVgOHd/jTbx083C8Sg1b25fBXyRDNClMTd6ooQNpih7sgmsYbSR7OoaFB6qJz6gVYyHNQaJ4iX8JN4QkckjNaixB/iZhb5FuT7Uayavw+0+2w/uIvDT52VJq9UMaVrUtDV5mEVoDhzndG3jPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B7E3227AA8; Tue, 14 Oct 2025 06:52:36 +0200 (CEST)
Date: Tue, 14 Oct 2025 06:52:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org, v9fs@lists.linux.dev,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 07/10] mm: remove __filemap_fdatawrite
Message-ID: <20251014045236.GC30978@lst.de>
References: <20251013025808.4111128-1-hch@lst.de> <20251013025808.4111128-8-hch@lst.de> <4e508d42-9cd4-481a-904f-535b1de0b765@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e508d42-9cd4-481a-904f-535b1de0b765@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 13, 2025 at 05:02:50PM +0900, Damien Le Moal wrote:
> >  int filemap_fdatawrite(struct address_space *mapping)
> >  {
> > -	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
> > +	return filemap_fdatawrite_range(mapping, 0, LONG_MAX);
> 
> This should be LLONG_MAX, no ?

Yes, fixed.


