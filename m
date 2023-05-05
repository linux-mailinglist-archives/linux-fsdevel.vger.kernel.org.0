Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C414F6F8571
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 17:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjEEPUf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 11:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjEEPUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 11:20:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7B34C26;
        Fri,  5 May 2023 08:20:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115e652eeso20485073b3a.0;
        Fri, 05 May 2023 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683300032; x=1685892032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OJUkhoBJrhHGknGMZO9ShmJQsdgZCKjJXfQhDAMN9c=;
        b=nEnlw9VAAUV8WgNAPYNTJj+JJukKpNz9rlfLjajzDo6oLzt6bHdqqDW5kzTegJra9t
         YqgXUrOaWZYSbauy+qZCYXAKyO+affH/D9ml3yqEBsVOLLOEBPQ3nYAn4dkw3vK+/DeC
         Q63TYrhELFF6DNiKVS6VKEE9s2CHECurVK5fOrZVdgFLiP45O3UHeJOZ//0aAuMBFWvy
         DpMm5h6yWQ0upjA4XKHgPhhoBnog4D3w86QQWL10kQT0pjKBhd//u61QvieuJIqOzMHM
         MIlzjYtFjK5kUih5O8FC8AbfvKALBY/0N0VZapRB3VULwuR2jEK5REd4Dva5t3YEK2pA
         pyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683300032; x=1685892032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OJUkhoBJrhHGknGMZO9ShmJQsdgZCKjJXfQhDAMN9c=;
        b=g/YnJDeOWNVdYYNfJpXwQ8GKUROenRKTsUVByqEauGcVY9opoC4iU08sj/GhT2AEDC
         jGlwiJAs1lXi99vngzDk8KY2BZ0naong9GmqatwDCqaqFjq5oKL02xE+EOCcnst886jG
         WwsAD5afoXLLf5E+KpUBVp/aiD7gsWwD2OxQyNnb+eH1aj5zDyZyPUJu6FRbZjAIpgke
         XtrmyuCmCvxEgWq4XXsmmTtAlfmZg/AHQZPTglNKUAPI5mzVZ5Ypab07Du1qKnJzw0pu
         IVqhOMQ7J4PlFG2nkUE03AYXs3aUiCgwiy3TmBuQHs+xt45KPP+KwphJ7NiKi5GsWQT/
         hdDg==
X-Gm-Message-State: AC+VfDxNusc4EALzXrLf368x4RLV/WwrsZSDO4od2MLN16JGokjZ+Ygr
        YWRYgmTlculnt9ImYrNr3bc=
X-Google-Smtp-Source: ACHHUZ7oiYndB9cpc+CjGNkoH0LARizJXbdY0M9WRBdPrmnSqXgZpNdLlOsdX8VfFturuI8l4ydt/g==
X-Received: by 2002:a05:6a20:1595:b0:f2:4c39:8028 with SMTP id h21-20020a056a20159500b000f24c398028mr2598756pzj.21.1683300031571;
        Fri, 05 May 2023 08:20:31 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79152000000b0064394c2a1d0sm1758065pfi.209.2023.05.05.08.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 08:20:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 05:20:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 5/5] cgroup: remove cgroup_rstat_flush_atomic()
Message-ID: <ZFUevQbT8hHzH_vv@slm.duckdns.org>
References: <20230421174020.2994750-1-yosryahmed@google.com>
 <20230421174020.2994750-6-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174020.2994750-6-yosryahmed@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 05:40:20PM +0000, Yosry Ahmed wrote:
> Previous patches removed the only caller of cgroup_rstat_flush_atomic().
> Remove the function and simplify the code.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
