Return-Path: <linux-fsdevel+bounces-41632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69D0A33852
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 07:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23AB97A1790
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231C7207E15;
	Thu, 13 Feb 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GciYl71R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC5207A3E;
	Thu, 13 Feb 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429714; cv=none; b=l2F43VqxsjvJzfFQLlBIDYdmV2LOL9BlvJZt7/Waqsqggp4/YRtJezckEuep+rek8hUWrxMh9GaH8sv16byT1xW7y797bxhoYZ4M4rdYq8WrqQUczVC5Zin6q+yE/Vs1VN1MCj867MW6HamJ/T0ouUCrLIz5mqxBRCSg4w/chFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429714; c=relaxed/simple;
	bh=lnm6bkOZ0sGG3ibhnfqop2q8t1g7hOlliiQqEM9lmyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inL91hCiaQVgdQb33vTdxB/yz3lfhjLxT6JSB610O46h6bQRyc4p8TzV+bEtiZdpns8RMmTTvYuk6/3ckGAT+KVnbIzOM5jcr1Tia7c9gzv7omXr5Qy74Wa+53Vsm/PPorOp5lEvQZE5G9vjPe7sbhPCARXjY8K+hcKMWaCkJoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GciYl71R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lnm6bkOZ0sGG3ibhnfqop2q8t1g7hOlliiQqEM9lmyc=; b=GciYl71Riv1mO1mF4VbM0Eqdip
	lBdqFtsTPvXtLOPB/jKsA2/t1qeEsQ4Vdv/d17c11Nuq3vnPRNguVOAlYiFrgZ5hTKBwGO8kLP2wu
	TqL6b67CXYeiLqOY+oAiQqG76cJzBEBLQEx7zja8df0HQE35r4faQH7V9o5Ec3OXQTHeSy3NpFG8E
	vk7pe0MrdEHloLUnG17gknrMtpww3BMriH5LaWY0nmcDb7FVQU/LZJlKopR2W7njfTr/SyiAMfPTM
	sHuEx5vEY1JvgrRHpKQDyIWPGdymC1GILyepYkc2Ujx2+eF4YFt+fW+sTyKIv8AvJk0LcIR5SLfVu
	+OGP/P/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT7w-0000000A18J-34uI;
	Thu, 13 Feb 2025 06:55:12 +0000
Date: Wed, 12 Feb 2025 22:55:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 04/10] dax: advance the iomap_iter in the read/write path
Message-ID: <Z62XUFHMtNkXJpDi@infradead.org>
References: <20250212135712.506987-1-bfoster@redhat.com>
 <20250212135712.506987-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212135712.506987-5-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 12, 2025 at 08:57:06AM -0500, Brian Foster wrote:
> DAX reads and writes flow through dax_iomap_iter(), which has one or
> more subtleties in terms of how it processes a range vs. what is
> specified in the iomap_iter. To keep things simple and remove the
> dependency on iomap_iter() advances, convert a positive return from
> dax_iomap_iter() to the new advance and status return semantics. The
> advance can be pushed further down in future patches.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(and looking forward to the future patches..)


