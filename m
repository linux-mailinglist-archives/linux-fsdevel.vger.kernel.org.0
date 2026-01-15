Return-Path: <linux-fsdevel+bounces-73880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B51DBD228A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24BFC30116E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 06:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B18922CBD9;
	Thu, 15 Jan 2026 06:21:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB3381C4;
	Thu, 15 Jan 2026 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768458105; cv=none; b=eos9IUdAU/Bqxo8p01/2n1Kj3btG9eTiHSodCi5vU0zrh7+LueBqWrqB+KrA68Gt3hWgnf4bs0T39Gjc6Vsu7ulj/TnXxK1ykcJiSqzeSr0yWlIa8e1HhEQcmAPS++kwTskcd1RHvVNhKP3Qk8vlgImCfbPsZekCjoASm2jaJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768458105; c=relaxed/simple;
	bh=KTiGjZlSpROeZV7B/FIl5j0QptY4FX5kdz667cMGzrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMXLY4uCrRQC59Bo7f60NsLnlS4zRp+EGDwvWD4m8D+XkfqBVYcZqQ/+8L8LzPfYVAu+WWeF78d/PRbgmaMI3t8HVu73KBar8uaRXldNRn9iPvFYexyWm7vcAl3QrJzHuLmvZ+zQcm+1ZakqqpdwnTKfk16map/gxs1htoA6DSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1146227AA8; Thu, 15 Jan 2026 07:21:41 +0100 (CET)
Date: Thu, 15 Jan 2026 07:21:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/14] iomap: support ioends for direct reads
Message-ID: <20260115062141.GG9205@lst.de>
References: <20260114074145.3396036-1-hch@lst.de> <20260114074145.3396036-13-hch@lst.de> <20260114225756.GQ15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114225756.GQ15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 14, 2026 at 02:57:56PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 14, 2026 at 08:41:10AM +0100, Christoph Hellwig wrote:
> > Support using the ioend structure to defer I/O completion for
> > direcvt reads in addition to writes.  This requires a check for the
> 
>   direct
> 
> > operation to not merge reads and writes in iomap_ioend_can_merge.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> ...and I think this patchset wires up the first place the iomap ioend
> code actually gets used for completions, right?

Yes.


