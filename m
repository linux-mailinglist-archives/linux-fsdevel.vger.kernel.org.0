Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F6E50C5CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 02:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiDWAtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 20:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiDWAtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:49:05 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ED1CA;
        Fri, 22 Apr 2022 17:46:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q75so6989066qke.6;
        Fri, 22 Apr 2022 17:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jfQRXS4ku+z/ycc9nTfWUDDx9ywRVizLo210oRenoss=;
        b=DoTALWV07OybXqnGSs0R5MiCnDqBA7BZnuF6lkTq4LzjOOtkniv9SqQFSIJLCnMcXh
         2x95qCHHmGlULR/msQk0FVlDfsONshsYuYRnUnMCoc3LA5PcwL+O/zT3QwuvS/LFGS4c
         KIf2C73XB8qzbxndYLfboXK6+OxNBsbKSmEKA/UpnFx942y7OKUb32J6dtc3JzqJ6Imw
         hZZe1D2hnVCEhB8pOcX16w2qJuBimhFYFYVRmxdoMtFbXtBa91gLdBk+DJj0eDqs634U
         S8IaLNOh2HgkIxf4aYksEjh+nkqP4hNG3wNk2XhIJTfQ89WlMtFe1mG9ToNa4tGcD3rr
         n1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jfQRXS4ku+z/ycc9nTfWUDDx9ywRVizLo210oRenoss=;
        b=4o7Nigk5EHRAinW4q7EPloVjEGq+Cnx59sCHibM8J56xwAlqu5dQmC8NEQ5LneXx+p
         YQoDHQUz2nHNP06UvxsOW9cG7nf3LViHuyTqHM7YOXKH0G5u4t49rV39nO/RMjrvh9bR
         XBao26WXdpglLDkhX/eHpQoB9wC+Max497be02u/q+sWqsx6N5u0qud8KLxPO9GWBu86
         x5lqIwqAVOnOKx3BRlpZuUcpq9hfCLOLo6V/bqqH6Q0yjizuSWrtMEdSEY4HyjeLxvNp
         ZkemnmH9m3GryzYq9ueuYnAdTHb9+Ss8nnTotX/ojECiPX7WIoSNvY90yvPL0D6l9biJ
         L/tQ==
X-Gm-Message-State: AOAM532I8JA3vIEAMA02dT6+Z2hfYKYHIsQvU6fS/ana87g2JuMwLc97
        PXNS427OREpXw2cP2qnf2w==
X-Google-Smtp-Source: ABdhPJyMxnxg3VzI2lcxypaPp3yv1KZCrV32ALJz1LGncCd6sBXzQhcsJxcOvEGYHvxGJnfC7dU0Pg==
X-Received: by 2002:a37:8d43:0:b0:699:b613:be6 with SMTP id p64-20020a378d43000000b00699b6130be6mr4426505qkd.484.1650674770030;
        Fri, 22 Apr 2022 17:46:10 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id t12-20020a05622a01cc00b002f204a559a4sm2200957qtw.53.2022.04.22.17.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 17:46:09 -0700 (PDT)
Date:   Fri, 22 Apr 2022 20:46:07 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 8/8] mm: Centralize & improve oom reporting in
 show_mem.c
Message-ID: <20220423004607.q4lbz2mplkhlbyhm@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-14-kent.overstreet@gmail.com>
 <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
 <YmLFPJTyoE4GYWp4@carbon>
 <20220422234820.plusgyixgybebfmi@moria.home.lan>
 <YmNH/fh8OwTJ6ASC@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmNH/fh8OwTJ6ASC@carbon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 05:27:41PM -0700, Roman Gushchin wrote:
> You're scanning over a small portion of all shrinker lists (on a machine with
> cgroups), so the top-10 list has little value.
> Global ->count_objects() return the number of objects on the system/root_mem_cgroup
> level, not the shrinker's total.

Not quite following what you're saying here...?

If you're complaining that my current top-10-shrinker report isn't memcg aware,
that's valid - I can fix that.

> > In my experience, it's rare to be _so_ out of memory that small kmalloc
> > allocations are failing - we'll be triggering the show_mem() report before that
> > happens.
> 
> I agree. However the OOM killer _has_ to make the progress even in such rare
> circumstances.

Oh, and the concern is allocator recursion? Yeah, that's a good point.

Do you know if using memalloc_noreclaim_(save|restore) is sufficient for that,
or do we want GFP_ATOMIC? I'm already using GFP_ATOMIC for allocations when we
generate the report on slabs, since we're taking the slab mutex there.
