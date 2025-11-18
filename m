Return-Path: <linux-fsdevel+bounces-69023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23113C6BB18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4DAC4E7A3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 21:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA1330DEAE;
	Tue, 18 Nov 2025 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="dNYrkFIb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342230DD20;
	Tue, 18 Nov 2025 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500294; cv=pass; b=oUK37r2b9vnZ/YGPn/IbjNrO0W18wwwQdi/dIGD8+qADSteySai5HJaOehgfW1DLwg+eUvtFzlNndz51Ymih51PzYJiH21Rwtzi8Zfp8chZGKDmCIDRQVx/L2Gy53eFO057Lywp4FatPRGanFWU0wgr820p6eBTZlXT/dzBXlwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500294; c=relaxed/simple;
	bh=dAh/xxUCbeSb80riAMFMJlen4q76+fv57R5qkK4ILv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+FnpOQL2w8eo53WSbSA29qTIiUk0jBdFHslp7aTbHLf4lPE6kDNU7Lf1FIzKirs73aK6ssZImYvj6uxYUuXtKQSHXZwWqzm4bb2lt7Fvp0EnGgHqIRzr4BWekpdgDMmFOD5Fxcrlz3xr63+djcO5p4Pa7XvbALcl1Djs/4SaUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=dNYrkFIb; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5AD49162513;
	Tue, 18 Nov 2025 21:04:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.97.207.19])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D28F9162572;
	Tue, 18 Nov 2025 21:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763499865;
	b=fX1eurwp4fC2IV5EJj3UAHSeMguLdwKNpHfhTwGo5WP9NupnHiaIoRaglTapuYlJ82sB96
	RSs9I9IEWdnDbOlyLYw/025+7/3mApQcokLkUlQNgu5bEFbyQPNlSt+dp7Dv2WGSOccMJg
	qB98gzSZPir4frk6ErTCuvqgPHxvpmTjXpuHWI+UVxb7LkAvLdG/tB178FsR5cMbpoZYNl
	SRxzlpaMsuZ7voKQ9oCnWLHRE8q8RR9z3JXih7pfGFgK1bkrgKPeVPnXQ83rcbH/YA6MGw
	do5KdAGhQS55HMu+CuCqm9HYTNSJTIxj3gK+gFP8YGYYNh0A1gTu6fWjiISjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763499865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dAh/xxUCbeSb80riAMFMJlen4q76+fv57R5qkK4ILv8=;
	b=4cUlpak4ihfPBdBdFH2Dv47Q9O/fbwOqsC30bOp3yfzi+yoGFdzjRoT8ff1u6sqHIiyOOA
	O3dsFjVrBZZgmHjLjP1EIWDKuwyYRc7sWJZHpc9ur9UnAPA9v8Q1r0FnSxRb+9/VNjGIqm
	7bZChv/DoxihY0wx4X5NeNb3hYFnSVu/ut3tpa7WkaXaH0lPBgDLUpJmQ540fryWMZry9t
	NBFK5qbuhooBko8Ud1fpzoT0Ha2Rryz0SWRdXmZQbfE1mZ9w/Ne4UpYZfdi6D1umbFWNWJ
	a6ibxZeKO0RvS17aPLuUFBhw+ohsKWDZg2N15S4hvaQibNcjLh5hgBJfBQvhqw==
ARC-Authentication-Results: i=1;
	rspamd-5ffd6989c9-2grxv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Macabre: 78de108c665a9dc8_1763499866092_1553528019
X-MC-Loop-Signature: 1763499866092:2260034869
X-MC-Ingress-Time: 1763499866092
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.207.19 (trex/7.1.3);
	Tue, 18 Nov 2025 21:04:26 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4d9xtx2W4Qz107J;
	Tue, 18 Nov 2025 13:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1763499865;
	bh=dAh/xxUCbeSb80riAMFMJlen4q76+fv57R5qkK4ILv8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=dNYrkFIbLQomGte/KGkGpeqgnnR/Q5YDgBR3UQymi5iXGZYFzkJcHiD+ozxD17UKQ
	 pmKnHgEmtvy94r83cC4PjG0Oedhdk0AYaVMEEGlxV/N6VTIvt2yMZa+UpZOX7rFxLI
	 4AapTQoB1lwwT7+HrnW4Uu1i0v+c2Jr3Xy8jQHEXH2jlwP/hyvH7fAl8PTYxPrBXfM
	 3N0KMqoNwESArtjjPYHiWOUybUl413YuxShYdCLKJgYsxEXrNFlJ3nz6Ua2G7NzuMQ
	 V4Eys+ggwdNVGWR9hQ6YBu9fbor1WQq5bf6hTAreT0d42jkokrc7smSInz4jMwBt1p
	 DmzR2TsZKVsIw==
Date: Tue, 18 Nov 2025 13:04:22 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: dhowells@redhat.com, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watch_queue: Use local kmem in post_one_notification()
Message-ID: <20251118210422.f6js7cmtsn3dvdjx@offworld>
References: <20251118205517.1815431-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251118205517.1815431-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

On Tue, 18 Nov 2025, Davidlohr Bueso wrote:

>Replace the now deprecated kmem_atomic() with kmem_local_page().

heh spell checker fail.

Will send a v2 with s/kmem/kmap for the whole changelog, sorry for the noise.

