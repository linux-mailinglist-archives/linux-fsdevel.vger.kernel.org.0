Return-Path: <linux-fsdevel+bounces-31855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CCE99C243
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6EE1F2131D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4281531D5;
	Mon, 14 Oct 2024 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OPCk02JS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75086148FF3;
	Mon, 14 Oct 2024 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892593; cv=none; b=p9mzcj9+Z1m2L0go1F/VFNVpk2pjpB9d//pzaGPJmXiUCFyJD1cO9ERP3SahmkPXDxeIgXLK0vgBLv2N0tq0K+xLuIKtLMIAgbLMFl935dgtqczZVq5HK/HjxjB4y1TV8wWN+XuOrvBL6aae3moviivcCN6Or/2q06DOoumR2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892593; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7hTipRhB8eEYpEGPWTBxtU5Bp7OG+IY7eHde1DLnkTz7cC1fsmZKvTwVO0e1uWcgFqrx48gmV3PeYNjtaiFTpesFDcQMybykdn/VvSUNokNoc89LVCzIAed3lccy90J6wooJOU6+bAHKXEqTMFg+zeeKXPIve159DcAkjPv+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OPCk02JS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OPCk02JSMDmXHRHelAtKP9Jxu3
	MiFjMdb6jrcgEn7X+05bpLl57jAkmDL4DiVkyShBFwBTPJcIKedOLjvTENEdaM6WgVqkCqcUwdwxI
	Xk2/NAAnfkVUriT2f7DyZOveUoKGaJhHQkrJq5/E4c1jMzqXF3REnp/H+aEbWzSXbCrf62dHGWafC
	JJ0hEjhtfp0M5/L+BqZQvVR0HAm4tKL/celNXHMI6tnPlOv1arAYs9nhXufr7o8C4ge0wLZSvy4iv
	hX4vCie5sQI70aJ6ZPX8O7zoawaLw5tqjP1fuQ8c38cYEqkdQeqzGlcQw4bM2wLcpoNecqLmdxJbM
	bczHZyog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0FwO-00000004A6y-00lN;
	Mon, 14 Oct 2024 07:56:32 +0000
Date: Mon, 14 Oct 2024 00:56:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs: fix rt device offset calculations for FITRIM
Message-ID: <ZwzOr1IeahvZhWYj@infradead.org>
References: <172860643652.4178573.7450433759242549822.stgit@frogsfrogsfrogs>
 <172860643675.4178573.6455434897985057942.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172860643675.4178573.6455434897985057942.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

