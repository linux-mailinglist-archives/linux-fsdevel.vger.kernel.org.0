Return-Path: <linux-fsdevel+bounces-30971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B99902B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F111F226EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECAF15B140;
	Fri,  4 Oct 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GhOdYtC4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DE1494D4;
	Fri,  4 Oct 2024 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043788; cv=none; b=dnaup5pqnKG7hpn2ly/wqSoIW4JktVojgLAWUwkglcYb3sJA1YUXYzCmsUp29uHQECIxY8C0NX4iVLJV4BR2R/9uCnkuIq/+8rGNtndzyMD/HDhZ905/HY5GB6nGBsO8XlN4e1VUXRZ854oN1V0FQrAkSdsf/nbxNjlK1ZFLwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043788; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIFgHgIRDoJ3UzhyKASFOx3lI19sncOsjfriY04XSIm8vP+XbryrCZeQ/2HcHR1yZOtpFrJN1B9TcRYBOnvh6sQt1ZRtYdlaaVVdyIRjS6V8fupBK/qbfgVv6QgvHSdzKDXcC3kmSplbeHNuf2qZA0lS6wzQtxZVD6fS9PDiXns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GhOdYtC4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GhOdYtC4ZBlgCiDYFv6xB44Vty
	KbivPKJ8T3aRoCy4NIYu6bVQL92Lsdmf0YDkLITREuh7MCP610IIDc5GIymUiHZC+qSByMqswLtCx
	cdiqFkrbOanTYnQ852Mnac0r5NmWFqWyEW7pf7DTPlmHv2/USVCbqJGEjTIjmSBAsziW84QXDi8/G
	jH2OV0smVhEnmJstHw9YCFXD07vyOUCEIzeLbg7+oXk0uAb2LqsR7RrjrMMrHGAVrCLg04Nj/uiCk
	ynnz7YRLNB/PzMdBG7u7HvRQjWokb0rJ4fYvIsCO6598p/MGWoVJNQ4uLOssWUjLn45Jt0+2GJgPM
	pG6C1/hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swh7z-0000000CFWU-0m21;
	Fri, 04 Oct 2024 12:09:47 +0000
Date: Fri, 4 Oct 2024 05:09:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: willy@infradead.org, brauner@kernel.org, cem@kernel.org,
	ruansy.fnst@fujitsu.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/4] fsdax: dax_unshare_iter needs to copy entire blocks
Message-ID: <Zv_bC91KNS9Jt511@infradead.org>
References: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
 <172796813328.1131942.16777025316348797355.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172796813328.1131942.16777025316348797355.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


