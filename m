Return-Path: <linux-fsdevel+bounces-14685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D7087E1C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446852832B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D140721A19;
	Mon, 18 Mar 2024 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B0UmZ+35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366F21342;
	Mon, 18 Mar 2024 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725710; cv=none; b=WKf/dOL6jHROl521KkPE0FHZLcqF7AExKweao2Yq0lbywodETomyOBi5zCSWKkOHFl/9ubJcEfRqOVn4L9sXXkVZ4o8klucDPRWw7olJOGLsshM07P+8IFf8wz5aWRYlyrEVFnTfu6K3BZ5pTI0WfldaAPgizVQQTx6UHC/hzf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725710; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvs/IXFqMNlLzft792ujERFKVid5CnXb1BpHl2udSjhh2SMUrhPw6sFQzTB79Uj1DDwiOBbAV0aCrbm8PIzcX8MOYiEfyOl8E9WYAuBHNUA5Y0BSHNCtUArQNlXJz85vREIN2KPKXc3RDO1vDtLS0Q4e2zHfoGUnAoaVu+1wJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B0UmZ+35; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=B0UmZ+35ZEWctKQNy87aZhkhuA
	4QCshevB0rHy+k+K95siaI4Xldjux88Yw/0Sh+9eUiTvXsNIYyixFwjSV6xdu1TkWg5acjBXfe70v
	nOiz99JlhChuh17AK1NYbB2pRni4LG9A2vaeezvkQPSLbOplN7/es0eeoxOp/FsW68Ww7yJCqEV6U
	a6jTLhzUaM9BHbp85fUETkpXW0x4uS0aZqPbBRrsyhCmlJGEqOrc/BsNwwmJxnh7zw3bLDRhU/P83
	S5gievR4meEyNL1aJEGxh2qrhTbfqc35Mbz8NF+sfeJUJUkBPWpSeBWfEgeBGRivljDy0X8nUZqgj
	PATdMcZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm1u7-00000006wPK-4A0x;
	Mon, 18 Mar 2024 01:35:08 +0000
Date: Sun, 17 Mar 2024 18:35:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 07/10] iomap: don't increase i_size if it's not a
 write operation
Message-ID: <ZfeaSyQxTbzA0Yef@infradead.org>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
 <20240315125354.2480344-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315125354.2480344-8-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

