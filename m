Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F243E0410
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 17:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbhHDPWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 11:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbhHDPWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:22:40 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C63C0613D5;
        Wed,  4 Aug 2021 08:22:28 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r16-20020a0568304190b02904f26cead745so1579411otu.10;
        Wed, 04 Aug 2021 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GHXzGOHsNUaU15+3cUdFR4m7Br9N2/ukxtu8/mdLTWs=;
        b=AA6gM4dB2aRjdZjmdJ3U38VkuOrOUA8UqEnwP4IH7ewdi0Bq0gsKxpQFz67uY7Z2cb
         M3f/GEDzpNZaqs26wb2mNEwDXaGrBO5qfnxB/F8xpZJt3evRsKlj26XhCG2fr/sgGmfn
         hBb6SJNw8ix4QwaM4yvM+edq9ig+G3g/8iknv1uJP+xjcFw1YI4K7PfozWHuES2oWsuY
         EDDZ685BcWPlpf90CVB0/83K+1a3w/UapDnceSruvFX/Ck/c4Y7kiQc5vw79LppDQKwe
         Z/q7SnsDjyV8ZAuVqcLKuoRp1CRtr4dI+PiC00jtKCq0VshBpAuGOX/0rBcrn6pqG9ql
         ui4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GHXzGOHsNUaU15+3cUdFR4m7Br9N2/ukxtu8/mdLTWs=;
        b=FV8jWAD+8TvsNMhbPyxWmyGuBXfVKbW6rxOqqtcylFupvoOuioSuP9nXOPJ4Rzl3Zf
         POhRLwbrzPHNHZeY32/vxRTLLExLXzU5aZdSc5iS8/erIOhc8xJXcSwSSsMJvWTemx8s
         NJnSy/PMZLSly8QNEFgyFF2ilbDRFRLngbALDxzAggcXoqnR7/fpQUSZB65UdZreuodi
         rsljqLO6l6p3eSfMiZYm4f5hv/zbjw0YIt0m+OcXIgIUSYkCPI+l67jfcTOrzPo1qMld
         he9AeVuXsWJ6H3lR85uWr43AhF5P6L026iErZawe1DOhVhpTYuEQ89vPei4n6E+FKJDB
         prvg==
X-Gm-Message-State: AOAM530ldWFeKeVuDVAOyLorKjpxGWhAY7LlY9tRWIVouY70Eas4/DVj
        moXQC/aNT9rfiFUL/PCDL6A=
X-Google-Smtp-Source: ABdhPJz4xY6/XN0asdQC63nYaXpDF8JZCZNayLgrSAn+1yZwMW2B32kv3oncbDLICHz5o4vkLvKh4Q==
X-Received: by 2002:a9d:7844:: with SMTP id c4mr169495otm.213.1628090544337;
        Wed, 04 Aug 2021 08:22:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bd20sm504570oib.1.2021.08.04.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:22:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 4 Aug 2021 08:22:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH v1] fs/epoll: use a per-cpu counter for user's watches
 count
Message-ID: <20210804152222.GA3717568@roeck-us.net>
References: <20210802032013.2751916-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802032013.2751916-1-npiggin@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 02, 2021 at 01:20:13PM +1000, Nicholas Piggin wrote:
> This counter tracks the number of watches a user has, to compare against
> the 'max_user_watches' limit. This causes a scalability bottleneck on
> SPECjbb2015 on large systems as there is only one user. Changing to a
> per-cpu counter increases throughput of the benchmark by about 30% on a
> 16-socket, > 1000 thread system.
> 
> Reported-by: Anton Blanchard <anton@ozlabs.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

With all tinyconfig builds (and all other builds with CONFIG_EPOLL=n),
this patch results in:

kernel/user.c: In function 'free_user':
kernel/user.c:141:35: error: 'struct user_struct' has no member named 'epoll_watches'
  141 |         percpu_counter_destroy(&up->epoll_watches);
      |                                   ^~
kernel/user.c: In function 'alloc_uid':
kernel/user.c:189:45: error: 'struct user_struct' has no member named 'epoll_watches'
  189 |                 if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
      |                                             ^~
kernel/user.c:203:52: error: 'struct user_struct' has no member named 'epoll_watches'
  203 |                         percpu_counter_destroy(&new->epoll_watches);
      |                                                    ^~
kernel/user.c: In function 'uid_cache_init':
kernel/user.c:225:43: error: 'struct user_struct' has no member named 'epoll_watches'
  225 |         if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
      |                                           ^

Guenter
