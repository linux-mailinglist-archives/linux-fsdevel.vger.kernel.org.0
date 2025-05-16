Return-Path: <linux-fsdevel+bounces-49214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8B0AB966B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 09:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12DF1BC33A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 07:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FAF226161;
	Fri, 16 May 2025 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QLot+Vx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3422576A
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747379665; cv=none; b=oXs5vm4tkogs/e/coI04oRpI8YmikFMCA6JmB9BYfsOGq6SgK78ksDAZV4As0ILoGOIjYPSkTLGCPnQ8Sm8+9YhyaE4Iv4bqZ0M/rwhXFgMkDKeD6jHenUKQD4QdCQqGMWS6Pz/VnElDUjMyWgiyrmOUKmE92Op2tAjCSn5Kc3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747379665; c=relaxed/simple;
	bh=fpu8njeWzfmxWwtkc4e5dE5qO+aSCAu2WwIBDG2xnu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+YOl+FbQq6W1KRcU1pHmF8ZB9yjUZ8R5VlmyjD+KQifK2n9qoSaeiGeuMjUulNIzlx7txxB23vTHWU2oilzDucNogPWd4SmMtHDOBEG5jmYfhWFwsGwgcHvFR9bBCtnXXE9HbVvIihwsK8pNysGzPA739o9TQYEj+Ki4VBczqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QLot+Vx2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fpu8njeWzfmxWwtkc4e5dE5qO+aSCAu2WwIBDG2xnu8=; b=QLot+Vx24V/qyXkcAwx6BtJ+Js
	EpamjYca5evh4DWE5FCby/IKeu5zylp8p41zqw0X4eyPO/UJ8c4KUvDk99AC5pxt7cl+cfThX7r+a
	F4j7inkr1eYrtOPpzqqI7CEfC9bFLcvbQeLZRbF79XmnY7Zr3aojQHdRL+6sM+MTuHH0vWC+mX1aq
	sh6mb3iiB9yuzF3S4k1Y0hnDhiojRikrsw+kKHTEkKSza19hA+rfWqHvr5+5VEj0t5Vo6hlDy8ozp
	qm1ufemAp+Rsgyt+pXVH+6ftQyb3UhyNdYKfyrf+S5qmMVKXLid2sxOz5FZZglipK1ZYgukCmxWsW
	p6JWh5Vg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFpGv-00000002drn-2dV0;
	Fri, 16 May 2025 07:14:21 +0000
Date: Fri, 16 May 2025 00:14:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: support mtd:<name> syntax for block devices
Message-ID: <aCblzTuIJzBUYepM@infradead.org>
References: <20250516065321.2697563-1-joakim.tjernlund@infinera.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516065321.2697563-1-joakim.tjernlund@infinera.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 16, 2025 at 08:51:56AM +0200, Joakim Tjernlund wrote:
> This is the same name scheme JFFS2 and UBI uses.

Great to know, but compltely fails to explain what you are doing
here given that this is a block device mount helper used by file
systems using block and not mtd devices and thus the only obvious
effect would be to crash the mount if actually used.


