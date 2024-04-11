Return-Path: <linux-fsdevel+bounces-16701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD338A17FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 17:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B86B23D6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804EB134A6;
	Thu, 11 Apr 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="usBgIlvD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7562210788;
	Thu, 11 Apr 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847588; cv=none; b=gtVjZffratwH/FhArDKshfbOBEMpTLe20HRP1c9265GoM7y9iyJG/jhM0EOeu48ETAaG6pXBhe4lsD75gP7bfDUdbTMTQ2b4K4TjjGuaOgpmv7pQgGqSQMUyw9cluQmF+ST+8NyxoSWSTvsc/0iA1bNRpeDe/djernXFDmVRtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847588; c=relaxed/simple;
	bh=bdE3gut+4CKvWaACvPLuBZ9pXayL9LrHXy5w9CPb8IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtY6MGWu0NmxABlWRzuIoM3Q+ofTsIqgv79a4UIRi2OkhZh/mmWECQwIMZskHPCiU9e/4gRwGSK5G2rFJtEEOVPRfL6T0iMarS0jGA2450e4KeomHKXXkmiwAjfKLgNzicQ9zUnAQSfzrdm8qdR3YYTcMPpgGXGEOJ2+4Eu0Meo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=usBgIlvD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bdE3gut+4CKvWaACvPLuBZ9pXayL9LrHXy5w9CPb8IA=; b=usBgIlvD1ni/lqwzyLHdTKqQ7g
	k99Dy4Mtk5Df6WcuXQDPDpWeifO6yPLKsPCeU9ycok1zIHGRzRXrFIoweNOu1Mon64Y8LmFUtYmCx
	A5UPGT4tVcZ6uR02SM9GcZSxGTPbtOrP5vaIntmSI2Y3yFdr9QDwJ/f1AolUSdyr60P14kk/f49wl
	BLSOx1EBFB0x4JxswTolxDtChGYkAXrj9TKi/60rVOOz5cCTYqiOMAy+jIJRKt5GXFDtOFrdN5VYY
	IPCJTOAdTaKx3xdlVN4He2HHyvZEub5LwTFzpmOcJWqh4Vi+IRpFBooxzO2yO0E9EpelRJTJdS3hw
	S6rdhwdg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruvtq-00000007Ay9-3V1g;
	Thu, 11 Apr 2024 14:59:38 +0000
Date: Thu, 11 Apr 2024 15:59:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 03/11] grow_dev_folio(): we only want
 ->bd_inode->i_mapping there
Message-ID: <Zhf62vtfnMs33pq3@casper.infradead.org>
References: <20240411144930.GI2118490@ZenIV>
 <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
 <20240411145346.2516848-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411145346.2516848-3-viro@zeniv.linux.org.uk>

On Thu, Apr 11, 2024 at 03:53:38PM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

