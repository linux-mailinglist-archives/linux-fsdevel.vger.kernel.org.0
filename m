Return-Path: <linux-fsdevel+bounces-31148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48121992513
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 08:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F07C2817B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 06:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987A3165F08;
	Mon,  7 Oct 2024 06:46:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A2115B130;
	Mon,  7 Oct 2024 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283616; cv=none; b=eozA1KkZyzgOf5tDOqwnPpTfCBzbZfyj9qPDBcsxqrnB/hKeiBBWNvfoxegbslNoXv2h7YLT0oGK9MP8rde70WkS0oVxqvDE9KP4BNCqQZJ0zETzo95yjF2cRg0pp418aQjdUFHRdfG4LXzX/EcGuJY+ub/pH+kdk7ixjEGHJvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283616; c=relaxed/simple;
	bh=jj2pSTv5JXWP9SanIcaG3tEISQXWkliCyyRZwFkELYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqn/mCkinXEC34z0Ygqu/bml4H8V4dumwVCfN2oWYLMCNG3ywuusyZ+CSRqqbTxZsLV4i00YnJ9h2quk2fQKD97fmRTDSXZORkzzfW0s3COe8EOetVVcc/HeszyPuc96P0oZof0RhW7V7G/Xs1ht/+xwUEj8Cn9Go+IXwQUtuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1036227A8E; Mon,  7 Oct 2024 08:46:50 +0200 (CEST)
Date: Mon, 7 Oct 2024 08:46:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: fix stale delalloc punching for COW I/O v4
Message-ID: <20241007064650.GA1205@lst.de>
References: <20240924074115.1797231-1-hch@lst.de> <20241005155312.GM21853@frogsfrogsfrogs> <20241007054101.GA32670@lst.de> <20241007062841.GP21877@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007062841.GP21877@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Oct 06, 2024 at 11:28:41PM -0700, Darrick J. Wong wrote:
> On Mon, Oct 07, 2024 at 07:41:01AM +0200, Christoph Hellwig wrote:
> > On Sat, Oct 05, 2024 at 08:53:12AM -0700, Darrick J. Wong wrote:
> > > Hmmm so I tried applying this series, but now I get this splat:
> > > 
> > > [  217.170122] run fstests xfs/574 at 2024-10-04 16:36:30
> > 
> > I don't.  What xfstests tree is this with?
> 
> Hum.  My latest djwong-wtf xfstests tree.  You might have to have the
> new funshare patch I sent for fsstress, though iirc that's already in my
> -wtf branch.

No recent fsstress.c changes in your tree, but then again the last
update is from Oct 1st, so you might have just not pushed it out.


