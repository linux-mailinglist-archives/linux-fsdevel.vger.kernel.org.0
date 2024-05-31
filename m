Return-Path: <linux-fsdevel+bounces-20613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0718D61B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB49B2823BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 12:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8CB1586D0;
	Fri, 31 May 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vBCRKEsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9271581F5;
	Fri, 31 May 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158408; cv=none; b=Cr0hP6LblxC0VZqifwL08oBfwBdlcMNwimCDM5iz9FmnSuCLU0de232vyDrg56Gc2jk/OzEI0q4x1ABAHpR0pb5MCRbsD3zZGX4/kk8pwv2TDI6jCzgBzVq3n0aqBkfOFpr+yuhAt/VTiHy96G/bWQzxVCE5g6TooKv9u2JxFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158408; c=relaxed/simple;
	bh=tyjiJhJUky+P95f/gBMZegAOq44q9U06Rmp8c34+qxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTDNjAZiUdrqRTM6+5n0+BPe988BDTeqCKvTHw0ko4f5olYYZkaH7cPVYvR+J0VcHIRvIpMVU2MJBXLS/5I9odrnqCjRelj7SpyQBtK9A+KC9K5oD9etM0R0WWl2wmHF4e4uWaKGrs8Ou4CPIcp+/IWWZ4+WKcP850Q0BoKA/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vBCRKEsd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ya0JKaaN/iqn+GC8hMfSZ/1c+tmy47dUnxaIMYg9sxE=; b=vBCRKEsd4jIRlt9sE5TtUB94xC
	EWnNrKH7Kej4zEeq1Aeex2t1LFk6yqgwXPCfV4axCY8NaMugJlioi2Q3Vlmv7YS+S+H9OaPDlKW7y
	YKoK6LpAmvdwAqA1YroY6vYlrpGf37yB1fruVBrckHLj+DZlBdJxX/X5wcgGczK0AqBDz5XMvB37s
	gf/wQ8xRIFPJelgti81P4TC+Sh3wn95nwmmTUwvy+mOsCrz7P1uZIgQNxOEfA8jxLdUxRtnX7y8me
	Fqkyyybz3FBACwGlYRyv5QF5szIvVBLiLGtx++5gxFBIuISkNdUsR/+9rwSoduQ4NPkLf9mdMZ/5U
	JAvT1jGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD1LG-0000000ABnv-3ddw;
	Fri, 31 May 2024 12:26:42 +0000
Date: Fri, 31 May 2024 05:26:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 0/8] iomap/xfs: fix stale data exposure when
 truncating realtime inodes
Message-ID: <ZlnCAo0aM8tP__hc@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Procedural question before I get into the actual review:  given we
are close to -rc3 and there is no user of the iomap change yet,
should we revert that for 6.10 and instead try again in 6.11 when
the XFS bits are sorted out?


