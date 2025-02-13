Return-Path: <linux-fsdevel+bounces-41635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10936A3386E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 08:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2033A9333
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFE62080CE;
	Thu, 13 Feb 2025 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GkGDqwJX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B16207A19;
	Thu, 13 Feb 2025 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430024; cv=none; b=AnOk1Uv6xFawQDT+7qRJ9OHgdlaetX09fIIZpmytoj9bJHMrSSI0QnlAxfkQdRS+9YkxZ5rWsMWwgCMq5GwWlILEKQNmkPECY3W3n4SDnjTO3pMkUXG1xEozD2O1BF52tfvlgyYlH8S9aD5eQaavuLGSnKUFcQ2n/asifpYP+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430024; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnodzKENOTu4YNzYr49OtMN4DGOXQRMmJH0N9i8B59a9gEYz884HGO3GSeb3xyObiycRbSgu1/tMit6l0ZiMPl2TaUFpMjBamuonWBtRtbAcRO5pY9WSvsKp/VjZMrazltGC0YF9Zs6OXA4McCdqdc1CyETKTwwdYyUDc9Kl7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GkGDqwJX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GkGDqwJXS8+8DzM6k6I3vayhcL
	QqIXhrrqrhQhDpzXLOrKoi95EaF+TQ87ZGIWGq8mNhTMhS0OYIOc90L6R9Bzb9YsnQkej7Yswnrav
	Lgb3ImoAAhbta3zqJi6jaGxsdc6MVNCV5FT44tt4+9zd67719a4Hg9lKzmflRBDCiV5vA0uHuXB7E
	2s5gvvszUM/P9NKaxq3MxU5ZhxZlDC7DTsZAGVtCQmn7wnC+d3w7GAh/63Q1+UdGGvx+knLhJpfjk
	r2F5WQGyaJS4/mqMB6xxjlXlcfVISxYGm6HxQvtbNvh/RoraltVwok3nN5Jj4/7iNhsfg9bmv9isR
	4Wa/F1cQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiTCw-0000000A1vr-476K;
	Thu, 13 Feb 2025 07:00:22 +0000
Date: Wed, 12 Feb 2025 23:00:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 10/10] iomap: rename iomap_iter processed field to status
Message-ID: <Z62YhodXxh65UD8s@infradead.org>
References: <20250212135712.506987-1-bfoster@redhat.com>
 <20250212135712.506987-11-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212135712.506987-11-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


