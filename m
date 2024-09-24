Return-Path: <linux-fsdevel+bounces-29929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA629983C77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA21F1C22615
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 05:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1BF49638;
	Tue, 24 Sep 2024 05:45:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F633CFC;
	Tue, 24 Sep 2024 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156759; cv=none; b=SuH9eXNtEIKil0TgOkZcGRR8ZUgRkk6KRMwbgvbeJ4mAax+Nigk44Ec1z/J/0BSaeCTdP5oiPugOKDtUlL4FHNQIq2RHkCGr0JZuFIX6D1HzrEFwoRlCelUfJj8X8kUw4QXQIiGjBA+6WnvOpBv0JQNEk39q8T2y30XN9NFyC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156759; c=relaxed/simple;
	bh=roGrlwzOsk+7jXjgt3d/e5vWQ29l2rdQsbReOTXw38k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvVe5c7cpmktJiOoNAbGKLu9zi6ZKTqWWp7IOOXmBzbaQWBxLD+jXO4eCw7FzT3XZtYVBEzdU616U/OkF/yuE3cSSPjMDfXo8FrI2GNdygsxfJBqzk4etPxJtFTbk4HozjLUaueyYjjiGr4cpG9w0tSBNjEjKCNLuDhMNgeIn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BBF7227A8E; Tue, 24 Sep 2024 07:45:54 +0200 (CEST)
Date: Tue, 24 Sep 2024 07:45:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] iomap: factor out a iomap_last_written_block
 helper
Message-ID: <20240924054553.GB10630@lst.de>
References: <20240923152904.1747117-1-hch@lst.de> <20240923152904.1747117-2-hch@lst.de> <20240923155319.GC21877@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923155319.GC21877@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 23, 2024 at 08:53:19AM -0700, Darrick J. Wong wrote:
> > +/*
> > + * Return the file offset for the first unused block after a short write.
> 
> the first *unchanged* block after a short write?
> 
> > + *
> > + * If nothing was written, round offset down to point at the first block in
> 
> Might as well make explicit which variable we're operating on:
> "...round @pos down..."

I've updated this for the next version, thanks.


