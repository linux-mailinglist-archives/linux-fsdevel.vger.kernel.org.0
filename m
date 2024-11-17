Return-Path: <linux-fsdevel+bounces-35036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949269D03AF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 13:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413DC1F233C4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C8B198A0D;
	Sun, 17 Nov 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mTU1+u6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A672B183CCA;
	Sun, 17 Nov 2024 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846328; cv=none; b=peEy5TPddAbekjb+CxxKwwcOyU5nRzmLXf29TFmo6qkglRFfq+JjRxQcHllvjgdX4uI2hVsNWwWlJSbkmRbRIyrdOlzPF1nEk5LDknuPAhKlflSX3kFizdFN8MCnyjYWLckaIPP/+ixYHi1Z39pd7jh+QUIU0Ko6KFeJe7stcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846328; c=relaxed/simple;
	bh=2Vzu3RlYgWlUg+kP8l3nTLXS8GOcuKbfykkwWU/BOFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LNQ/gtUOCrqCVL+bkvrll8bT2wbdXPTXG/AQzCW4TNqBig9lun9ZzyhGtaoC8TmFCule8Yti7BWeCAriCC+bdZRkdQJNsC5ycPVA0+rOU5HuQ013kHkoKAw+9UV6Jvu0Txm96BfjvUC8xIX0YFwaUlYTEi5x8JaXgd1B/c5Wj/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=fail (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=mTU1+u6c reason="signature verification failed"; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846322;
	bh=tp2Q+8b3zGUBih3afpuzhAn88G4uKrpXKwQ9ivMWqHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mTU1+u6copmZDAjfqnXWv+2ujIPjQ3JtoGu9so550WGMXDTKHgPRUtKWL5WTQKacA
	 ukYIXyZnvXaIaM7phYyg2ffevuNcZwkVM+fGzA0yJe4hA6ivVJfsyMN2k5es56Dca2
	 xnyEpYxwi2vRkSTSXt4SDnE54vHeCtrhpgtS0p+MhXC1a/iPqUZ6noNUE4xD/tX6x3
	 9xyLmagErBzssEeKDZj2zkr4owFCFT2YctuTq6qJ9KGCJplX90TRwhVHol5EujIAFV
	 JLHuHIFQhKPYuj26daIFU9Gqj0sP+YYyQFfmqJ5wJevMLVh4tXn5ub20TQGEUboHP9
	 4WeeB6bi4EbDw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqhp5Zp2z4xf5;
	Sun, 17 Nov 2024 23:25:14 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-gpio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, audit@vger.kernel.org, linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, linux-mm@kvack.org, maple-tree@lists.infradead.org, alsa-devel@alsa-project.org, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, dccp@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, drbd-dev@lists.linbit.com, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, nvdimm@lists.linux.dev, linux-leds@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, tipc-discussion@lists.sourceforge.
 net, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 00/35] Reorganize kerneldoc parameter names
Message-Id: <173184539760.890800.14513086226459117952.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 13:20:46 +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> The misordered cases were identified using the following
> Coccinelle semantic patch:
> 
> // <smpl>
> @initialize:ocaml@
> @@
> 
> [...]

Applied to powerpc/next.

[11/35] powerpc/ps3: Reorganize kerneldoc parameter names
        https://git.kernel.org/powerpc/c/276e036e5844116e563fa90f676c625bb742cc57

cheers

