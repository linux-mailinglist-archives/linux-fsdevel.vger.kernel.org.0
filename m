Return-Path: <linux-fsdevel+bounces-57308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CCDB205DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8D83A129F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB44239096;
	Mon, 11 Aug 2025 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffqmA0fB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37FC2264C7;
	Mon, 11 Aug 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908910; cv=none; b=Mq0kPAImWhNJsJ1mZKSi572mT29Ux0l59Z1YT3/eu3itu2UBki6zk5e2HU9R6sgWu+CBQ3IZWKOFwJ2VW+rpk7JF/80ZRdOrQ//8rahr+2E08mRakQhF2uYKCWlgmpn7OsQqnjLdDOSdrlPIEQ6/NNoZT+uwkZNJrZkN2abzzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908910; c=relaxed/simple;
	bh=ogNDkN0Kti67wyjDkFkj3V/1dOo2vGXEtQDlghmP1JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8lkGvatNAEQrSHwhW4+xUA9sid46O+Oie4dXfpxh/m2PrGBiwTunGs7xRa/TN69v8gsrmSi8gftgO3QWxONNH8FsIgXmFBmFjRkB6B5B6bkv0ZkInCG1eSIMLmrI2s1fcLY3FnN3UKMIvYPVQI6DOYj4Hr+hNtoL7ASUi0qy00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ffqmA0fB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ogNDkN0Kti67wyjDkFkj3V/1dOo2vGXEtQDlghmP1JE=; b=ffqmA0fBOVEiLoSiu2XMUCtY5W
	yErdxopJdli+VogUfdGfEwFhU+940mHrbFxnIRTiyQhqPnJWnQk+b91BgvMqaooQTeMQ0RyojMxBB
	Yj7sPeQQaaDYFocd9q+s9XyeNt9dGre/JBZbNtnOhlXMVi+HMELHZWsZOuNiiMCaylgYV6UrjI306
	BaiXOk8uLtQzjeO9QHqFD/mlzdmY9huKnI7hRnJ3DSh3ljm+o1dbGonizhpXlXH9zxq6octWTAebF
	5jbahh9R7w9Y11ssWY8ArZ5OP7H3n/3qmWAzeytm1z0lbGHkq2X1mQKwQ6hdalJ3LRg9I/kQ7OJ7u
	gaP2cRIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulPyF-00000007MiG-1faC;
	Mon, 11 Aug 2025 10:41:39 +0000
Date: Mon, 11 Aug 2025 03:41:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v2 4/4] iomap: don't abandon the whole thing with
 iomap_folio_state
Message-ID: <aJnI49GCSfILx8eE@infradead.org>
References: <20250810101554.257060-1-alexjlzheng@tencent.com>
 <20250810101554.257060-5-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810101554.257060-5-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Where "the whole thing" is the current iteration in the write loop.
Can you spell this out a bit better?

Also please include the rationale why you are changing the logic
here in the commit log.


