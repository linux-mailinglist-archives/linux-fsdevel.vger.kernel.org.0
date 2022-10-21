Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BAC6081A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Oct 2022 00:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiJUWcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 18:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJUWcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:32:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A972AD303;
        Fri, 21 Oct 2022 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EhLw+OP+FE0NeXoi3BoUpy1E+bq1XnpQzq5iHUM5IX0=; b=qFbw19MdbE4sn1D1jt7fhiTDR+
        BAsjtTxzrY/b43YRTak1rnzFbtSDGfaIsYOzdxaA0j93wDF/QEpSPYYo2AQ+Mqkm+28sC1vzhF1W2
        3xnYW4bjvVQ4zz5LkLUwnfYmw/0WsQXfhRC5Le9zhxZVePcFvyK4I9LREsgErUawpz24aohVq1DD9
        e8CjzTSTpviPQm0Osj86G8CTltuwIPexVLBWZNk2Sayd/EFX4Sm+ASEsoIQWpbv6+jtxOhWD1l8Bm
        NhUtc4YjPDfQ45AYs9rR8vlHO5xPvoiBJeebIBMVi/KL5aan2jv0O4We22dS8dRHVtjd0HnwsH5uW
        PwtsMyyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1om0YN-00DSs6-1b; Fri, 21 Oct 2022 22:31:47 +0000
Date:   Fri, 21 Oct 2022 23:31:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Pulavarty, Badari" <badari.pulavarty@intel.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "huangzhaoyang@gmail.com" <huangzhaoyang@gmail.com>,
        "ke.wang@unisoc.com" <ke.wang@unisoc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "inux-kernel@vger.kernel.org" <inux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "zhaoyang.huang@unisoc.com" <zhaoyang.huang@unisoc.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <Y1Md0hzhkqzik/WA@casper.infradead.org>
References: <DM6PR11MB3978E31FE5149BA89D371E079C2D9@DM6PR11MB3978.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3978E31FE5149BA89D371E079C2D9@DM6PR11MB3978.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 21, 2022 at 09:37:36PM +0000, Pulavarty, Badari wrote:
> I have been tracking similar issue(s) with soft lockup or panics on my system consistently with my workload.
> Tried multiple kernel versions. Issue seem to happen consistently on 6.1-rc1 (while it seem to happen on 5.17, 5.19, 6.0.X)
> 
> PANIC: "Kernel panic - not syncing: softlockup: hung tasks"
> 
>     RIP: 0000000000000001  RSP: ff3d8e7f0d9978ea  RFLAGS: ff3d8e7f0d9978e8
>     RAX: 0000000000000000  RBX: 0000000000000000  RCX: 0000000000000000
>     RDX: 000000006b9c66f1  RSI: ff506ca15ff33c20  RDI: 0000000000000000
>     RBP: ffffffff84bc64cc   R8: ff3d8e412cabdff0   R9: ffffffff84c00e8b
>     R10: ff506ca15ff33b69  R11: 0000000000000000  R12: ff506ca15ff33b58
>     R13: ffffffff84bc79a3  R14: ff506ca15ff33b38  R15: 0000000000000000
>     ORIG_RAX: ff506ca15ff33a80  CS: ff506ca15ff33c78  SS: 0000
> #9 [ff506ca15ff33c18] xas_load at ffffffff84b49a7f
> #10 [ff506ca15ff33c28] __filemap_get_folio at ffffffff840985da
> #11 [ff506ca15ff33ce8] swap_cache_get_folio at ffffffff841119db

Oh, this is interesting.  It's the swapper address_space.
I bet that 0xffffffff85044560 (the value of a_ops) is the address of
swap_ops in your kernel?

I don't know if it will help, but it's an interesting data point.

> Looking at the crash dump, mapping->host became NULL. Not sure what exactly is happening.

That's always true for the swapper_spaces, AIUI.

>   a_ops = 0xffffffff85044560,
