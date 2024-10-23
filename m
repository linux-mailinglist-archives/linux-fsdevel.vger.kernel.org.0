Return-Path: <linux-fsdevel+bounces-32639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C779ABBF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 04:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656A31F23636
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 02:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F687A13A;
	Wed, 23 Oct 2024 02:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="AqAoz48d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C384087C;
	Wed, 23 Oct 2024 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729652370; cv=none; b=u5bQOY5PbOZS71BMuut4TxcjgAoK3YxWQOK/jOLLYKwK9FPqTTsdAihfCmYl6YwXurE+Hwekwln4itQyRIcY5shUaWsupLjQotGY2K1oZZtvcvFPNeqmxudoiB1XpguMzwXhbGVcZYtNQBKKmZhRRUvhNy6692Bvok/UQdTFM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729652370; c=relaxed/simple;
	bh=Hm55JIIafmTzUEO8JWQJfwRvYyt+RY/+hRvVQZJoOJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtKuibHlP2647hPxlOVWYBOVAGJpzfCGsx97oRGHgdkT9PHCVVJqSdWcwWreQTSIA4/NASYKrPulbCqtPruykDwIySPTPjlMmT56JNRGhIvLmHUEUFsaxPrbLIJ7zdZLw8tCvXglQyORV55sUloWj3yim3ty8sbTuD0cLytIAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=AqAoz48d; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TTzAK06IbzaCuf3+XhM9A1yRCGYdNF1dw+CfbxtWmj0=; b=AqAoz48dnl4qMLA5c+GW30jmF/
	y4XwN6rToUpPoOuXrfezhXcBaUp4e8SgEAxdFC//acHZzu9U+CMWwwejKcp5G0SSrqX1eGP3fAKmA
	JX1oYUYrjJ6of8CsE8yCsS3HSsIcuq9LX1vIHQsj2Lvq1QbuwzGy4uMnhE7Xuxl2J9uVIiZico/dC
	ISbDAjOFbyowABYQV1jjs2udJg53tIFHbmFqKLqMqexQ0c1bn7NPw9qXUw+35FuVo+YP6JPdKk7Ui
	xcMvD3516AchJaLeUispoM8VbvqvYKkh4/V3FGel7Uh2pCYQ0p/6in/27NWAxlVShDKevZyphd03+
	VhbZnvng==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1t3RZm-00BPDm-1e;
	Wed, 23 Oct 2024 10:58:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Oct 2024 10:58:22 +0800
Date: Wed, 23 Oct 2024 10:58:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"surenb@google.com" <surenb@google.com>,
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>,
	"zanussi@kernel.org" <zanussi@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"bfoster@redhat.com" <bfoster@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [RFC PATCH v1 09/13] mm: zswap: Config variable to enable
 compress batching in zswap_store().
Message-ID: <ZxhmTmhfeQAEoCwS@gondor.apana.org.au>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-10-kanchana.p.sridhar@intel.com>
 <CAJD7tkbXTtG1UmQ7oPXoKUjT302a_LL4yhbQsMS6tDRG+vRNBg@mail.gmail.com>
 <SJ0PR11MB5678D24CDD8E5C8FF081D734C94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5678D24CDD8E5C8FF081D734C94D2@SJ0PR11MB5678.namprd11.prod.outlook.com>

On Wed, Oct 23, 2024 at 02:17:06AM +0000, Sridhar, Kanchana P wrote:
>
> Thanks Yosry, for the code review comments! This is a good point. The main
> consideration here was not to impact software compressors run on non-Intel
> platforms, and only incur the memory footprint cost of multiple
> acomp_req/buffers in "struct crypto_acomp_ctx" if there is IAA to reduce
> latency with parallel compressions.

I'm working on a batching mechanism for crypto_ahash interface,
where the requests are simply chained together and then submitted.

The same mechanism should work for crypto_acomp as well:

+       for (i = 0; i < num_mb; ++i) {
+               if (testmgr_alloc_buf(data[i].xbuf))
+                       goto out;
+
+               crypto_init_wait(&data[i].wait);
+
+               data[i].req = ahash_request_alloc(tfm, GFP_KERNEL);
+               if (!data[i].req) {
+                       pr_err("alg: hash: Failed to allocate request for %s\n",
+                              algo);
+                       goto out;
+               }
+
+               if (i)
+                       ahash_request_chain(data[i].req, data[0].req);
+               else
+                       ahash_reqchain_init(data[i].req, 0, crypto_req_done,
+                                           &data[i].wait);
+
+               sg_init_table(data[i].sg, XBUFSIZE);
+               for (j = 0; j < XBUFSIZE; j++) {
+                       sg_set_buf(data[i].sg + j, data[i].xbuf[j], PAGE_SIZE);
+                       memset(data[i].xbuf[j], 0xff, PAGE_SIZE);
+               }
+       }

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

