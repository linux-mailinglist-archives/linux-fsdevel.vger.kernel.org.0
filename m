Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40F356B48D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 10:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbiGHIey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbiGHIex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4BA312615
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 01:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657269292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OP4X7LUwgicK2Z8iBMF1E87pgvSh5qnsKOoxYGUrQZE=;
        b=WTXE9QpcWj/4hSJCuvEnauYTvICvnfumdBI0KEsZSuJuHWIZg+M6+eFxGdVZrl4u7wOMdg
        3Kyzugz4dK+gVYAV6wMa6ZzFWpDiDOMrqSg7VjEFY/FFRxv67m+zKdDdyEK1ttlS8C2Anh
        V5OVwB+alVKQPytupjiDcqbEg9bAmxM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-YLkXHmJ7MkK83y7yYijfCw-1; Fri, 08 Jul 2022 04:34:48 -0400
X-MC-Unique: YLkXHmJ7MkK83y7yYijfCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C18123C0ED4C;
        Fri,  8 Jul 2022 08:34:47 +0000 (UTC)
Received: from localhost (ovpn-12-169.pek2.redhat.com [10.72.12.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17E662166B26;
        Fri,  8 Jul 2022 08:34:46 +0000 (UTC)
Date:   Fri, 8 Jul 2022 16:34:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jianglei Nie <niejianglei2021@163.com>, akpm@linux-foundation.org
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <YsfsIzjmhR5VQU3N@MiWiFi-R3L-srv>
References: <20220704081839.2232996-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704081839.2232996-1-niejianglei2021@163.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/04/22 at 04:18pm, Jianglei Nie wrote:
> elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> predefined value. If parse_crash_elf_headers() occurs some error and
> returns a negetive value, the elfcorehdr_addr should be released with
> elfcorehdr_free().
> 
> We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> fails.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  fs/proc/vmcore.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4eaeb645e759..86887bd90263 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
>  	rc = parse_crash_elf_headers();
>  	if (rc) {
>  		pr_warn("Kdump: vmcore not initialized\n");
> -		return rc;
> +		goto fail;
>  	}
>  	elfcorehdr_free(elfcorehdr_addr);
>  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
> @@ -1577,6 +1577,9 @@ static int __init vmcore_init(void)
>  	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
>  	if (proc_vmcore)
>  		proc_vmcore->size = vmcore_size;
> +
> +fail:
> +	elfcorehdr_free(elfcorehdr_addr);
>  	return 0;
>  }
>  fs_initcall(vmcore_init);
> -- 
> 2.25.1
> 

