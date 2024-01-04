Return-Path: <linux-fsdevel+bounces-7400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6A8246D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 18:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DDC1C22426
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2FC286BD;
	Thu,  4 Jan 2024 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K3Rgv7W7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t7RtALx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88E28699;
	Thu,  4 Jan 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A22F01F821;
	Thu,  4 Jan 2024 17:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704387859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ipK/226LRJDTM3FDOd68E2idK7q9JRqvu+4u/g3wH50=;
	b=K3Rgv7W7sta/rNDtR0eZIZmZNKZUs0KubO9/2GP3vpEH7iAUILQfJvyKtKMy6kd/voBYGU
	BgK5F8KgWvEAUx4gmMDTSX+gF09v9SZxutGU/aR8dqTee7V8PS/jkZ9U/flaNILNZC0EoL
	V5CaUtevifWroaAiZir/Abo2a+5JkNk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704387857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ipK/226LRJDTM3FDOd68E2idK7q9JRqvu+4u/g3wH50=;
	b=t7RtALx4OLAwYM1NSnnPIxj9u/urq88xoeMObBg2yBueCWbTplQCDwM9XjKaKTlCZNXWSb
	8UvcDmIESZxi2Pw4v1s1yqzQRAaW2t4k3Dss65JDw5QjtwUxXXp9gRl3D1T+jt99x7U8C4
	0fdzJJvtaZzf2609O9HT7+10cFgFQc8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 726B213722;
	Thu,  4 Jan 2024 17:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MsmyGxHllmWDaAAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Thu, 04 Jan 2024 17:04:17 +0000
Date: Thu, 4 Jan 2024 18:04:16 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, 
	alyssa@rosenzweig.io, asahi@lists.linux.dev, baolu.lu@linux.intel.com, 
	bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, iommu@lists.linux.dev, 
	jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org, 
	krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	lizefan.x@bytedance.com, marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com, 
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, will@kernel.org, 
	yu-cheng.yu@intel.com, rientjes@google.com
Subject: Re: [PATCH v3 00/10] IOMMU memory observability
Message-ID: <eng4vwaci5hwlicszgcld6uny55vll2bfs3vp2yjbjf3exhamg@zf6yc2uhax7w>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
 <eqkpplwwyeqqd356ka3g6isaoboe62zrii77krsb7zwzmvdusr@5i3lzfhpt2xe>
 <CA+CK2bBE1bQuqZy3cbWiv8V3vJ8YNJZRayp6Wv-j2_9i37XT4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22fntkpk3vilmqk6"
Content-Disposition: inline
In-Reply-To: <CA+CK2bBE1bQuqZy3cbWiv8V3vJ8YNJZRayp6Wv-j2_9i37XT4g@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.43
X-Spamd-Result: default: False [-1.43 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[soleen.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.03)[55.23%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[44];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[soleen.com:email];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,samsung.com,rosenzweig.io,lists.linux.dev,linux.intel.com,google.com,vger.kernel.org,lwn.net,redhat.com,infradead.org,cmpxchg.org,sntech.de,gmail.com,nvidia.com,8bytes.org,linaro.org,kvack.org,lists.infradead.org,bytedance.com,marcan.st,kernel.org,arm.com,sholland.org,amd.com,svenpeter.dev,csie.org,intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO


--22fntkpk3vilmqk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 04, 2024 at 11:29:43AM -0500, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> Thank you for taking a look at this. The two patches [1] [2] which add
> GFP_KERNEL_ACCOUNT were sent separate from this series at request of
> reviewers:

Ah, I didn't catch that.

Though, I mean the patch 02/10 calls iommu_alloc_pages() with GFP_KERNEL
(and not a passed gfp from iommu_map).
Then patch 09/10 accounts all iommu_alloc_pages() under NR_IOMMU_PAGES.

I think there is a difference between what's shown NR_IOMMU_PAGES and
what will have __GFP_ACCOUNT because of that.

I.e. is it the intention that this difference is not subject to
limiting?

(Note: I'm not familiar with iommu code and moreover I'm only looking at
the two patch sets, not the complete code applied. So you may correct my
reasoning.)


Thanks,
Michal

--22fntkpk3vilmqk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZZblDgAKCRAGvrMr/1gc
jiwfAQCSCpFQriEKwkEB8UUxOA9LFBhZfPl+l6lvTbTvghQXmQEAh2ukMdYInk9Z
KYebGDty+dxGKeNxW6aKFLuxo9UKywg=
=e+tC
-----END PGP SIGNATURE-----

--22fntkpk3vilmqk6--

