Return-Path: <linux-fsdevel+bounces-66755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A51BC2B917
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A57188CA4D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E13308F1B;
	Mon,  3 Nov 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JMMjzDoU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46E26ACC;
	Mon,  3 Nov 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171487; cv=none; b=l/zr6m3btVrxzPTA0OHnFsDD04U8YMcOhdOX315yGn+ZCmbFINhdnB1Cmq8zuTvjJ5f8/uVK6fPPD0bdjuk5TPKpnN4HLLD3aaPxmQY1HfNGFeU1tEfNzj2WaUKKleZ+VB+SP14DLB4FVW7GAe+7peWLeSP4/R9HVanLLzWAjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171487; c=relaxed/simple;
	bh=ND/wtn8aGkqyLhe4PNEJvDjR1b00kCrak+SkTQ2XYlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxSjL3ToBp/MU+SMFd5NIO6+VRJT4awRVPhw7pkigmUMTKhA7rehpq0JbajZUW5biglwMuO8x9dvS/NR4SoUyLFAwrF4DJh4k7r6GJ8Ou5ILBa454VqOuhmlnElpqaGxlRb9PAMAcQPpV+10dbx9xDUANQ9/sY6fESDRisMntL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JMMjzDoU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2buAJuo0aGFui/ktuvPK4Zx85isxHIAjKpaMWKyQH1g=; b=JMMjzDoURoDcFdBRO5lRJPvic5
	2H/rVvXmHUr0EfVPG/68YDR6Z+fi+U+mk1s0qMs2KEsOntN4q9JSJf2CTQjSExTovxOByUbuhwLzX
	fOpA/+pFp7j5D2bAy5V+J+jMJl7wlN56/w7YBecCNMDGBaaHgolyeEAk3oSD5EmWO12Ww3dUoVTiY
	1pNV7ofRcHAdGtcUrBCIRrqZMbTl9cQoqmtqIwce2doz1i9Qi9rnQPqgriddRtTfnkJ0qNNjdaoTk
	aEE2zJrNf71kTNOkqfUsWxXlUDtNGYoeQPk4yFic9Ycnql98ZxirBCGLW9NRQq2P4mv7CFcnyJ4dw
	hh0EPT5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFtIj-00000009nhS-0E4l;
	Mon, 03 Nov 2025 12:04:45 +0000
Date: Mon, 3 Nov 2025 04:04:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	Askar Safin <safinaskar@gmail.com>
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
Message-ID: <aQiaXVkz1QYkMsWA@infradead.org>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
 <aQiYZqX5aGn-FW56@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiYZqX5aGn-FW56@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Forgot to add, but I think the main issue here is that btrfs clears the
writeback flag on the folio before commiting the metadata for the
writeback.  I tried to fix this a few years ago, and IIRC Josef tried
again a few month ago.  If that is fixed, even a non-blocking writeback
will commit all the updates it actually kicked off, just like for other
file systems. (It will also sort out all kinds of annoying locking
issues)


