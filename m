Return-Path: <linux-fsdevel+bounces-46169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A812A83ADB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 09:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A193AAFC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 07:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A370320B80A;
	Thu, 10 Apr 2025 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0fNMiYgm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9283B20AF9D;
	Thu, 10 Apr 2025 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269427; cv=none; b=H906x5ZP5kvgMtE7rUpa8mGeXj4pIrhM7Xd4varJvacNjtVi2a0QAheNc67gob7wrHTDIaaSztVBC4yxvwQSXgd+HzH4CO2Vsrh45T8u+dE5deVx8xXCUiYanjlnVw6tKFgsj/eZQV5XVZQAl/3edLXF8S/+luNgOd/xL1gpzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269427; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOr48zjVC0JNmmyN1rJSTnB4K0f45ztLcjKWIFxEIsIlU0k8Nmc+1vCL4X7QKZJ++FcOOeqMd/U7Pb7rJMWFUAR8JRPxP7LGzAhQRuTHjZMv8GQflGtuYIiyJuorT7FgySxFBd4GNLtyg9140GRDAAcwH668RfjPLdXbmARy3IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0fNMiYgm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0fNMiYgmM3+V3L0ZZJQFNz7hC0
	tjCr1K9/wITp1HhOOwUItzPLQO16HptgqkMB1w7KEWSL58Uin1zD89+5OZfEKNuSJGEvyMRKekLUT
	zKFK+hSPR+n64sEdeDN/Qv5vk8ypvZVEhEL0i64cA4nUDnR0+3gSeZ53UinXAvdeWJxn3C5ugr5nD
	CRYHifUfQkwEHUeK3i+9oKWQRJpUAjx9z6HbDDb33wzeN4H3Cc1XgwXXf/jhz0zW5g9pM54GbRL5W
	cy3F/arfVN91uUvSUzo3J4mEQ9JvChcwdv+DH0BSBUiXto32aHtw63fu9YbNp6SIrsaZuj9pXYHsz
	ry7zYFoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2m9p-00000009Vgq-0601;
	Thu, 10 Apr 2025 07:17:05 +0000
Date: Thu, 10 Apr 2025 00:17:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gou Hao <gouhao@uniontech.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	gouhaojake@163.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	wangyuli@uniontech.com
Subject: Re: [PATCH V3] iomap: skip unnecessary ifs_block_is_uptodate check
Message-ID: <Z_dwcbeIIVMcH533@infradead.org>
References: <20250408172924.9349-1-gouhao@uniontech.com>
 <20250410071236.16017-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410071236.16017-1-gouhao@uniontech.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


