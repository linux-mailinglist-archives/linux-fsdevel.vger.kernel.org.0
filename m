Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97347654722
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 21:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLVU3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 15:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLVU3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:29:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74EE20BC6;
        Thu, 22 Dec 2022 12:29:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84663B81F57;
        Thu, 22 Dec 2022 20:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF61AC433D2;
        Thu, 22 Dec 2022 20:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671740979;
        bh=78+XeTaO6EMlC2xgXSJtYAPRNZoQKpOoT72uxN9IWGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xyQfmfqHleLWQeqi0qk3kyOaphPCaS5qie4t74lALvgAZ+RJZDhcSgk0Rjt0Luol2
         SgQmFBqK2/nkThRXODkH/0mB2/KFmBSg+30Gw6lQ9wgSx+RCx0KHuOZ7B2gY/iOvWw
         mQfP7+bj3hW/aKupheNg6Oj0RhjLn/V0cXLnJp5Q=
Date:   Thu, 22 Dec 2022 12:29:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Yuanchu Xie <yuanchu@google.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: add vma_has_locality()
Message-Id: <20221222122937.06b9e9f3765e287b91b14954@linux-foundation.org>
In-Reply-To: <CAOUHufZpbfTCeqteEZt5k-kFZh3-++Gm0Wnc0-O=RFT-K9kzkw@mail.gmail.com>
References: <20221222061341.381903-1-yuanchu@google.com>
        <20221222104937.795d2a134ac59c8244d9912c@linux-foundation.org>
        <CAOUHufZpbfTCeqteEZt5k-kFZh3-++Gm0Wnc0-O=RFT-K9kzkw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 22 Dec 2022 12:44:35 -0700 Yu Zhao <yuzhao@google.com> wrote:

> On Thu, Dec 22, 2022 at 11:49 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 21 Dec 2022 22:13:40 -0800 Yuanchu Xie <yuanchu@google.com> wrote:
> >
> > > From: Yu Zhao <yuzhao@google.com>
> 
> This works; suggested-by probably works even better, since I didn't do
> the follow-up work.
> 
> > > Currently in vm_flags in vm_area_struct, both VM_SEQ_READ and
> > > VM_RAND_READ indicate a lack of locality in accesses to the vma. Some
> > > places that check for locality are missing one of them. We add
> > > vma_has_locality to replace the existing locality checks for clarity.
> >
> > I'm all confused.  Surely VM_SEQ_READ implies locality and VM_RAND_READ
> > indicates no-locality?
> 
> Spatially, yes. But we focus more on the temporal criteria here, i.e.,
> the reuse of an area within a relatively small duration. Both the
> active/inactive LRU and MGLRU rely on this.

Oh.  Why didn't it say that ;)

How about s/locality/recency/g?


