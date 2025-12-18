Return-Path: <linux-fsdevel+bounces-71611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6753CCA4E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BED1302D29F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625BF306B3B;
	Thu, 18 Dec 2025 05:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a199SXfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F129305E21;
	Thu, 18 Dec 2025 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035358; cv=none; b=abat0oOQlUCrwKilYdNhFz4DdScorMe6JxizQ4dgZ/TDO00xaFw4dXpTg2RMkgVbx31XJHWkNpIlxMFjbry8srtY0eEZuOXeNF9aJjD1yrofTL8K3S2N9MLlNvk9sxGH/82pTX5sig6rGRGmRUhXBJmUfZa9MeBpc4k4/+GipnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035358; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpcyI6qxMG1r8HbZ4LLMhX11MVvtacY4B8FXnHpKgxIfBLRJsTVirHwv0VxOWa4c+tx7xjxhTgdpAQ5IYMl/bm8xWZiu5YDZM0NtV6Pj0BnyZzJO16IvgMCfr7xlkCaWWCyI+MyVQGZ1z5lBd8I8KyG9vgu9SPcvM3apRFyjb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a199SXfh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=a199SXfhW0oS45DMbMScMPbxvK
	MtzSKDwrpmU/cry4TWx56yfVuMoWL0ONtW6JGv/asr5GSP9+aBtoFVo9zb8saRKq9V9uKObKOHEkS
	rPKBNDGF6KgS+JDZNGlw5LRK650LB/Es8L7xc72LbFcXhty0MfAedSmGnLcb3/JnnIRcFxlUuHikj
	UudDHv7oTOB8j8L/K+JxL7MppFUlVYossOlbPN8KMqPyv4d4PK8D+dJsihHjOONg4Aob6jYCoAj5s
	VbVmCVvXDD8ErG+6bz/Y5vd+sT6RuU8Cbp3h44DkYCjQARl0vzwnJeVcobzqJxMS0eiuvM26w8+Ju
	ghRK3/yg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6TF-00000007pz9-0YW1;
	Thu, 18 Dec 2025 05:22:37 +0000
Date: Wed, 17 Dec 2025 21:22:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 3/6] iomap: report file I/O errors to the VFS
Message-ID: <aUOPnSuDK3U1ejQg@infradead.org>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332192.686273.7145566076281990940.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332192.686273.7145566076281990940.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


