Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B809705A86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjEPWWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 18:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEPWWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 18:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F1559DA;
        Tue, 16 May 2023 15:22:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E74963F85;
        Tue, 16 May 2023 22:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D852C433EF;
        Tue, 16 May 2023 22:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684275733;
        bh=EIdRYcyP9S+kTImEKsoJFXEN/e3jqvOkEEH/JnuSzco=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1oMgZuuxCVMi9e86xkru49WX/+FY8PSoo0tBvRgNNTI0VmrvS1f+nwBjGHgvSKZC1
         zYWcqZ6d9vYb/CAT23ciFEPMu7LfYRiwfR7dfUoWKy/SJXVP40Jrr7awZ14Gw60VD1
         u6Mg2ZpvWMIdMnGfJPVqFF13W5a/8QLsOMdjO58U=
Date:   Tue, 16 May 2023 15:22:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>
Subject: Re: [PATCH v2 08/13] mm: page_alloc: split out DEBUG_PAGEALLOC
Message-Id: <20230516152212.95f4a6ebba475cb994a4429f@linux-foundation.org>
In-Reply-To: <20230516063821.121844-9-wangkefeng.wang@huawei.com>
References: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
        <20230516063821.121844-9-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 16 May 2023 14:38:16 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> DEBUG_PAGEALLOC
>
>  mm/debug_page_alloc.c | 59 +++++++++++++++++++++++++++++++++
>  mm/page_alloc.c       | 69 ---------------------------------------

and

FAIL_PAGE_ALLOC

We're irritatingly inconsistent about whether there's an underscore.

akpm:/usr/src/25> grep page_alloc mm/*c|wc -l
49
akpm:/usr/src/25> grep pagealloc mm/*c|wc -l 
28

