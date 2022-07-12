Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0CD570F71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 03:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiGLB1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 21:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiGLB1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9ABA8B493
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 18:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657589237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dJoHVsOF3Ns0hbojCVbv8KvE/Pi32b6Sl12+Q0qK9b4=;
        b=E98UpGBqyqGglXzH0hD0LyeKtfo7vVupuQfdnai5H02tEBMqQUzk4xIifApT+NMF67VgtB
        nql1t90AdKp98mfT4+amvnMo7aiqJvQjhRc+HrRuQyskPY82XzeJDZ9YTC6xYhX98jS48B
        6XXidNZsUlYVdbNxUJf2Rj9MKyHCLGE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-d6BUpj6FPxK4lPKnQ7Ting-1; Mon, 11 Jul 2022 21:27:14 -0400
X-MC-Unique: d6BUpj6FPxK4lPKnQ7Ting-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F2AF811E81;
        Tue, 12 Jul 2022 01:27:14 +0000 (UTC)
Received: from localhost (ovpn-12-173.pek2.redhat.com [10.72.12.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AF9340D282E;
        Tue, 12 Jul 2022 01:27:13 +0000 (UTC)
Date:   Tue, 12 Jul 2022 09:27:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v4] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <YszN7VTPBMVniIz9@MiWiFi-R3L-srv>
References: <20220712010055.2328111-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712010055.2328111-1-niejianglei2021@163.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/12/22 at 09:00am, Jianglei Nie wrote:
> elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> predefined value. If parse_crash_elf_headers() occurs some error and
                                                 ^ s/occurs/gets/
                                           occur is intransitive verb
> returns a negetive value, the elfcorehdr_addr should be released with
> elfcorehdr_free().
> 
> fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> fails.

  Fix it by calling elfcorehdr_free() when parse_crash_elf_headers()
fails.

Other than above log concerns, you can add my ack when repost:

Acked-by: Baoquan He <bhe@redhat.com>

Note:
- Please also add change history so that people know what's happening
  during reviewing. For this one, you can skip it.
- remember adding all people involved to CC.

> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  fs/proc/vmcore.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4eaeb645e759..390515c249dd 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1569,15 +1569,16 @@ static int __init vmcore_init(void)
>  	rc = parse_crash_elf_headers();
>  	if (rc) {
>  		pr_warn("Kdump: vmcore not initialized\n");
> -		return rc;
> +		goto fail;
>  	}
> -	elfcorehdr_free(elfcorehdr_addr);
>  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
>  
>  	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
>  	if (proc_vmcore)
>  		proc_vmcore->size = vmcore_size;
> -	return 0;
> +fail:
> +	elfcorehdr_free(elfcorehdr_addr);
> +	return rc;
>  }
>  fs_initcall(vmcore_init);
>  
> -- 
> 2.25.1
> 

