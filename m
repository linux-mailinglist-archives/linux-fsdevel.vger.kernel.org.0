Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3304B8C8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 16:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiBPPgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 10:36:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiBPPgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:36:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12E1D3B6
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 07:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645025782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKD/4070741hN0kwcqjX6GsS12MPocIQ6/ZtojeHEfM=;
        b=jTAO0gdF0DVvWHtookFdp/nueGhLCA/WSR70B9BqfaCYP4qMMvE8PJe8ZhBHyKLe6Ln5uw
        zo2XaieYPxZ7gm4rul8LGWMaA5uoPauXtPdhBPZnrGniVdW6PrBW7PdkBhI8HQtfdqsObP
        +d2c3F4E+QdnDBZk6QwhdkEPpiZLcIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-G7tII1sKPL-0BS8cLLkBVw-1; Wed, 16 Feb 2022 10:36:18 -0500
X-MC-Unique: G7tII1sKPL-0BS8cLLkBVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABCA01006AA3;
        Wed, 16 Feb 2022 15:36:17 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89EE7108647F;
        Wed, 16 Feb 2022 15:36:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E8B9522361A; Wed, 16 Feb 2022 10:36:16 -0500 (EST)
Date:   Wed, 16 Feb 2022 10:36:16 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] init: remove unused names parameter of split_fs_names()
Message-ID: <Yg0Z8AN5P+8oV11o@redhat.com>
References: <20220215070610.108967-1-jefflexu@linux.alibaba.com>
 <Ygv9qt4CEQ7P8/lD@redhat.com>
 <8343b195-b9d4-0501-d312-6ffdf382ff83@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8343b195-b9d4-0501-d312-6ffdf382ff83@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 09:32:33AM +0800, JeffleXu wrote:
> 
> 
> On 2/16/22 3:23 AM, Vivek Goyal wrote:
> > On Tue, Feb 15, 2022 at 03:06:10PM +0800, Jeffle Xu wrote:
> >> It is a trivial cleanup.
> >>
> > 
> > Would it be better to modify split_fs_names() instead and use
> > parameter "names" insted of directly using "root_fs_names".
> 
> Yes it can do. But currently split_fs_names() is only called by
> mount_block_root() and mount_nodev_root(), in which names argument is
> always root_fs_names. And split_fs_names() is declared as a static
> function in init/do_mounts.c.

Ok, fair enough. I am fine with this patch. I am not very particular
about using a parameter. Was just trying to avoid making use of
"root_fs_names" directly in functions because it makes it harder
to read the code. Anyway, not a big deal.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek
> 
> > 
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> ---
> >>  init/do_mounts.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/init/do_mounts.c b/init/do_mounts.c
> >> index 762b534978d9..15502d4ef249 100644
> >> --- a/init/do_mounts.c
> >> +++ b/init/do_mounts.c
> >> @@ -339,7 +339,7 @@ __setup("rootfstype=", fs_names_setup);
> >>  __setup("rootdelay=", root_delay_setup);
> >>  
> >>  /* This can return zero length strings. Caller should check */
> >> -static int __init split_fs_names(char *page, size_t size, char *names)
> >> +static int __init split_fs_names(char *page, size_t size)
> >>  {
> >>  	int count = 1;
> >>  	char *p = page;
> >> @@ -403,7 +403,7 @@ void __init mount_block_root(char *name, int flags)
> >>  	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
> >>  		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
> >>  	if (root_fs_names)
> >> -		num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
> >> +		num_fs = split_fs_names(fs_names, PAGE_SIZE);
> >>  	else
> >>  		num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
> >>  retry:
> >> @@ -546,7 +546,7 @@ static int __init mount_nodev_root(void)
> >>  	fs_names = (void *)__get_free_page(GFP_KERNEL);
> >>  	if (!fs_names)
> >>  		return -EINVAL;
> >> -	num_fs = split_fs_names(fs_names, PAGE_SIZE, root_fs_names);
> >> +	num_fs = split_fs_names(fs_names, PAGE_SIZE);
> >>  
> >>  	for (i = 0, fstype = fs_names; i < num_fs;
> >>  	     i++, fstype += strlen(fstype) + 1) {
> >> -- 
> >> 2.27.0
> >>
> 
> -- 
> Thanks,
> Jeffle
> 

