Return-Path: <linux-fsdevel+bounces-74423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F2FD3A310
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA89B3051597
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BCD3559F7;
	Mon, 19 Jan 2026 09:28:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996BF3557F1;
	Mon, 19 Jan 2026 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814877; cv=none; b=jGNStHk1AVsbnRwp9QgdtjWse2sbVRyXVB/M/jUNk5+qTRQ9/7KCXYmQPpZRDiOfH6JMf2r0eFTecgjqtMElSUeaDPNRJL9pLBSl1nSfx188AMCpVMyVcz+WjPh6cLdkYPw0edoWj6VkZHpzkI6/8JPCRpTJFfN6qdnSnjHzOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814877; c=relaxed/simple;
	bh=sh0TkxkEOKhDl2DVrl4mw+NTqDA2lqqTM0EYMUUo+sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6yHX+/hpE85f9zDPh6xl54DfAe/+X+51SC2lne4Qh/0kwekd2Dyn0AOoxYjWfK9zXWCQnnNA0dRiOyiOwuJ62YlArqBezKT1flk4z5yg75uJ6VUxHoiOnk2AjZB2035goxOMsIHTEwRBAPi8fFI8kJhTmd318a5iXVA4nXWgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7696C227A88; Mon, 19 Jan 2026 10:27:49 +0100 (CET)
Date: Mon, 19 Jan 2026 10:27:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 4/6] fsverity: use a hashtable to find the fsverity_info
Message-ID: <20260119092748.GA10125@lst.de>
References: <20260119062250.3998674-1-hch@lst.de> <20260119062250.3998674-5-hch@lst.de> <z4652hoxetll645hgpfuhy3pogm5y32ealgydlaz4kwve6qc2g@bl6ilzut2ybp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z4652hoxetll645hgpfuhy3pogm5y32ealgydlaz4kwve6qc2g@bl6ilzut2ybp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 19, 2026 at 10:21:00AM +0100, Jan Kara wrote:
> OK, but since __fsverity_get_info() is just rhashtable_lookup_fast() what
> prevents the CPU from reordering the hash table reads before the S_VERITY
> check? I think you need a barrier in fsverity_get_info() to enforce the
> proper ordering. The matching ordering during setting of S_VERITY is
> implied by cmpxchg used to manipulate i_flags so that part should be fine.

Yes, probably.


