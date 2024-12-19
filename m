Return-Path: <linux-fsdevel+bounces-37840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7769F8221
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12686188F4A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E1D1A7262;
	Thu, 19 Dec 2024 17:35:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F11A0BDB;
	Thu, 19 Dec 2024 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629725; cv=none; b=lzWF4/7tN/mrRbV8mCX47StlZRDjRt/5bGmOifoGBXdmUq7Niw+STtkpIWmYx/6MtqlTpxO20lj38gXRiconC4hQKf9h4an7/lCvTeMeuHM8cPCrbuXT9b8/oIt6unchvUHK6lCmKf1hrcenlyEfKj2zVfx9Y5K3jqy4K1ORugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629725; c=relaxed/simple;
	bh=V3Gx5QYqU/5xudT7qWHj3e9jYeB9XfwmKZYec84Ta24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plMIOUPdBqcxQI5ZJzqdOW3nV7jV3gz0o+eiIxkDG+oWAaBhmoaXwOW0E3cMaXK2MWtvvi5E6dWhIKk7xfVHKQ28Gb8hVzSBH/Jcxz6VgA/nQLMIZQ+/BM126/DNfaK+3hhkMGOAGUNJIl5TCBOh855GCnNRzq9BLgmHw4yasuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F34468AA6; Thu, 19 Dec 2024 18:35:13 +0100 (CET)
Date: Thu, 19 Dec 2024 18:35:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/8] iomap: add a IOMAP_F_ZONE_APPEND flag
Message-ID: <20241219173512.GA30295@lst.de>
References: <20241211085420.1380396-1-hch@lst.de> <20241211085420.1380396-4-hch@lst.de> <20241212180547.GG6678@frogsfrogsfrogs> <20241216045554.GA16580@lst.de> <20241219173030.GJ6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219173030.GJ6174@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 19, 2024 at 09:30:30AM -0800, Darrick J. Wong wrote:
> The iomap documentation has been helpful for the people working on
> porting existing filesystems to iomap, because it provides a story for
> "if you want to implement file operation X, this is how you'd do that in
> iomap".  Seeing as we're coming up on -rc4 now, do you want to just send
> your iomap patches and I'll go deal with the docs?

I've actually writtem (or rahter copy and pasted) the documentation
already, that's what made me notice how duplicative it is.  But let
me shoot out what I currently have.


