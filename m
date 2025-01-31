Return-Path: <linux-fsdevel+bounces-40475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD3DA23A77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 09:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70956188839E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 08:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45E716132F;
	Fri, 31 Jan 2025 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iEZaKCyo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C312632;
	Fri, 31 Jan 2025 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738311000; cv=none; b=UYJ+qTOFjSDlGLZJhvQeTbFFE8EXM5KgEGD/1KQP1+nNmZ1tQ01oiR0iVQ4cHwSWCxI5bvOiw788F5oCvSeDxUB18sosvpEpSrs2oaZPAhbmIXxi0Kr2afiuAPjdYKUcOODWpNNUfzxnvRQ4mjcwS9aFnTVPOXYxd5C31I+bklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738311000; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVwBNBTApbPk8DNBMTDQmuwoxepKnAkvucQ/UWJwO3J4Lpq0T/s91ghKp/qpF7KsreZS2PIvKcg0PJQKqDIychac3k1OMgpFpZ109+aU5kouz7whC+kLL6pe1BSuNEsnBQ+8hX7O+gC1b892BnFdYEwPYUT0TJPA8d/mN/L/IvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iEZaKCyo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=iEZaKCyoP5JJOTUoS5894lCOG4
	KVwZ/VhxvOeV0ERIU5PO5l8EOMER6fwsABE+M9zZjA10UzdrxSZQsDp8p6awDdSLgSeg1+XFE3Cvx
	FTCdVxvuOjlzEHP9c0SKTDgT6Bvu9W7poUzwiXOjk3pvswEnZ5KU4qLiKOmyEy9mG9QOlt3h2WbKF
	9bP/WEJP3EvgRFxxg7t4HdfAZYY18mNQk/SVKCvz9CqaWs8HOAlZL7p3t7j1ftgB5k6dik5IJ2j9D
	O82bNGhx4nHlBa+5flUXNotkU5Xw113n8o8F9QQNTFC2tHR+4IKT/+f1qkuREONrKi7w0Oud+i7C7
	aoNoC3mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm6A-0000000AAtb-2ykg;
	Fri, 31 Jan 2025 08:09:58 +0000
Date: Fri, 31 Jan 2025 00:09:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 7/7] iomap: advance the iter directly on zero range
Message-ID: <Z5yFVpVChgp8hnYE@infradead.org>
References: <20250130170949.916098-1-bfoster@redhat.com>
 <20250130170949.916098-8-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130170949.916098-8-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


