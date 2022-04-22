Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA51050C574
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 02:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiDVXvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 19:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiDVXvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:51:18 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155D5C6EE4;
        Fri, 22 Apr 2022 16:48:24 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id s4so6973603qkh.0;
        Fri, 22 Apr 2022 16:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9/2xDFh9dl7zEQ1Wno66tlhOklc1X6CUbTpyUD0JYSo=;
        b=GtSJCfb/kFq8IZZVn9cYuEpNofTiZEMRAjQfrkDfZ4MxVTKJPumEe82wv9zvlt1wdb
         YPGc+4HLi52g83DegnPV7Cj6RXbdrJo1Y8wo6s7UGnFDsKKta8q8Xx7jhgcCz4eU/a97
         EuGLMkt0mIDNF29xe2qkJ7myJO7L0xrLSIgSa2r4Vc6xT0g/QfSYOVhK2iwYqw+/etOT
         /dd1n5RN3+QgA3B4tO1wy/se9l6wzI2XF9hwKP/ROBHn2/XvwNpvLSo0fRujXQimJSOG
         /oOMxhB+vD8N5gztL5XgScwovH24Y2a0EiUZ0e9mvHM+2ugwjmviB7CVAH6ON/Z9F+CU
         q0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9/2xDFh9dl7zEQ1Wno66tlhOklc1X6CUbTpyUD0JYSo=;
        b=J2XoiKh6bQLMjETvAB7yCMB1W5Lw4r21U4/QlrqkYZ2qtebTYVErge6OvKvi9fZcjx
         nyu+Bwj6Utut31si1NVw8hZtdGhu6SeD0q9G7dWv6I/yTRNHkPMbTsqEF2UTQU2l/XC9
         otsaHh8J1cZkDPZrNITXfjE13ilL1EFbQZg2faIMyTuYHpbd896x9PIfPD4juZ44A9KN
         8t9q0PyjGx1c3GrMFvkHlA0hEggs2J8RirIXn553885fEp57wJjL4Hfvi8ycmNcqgUTj
         TfYyfWE9jNBhSUnourQi9NWcPuFuC1hyJ7qtrN5aPR/zc6kHJaNfvItq1U4CqAt7Ixte
         PDaw==
X-Gm-Message-State: AOAM533ZRt2cXLPwRB6Id10dgYctQAexvEa7LWFEFNm5yarYgyAwb3F4
        JdEcuTE4/bSnJJoW3DNA4lWqour++Jw6
X-Google-Smtp-Source: ABdhPJyw5vkKW6b5EOOq344HLslU2RWAyR40NLeFfnTi3FFpV26KMen487nIt7tPNpC9/77RvhcVxg==
X-Received: by 2002:a37:a247:0:b0:69d:5e7d:42b7 with SMTP id l68-20020a37a247000000b0069d5e7d42b7mr4281597qke.320.1650671303234;
        Fri, 22 Apr 2022 16:48:23 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id b2-20020a37b202000000b0069c7ad47221sm1543720qkf.38.2022.04.22.16.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 16:48:22 -0700 (PDT)
Date:   Fri, 22 Apr 2022 19:48:20 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 8/8] mm: Centralize & improve oom reporting in
 show_mem.c
Message-ID: <20220422234820.plusgyixgybebfmi@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-14-kent.overstreet@gmail.com>
 <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
 <YmLFPJTyoE4GYWp4@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmLFPJTyoE4GYWp4@carbon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 08:09:48AM -0700, Roman Gushchin wrote:
> To add a concern: largest shrinkers are usually memcg-aware. Scanning
> over the whole cgroup tree (with potentially hundreds or thousands of cgroups)
> and over all shrinkers from the oom context sounds like a bad idea to me.

Why would we be scanning over the whole cgroup tree? We don't do that in the
vmscan code, nor the new report. If the OOM is for a specific cgroup, we should
probably only be reporting on memory usage for that cgroup (show_mem() is not
currently cgroup aware, but perhaps it should be).

> IMO it's more appropriate to do from userspace by oomd or a similar daemon,
> well before the in-kernel OOM kicks in.

The reason I've been introducing printbufs and the .to_text() method was
specifically to make this code general enough to be available from
sysfs/debugfs - so I see no reasons why a userspace oomd couldn't make use of it
as well.

> > Last but not least let me echo the concern from the other reply. Memory
> > allocations are not really reasonable to be done from the oom context so
> > the pr_buf doesn't sound like a good tool here.
> 
> +1

In my experience, it's rare to be _so_ out of memory that small kmalloc
allocations are failing - we'll be triggering the show_mem() report before that
happens.

However, if this turns out not to be the case in practice, or if there's a
consensus now that we really want to guard against this, I have some thoughts.
We could either:

 - mempool-ify printbufs as a whole

 - reserve some memory just for the show_mem() report, which would mean either
   adding support to printbuf for external buffers (subsuming what seq_buf
   does), or shrinker .to_text() methods would have to output to seq_buf instead
   of printbuf (ew, API fragmentation).
