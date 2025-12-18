Return-Path: <linux-fsdevel+bounces-71617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E24CCA53B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FA1F30321F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D3D30BB85;
	Thu, 18 Dec 2025 05:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z4rb0o9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40307309EE9;
	Thu, 18 Dec 2025 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035645; cv=none; b=uFbO8Ns5TKnUaA7EdqGasvq/2+RkRxZrc/LtwWnmOuBTr9O61Brk4iioY97o1gfRPe9KwLsD9cUN9pVGhMBG0QzcFbqNJ10y8toLcw3rjvE3/AN8loqPluN6fzNmSwp9EWbhUlDobYwQmqUEJ9Dp4McrzH/UUvsvvIzvl93BoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035645; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGqO71MIxw5jtVRHaAR3Q61jDZmkSwyD5OW66EYgl8U06GnenpBQhmaEEMdEGIt6F3x4oDexUczqccCyGL7b/8UjyepMLW4BGIpTPaCsIbZmIn5VOKlr/UD2wBjHCNVsz0VuFZOAYgDn9Mu9qCxPcWbGZF30CuYgLAga8W9WfOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z4rb0o9O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Z4rb0o9Omna0cDbnBwLcsRXfjC
	PuP3yXjAGgq8btIhaR2HwUy8orD7FGS8P3M+QFCpP64Lnn7hCC1pAQoweEF7myNviokApHqvnKLuF
	L6vXWlYxVEWAfJ1jaePt/Mzs2pc3CVV6Wqt+8vNT0nnF/i4wDllB8yur8asUdIMQJNkLt3DK8mA3s
	wBipj9xwJk1D7gdtcT0aIaHGYLmc4YHUzdZHpwzb1oqzo/nwjfwyBT94ZxNdXBfIVp/PxK8xOuj+J
	LaEHnr0W5cU0FwaXZ0zhxgU+SzWOr60mS5ohskOeLHiWwE2NmHtvtjkKObMELlu4tED9hEjHmKKik
	ftObvhZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6Xs-00000007qRQ-03i3;
	Thu, 18 Dec 2025 05:27:24 +0000
Date: Wed, 17 Dec 2025 21:27:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] ext4: convert ext4_root to a kset
Message-ID: <aUOQu7SzQqkX-iPh@infradead.org>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
 <176602332570.688213.9854057917443661154.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332570.688213.9854057917443661154.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


