Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE98E6F3EA0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 09:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjEBH4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEBH4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 03:56:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEF430F9;
        Tue,  2 May 2023 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683014170; x=1714550170;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=nrkr4HYmMNERiR03z1fTM4+8ZBGmodVVyRAkn4iTZe4=;
  b=iA1CKD9QN/r5BedDyY96UN8tEqmADQ8p/7gWi0GV/hZg/dWYsvbDKHMq
   33vb2IpxrE1rAveWR9F7Z1IYquO5t65yUi9FLPwi9LRq3f06Sosy/sqoR
   a6+HAEYb/2sJC5u5rv4iUAuURiqvgxGYB4nMevSeNFn6gUsl6pxIZMVBF
   M1jkSVzwLlGtyBRb3TUyT9qHHp32yL9v+hHMAyERpTAN5q+0q8yDFxBHk
   Xo/es4qt5ZESY7ksYC9Z8pqSYfuuSxyWRlPzg7MjeRsEKnFGtDdb3ZGzd
   7rT9sPR44NwgT5PZGYcjIMbeQOX06tmfleBeXBPDeTc99TD6PKVof79XY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="332689690"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="332689690"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 00:56:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="807752489"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="807752489"
Received: from xinpan-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.35.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 00:55:50 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in
 string_get_size's output
In-Reply-To: <20230501165450.15352-2-surenb@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-2-surenb@google.com>
Date:   Tue, 02 May 2023 10:55:47 +0300
Message-ID: <877ctr2mm4.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 01 May 2023, Suren Baghdasaryan <surenb@google.com> wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> Previously, string_get_size() outputted a space between the number and
> the units, i.e.
>   9.88 MiB
>
> This changes it to
>   9.88MiB
>
> which allows it to be parsed correctly by the 'sort -h' command.

The former is easier for humans to parse, and that should be
preferred. 'sort -h' is supposed to compare "human readable numbers", so
arguably sort does not do its job here.

BR,
Jani.

>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Noralf Tr=C3=B8nnes" <noralf@tronnes.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  lib/string_helpers.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 230020a2e076..593b29fece32 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -126,8 +126,7 @@ void string_get_size(u64 size, u64 blk_size, const en=
um string_size_units units,
>  	else
>  		unit =3D units_str[units][i];
>=20=20
> -	snprintf(buf, len, "%u%s %s", (u32)size,
> -		 tmp, unit);
> +	snprintf(buf, len, "%u%s%s", (u32)size, tmp, unit);
>  }
>  EXPORT_SYMBOL(string_get_size);

--=20
Jani Nikula, Intel Open Source Graphics Center
