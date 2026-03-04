Return-Path: <linux-fsdevel+bounces-79314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHX4BSSZp2kCigAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 03:29:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8EE1F9E26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 03:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34579310C397
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 02:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E58329C66;
	Wed,  4 Mar 2026 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spjB+qe8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8C231A21;
	Wed,  4 Mar 2026 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772591329; cv=none; b=Nvt/dnmGxtSrA0EG/Rlhok2LXwYKmucBF7RMPWLMJvrMz06g5qI8d9hfF+66GnoFNvJep+48+FM9sd3GbmEo3exFMp2Ye/aHw8e3hQLGoronvWyyr/0QPLnPPbPNJu61qoS1iPL3+2S6a6GirS3RHb8ZRx6+SNCvFa3Py25ZAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772591329; c=relaxed/simple;
	bh=w0enNDJ6vj/GjKs1g6Qapybf69Y+ysKOpkctiG5RrpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQRAn0h3laXENu/bzGpGkiLJS7Dod+JVQu/ZL2zCdR9iPu6YW0WHP+KDWox8fPx5rzDLrFt/eqA0BNtuvkosiP9S8Y2U7LqQt4ClJ7y055E7lTi0f3v6F4NExcrcuw/0/bbWsfQnEz2yZ5lPsHiBuof/HmLqorwz9fLC0+IekyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spjB+qe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB983C116C6;
	Wed,  4 Mar 2026 02:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772591329;
	bh=w0enNDJ6vj/GjKs1g6Qapybf69Y+ysKOpkctiG5RrpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=spjB+qe83UoElqhhSNfGwtYNBZK6rgflA8nN48IzNFPIWPeUr3QRcXVdCtF1NJKnf
	 z5EksqVKhftC9MLC9j/7nGeIaaTR87yGm5Rwd8MxIRtsUMKdsilMMJ3Cd9iakxj8Bd
	 EH9ATACpJVqsf4PLZG7kLZaviIgPJnXRNiYRro7z9N/ZFYixQx9IlT7mTSxw717b7C
	 FtZrlDgcd81FIPR+0JhvBn0boDgv6oQAtRyqPocimgjFVPbqTR/7W2RrWO0jyc8Sw9
	 QZEusDhvc5/gFZA6KC6+NigNLVm6yl1rbhBl2iBivGRlsjsn6q5oZHNnRRI6Qq4pAT
	 NJF9zxNmgNh2w==
Date: Tue, 3 Mar 2026 18:28:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>, "Theodore
 Ts'o" <tytso@mit.edu>, Albert Ou <aou@eecs.berkeley.edu>, Alexander Duyck
 <alexanderduyck@fb.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Alexandra Winter
 <wintera@linux.ibm.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Anna Schumaker <anna@kernel.org>, Anton
 Yakovlev <anton.yakovlev@opensynergy.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov
 <bp@alien8.de>, Carlos Maiolino <cem@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Chao Yu <chao@kernel.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, Dominique
 Martinet <asmadeus@codewreck.org>, Dongsheng Yang
 <dongsheng.yang@linux.dev>, Eric Dumazet <edumazet@google.com>, Eric Van
 Hensbergen <ericvh@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>, Jaegeuk
 Kim <jaegeuk@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>,
 Jens Axboe <axboe@kernel.dk>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Latchesar Ionkov <lucho@ionkov.net>,
 Linus Walleij <linusw@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>, Namhyung Kim
 <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paolo Abeni
 <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Sean Christopherson <seanjc@google.com>, Simona
 Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner
 <tglx@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon
 <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, Zheng Gu
 <cengku@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 dm-devel@lists.linux.dev, netdev@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, v9fs@lists.linux.dev,
 virtualization@lists.linux.dev, linux-sound@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: globalize rest_of_page() macro
Message-ID: <20260303182845.250bb2de@kernel.org>
In-Reply-To: <20260304012717.201797-1-ynorov@nvidia.com>
References: <20260304012717.201797-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6A8EE1F9E26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,davemloft.net,redhat.com,mit.edu,eecs.berkeley.edu,fb.com,linux.ibm.com,zeniv.linux.org.uk,dilger.ca,lunn.ch,kernel.org,opensynergy.com,alien8.de,arm.com,linux.intel.com,gmail.com,codewreck.org,linux.dev,google.com,gondor.apana.org.au,perex.cz,kernel.dk,ionkov.net,ellerman.id.au,szeredi.hu,dabbelt.com,infradead.org,intel.com,ffwll.ch,suse.com,ursulin.net,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	TAGGED_FROM(0.00)[bounces-79314-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[85];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue,  3 Mar 2026 20:27:08 -0500 Yury Norov wrote:
> The net/9p networking driver has a handy macro to calculate the
> amount of bytes from a given pointer to the end of page. Move it
> to core/mm, and apply tree-wide. No functional changes intended.
> 
> This series was originally introduced as a single patch #07/12 in:
> 
> https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
> 
> Split it for better granularity and submit separately.

I don't get what the motivation is here. Another helper developers
and readers of the code will need to know about just to replace 
obvious and easy to comprehend math.

