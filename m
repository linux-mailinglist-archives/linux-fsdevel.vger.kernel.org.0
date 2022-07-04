Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D8F564BEC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 04:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiGDCyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 22:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDCyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A1C62C3
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jul 2022 19:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656903253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1P+Z0NPfnwQi7DbmZ8kWxij8Re3KK3gRyK0ayDPLp8E=;
        b=T1xAs8pJc5Qv0naTGv4d63gmf5DdJnZg1KaX8px7wZZF0S6GCSBviXCWaqRWEkp/5b/kxr
        oyvMjSmI+m0eq1DYfxvm5QdXpsX/M+1pFsxkVUMWLR6b/egKdyu7Syf868MAPrwCnwKu0U
        FoBekHW0PaOmBUXPON6dIDbLtfzFHfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-3Y-jYpWXPkaCqKBkgi_BZA-1; Sun, 03 Jul 2022 22:54:10 -0400
X-MC-Unique: 3Y-jYpWXPkaCqKBkgi_BZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B27A185A7B2;
        Mon,  4 Jul 2022 02:54:09 +0000 (UTC)
Received: from localhost (ovpn-13-121.pek2.redhat.com [10.72.13.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C36A1400DFD0;
        Mon,  4 Jul 2022 02:54:08 +0000 (UTC)
Date:   Mon, 4 Jul 2022 10:54:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] proc/vmcore: fix potential memory leak in vmcore_init()
Message-ID: <YsJWTT71QAfTef5N@MiWiFi-R3L-srv>
References: <20220629165216.2161430-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629165216.2161430-1-niejianglei2021@163.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/30/22 at 12:52am, Jianglei Nie wrote:
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
>  fs/proc/vmcore.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4eaeb645e759..7e028cd1e59d 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1568,6 +1568,7 @@ static int __init vmcore_init(void)
>  		return rc;
>  	rc = parse_crash_elf_headers();
>  	if (rc) {
> +		elfcorehdr_free(elfcorehdr_addr);
>  		pr_warn("Kdump: vmcore not initialized\n");
>  		return rc;

Guess it's found by code inspecting since if vmcore_init() failed, kdump
kernel won't do anyting meaningful and reboot, then nobody notice or
care about this leak.

If so, is this better?

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7e028cd1e59d..ea2f44d77786 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1568,16 +1568,16 @@ static int __init vmcore_init(void)
 		return rc;
 	rc = parse_crash_elf_headers();
 	if (rc) {
-		elfcorehdr_free(elfcorehdr_addr);
 		pr_warn("Kdump: vmcore not initialized\n");
-		return rc;
+		goto fail;
 	}
-	elfcorehdr_free(elfcorehdr_addr);
 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
 
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;
+fail:
+	elfcorehdr_free(elfcorehdr_addr);
 	return 0;
 }
 fs_initcall(vmcore_init);

>  	}
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

