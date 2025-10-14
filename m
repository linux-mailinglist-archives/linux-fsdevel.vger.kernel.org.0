Return-Path: <linux-fsdevel+bounces-64079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A0BBD757D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD8184F15F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 04:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25230DD07;
	Tue, 14 Oct 2025 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2B3clVq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51DE30CD8D;
	Tue, 14 Oct 2025 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417907; cv=none; b=H+I5ZRGvmoGQV64DPe6IyPha5V5gwz9gNiV4tvjue0783DNO5cAA17lhfxuifjP5IW3+fm886glenBaYxXzWnWtWMfY9QsN3uvQ5EWFK8Zam4B6aVu5EQCSOB+sraeLtfpFzz+1tc80y34W5RLmTO/HgfzM7zL33v1ta0i3Plq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417907; c=relaxed/simple;
	bh=gnCgZboH965UBl1pgYvt2cfC/c8DDjxZu7ePWJxZvrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0ZnFvldvz260vkayb+zR7RTurH7yJieLhm19M4TfWIRdaMAeyeZQyh6cPdckbuV5Bto+UWSCxl5EKCg25tqe42Oqu9HtH5BLE9mi7kNeeYH4Vz7vyJ+KqAbouQBS6l+j/GPapan+1kcSwOnxRvbxCx2ejIKHHSw1+o9+zN8O4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2B3clVq3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qYhG1tt+ebDKd9YrwwL/1D/WWmYClWQN9/msHoJlTjI=; b=2B3clVq3quCwnzD6BvVlcXulFf
	ZpD+XoKhclW/3dMav2ZWGH6pwDL1QffyFx9pyPrLOVoJndLnN1fjJ/lsONzsY6RTnJSqTW1In1Tyu
	/hoSoqCFOZYp7QrCwhj89qjs9gF3ALEva3GteGXK2C7e4/AEvjzfLBOdGVs+/tPBEN6oP0B0o9xmT
	kya6aTrSh28/ghiP1bzJ5xLCwreXdOF2XncirsWpaMUc/odvbeWq2L/zTMTtSKrk53XAG5rVZAjlJ
	AcJ3QiSmIk97Pol4FXeGSIX8PvqYXUL1SRG4nvLcsRwaYYaFPNo5TgPBE5rcyg+7o34GjuIj4M0Cx
	TVcq58kQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8X7B-0000000FAD4-22pM;
	Tue, 14 Oct 2025 04:58:25 +0000
Date: Mon, 13 Oct 2025 21:58:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
	brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Message-ID: <aO3YcT9s8ezmIkzv@infradead.org>
References: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
 <aO3TYhXo1LDxsd5_@infradead.org>
 <5a9e8670-c892-4b94-84a3-099096810678@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9e8670-c892-4b94-84a3-099096810678@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 14, 2025 at 03:25:31PM +1030, Qu Wenruo wrote:
> Unfortunately that may not be that easy. Either we merge it early, meaning
> just this change + using the new flag in btrfs.
> But that means it makes no real change at all, as bs > ps direct IO is still
> disabled.
> 
> Or we wait for the btrfs sub-block checksum handling patchset merged, then
> with the full bs > ps direct IO enablement.
> But that also means we're waiting for some other btrfs patches.
> There are already too many btrfs bs > ps patches pending now.

What's your plan for merging this?  I was going to look into doing a
patch like this to improve the zoned XFS direct I/O handling soon,
so if you aim for 6.19 we need to figure out a way to get it into
the iomap tree and merge that into the xfs and btrfs trees.  If you're
not aiming for 6.19 we could merge the iomap and xfs work through
either the iomap or xfs trees.


