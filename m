Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FDC570F30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 03:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiGLBGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 21:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiGLBGl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91FB425C42
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 18:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657587999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=huHQ7wQGcrutWiJlcJnxnWvbU6uKiCOCZmwib/4pnSM=;
        b=JPtSrNNmo9CjBAbPYXTzkim9DigQqV3fmsbkO2K386tfy1xoZ2+gQTzC7WLS20mWTC1cR3
        DDmJkunL/YRQvKLsxyEnyZQ+lzvXddu3Q+rVHTpgyGA+F3emdTVF15/rZJSzica9bpW6I0
        AmkC16jSOetVCzR3d55jbbolWnZkxig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-FZlhS81rNiaxZ4ASu3Y23A-1; Mon, 11 Jul 2022 21:06:34 -0400
X-MC-Unique: FZlhS81rNiaxZ4ASu3Y23A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F3718041BE;
        Tue, 12 Jul 2022 01:06:34 +0000 (UTC)
Received: from localhost (ovpn-12-173.pek2.redhat.com [10.72.12.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CCB340D2827;
        Tue, 12 Jul 2022 01:06:32 +0000 (UTC)
Date:   Tue, 12 Jul 2022 09:06:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jianglei Nie <niejianglei2021@163.com>, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <YszJFi+deSIXK3ns@MiWiFi-R3L-srv>
References: <20220711073449.2319585-1-niejianglei2021@163.com>
 <YsvWHwrltqqAb12h@MiWiFi-R3L-srv>
 <YswVHNQX+OGz6IaQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YswVHNQX+OGz6IaQ@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/11/22 at 01:18pm, Matthew Wilcox wrote:
> On Mon, Jul 11, 2022 at 03:49:51PM +0800, Baoquan He wrote:
> > On 07/11/22 at 03:34pm, Jianglei Nie wrote:
> > > elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> > > kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> > > predefined value. If parse_crash_elf_headers() occurs some error and
> > > returns a negetive value, the elfcorehdr_addr should be released with
> > > elfcorehdr_free().
> > > 
> > > We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> > > fails.
> > > 
> > > Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> > > ---
> > >  fs/proc/vmcore.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > > index 4eaeb645e759..125efe63f281 100644
> > > --- a/fs/proc/vmcore.c
> > > +++ b/fs/proc/vmcore.c
> > > @@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
> > >  	rc = parse_crash_elf_headers();
> > >  	if (rc) {
> > >  		pr_warn("Kdump: vmcore not initialized\n");
> > > -		return rc;
> > > +		goto fail;
> > 
> > Sigh. Why don't you copy my suggested code directly?
> 
> I think at this point, you should just submit your own patch
> and credit this person with Reported-by:

Thanks for telling. I will consider doing this in the future.

