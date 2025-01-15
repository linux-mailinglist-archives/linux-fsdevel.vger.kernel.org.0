Return-Path: <linux-fsdevel+bounces-39230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E39A11933
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 06:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C286188AE01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 05:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9222FDFC;
	Wed, 15 Jan 2025 05:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EU2A7v85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEC322FDF2;
	Wed, 15 Jan 2025 05:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919973; cv=none; b=eo7nGg1WLmd3O2nxRnUcYtZOzNGQq01HPGloncH3UJyS9jk27S3W2inslWMN6TqF9HBaT3gornX/HW/pev/HFzE4ERps4jrFXejuyVW/VwX5qQ3ccN1Nxve8cWTLTiuhbVN2fs4ylf5LHczYejrXcrY3bjCG6vXt5OPxeK2lWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919973; c=relaxed/simple;
	bh=jbBH4DmzYSc6OQ5oIp+YMeTy1wF+GI4uIsNKJmlFGdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpxm0gvUqFbOLWvaOjpznzae47G0geFWnHQbB9WrQsvEa0tyU5Kmw85Khm1TVZt2mbt4qYJ6luDDLbbnf6C1xKH0/dkdFgfLmJZ+RY9kU5Netqc/nJmeatp9tbkc9d47m4Tx+gRAr/Y+mpbXS9o6KW4F+dzhPCowzNG4eb3FOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EU2A7v85; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jbBH4DmzYSc6OQ5oIp+YMeTy1wF+GI4uIsNKJmlFGdc=; b=EU2A7v85oYKDcGva+bxtnwSLmE
	TX7ubmtj7DBSW2Ix2TchYFRvOc3M6ZGX1CKhcetMnaTurZg9DiwgZM2Y6ZSxw9IU1HwhJzagCBuA+
	G/7nWCiOs2idW+eS0UF02+/vlN/21z/pBnk4YCb/mtUAn8ZeUehVVEWxRPKGJ8EgyprNYc1DVTBNb
	IH+EZn7pF9XaRlgVxUVxuu470UDsuHkMybKVf1DsvZR/yRZBNMfjwkxL0zcDHn7wNudDfSKMu0yfl
	z1tEZ77NC+Af/SVoQT6JXyBl7/Nu0uW5aWY0XKiBw7eUZr18+y08E/JXdqni86zBO7rjyZH2LEKOy
	6g9lZWZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwEF-0000000AiVX-2DFt;
	Wed, 15 Jan 2025 05:46:11 +0000
Date: Tue, 14 Jan 2025 21:46:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/6] iomap: advance the iter directly on buffered writes
Message-ID: <Z4dLo9fW5QRJF3yL@infradead.org>
References: <20241213143610.1002526-1-bfoster@redhat.com>
 <20241213143610.1002526-5-bfoster@redhat.com>
 <Z392eER1_ceFfMJe@infradead.org>
 <Z4FeE4F4Hp_PznnV@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4FeE4F4Hp_PznnV@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 10, 2025 at 12:51:15PM -0500, Brian Foster wrote:
> This might be a little more clear after the (non-squashed) fbatch
> patches which move where pos is sampled (to handle that it can change at
> that point) and drop some of the pos function params, but if we still
> want to clean that up at the end I'd rather do it as a standalone patch
> at that point.

Yeah, that sounds reasonable.


