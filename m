Return-Path: <linux-fsdevel+bounces-8471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA188371B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 20:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1423129583A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE245A79E;
	Mon, 22 Jan 2024 18:41:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69124B5B5;
	Mon, 22 Jan 2024 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948913; cv=none; b=YqskDjFbAsvUlm1xALrBWOxyHAeDQrz1BvSeIbH70zHKMuAUTXXRhkVPb+w5fcZVft7ryG5T5sPGe6mOK6uTKSPWyTie4IDQ2i7zgBj0BSe3W7WyYXP3svbeXWqtZJSxa/8x7Ta6FW7u9RWrGTrptuDeM4q42BhHYWKFp4qkHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948913; c=relaxed/simple;
	bh=uO0KeictCoIcP9I2MTCYiGiqrjOqOts/+4YsOwRdg/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DflUudxrIl+KD7JIVlw/076WHsS4QL5bg4nmlzBUri7W3guq3eul9SmTrIvuBVCVr86LV0SjTWtLQCIFtpsub5JgN0q6VFtc9JkNrW6B/J+VOhm4XrbfHHbc4gyGWSKRHfaQ5QTtrUpYIatQg9jDzKvbg2I9zA02U6fuFe29yHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E096C68CFE; Mon, 22 Jan 2024 19:41:47 +0100 (CET)
Date: Mon, 22 Jan 2024 19:41:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, bfoster@redhat.com,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix incorrect usage of REQ_OP_FLUSH
Message-ID: <20240122184147.GA7072@lst.de>
References: <20240111073655.2095423-1-hch@lst.de> <ueeqal442uw77vrmonr5crix5jehetzg266725shaqi2oim6h7@4q4tlcm2y6k7> <20240122063007.GA23991@lst.de> <eyyg26ls45xqdyjrvowm7hfusfr7ezr3pjve6ojikg4znys6dx@rd2ugzmo44r4> <20240122065038.GA24601@lst.de> <3cs7zhkf3gz7fmytpxqjvstr6oegvhy3ehwu3mzomfllvjqlmc@yaq6ophbgbfr> <20240122173809.GA5676@lst.de> <6jhgnewkmex25jgtw2s3fifyyje4w3yja2exdrnx2vesk6bp5w@gysfpght3cbo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6jhgnewkmex25jgtw2s3fifyyje4w3yja2exdrnx2vesk6bp5w@gysfpght3cbo>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 22, 2024 at 12:42:24PM -0500, Kent Overstreet wrote:
> updating my tests for the MD_FAULTY removal, then will do. Is there
> anything you want me to look for?

Nothing fancy.  Just that you do data integrity operations and do
not see an error.

> considering most tests won't break or won't clearly break if flush/fua
> is being dropped (even generic/388 was passing reliably, of course,
> since virtual block devices aren't going to reorder writes...) maybe we
> could do some print statement sanity checking...

Well, xfstests is not very good about power fail testing, because it
can't inject a power fail..  Which is a problem in it's own, but
would need hardware power failing or at least some pretty good VM
emulation of the same outside the scope of the actual xfstests runner.

But basically what this patch needs is just seeing that you don't
get I/O errors on anything that flushes, which on currently mainline
without the patch you should be seeing.

