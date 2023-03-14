Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7AE6B8ED6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 10:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCNJeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 05:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCNJeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:34:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44F911F8;
        Tue, 14 Mar 2023 02:34:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so14537286pjp.2;
        Tue, 14 Mar 2023 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678786450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysZcgPIZpy+HhVhzVSSUWzsAzGKPFN8FhmKQ7lvViXM=;
        b=fBK7Q7ynMAXgbK2sdnxHmrLOizlbck5xtQ5OIR4fjkahD8USoUHUK45d9H92Cp1Ddk
         zNR9LP+kUS/qLbV+9TgTcIW6Ohi1myNLcekkSVoYaGCsWlUC30z2wF6zvoQ4u6xBJk/u
         sREzqnwt0ALn06h4jy3zdFtb1nHQzn7yumamBoM+fmiqt2IF1nj92uM+JjWBuVaYbS54
         PkzMt0+4/ulBzkVSdMATyjrkVc+nrnyX5XPsRzv9oHOVMdRWLOJbH6LqfEjLh3xXYiaX
         a3l7zQRXgh1Yegw2Z+RBXyWxblOGhbCfzqJyjCpY6VvFmV4/9p5MESY42xt6SzfIg2sO
         M21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678786450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysZcgPIZpy+HhVhzVSSUWzsAzGKPFN8FhmKQ7lvViXM=;
        b=SQmt2ct3J3hxQpRpmKIhSGg3Hl4NisDXd8cxdfav3mT263hgAsyYfwfDfW98P2SAzq
         RC5S6v9JJTsUPG31b6IvjuOmcYaT7AKiQa84gqLe8suDKmh4M9NKHpMvEAESmofouxO8
         sGIjUGrsn9NKTJy2Q9TtInwYS3eBkDmy8Yc8B/E0uw1OIbUSP3lSCwrodgh/Zd70v1qr
         RoSCtIAQTsPwk8AVs87l+Of5+OHoH9nV7KXnytTEpKf9mK5ON6/KFVD6/s8THnb3vSd7
         GI8lspuMdzWKoItHztxU3t5qCnjv1YflpSQ55uH+fXuXamNzndELBXXwf0fZB2fOjy8W
         mYeg==
X-Gm-Message-State: AO0yUKV9I/APLz8+Fn4Mfw6S0KNOBypI0NO9Z8gdfMKRbVhfCCPGr//k
        SDD/CIxFOHTZrupFWZPYm98=
X-Google-Smtp-Source: AK7set+l1it0mNZFvuEDI3VT1K7wkdRl7g9zbpaOT2luN/TmcsFqz/Zv0OWl6OJWRd52+XBEAjiN+g==
X-Received: by 2002:a05:6a20:748b:b0:bf:65dd:94fd with SMTP id p11-20020a056a20748b00b000bf65dd94fdmr35793146pzd.59.1678786450235;
        Tue, 14 Mar 2023 02:34:10 -0700 (PDT)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b006254377ce44sm1166268pfn.43.2023.03.14.02.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 02:34:09 -0700 (PDT)
Date:   Tue, 14 Mar 2023 09:34:03 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        rcu@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 6/7] mm/slob: remove slob.c
Message-ID: <ZBA/iw9//3o62oRO@localhost>
References: <20230310103210.22372-1-vbabka@suse.cz>
 <20230310103210.22372-7-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310103210.22372-7-vbabka@suse.cz>
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 11:32:08AM +0100, Vlastimil Babka wrote:
> Remove the SLOB implementation.
> 
> RIP SLOB allocator (2006 - 2023)
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Goodbye to SLOB.

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> ---
>  mm/slob.c | 757 ------------------------------------------------------
>  1 file changed, 757 deletions(-)
>  delete mode 100644 mm/slob.c
> 
> diff --git a/mm/slob.c b/mm/slob.c
> deleted file mode 100644
> index fe567fcfa3a3..000000000000
> --- a/mm/slob.c
> +++ /dev/null
