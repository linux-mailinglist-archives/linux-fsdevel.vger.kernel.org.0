Return-Path: <linux-fsdevel+bounces-38706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63675A06E3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E7B1888571
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 06:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E521E21421B;
	Thu,  9 Jan 2025 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b="pAeiMof+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRoZ2+FE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBE1FFC7F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736404179; cv=none; b=YL+rH21qGMRGievLpH6RyMdR3fJpa06qmkvi2kccrThqcOUKtu8AtsQ9Z+XwjVMmRjJkwhHDuXs7FBw2xwgKfzVBXldRw3wpbXEfhf1owOw3sm+T5vDxfISkqZ7mrXYiVnWWraNL5xaSH4o57TbILpnmijXwvBCWvNCTHu9BfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736404179; c=relaxed/simple;
	bh=4mVQmS4RZHvG4zhomheE2sKBKoMHYf1PhLTBbEqr5Fk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=m3QRxILArrLQtp9bWT9WjtGLlTxUAnbbD4A+ExTOMwNZNMIPuTy0E9HsELrxqLH7tSoEbat4t+zc/hCZVwR2vuzd/uQrarCYQx2E+tnf+TuJPJHH/ITMpXMPgfN871dYU5RNZ8BuXjkEdFydzub0bxbGkdMwnXKQdiDVPku4j6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io; spf=pass smtp.mailfrom=devkernel.io; dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b=pAeiMof+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRoZ2+FE; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devkernel.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6703D254014E;
	Thu,  9 Jan 2025 01:29:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 09 Jan 2025 01:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736404176; x=1736490576; bh=ZMjiqLnfBZ
	TWDx7xIn7ilq0br1Tm88oK/mnUP4PZ4z4=; b=pAeiMof+j0WbW88PCMTB/I8MJw
	6t6Rh//7NulpIJ7sPnOGWnY0htrsdLydY8IMRQZ4TBNdKGJUqJ9bMLluT6m6CI0z
	klBSSiZ6fs/mH8g8iMM1hs35pgH3/nBd1Co0rbgllimrbBVm/lZ47bGMHjtTjqI3
	QjYwssdiPsq/Mp3AcGZkQKkvJlUpnCKeQDt7LjKO5z7z+Q+6B+p4n9qdGVA3zm4Z
	rMPYHhHUOQRgr46B5NFVwtGRLPEGze1KSgKV93oi/brCJelblDDC01tpXMn75mWK
	vubtKPGcH59GklzWda0/Wq50mT9qdJX4698bL+Z0CmgJWGn4oNveMtXh/Yrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736404176; x=1736490576; bh=ZMjiqLnfBZTWDx7xIn7ilq0br1Tm88oK/mn
	UP4PZ4z4=; b=NRoZ2+FERc7au3YYpE4KDsEJrbMI8UCnafPph6p3UzbJLICUwmV
	9qWxBBCzXcvlBVXKHeJkS9SLr6XsD6BAx4Kir918YSt5z+7ED3PnOHMe8Ppo55Cj
	Zfw31IwfEZWXQ9a+uka1eQLMKYGpehCEml9RLLonP9mt0TN1cekTB3v01hRQ5MJ1
	67881WF9QmoYZGp4ZAEMb5NP98ytUgQ2CMGSQn+YkXGjszco/I3YuEThaQOlDdDC
	HUzcrT16KUIpfXoG7x+N/eLHuUzMIoZYYiJ5z7zwCdDcKVMOVUzAZNlNGkLa/cgc
	uZm14K3iCG/sYZlig113QrCnxmpd0QOyzSQ==
X-ME-Sender: <xms:z2x_Z8JRiT3Hlxd-aZyE2SwONaooTp69ybtG1y_hYG9W0vvNYQ1oSg>
    <xme:z2x_Z8I3unX6Cv9A4IpiCiUfIPPNUhzcb9hXu97AkQwcldwYMCHoeesqS6gVvmTGV
    beluV9CkEkXNT9t8Ew>
X-ME-Received: <xmr:z2x_Z8thmgg4lb8cvYsAK6eTUpYZqKZs3r8GhbzKCW7nG8ON3ZQf-T0vjH5jTPyVAsy7N4vaNxzgprpcuIlsYfgTh8apq60YRFU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertden
    ucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrd
    hioheqnecuggftrfgrthhtvghrnhepveelgffghfehudeitdehjeevhedthfetvdfhledu
    tedvgeeikeeggefgudeguedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihhopdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhfshguvghvvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehk
    vhgrtghkrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopeiiiihqqhdtuddtfedrhhgvhiesghhmrghilhdrtgho
    mhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    epuggrvhhiugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:z2x_Z5Zxn9PvLQk-VdjNZ_F0y8baTqumI5nE1iC6q8ScTfn5_AjFtg>
    <xmx:z2x_Zzble2FEKXpNwHcRL_AHQYIFEM3572dW4pBn9UeWRMREH_qwxQ>
    <xmx:z2x_Z1C4XXQ_OVzEXCPPQGNU3IJ-sBaEwfQe6jtuysyR89QZxIqipQ>
    <xmx:z2x_Z5br3HtBQrbpualOQdFgawV0pAaOSjYLphFIpTwJ7poKS9_0-w>
    <xmx:0Gx_Z4Or1inMiWiBJvmmu8Ly2De-wTn03DS0us7FAA6X-fIUot-Fop56>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 01:29:33 -0500 (EST)
References: <20250108014723.166637-1-shr@devkernel.io>
 <f85f46ac-9893-4b6b-89a4-f5b0d435886e@redhat.com>
User-agent: mu4e 1.10.3; emacs 29.4
From: Stefan Roesch <shr@devkernel.io>
To: David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, zzqq0103.hey@gmail.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix div by zero in bdi_ratio_from_pages
Date: Wed, 08 Jan 2025 22:28:06 -0800
In-reply-to: <f85f46ac-9893-4b6b-89a4-f5b0d435886e@redhat.com>
Message-ID: <87seps7b5f.fsf@devkernel.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


David Hildenbrand <david@redhat.com> writes:

...

>
> I would have done it slightly differently, something like:
>
>
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index d213ead956750..4b02f18f7d01f 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -685,13 +685,15 @@ static int bdi_check_pages_limit(unsigned long pages)
>         return 0;
>  }
>  -static unsigned long bdi_ratio_from_pages(unsigned long pages)
> +static long bdi_ratio_from_pages(unsigned long pages)
>  {
>         unsigned long background_thresh;
>         unsigned long dirty_thresh;
>         unsigned long ratio;
>           global_dirty_limits(&background_thresh, &dirty_thresh);
> +       if (!dirty_thresh)
> +               return -EINVAL;
>         ratio = div64_u64(pages * 100ULL * BDI_RATIO_SCALE, dirty_thresh);
>           return ratio;
> @@ -790,13 +792,15 @@ int bdi_set_min_bytes(struct backing_dev_info *bdi, u64 min_bytes)
>  {
>         int ret;
>         unsigned long pages = min_bytes >> PAGE_SHIFT;
> -       unsigned long min_ratio;
> +       long min_ratio;
>           ret = bdi_check_pages_limit(pages);
>         if (ret)
>                 return ret;
>           min_ratio = bdi_ratio_from_pages(pages);
> +       if (min_ratio < 0)
> +               return min_ratio;
>         return __bdi_set_min_ratio(bdi, min_ratio);
>  }
>  @@ -809,13 +813,15 @@ int bdi_set_max_bytes(struct backing_dev_info *bdi, u64
> max_bytes)
>  {
>         int ret;
>         unsigned long pages = max_bytes >> PAGE_SHIFT;
> -       unsigned long max_ratio;
> +       long max_ratio;
>           ret = bdi_check_pages_limit(pages);
>         if (ret)
>                 return ret;
>           max_ratio = bdi_ratio_from_pages(pages);
> +       if (min_ratio < 0)

I assume you meant max_ratio.


> +               return min_ratio;
>         return __bdi_set_max_ratio(bdi, max_ratio);
>  }
>  -- Cheers,
>

I'll use your recommendation for the next version of the patch.

