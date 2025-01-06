Return-Path: <linux-fsdevel+bounces-38444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53209A02A7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442CB164EAE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B43158525;
	Mon,  6 Jan 2025 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QyMiXG6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2C78F49;
	Mon,  6 Jan 2025 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177660; cv=none; b=eN4rIwztRqr17e8TkMpbTa23cJ0IVRCILvx0gD7nUnb7UsILEdl1INv4Q0DnMpyzyIdnMAqocAyhIQJ2ZoGxDEdZpHC3LjRgfaAdTaWGMi6ND+somiVs1NnK5z1s47GUcqFrnMVNbIqlyXGxqzZW4fGMdVoWKP2GF9J5XFE9QDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177660; c=relaxed/simple;
	bh=QJLQ6rflt4XyaXpP9xSwkGauknLAyMdxyfE5BLOx/9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTr/z6Mtc4r+n8HcnCJfoNvAczvvpJlxJCLll8/4dZdPxlD3S5sVKZTk9UAN8V5UssMhwlNtr1qrq7zTBGPp3hs9ppltPaS0t9j3353QdjAB+l1RWPuCUjNh5dGOgtJrLpyw3YFde2vApVoTQ6pbc9rwE/yxGwDVmAMtAmS3nHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QyMiXG6U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cgAjjKJiHCaH82HENENmVpcOqkdz5nrdQ1hbhMz4z/A=; b=QyMiXG6U8j5VVIz/mUrFq7V0Oy
	UIIT6UaoKHgZLHT/yUwVDtEYeJD0rWIg39lRxmPNIaAbWQqVB7EmacUpIkyBZBPnw1VobX5Em2qPF
	Oujgg1SuBQ1yUvDh54OfvYr33vC9SHstRTg4YxqOhyHMvk+5SJNyAckipbc05ZQVSVNdmwQcLQegT
	G+iIb37vuyMGJyXTmAg66WGAv5UAtu6Vtf9D7Xt3L8o6goy8jgPzbtvaO4692mF4Qa/BirvoGMF0T
	N8eXq4A4le4YbhNA5Il3s6yLIK5hyYsAZJ9uKCGWMsrISZN3oTC39OArhOWyzw+STmj67yWHDnwzb
	FwJ+98FA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUp7Q-00000001mt8-354b;
	Mon, 06 Jan 2025 15:34:16 +0000
Date: Mon, 6 Jan 2025 07:34:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: nicolas.baranger@3xo.fr, Steve French <smfrench@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix kernel async DIO
Message-ID: <Z3v3-LNGff6OxObh@infradead.org>
References: <fedd8a40d54b2969097ffa4507979858@3xo.fr>
 <669f22fc89e45dd4e56d75876dc8f2bf@3xo.fr>
 <286638.1736163444@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286638.1736163444@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 06, 2025 at 11:37:24AM +0000, David Howells wrote:
>         mount //my/cifs/share /foo
>         dd if=/dev/zero of=/foo/m0 bs=4K count=1K
>         losetup --sector-size 4096 --direct-io=on /dev/loop2046 /foo/m0
>         echo hello >/dev/loop2046

Can you add a testcase using losetup --direct-io with a file on
$TEST_DIR so that we get coverage for ITER_BVEC directio to xfstests?


