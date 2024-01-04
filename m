Return-Path: <linux-fsdevel+bounces-7389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8355E8244FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6F728753D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A860724218;
	Thu,  4 Jan 2024 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pae+nnL8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d4W1wAY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573FE241E4;
	Thu,  4 Jan 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBE9822090;
	Thu,  4 Jan 2024 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704382280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzC23ESDAqjrYsUUWU3jTenMnuzE0UYEATU9SXb7+hA=;
	b=Pae+nnL8GFn/90/6MVvjWD52MleXZMEQSfyVMqUsSKCAAx6kTTQ7y/fR66ckCQIKBeUAWK
	ZfkewmROo/43t3zJCXwA4wYyzrHCpas+/WrNiHncgarksTqf+Lw1E9AYw5YalW31ApoY+p
	y/Ok7gnLnUEo3mCXBRa4HaaMb+5GVtI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704382279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzC23ESDAqjrYsUUWU3jTenMnuzE0UYEATU9SXb7+hA=;
	b=d4W1wAY3OJtJtth1XCzoTR7umctbQgU0lYLtet8VnS+QUeM0A3AJQV+WHXCTfVtktmNHnL
	9d5K3STBwSK115bhRlI9joaJ/AMggRm/BXcBxrrEBrOVb2hmKluJ3nUltLD//+znrx279P
	D3ebRpFcyuqMyw7qj9a8bYKRWfjXt9Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11D3A13722;
	Thu,  4 Jan 2024 15:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cw50A0fPlmUBUAAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Thu, 04 Jan 2024 15:31:19 +0000
Date: Thu, 4 Jan 2024 16:31:17 +0100
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
Message-ID: <eqkpplwwyeqqd356ka3g6isaoboe62zrii77krsb7zwzmvdusr@5i3lzfhpt2xe>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3miwvahtspdiywqu"
Content-Disposition: inline
In-Reply-To: <20231226200205.562565-1-pasha.tatashin@soleen.com>
X-Spam-Level: 
X-Spam-Level: 
X-Spam-Score: -0.42
X-Rspamd-Queue-Id: CBE9822090
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=d4W1wAY3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.42 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:dkim,soleen.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 BAYES_HAM(-0.01)[51.19%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[44];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,samsung.com,rosenzweig.io,lists.linux.dev,linux.intel.com,google.com,vger.kernel.org,lwn.net,redhat.com,infradead.org,cmpxchg.org,sntech.de,gmail.com,nvidia.com,8bytes.org,linaro.org,kvack.org,lists.infradead.org,bytedance.com,marcan.st,kernel.org,arm.com,sholland.org,amd.com,svenpeter.dev,csie.org,intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]


--3miwvahtspdiywqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Tue, Dec 26, 2023 at 08:01:55PM +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> This patch series solves this problem by adding both observability to
> all pages that are allocated by IOMMU, and also accountability, so
> admins can limit the amount if via cgroups.

Maybe this is a mismatch in vocabulary what you mean by the verb
"limit". But I don't see in the patchset that the offending pages would
be allocated with GFP_ACCOUNT. So the result is that the pages are
accounted (you can view the amount in memory.stat) but they are not
subject to memcg limits.

Is that what you intend?


Regards,
Michal

--3miwvahtspdiywqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZZbPOgAKCRAGvrMr/1gc
jk4WAQCSVaG9CWTytNlHm4t/CSbpxTWFYWcybzn/jqIJ0y0DDgEA0/XJAjN4NyF+
F6HbClZ0bzyKHY2eGvX2UwXRtcfFPQM=
=GWPV
-----END PGP SIGNATURE-----

--3miwvahtspdiywqu--

