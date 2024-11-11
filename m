Return-Path: <linux-fsdevel+bounces-34186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F259C382C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 07:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B6D1C2142C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879214AD2B;
	Mon, 11 Nov 2024 06:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2J0jrmxp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050152914
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305164; cv=none; b=KTMgGEtRwe2AxnwH2tzPm7gu4lwpyf1WpOql7koRNX8NP4Ot+hBgrYW4pNMSkCOGrDPT5lAtZ+AIeab9O0zhhF0rqup3WleknUle/0641Zu7JDanI91V9ubLRktEUQji1jW5EewzO5g6ZYpgyXNGf2CJJsru1kLMgpVqKlwzaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305164; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZzgPumGDjUj9TS5Z0BeCMUfFe2RwE30xnJ1rrd1Kxqia+tmV1BA3omkOBwu507dM6oK0g7DqFvAEacySDOH5GalbpVLeUESGJzKbAnUILPomAjrgmqlwLBDaTFiGoGTk6F6gLs3YcQeU17/SubjmqZIoP5E9MeSl05NB8wk/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2J0jrmxp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2J0jrmxpHrQeoBOBmXxvqj6piR
	rX9laK3bogB990zl8d7ilaUSyWGPlxKvohXmsUYAnJjrC5h7W995I7e6mWLycv6xpqwFxPH9fQpbt
	kNP+vCTHdkLetx9BfEC4o4nH0DJCTkJTB/sJCR7qf2tsAypTavmXQgMNbb4ORy80t7lIJ9loYlrBq
	mnpvAAgTfZYAotKNbNAedfGn9sTMyE/nXmjSpkFfeGe+IyyQgloczKQHiSVfRMGtFANIdLDR9CXWa
	/DVB+xjiDwpxsrtF5k0ql2wqj+nIxAwW9dBXV+L1grvbmko5pNh4X4S7SfcVR2k8aP/pcLDejqRo9
	iplxFYNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tANYo-0000000GRwi-1o5n;
	Mon, 11 Nov 2024 06:06:02 +0000
Date: Sun, 10 Nov 2024 22:06:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iomap: elide flush from partial eof zero range
Message-ID: <ZzGeytHDGpNUdgtj@infradead.org>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108124246.198489-4-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


