Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6311656D70A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 09:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiGKHuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 03:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiGKHuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 694311C118
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657525799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=65+qN8d8sGZSpzbvLfg3emL2uyMu+GmRHRjSzDdv/js=;
        b=QFyTurqFtEsvJjnK1CbC6ZhjRjwqL8tPlAp81D3sS1IoeLQdIjriY6BAtysnoRcnoV8Wtu
        uUinDMH3TjHWJ1tOAQl0cCS1V0pVVtt8FvHGxml4uryavd5fg2eGRTNMRyXGv23teDC9l0
        1nRRpSCQcJO6fQ5bcEKC0l3akjmO+SI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-PcKH02_GNmyyAY5EzywamA-1; Mon, 11 Jul 2022 03:49:55 -0400
X-MC-Unique: PcKH02_GNmyyAY5EzywamA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D5D6804197;
        Mon, 11 Jul 2022 07:49:55 +0000 (UTC)
Received: from localhost (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0E9140CF8EA;
        Mon, 11 Jul 2022 07:49:54 +0000 (UTC)
Date:   Mon, 11 Jul 2022 15:49:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <YsvWHwrltqqAb12h@MiWiFi-R3L-srv>
References: <20220711073449.2319585-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711073449.2319585-1-niejianglei2021@163.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/11/22 at 03:34pm, Jianglei Nie wrote:
> elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> predefined value. If parse_crash_elf_headers() occurs some error and
> returns a negetive value, the elfcorehdr_addr should be released with
> elfcorehdr_free().
> 
> We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> fails.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  fs/proc/vmcore.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4eaeb645e759..125efe63f281 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
>  	rc = parse_crash_elf_headers();
>  	if (rc) {
>  		pr_warn("Kdump: vmcore not initialized\n");
> -		return rc;
> +		goto fail;

Sigh. Why don't you copy my suggested code directly?

>  	}
>  	elfcorehdr_free(elfcorehdr_addr);

Remove above line.

>  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
> @@ -1578,6 +1578,9 @@ static int __init vmcore_init(void)
>  	if (proc_vmcore)
>  		proc_vmcore->size = vmcore_size;
>  	return 0;

Remove above line too.

> +fail:
> +	elfcorehdr_free(elfcorehdr_addr);
> +	return rc;
>  }
>  fs_initcall(vmcore_init);
>  
> -- 
> 2.25.1
> 

