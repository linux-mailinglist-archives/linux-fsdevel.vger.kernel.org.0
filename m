Return-Path: <linux-fsdevel+bounces-48034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13F0AA8ECE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00B71896F65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155C1E5B7D;
	Mon,  5 May 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGf6A3kx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643D91C6FF7;
	Mon,  5 May 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435813; cv=none; b=M1JR7eO8A4iLgdS//dPsxkC4WWeWATBUbWAAn7NyGalS9kSzIxE/p3utH6MVV1i+zw8ldu6QD3pFopwdQYkxSq5DqNCCB3zTeyEZ7sQiQZ1sMbK5iL5z9gukzz1+AB0dbbtjjiUabApbRSSBqv2SHquFlnhT76P19isVT2qTkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435813; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djv4FJSbaLS2+eaznVv7gA4HkQ9VIxVjNWc0nI1xxbRbAq+LFy4h27Fq1UJoiM8EC3lwrUx2cIOooTvq2PWBGTRs+DdQyD+3j68ITTXrdZg71nGIqJvPsTfBmN2wEHXsh4fpNqKAeXIrUs9qB4a2i4YrT3qATyYkVJTeCAe06jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rGf6A3kx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=rGf6A3kxZcpqwHX7yY9hKLv10q
	0pQSSxHTSBSBmf+92MnIXiEoO/DqLQ3pIoH0DooaEbaxGSuU0ujDfyUtoaqNwddNyzUwwszHzGLC0
	2qGld42RQj+K7zMWvt86TNgZmX+5kxyb27ji+/SYCpoNURS2yxMFuhVhs7ft6TCpkNHEXn9KhiQnj
	tRFm6VdwxCwwwlYlxE68xF3IlEznRGH0gEziUpdiFYmEQAvbTfnwXMDohhgLmfWgvYTlmPAawVJuX
	p4whocKpJjKKjJipJXQmnSGGuTzkzcivcSZH8JYPMyTDvaYt9/xMptgAt0MyUAeLpVSoGB2lAaAb7
	9Fi8R4qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBrjY-00000006rI3-0AWK;
	Mon, 05 May 2025 09:03:32 +0000
Date: Mon, 5 May 2025 02:03:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/6] iomap: push non-large folio check into get folio path
Message-ID: <aBh-5Ch6DBz-eLhC@infradead.org>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-6-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430190112.690800-6-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


