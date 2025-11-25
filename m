Return-Path: <linux-fsdevel+bounces-69746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EDCC84339
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE18E4E8F2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDCC254AFF;
	Tue, 25 Nov 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t64NO6iK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5624E26056C
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062557; cv=none; b=nBhQv/2CmAiWpkSEArCpzyQQNCDt1OXW4Syaxdw7JBso5VpTB2V6o3XL4iBRwUN74ZISqG2O0ZjvgveCVcEvjVBzidjIt6SSkGntThDadMD01Kve/3IjCQq6UbQAip45rqci+fd/GknnF7j0VR/vW7+GtvEGCh27t3lamJGYgkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062557; c=relaxed/simple;
	bh=/hP+cijAI0n97XrFaUvVgLL8TU2ch2cP1TsBvj+HOMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5bl5Eh9WIh1Mt2Ayo2V2v/dU9Rr3FhEOvzfD2O8d2jdwPMRZkuyP+ffwlYt/C86bcOXJwJxFptjI7ck6YFxLjnRPKwPKghmVutikyYjUsQGcDH9QX+YnSqOMhMQL2s1/jpmkfdPN2L6KX2BDZRwi89Y3L0KDQZXhSoia96rBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t64NO6iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AC8C4CEF1;
	Tue, 25 Nov 2025 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764062556;
	bh=/hP+cijAI0n97XrFaUvVgLL8TU2ch2cP1TsBvj+HOMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t64NO6iKPw6OMZPuLPDsZxx51IaIJz3uwIqIYhNJrMbRrg9kJel1giHQQeSTtfkzy
	 hTatG0LV02TZ3CISdlOvwrmV0CJSdkPLQQ3GEeC1+mG8bVkNjuc1zJGyDBjKskOZ4k
	 SRCrtzntYGgAAhG74HuCo9YXd6kUgK9+2LP3pLORfip+sYdRAnWBttNPETCxettND9
	 b8V1w/oxtTxnZPhea3NcoLFVTfDBC5rSxZSAtttupQHpWDSE6TbmNGeUZDKpgKswAR
	 KoHNAsME4oQUj6r6SktPeUFRBX6UiwFL1+ThLlbrlfosmQdfeHCAp98P3LRJcRX1nC
	 ox+lVzhOGxFeg==
Date: Tue, 25 Nov 2025 10:22:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, hch@infradead.org, bfoster@redhat.com, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] iomap: use loff_t for file positions and offsets
 in writeback code
Message-ID: <20251125-besang-heult-dd41b1419424@brauner>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
 <20251111193658.3495942-8-joannelkoong@gmail.com>
 <aR08JNZt4e8DNFwb@casper.infradead.org>
 <CAJnrk1Yby0ExKeGhSGxjHiYB9zA7z51V2iHdCjHLAn_Vox+x7g@mail.gmail.com>
 <20251119182750.GD196391@frogsfrogsfrogs>
 <CAJnrk1apaZmNyMGQ5ixfH8-10VL_aQAG8--3m-rUmB6-e-dtVQ@mail.gmail.com>
 <aR4cHCv0eabXywYU@casper.infradead.org>
 <CAJnrk1b+CEugwVReRqFBW91zGRzt0_LcF-Xw1AAdm1uEZAQqqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJnrk1b+CEugwVReRqFBW91zGRzt0_LcF-Xw1AAdm1uEZAQqqg@mail.gmail.com>

> Christian, could you please drop this patch from your iomap vfs tree?

Done.

