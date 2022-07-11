Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CC5701DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 14:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiGKMSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 08:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGKMSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:18:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3274DA8;
        Mon, 11 Jul 2022 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PWKdgytGuJS/GqF7wkUB921LDsDRCbl9WqcuwqS4VyU=; b=WLBkkmsbL8JR/wP9knKzTxAJfu
        zgidLq04zQgTBURaH79ibOAB22d4EsQ4Bn7bPht4FFI6EFzIdXcuYGlbs7EFFAYnux/beYf/Itsor
        SdTXk/wJ9u8qT3cg5LSuaJ//YbNjdesxvxujy7rGIxjHLj+kft15iP8xYhVEpoud7awjayUdX3Ukk
        3nfaf5zL8hmCUNb3uHbPhEd2fMz57lYDqjU8SSYxjvMeTECWxdif2FL9ylYAwbpN3/RpHj2rsBxJ5
        JRAYco9YpARjcDLsprngrurBdRSY82Z9dqla/E6KhYGU48ZJCYkB+9z4UqW1p4S98pIOUx9ikOm8S
        K/PPxyXA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAsN2-005waR-QO; Mon, 11 Jul 2022 12:18:36 +0000
Date:   Mon, 11 Jul 2022 13:18:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Jianglei Nie <niejianglei2021@163.com>, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <YswVHNQX+OGz6IaQ@casper.infradead.org>
References: <20220711073449.2319585-1-niejianglei2021@163.com>
 <YsvWHwrltqqAb12h@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsvWHwrltqqAb12h@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 11, 2022 at 03:49:51PM +0800, Baoquan He wrote:
> On 07/11/22 at 03:34pm, Jianglei Nie wrote:
> > elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> > kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> > predefined value. If parse_crash_elf_headers() occurs some error and
> > returns a negetive value, the elfcorehdr_addr should be released with
> > elfcorehdr_free().
> > 
> > We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> > fails.
> > 
> > Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> > ---
> >  fs/proc/vmcore.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 4eaeb645e759..125efe63f281 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
> >  	rc = parse_crash_elf_headers();
> >  	if (rc) {
> >  		pr_warn("Kdump: vmcore not initialized\n");
> > -		return rc;
> > +		goto fail;
> 
> Sigh. Why don't you copy my suggested code directly?

I think at this point, you should just submit your own patch
and credit this person with Reported-by:
