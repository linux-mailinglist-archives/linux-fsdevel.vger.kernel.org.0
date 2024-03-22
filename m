Return-Path: <linux-fsdevel+bounces-15104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F763886FCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C983E1F22B87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FD56751;
	Fri, 22 Mar 2024 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="kldN/Bo0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YdxfEgCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF7F54BD3;
	Fri, 22 Mar 2024 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121123; cv=none; b=JyXPpUPp8nBo5PAJv0zX6NBdYzSZ7SQdPK1forlv2geRHdEir/k8WoW+UxjiUpQqAkDYCVnz3gQ1NYFUEbK4fGNUn2lfBmj9N36jtLclzB5WzdTolmEWfypjqTDBq21T2Enq1vee1JVWITILXj4m7FER6I8IVO1OF0OeFoW9H/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121123; c=relaxed/simple;
	bh=1X+jnJGNJJlRwE895VkKaLxZq0x6oHeflOxLmP1lLnA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UJlweqCAnVwThRpjfgyLCke+pHl8CMV2VYMSmbY/Y3rlnexmbtbCDJl4Ew8FZmYyPVMlbNVjwdRhcyeIA7FHnqTf0UKmDXGZHHLq7nQn5doy0l3Jdce1Mm1cVKXTqY/bF5P1xJm4Ef47ukokVa/BlqD2M6IsR/xnV6uERXcLuho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=kldN/Bo0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YdxfEgCQ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B778B1140172;
	Fri, 22 Mar 2024 11:25:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 22 Mar 2024 11:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1711121119; x=1711207519; bh=1X+jnJGNJJ
	lRwE895VkKaLxZq0x6oHeflOxLmP1lLnA=; b=kldN/Bo0gwIEsV42OSQSXvu1xe
	x72fbZBsbbdjf/1NuiLKCftcKwXsGva5LvBC58ppp1KR7lX57+1H5ufBk1TAN95t
	GJZBrJd+OQvrzGS7SDVTjtI5g4loD10b/mvxEGbWFMYzVtqXcOh7GIu45k0Sj0gz
	XhxVk1oqro+SZ9r+asbbHB0q+9lCyXRzQMsy1sSIsVsGdt2JMv7KwfZ8G8fNUEHi
	RHohUsRQrqDyDGn4n91wimbdTkNjDhJdKnWZfUOdgVFGjyQpxnZ/9hRTqeFdv3Xw
	PS4UQWR7sTVapYvF/j+1+TjWRVrIRvDnJ5u6cqPnVWM/3SllODb/bdy96Sdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1711121119; x=1711207519; bh=1X+jnJGNJJlRwE895VkKaLxZq0x6oHeflOx
	LmP1lLnA=; b=YdxfEgCQfuw1X8/VkWKrNCCyBd3OGuNKnTPxNEf7/2HOPYxF7Dh
	WdeCOPaNnYbNVQP9tW1iV3ssPnzi2KybLo6FtHZlKAllTs0e+AncNG/17dN4WIZv
	CDOt0e51sCEAjxUOnyF2iQ97mn+IcUYeMsLWdifcbTmuqUc/9GU274pWuc++GtQj
	SrQZdjRTGUsMJ6A45zOR6LlfZ2Je+OmSZVUwckSLx0zLDARjKSj8BqMahuv4gCkv
	CQI+2r5RCCn88ESze37jHtDfgJHHtVctkUJ3NhH+9Sjs7RxKPg6recrYO0XQ0+pJ
	PygSfJbpF8pI13Ww7CvNuTFB2Pp/u1AVPnQ==
X-ME-Sender: <xms:36L9ZZL9h4L6b59P10r0_3mIhssHBZYwQKOLCYXuXTAGItNk0k-yLQ>
    <xme:36L9ZVI_Rmj-9r62D3UWK_hXEEw2Zb3mMStQAiT5wUIkjjakfHDtsqMoxwUInv6A1
    8SK0YB3z5wiPL-t0ls>
X-ME-Received: <xmr:36L9ZRv6xPVCpNUvtGlfPe_oH3ivnKTmgGh43cBuJTkHZTWjRidP0JsPtlk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfhrhhomheplfhoshhhucfv
    rhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenucggtf
    frrghtthgvrhhnpeduvdelheettdfgvddvleegueefudegudevffekjeegffefvdeikeeh
    vdehleekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:36L9ZaYrWt38yFhqwPsEwDSsf7D4ZN3haXL65N2oZFieVBXnH1UMLw>
    <xmx:36L9ZQZ-568P2erZS1h-l9N3far0j6FeOIEjMhSO0Nwi-HBI4dw1jA>
    <xmx:36L9ZeCoOMPsMqxXagfiDaqpmYZ3I7IishD3mDyrWImodhRIaYUeFg>
    <xmx:36L9Zea49mdEK08n1ybdbd5JQD10nXNu4nZXSFXxyrZdj3w4d4ZAyw>
    <xmx:36L9ZXU-1IvgsJgRht9YeutHVXLJq-KBaFSYu31YOBRzvTMEqQIxLA>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 11:25:18 -0400 (EDT)
Date: Fri, 22 Mar 2024 15:25:16 +0000
From: Josh Triplett <josh@joshtriplett.org>
To: Alessio Balsini <balsini@android.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: FUSE passthrough after opening?
Message-ID: <Zf2i3MJrKRsp-fkZ@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm really happy to see the FUSE passthrough support merged!

I have a use case for which it'd be nice to start FUSE passthrough
some time after the initial open: I have a network-backed filesystem,
and in some cases I'd like to serve an initial request before retrieving
the full file. For instance, for a library .so file, I'd love to service
the initial 832-byte read while still downloading the full file.

Would it be possible to add support for transitioning an open FUSE file
to being backed by passthrough *after* the initial open? Could that work
with the current passthrough architecture? (I realize that this might be
more complex, as the initial open is a good time to directly substitute
a file from the underlying filesystem.)

Thanks,
Josh Triplett

