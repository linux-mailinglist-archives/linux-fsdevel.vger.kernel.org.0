Return-Path: <linux-fsdevel+bounces-66753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F209C2B8E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2819D4FC172
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557DF306B08;
	Mon,  3 Nov 2025 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jf6f0ujK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518130146E;
	Mon,  3 Nov 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170686; cv=none; b=Vn1/WZs5dD3h0HD1F6+19gBPd09abyfkd2JryMJxaEFPau9/kOZxAXmEbMa8hIajNEG1y2gGLVV3/RgswBFMj5Ghq8bXq269Sl/ghotAuTVCFFcCLrgtSNItamgS3owk4GKF/yzJyOPGOYIOuLybglo02Buu9dM1ff4KF6ig/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170686; c=relaxed/simple;
	bh=3tyVsLEIR4r1SBV1e2i4siuFU/ItVWC5DBWZhbMuzS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSFSizXfHYp65bfZwfaFMAlvT4JShU5sWf35baZAVjC8NalM2s8GOGjVnypL7kV2A6YemimDBUmj71kSUHVmTrj5HzpORWMUZ+ZfOO6I4ODu0uyBjmVtgCYUqR3eLjEp2nyeNM7rXhl3HgK7KOPDI09Xo8TCnJBcb7SuXXom33g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jf6f0ujK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yidiP6bP2jLsvm3Tq4yAOymX+6IqlDsOxVtZqmcSlQk=; b=Jf6f0ujKavENpebtEDRT379y6z
	qnAZuBWqC53lJejm+Rj/eysO0mrnUmx3XF7tApEyvuGV/tP190onNdRjwoOgVLr8jOLMoldmvU6zJ
	B8gqvanLvX1hn96I0v5UDEjH71wgL/7z/awsAxdYfyC68OBu5FIpFOSdqYddHfco2DPV7lb4c+j0x
	5LpmwG8Z4A0ntbAGuyGxJVvL0u4qudq0hc/SIATiYDg4X2FIVgWPBQRXq81Cargy22c2znRUV8qTC
	SDyFddfI74XuvP6jNsc/WkGTdGITv0c7NTVnOWxH06lC4jZxPGfdWbNGV7YZ289JeGOHhZejCYHtt
	PGfVUNtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFt5l-00000009miI-3TQc;
	Mon, 03 Nov 2025 11:51:21 +0000
Date: Mon, 3 Nov 2025 03:51:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH RFC 1/2] fs: do not pass a parameter for
 sync_inodes_one_sb()
Message-ID: <aQiXObERFgW3aVcE@infradead.org>
References: <cover.1762142636.git.wqu@suse.com>
 <8079af1c4798cb36887022a8c51547a727c353cf.1762142636.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8079af1c4798cb36887022a8c51547a727c353cf.1762142636.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 03, 2025 at 02:37:28PM +1030, Qu Wenruo wrote:
> The function sync_inodes_one_sb() will always wait for the writeback,
> and ignore the optional parameter.

Indeed.

> Explicitly pass NULL as parameter for the call sites inside
> do_sync_work().

Note that this also kinda defeats having the two passes.

Te non-blocking sync seems to have gone away in:

b3de653105180b57af90ef2f5b8441f085f4ff56
Author: Jan Kara <jack@suse.cz>
Date:   Tue Jul 3 16:45:30 2012 +0200

    vfs: Reorder operations during sys_sync

(the argument was later briefly used for something else and that
then got reverted)


