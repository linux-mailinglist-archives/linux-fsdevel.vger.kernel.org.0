Return-Path: <linux-fsdevel+bounces-20105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC78CE1F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 10:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2423B21AFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDCA127E28;
	Fri, 24 May 2024 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fFSvZN9N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991F17578;
	Fri, 24 May 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537826; cv=none; b=JF5un4R/3sPetFnALNdnFt/xevJZiLY8M4PdROiQLBGq0CPhUUO2Aw+R7FgPBss3uQCuuESpEoXomFpwU0nTu0E5uBWos6XB5zdDdCruwE25mQn245Zcb2JmMkSuWhUUeZBzB2iSPdVZwxaDB9v69mmOsadus03iLvjA6vS9Bd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537826; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0Xw6e0/SCy0n21be4JqJv5qupp/I5kSkIyvfCCEyt/5CIw3IMUyLUhQDh52vKXduRFV6uh1nVXGfouWcPCf8Bs9q6mKwIqcM6d+27YPGFS2j2Y4KfCHOTjDGuimuE5EHzgUwKymlQLkOjo3QF+uVmXOSEm7vpdPdXwk6mlgRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fFSvZN9N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=fFSvZN9NmyvAZzaECH6xS+RIDl
	+SqqLGL9jPUtxX+EwdQKnUi5/wLE5qaK0MXJUsliz5wwwNbejAIlQLACCx7Cu0mpqL/Oy3ENjkYNc
	zAhqEN0ke11k3jRZ1NDw0YyVAOo8PM9mvGnedv+Gel3lBZumMFD6ex/Ih5WogenXoR0/qUUBkym50
	Thlh+TZ0/zav7eUOmzIkkRCRfuN+m90vLPIAxcJDZdVZCgt77dsaPqfgvDbpym8znBa075mY27yr/
	+M41MQKp61DCN3GqYil3f3B9X+Lz4yNIVRC3sMyP/kVlkHPW/0oCSyebxnz3zPnhAHT7WYrKTtfoP
	o5SsfYzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPtp-00000008Kzl-3wvs;
	Fri, 24 May 2024 08:03:37 +0000
Date: Fri, 24 May 2024 01:03:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: brauner@kernel.org, djwong@kernel.org, willy@infradead.org,
	akpm@linux-foundation.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jun.li@nxp.com
Subject: Re: [PATCH v5 1/2] filemap: add helper mapping_max_folio_size()
Message-ID: <ZlBJ2YviFb7m_Iej@infradead.org>
References: <20240521114939.2541461-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521114939.2541461-1-xu.yang_2@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


