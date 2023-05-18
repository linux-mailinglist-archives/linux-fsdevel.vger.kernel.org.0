Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D9B7077D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 04:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjERCKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 22:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjERCKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 22:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967372D7D;
        Wed, 17 May 2023 19:10:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BF0564C39;
        Thu, 18 May 2023 02:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088CAC433D2;
        Thu, 18 May 2023 02:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684375839;
        bh=dlKZujqMvvKJ+zXADboUqt8HKe3rP64mtoCT6SjbC6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vut9oY3/uEDSHXakBDvrTsw1QJpb/bAK0R47BA3B3UoybpYIhwHSSvlve/fzGH40u
         1u1MlR9QnS7o9yE/azuIZ/EKmTzTO4Wmp+BcXbrgoWLzzewGs/Z/fJSjPUtK1aB6ib
         5gM9e/bQYEHqIGdRh0pLqfV3FXA+V2HpLcWdJiZQ=
Date:   Wed, 17 May 2023 19:10:38 -0700
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
Message-Id: <20230517191038.437a3750caa877cde58c054f@linux-foundation.org>
In-Reply-To: <f7b5aec9-f9e0-dd51-f9a0-c6af227537fd@huawei.com>
References: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
        <20230516063821.121844-9-wangkefeng.wang@huawei.com>
        <20230516152212.95f4a6ebba475cb994a4429f@linux-foundation.org>
        <f7b5aec9-f9e0-dd51-f9a0-c6af227537fd@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 May 2023 09:35:29 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> > We're irritatingly inconsistent about whether there's an underscore.
> > 
> > akpm:/usr/src/25> grep page_alloc mm/*c|wc -l
> > 49
> > akpm:/usr/src/25> grep pagealloc mm/*c|wc -l
> > 28
> 
> All the 28 pagealloc naming is from DEBUG_PAGEALLOC feature, they chould
> be changed to page_alloc except the cmdline, but it will lead to long
> function name and don't gain too much advantage, so keep unchange?

Sure, it's probably not the worst thing in there.  I was just having
a moan.
