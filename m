Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FF2762B02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 07:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjGZF5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 01:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGZF5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2180726A2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 22:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690350996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cCdtovwVGt1zGQDulnNlAkJ36m7TNP783WWClrPi0Zk=;
        b=aYe/Eh6XNO9YR0OJaWpVHtSaByJfcBP4GcWr3sLpaAC3KF/RCKXHSxpyQkEYCBNLsMAwHj
        YnosqrvDgaj191spB5YeqyvHmE75aoO3ptuxePdGt3t1xFR3qzuwthykyX8SkvG5Rn1Jwz
        rgw+hDk+RGNI0F40v5VgU6+yufK8cmw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-680-95vf44wnPFeaXlb7Y-rxNw-1; Wed, 26 Jul 2023 01:56:34 -0400
X-MC-Unique: 95vf44wnPFeaXlb7Y-rxNw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85523830EFC;
        Wed, 26 Jul 2023 05:56:33 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D183246A3A7;
        Wed, 26 Jul 2023 05:56:32 +0000 (UTC)
Date:   Wed, 26 Jul 2023 13:56:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>, akpm@linux-foundation.org,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix signedness bug in read_from_oldmem()
Message-ID: <ZMC1jU7ywPGt1QmO@MiWiFi-R3L-srv>
References: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan,

On 07/25/23 at 08:03pm, Dan Carpenter wrote:
> The bug is the error handling:
> 
> 	if (tmp < nr_bytes) {
> 
> "tmp" can hold negative error codes but because "nr_bytes" is type
> size_t the negative error codes are treated as very high positive
> values (success).  Fix this by changing "nr_bytes" to type ssize_t.  The
> "nr_bytes" variable is used to store values between 1 and PAGE_SIZE and
> they can fit in ssize_t without any issue.
> 
> Fixes: 5d8de293c224 ("vmcore: convert copy_oldmem_page() to take an iov_iter")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/proc/vmcore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index cb80a7703d58..1fb213f379a5 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -132,7 +132,7 @@ ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
>  			 u64 *ppos, bool encrypted)
>  {
>  	unsigned long pfn, offset;
> -	size_t nr_bytes;
> +	ssize_t nr_bytes;
>  	ssize_t read = 0, tmp;
>  	int idx;

Thanks for this fix. Just curious, this is found out by code exploring,
or any breaking?

Acked-by: Baoquan He <bhe@redhat.com>

