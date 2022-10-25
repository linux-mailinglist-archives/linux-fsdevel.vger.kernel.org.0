Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF3560D3A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 20:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiJYSe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 14:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiJYSeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA16DEF13
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666722862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f3ngkylt5FBWl4cdAT7Bl1Z+Wly/kdFZ4oAqXwN3yHQ=;
        b=fGA8RfnLQ3MIMWHKR9FWjxXwz9fsNfonLsn9Xi2YJZStlfjkEvbVDZBICXQW7iUjJXv4wY
        tt6x7aYllIUMQT5OMDTpGKCvToe/5LRRYMQ0v989t28cQqLmb91ZnsQI0jYcCEOwYgn14C
        DyfXgEaLehg9fttyhQLa3dhrcJcX7Cw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-bLJB8rQ8P6yBPmJDMPZdyQ-1; Tue, 25 Oct 2022 14:34:20 -0400
X-MC-Unique: bLJB8rQ8P6yBPmJDMPZdyQ-1
Received: by mail-qk1-f198.google.com with SMTP id bl11-20020a05620a1a8b00b006f107ab09dcso9271546qkb.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 11:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3ngkylt5FBWl4cdAT7Bl1Z+Wly/kdFZ4oAqXwN3yHQ=;
        b=ZIzdeKp8H/kjO0OqIYEJ5mbGglz4jt02mgobdcEVGz17DjqKNfimyGUqTUpMYZpzdP
         4v2RYFNO0Wyy2EZjQXQSNBiRFgzwL5PM6i6RCqZM9Ad2wgijVaoZ4Kq7rQ09eAqGmrAt
         xiAezwwPOU8A0/CWPx1ej46jYz2MrmdxD+yZI/5C1pSko/D6DTp6cKjHH8IWUiuNBhHq
         aSX1uDj0uKg61hWmpI6c+X/l9y3HBQxEMtH0dpTu4uIC0Sd4sznnVAQiR5wpz+/d3py6
         yueiMlJBOr05/pf09nSIEifNqah/yHwphA7ZXBMcvRwEWatAQtZDNOI7rk55kkXdL+DX
         PsMQ==
X-Gm-Message-State: ACrzQf2hyHHZ+10HYdv+MDtPWccjfKCzTe/9hKym3foONB0ZrwA6Cr1E
        yD7/JCT1EXmFvhCx/acNQlye9L/dOdzUjoELrBdpElpNrmssAjoTudFxuzRLV7JVfKKI6aJvVaD
        qNrw9WDMcCTwOTkElglgQptGyxg==
X-Received: by 2002:a05:622a:547:b0:39c:bbbf:f78a with SMTP id m7-20020a05622a054700b0039cbbbff78amr32939052qtx.97.1666722860122;
        Tue, 25 Oct 2022 11:34:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5j3RDlpzN8gLaGUoESfHl7ZzuveQzxrapog2PSUrCFSjZOBW/giWOh0jzA6j5VoTDBo2pl4w==
X-Received: by 2002:a05:622a:547:b0:39c:bbbf:f78a with SMTP id m7-20020a05622a054700b0039cbbbff78amr32939034qtx.97.1666722859876;
        Tue, 25 Oct 2022 11:34:19 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bm25-20020a05620a199900b006ed138e89f2sm2409440qkb.123.2022.10.25.11.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 11:34:19 -0700 (PDT)
Date:   Tue, 25 Oct 2022 14:34:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: wake on unregister for minor faults as well
 as missing
Message-ID: <Y1gsKdfXdIzkidpN@x1n>
References: <20221025182149.3076870-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221025182149.3076870-1-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:21:49AM -0700, Axel Rasmussen wrote:
> This was an overlooked edge case when minor faults were added. In
> general, minor faults have the same rough edge here as missing faults:
> if we unregister while there are waiting threads, they will just remain
> waiting forever, as there is no way for userspace to wake them after
> unregistration. To work around this, userspace needs to carefully wake
> everything before unregistering.
> 
> So, wake for minor faults just like we already do for missing faults as
> part of the unregistration process.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7677f7fd8be7 ("userfaultfd: add minor fault registration mode")
> Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 07c81ab3fd4d..7daee4b9481c 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1606,7 +1606,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			start = vma->vm_start;
>  		vma_end = min(end, vma->vm_end);
>  
> -		if (userfaultfd_missing(vma)) {
> +		if (userfaultfd_missing(vma) || userfaultfd_minor(vma)) {
>  			/*
>  			 * Wake any concurrent pending userfault while
>  			 * we unregister, so they will not hang
> -- 
> 2.38.0.135.g90850a2211-goog

Thanks, Axel.  Is wr-protect mode also prone to this?  Would a test case
help too?

-- 
Peter Xu

