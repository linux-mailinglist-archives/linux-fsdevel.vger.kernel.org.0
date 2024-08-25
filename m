Return-Path: <linux-fsdevel+bounces-27058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9294895E1BE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 06:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF771C2123C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 04:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF132AEFD;
	Sun, 25 Aug 2024 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3U4juger"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD629408;
	Sun, 25 Aug 2024 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724561552; cv=none; b=B9yeT1JZLce2no+pYgc9UHlVngONl6U0vP5GvSJQf9Q3zhxFfFyuyNMnCbIA3EYdgLfXKMoeKajAywEKIWn8H5b3IAODv9NIPb0le6vzG24hAVPa54Bxg9LPzuFxMB7Ew9l0jWR5sXGnl4eniFk9deAOmbW+S7/DOrzPZmLFeCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724561552; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBJQdMHDj3NQOygOukmA0vKOz5GBg/sQRTg57Ve3C25uYb6Po7/4F2CvSzBM9KSVTxMfXiJkyEYiewPn3FV4wiJZYwD6VVhqu/5JrzGs8dTEWdr6NDtiIlTAEo0qflp2T1ZdZEo1aKKst6l6mOmMmLKYVrGTyJ2xBpxW1MfUIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3U4juger; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3U4juger1YU3gnNp8lIq8bb0A8
	iZmXluqMecwb0HCBWs4XeaCDCFc+9wsm3r3BOM4BHleG1AbKYkBrPZGH5nfpVruSLR6H24iuAY8kk
	uhnJmiMkqr3V3otqFJmLGkt3XFRqrQo26QpJ9olkmvDXPXemAju+viPyyKOk9KUxyScb6+02kAHHV
	eJ+RKWqR7bj+gLSv/OP/sqmnkyKrGYxY5b6C3DskP6SraTKHZjS9Px2W4tyWLZLYtqjqTcaRMV1Vx
	vsOeXvCSjKMBUjoAbJnbSeE+e0sMc6jCyxBTDyngglmqQc5hAmWGzQ/PenjQYkULX0hkN8CgXRIVQ
	9CrlVahw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si5Eq-00000003bez-3JaJ;
	Sun, 25 Aug 2024 04:52:28 +0000
Date: Sat, 24 Aug 2024 21:52:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org
Subject: Re: [PATCH v31.0.1 1/1] xfs: introduce new file range commit ioctls
Message-ID: <Zsq4jLSEU_vzOYYP@infradead.org>
References: <172437084258.57211.13522832162579952916.stgit@frogsfrogsfrogs>
 <172437084278.57211.4355071581143024290.stgit@frogsfrogsfrogs>
 <20240824062927.GU865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824062927.GU865349@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


