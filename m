Return-Path: <linux-fsdevel+bounces-43765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B362A5D72A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205E91797B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D11E9B37;
	Wed, 12 Mar 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oDk8BRBx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEF1C8628;
	Wed, 12 Mar 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763845; cv=none; b=Q/mVOl5cwJPxQ2EU+fnejJGZgb/U63mCec9g2QKBUoQmCSvfDeLbcjTFEk1YoJZMMB+C4gZLTL+bGLK6LGjmvCtTTajyN5OHfQePHpMV+9Y94ZVZJKgBfKEUrhk0DLzaVWz4l3YSg6uPuk+VNyT7CsBBk4UdgIf9HqMW541raxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763845; c=relaxed/simple;
	bh=nYf2HnCK2gNixj3Sk3mIgYiHLeuSYVPe+LgN2CAdlcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6iRrXVTm5ScPV2/9DnbV1dQNTtgpcf3jAtMXlJerKAq0ooxda8fKZJltJpR76O+MCsQ3YHQBBMKmjzvpm/I2o/pUbSi0fQHzq3d2WX01SMjJR2qGAulJHKgrMq7P72dQk1daLH1/of4kjTNcWOEtnUT33txConFL7kW1t1rLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oDk8BRBx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dmCEKhEatygoiFB3tbwoD2B2lyPKnxdt0OBAA/MS1co=; b=oDk8BRBxcqeevAg6pJWHjffMFk
	1unreD5brcmWnJROXkabrduR7XXhBk5pTDo4pHyAMLMMNlxnR9o7MaVILsUPdiHNYZ84CbEww4SNz
	Evu2eq/jivSyj6ccqOsEMSzCCnC2Tf1YbNx1UCnbETCEf/tAbmb/jGCX1FHg3V/l8xGEhQJDk1aQX
	TrSZ0c5KwnFz+JFso8MQ7BHXRfczdRC/2g+v0/vM/0SSDqfQZ9j5Iwlcg4MHY/C/NA39om9TJfcZP
	mFEyKFBkkaapOxxSnMqjqj9DYUCW2/Sp6bgzphLnhgOXK5MTs4SKCa56toYRr6kUAlLfd+Lt+znYZ
	kcZKMu+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsGLD-00000007gU5-1yKp;
	Wed, 12 Mar 2025 07:17:23 +0000
Date: Wed, 12 Mar 2025 00:17:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH v5 02/10] xfs: Switch atomic write size check in
 xfs_file_write_iter()
Message-ID: <Z9E1AwaFni3o00sZ@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310183946.932054-3-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +void
> +xfs_get_atomic_write_attr(
> +	struct xfs_inode	*ip,
> +	unsigned int		*unit_min,
> +	unsigned int		*unit_max)
> +{
> +	if (!xfs_inode_can_atomicwrite(ip)) {
> +		*unit_min = *unit_max = 0;
> +		return;
> +	}
> +
> +	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;

This is a rather ugly interface.  Why not have separate helpers for
the min and max values that can just return the actual values?


