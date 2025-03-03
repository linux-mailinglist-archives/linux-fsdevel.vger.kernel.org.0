Return-Path: <linux-fsdevel+bounces-42987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731DCA4CA49
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2473AD3DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D222E402;
	Mon,  3 Mar 2025 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4uQGxSas"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212318489;
	Mon,  3 Mar 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022656; cv=none; b=Xig9MK8l7h6O3Krx7Lfa+ma6EjJuGeZjcZJbKe40QvRR5fEB971huwX9nfYTbs2p692QbcPr4TQrJxZCVF74zpqhghYJ85Vw+IY3+zm4v2PB5WN1UR9SBZOy7hT+MB9PMuRbO/1PBEEmkDX0nJvkzV1bVmZ5x9dfW9x0UiGE09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022656; c=relaxed/simple;
	bh=C2ckK8bQNDcbcsSG2G21/Gbr8CgvuAOuCYZlkUnoJzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLSij6ixTublHiZClU7uHdwSdAF3wyK1NYXuNVhuhpIKlcPvmzQPVvspki70lJ5PBtZWz1SulDivKiAcPN4mLpKpEem3sn7ICShM20eTwmND7RfzbVynDDjb3Y7PyP7P7SegYA+1P4/uC68cepMUyukwbqAd69zduIEzN3Bves0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4uQGxSas; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W8TcBwyxADhLGVfNgYnLKlgRAFc493awa18FegwhHx8=; b=4uQGxSasnvdUe0VwB9hxz63WQu
	O3W5iHQirJAb0LlJ8nST9aR2VPRfy9NVZH/b9AmAl06WsDr6iWozOdBQvOBikaxrDwhITAvKXEBGR
	4k1Os81aX6xhVZ/FIvp2o+36HOxMHXO15SORYtaLWUU6+1vxPeWeqwtgjuEDnpYoSL3h/G701zhdR
	FpP9PBBgEH7VzhG8ATqt9zkazF5zF+5C62CX3OV+VUN2JlZ2NOX2PTDgmyDxrup65AILiFJrt0WeX
	b9VDVuolET3U2wU/HKpZzOSTUN9MkHkV2+Wg5saBndPjAv+H6ksAFPvbX9XDzesHxjrxVf694SE6g
	EdqvXLgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp9WX-00000001jSm-2duk;
	Mon, 03 Mar 2025 17:24:13 +0000
Date: Mon, 3 Mar 2025 09:24:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <Z8XlvU0o3C5hAAaM@infradead.org>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 03, 2025 at 05:16:48PM +0100, Mikulas Patocka wrote:
> What should I use instead of bmap? Is fiemap exported for use in the 
> kernel?

You can't do an ahead of time mapping.  It's a broken concept.

> Would Jens Axboe agree to merge the dm-loop logic into the existing loop 
> driver?

What logic?

> Dm-loop is significantly faster than the regular loop:
> 
> # modprobe brd rd_size=1048576
> # dd if=/dev/zero of=/dev/ram0 bs=1048576
> # mkfs.ext4 /dev/ram0
> # mount -t ext4 /dev/ram0 /mnt/test
> # dd if=/dev/zero of=/mnt/test/test bs=1048576 count=512

All of this needs to be in a commit log.  Also note that the above:

 a) does not use direct I/O which any sane loop user should
 b) is not on a file but a block device, rendering the use of a loop
    device entirely pointless.


