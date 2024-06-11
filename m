Return-Path: <linux-fsdevel+bounces-21391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82490366D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206401C23C2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 08:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE4175543;
	Tue, 11 Jun 2024 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="osE7N0Wu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZOqPDh57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow1-smtp.messagingengine.com (wflow1-smtp.messagingengine.com [64.147.123.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533A172764;
	Tue, 11 Jun 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094507; cv=none; b=f+M+XkzO3Jc3+enS1o9u6nJSelzb45mEB0XjifF15mMp9+iqqokpjhEb5EyWPaoHvx5vxRRk5paxmIWGpRH655jl6O1zZgAAUn9bGDxhRvo8vN6+FdTd8MiVeZLxqykiwcvniz+uvglvPiN2P+PX1rbGWAcAopy2M2SR3EuPhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094507; c=relaxed/simple;
	bh=WlCLV+10vurnCj41WSYI9fw9oRJL9wgxuJfNi2U9UP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDAfADCdJ1dWulLVX1YgpZ5AZ66ACs1AfrExLF3sbG8CLUpPMOGeCM+AG/QcZ4jIkjs/4cWcTT8Vl8mlRtEMzrMSaeu1nB/04Wvu9zEeOdvTMNmu8lr46839CQGPM+uIgUd1W4+X8wwTRrCc+4npCdIVqCFN0feWkUwzIDnepjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=osE7N0Wu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZOqPDh57; arc=none smtp.client-ip=64.147.123.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id BAE8E2CC0168;
	Tue, 11 Jun 2024 04:28:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 04:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718094502; x=1718098102; bh=bQpdgobU82
	YWZriN3d7BiIoR2BmrlzIuuKqmODIu3NA=; b=osE7N0WuCRJ4jr/zq9XEthfsSB
	JaihG8TMRtsCQYH3e74lkFjSBml+3s1i0xShAwaaxUYVSMbjVGY3pBd6oD9V/xFA
	4EQhcALk8KlAvXfna0DVEdgCOAgwRrrT0U84FNNmYmgSoQ1eAYZB8pQIE+uKJZTL
	JBwCXT+3w99jaMOnc5iKeo4Xc/RT9DaxqEcwXKiDL8A31Xl2rs2eHq6cjafmsUko
	XdVeMrXsMNOYWXX2KVJ8fiRwhqHIWbiajSn5Ff0SlrUUq0vCVusalLSHryvxB/nE
	naWH9GSK8CH0p6CRpNRg3O95uOWQw0GrLj3Kq2JlsrDkuo0hMXXDxpOpe/EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718094502; x=1718098102; bh=bQpdgobU82YWZriN3d7BiIoR2Bmr
	lzIuuKqmODIu3NA=; b=ZOqPDh57FHfBZoeMW5VTOtiPNI5X6qPdO47jp8figGmz
	rQUBRMnwR8xaLGfRDS/mEc5jYRLplg98K4VVw6rd/IEyvLDiVhXi+d/6x2LpFnIt
	jKtQvuFLkQS7TXGAfFPv2l0Zvqcg38jpCgfK+HrE/ZvNuQMx2b2waDYQzPyAiHRf
	zwHElFx3sT7n/kv/GUbWI/KVZlR9UJrB++qghkJUqjqckGq7+ZzecK+mKPPJ8/dJ
	QLZCU9od/qU2AYLno3ZZXyuEm/cqRZ9+WIvA6ydTL/K/wx2E0OTp2UbklsAygM/Z
	lrbV70srVgC0egd6MnTWjINW3FB1/DBsBwa4DdwVYg==
X-ME-Sender: <xms:pgpoZvHNoVLJZbvLBBx9zFSFJzjc3tBW9UvbNLH_EEhz7hUrZ9eJYQ>
    <xme:pgpoZsVRDa5XD2bB9RpI24nGiyrXg-nm5rbo01f73VnNF46kAmDY4tAdomQp12gSc
    gcOQgNGh2G4X5djpn8>
X-ME-Received: <xmr:pgpoZhInH0L3g_lSzDHyFn_04fwDolaKCC-XKra6rrhvqOIupxIfTMIpiszoXDXEEtflWn32cYxoDR8u5AoKrwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtjeenucfhrhhomheplfhonhgr
    thhhrghnucevrghlmhgvlhhsuceojhgtrghlmhgvlhhsseefgiigtddrnhgvtheqnecugg
    ftrfgrthhtvghrnhepkeekteegfefgvdefgfefffeufeffjedvudeijeehjeehffekjeek
    leffueelgffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgtrghlmhgvlhhsseefgiigtddrnhgvth
X-ME-Proxy: <xmx:pgpoZtE62QlC7KH4a1-Foj7m6SuGeo1__iLpVx3kWrNlKBtZDBGEXw>
    <xmx:pgpoZlWVRQ_p8fUh5gFYj3sWLfDDqVe2tMDDZAU1gqBXHf7mYlnMMQ>
    <xmx:pgpoZoOPDeZrLcNPr8SiDMzORypHNbn-VXsYWGSfv1UBbph_1w1i6w>
    <xmx:pgpoZk1eF3x0f-nXXHLkc3aOXfnwdUUVFZsttwxxSOhu5TFpp2cacg>
    <xmx:pgpoZqUhWZIGf2kTk6xnb51pDwG2k0o0o69dvVdgwO0G37IIm-rtNfGI>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 04:28:18 -0400 (EDT)
Date: Tue, 11 Jun 2024 01:33:29 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: Josef Bacik <josef@toxicpanda.com>
Cc: brauner@kernel.org, ebiederm@xmission.com,
 	Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
 	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 	KP Singh <kpsingh@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 	Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 	Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 	Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, 	Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>, 	Joel Granados <j.granados@samsung.com>,
 John Johansen <john.johansen@canonical.com>,
 	David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 	Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, 	Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, containers@lists.linux.dev,
 	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, apparmor@lists.ubuntu.com,
 	keyrings@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Introduce user namespace capabilities
Message-ID: <tqvnpbrdmfj3q7rc2m365nxvwgb6hsvipiz7l473cdwyacdb6s@b22nvrk7vbok>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240610201227.GD235772@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240610201227.GD235772@perftesting>

On Mon, Jun 10, 2024 at 04:12:27PM GMT, Josef Bacik wrote:
> Where are the tests for this patchset?  I see you updated the bpf tests for the
> bpf lsm bits, but there's nothing to validate this new behavior or exercise the
> new ioctl you've added.  Thanks,

Apologies, I haven't had much time to spend on it so I prioritized the
rest. But yes, we should certainly update the capabilities selftests
once we agreed on the different behaviors.

