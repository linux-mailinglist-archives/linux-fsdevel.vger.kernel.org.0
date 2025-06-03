Return-Path: <linux-fsdevel+bounces-50499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63A0ACC957
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69314171110
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB023A9AB;
	Tue,  3 Jun 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oHUIiHLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DC23816C;
	Tue,  3 Jun 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961502; cv=none; b=MUKM7tURU0+Xv6ZFP91sTXUQtAti7G2zQhXcc2A93sZ6CjLfjrjj3djp5cKyIUGeyUstKYUUNCl56i5H6bn3/jTv/+asxm0F9TSJLXZ5WT/qR9ercXS6XsBRqK+0TOwuFCLYh/bSN23RIiLz6hEYOH++nf7DN6IdaNOpFEPSb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961502; c=relaxed/simple;
	bh=gxfQNyX67WSiYsTJOKHuFWqT2IzQ3BqPYmGd9pAyp9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+fEMKAxE6F3n+dcwUtRg+QJFfN3jZakg7D2LZJH0T9vh9rTdfJ243St2C8BcFTHK1x9QIiWN3Z3P+nN2cthbAA6bhATlGSNTF7b1A7BePZ8MY/UjTtdbGwxmS2X6Z9R1WkiP1aEv3T5I/Dx3tJNb/DPZqHL45WZMRCJl/aCq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oHUIiHLy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lUqUZKHlbsRJsOcora1SHr3g81MSY2A6MrfjkdzuPAw=; b=oHUIiHLyCRZiLVFVKVurfDLBj9
	RtEMK/Ff1OfLAzpcYwe1wgiHJptcO7gi5/2hfojvTg/Am/WTVdsyQCBF9crdidw63Rbu7JFy9yMMR
	IEkCk+C2d3geZ3T4WsLg+48hJj4xEikJmUEl1P1qlhWyWETM0JxDTN272whDMjoWP5QjqkSmGe503
	CJ+Lm0oSJHvtFNvhy6QkkGvkXKXkDv9bO4pqGL7hGuDmD9HgvsM5k9IjtrYpQI/k2Gz2BY8Np2vT0
	JaI59TYQhZgwOvev6enc5MOwkQQd9TPBU9esoFeHJunHhi9ck+bIKvhNMK7dgyNmsCy0w7bI3zHGG
	jjypM8oA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMSmS-0000000BB18-2BpV;
	Tue, 03 Jun 2025 14:38:20 +0000
Date: Tue, 3 Jun 2025 07:38:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Christian Brauner <brauner@kernel.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aD8I3EdosyGPEksM@infradead.org>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <20250529042550.GB8328@frogsfrogsfrogs>
 <aD03ca6bpbbvUb5X@infradead.org>
 <20250603143523.GF8303@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603143523.GF8303@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 03, 2025 at 07:35:23AM -0700, Darrick J. Wong wrote:
> On Sun, Jun 01, 2025 at 10:32:33PM -0700, Christoph Hellwig wrote:
> > On Wed, May 28, 2025 at 09:25:50PM -0700, Darrick J. Wong wrote:
> > > Option C: report all those write errors (direct and buffered) to a
> > > daemon and let it figure out what it wants to do:
> > 
> > What value does the daemon add to the decision chain?
> 
> The decision chain itself is unchanged -- the events are added to a
> queue (if kmalloc doesn't fail) for later distribution to userspace...
> 
> > Some form of out of band error reporting is good and extremely useful,
> > but having it in the critical error handling path is not.
> 
> ...and the error handling path moves on without waiting to see what
> happens to the queued events.  Once the daemon picks up the event it
> can decide what to do with it, but that's totally asynchronous from the
> IO path.

Yes, I'm fully on board with that.  Maybe I just misinterpreted earlier
mails.


