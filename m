Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ABA723334
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 00:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjFEWcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 18:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFEWck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:32:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042AEF3
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 15:32:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-650c8cb68aeso3209063b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jun 2023 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686004358; x=1688596358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6XXKGqtv+SXyOIfPXMfeL9O+2fKpYePdxYVtpVnLRY=;
        b=fz6LdX4ZvGqimcI7Of4JtJTRBkucihJJdFfos11nPQb2O6NaLuIL7xtTPd9cYia88g
         UuxV0wXAMQXTo+WrDEwQm41gb2BFRGszwI9g2p2TaA5dRFMn8wGpMFcgUXxAlIOOnHcV
         Op6qoM9r8Th8ObpVUR3xt9tX9hy9aHBZ0f1tHVUVxn+pPWaE9B0Bc6p+2E9YmIwC9dZP
         Zv+Uo+Nqai8V2F8oa4zOKOzoj+NrvmWbo03cFg9Htu4Rw0pGHQO3N9hjRwYYfTDCRoL2
         omvrTOH85h0mhezupcIqVwktahMHlSSgrWgxghFhVFAU3YOKBwteR4Sh91YH00tkEXok
         CK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686004358; x=1688596358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6XXKGqtv+SXyOIfPXMfeL9O+2fKpYePdxYVtpVnLRY=;
        b=CBjPBP+vl/9El9d+45p0t3vtLymFcqVjGFcw7HSnT1lmlEZ9aBt4yBZ7JFd6FHcuK8
         GrXbJVyskdVQpf7KyAFD0h/hmLGV1TWaTklxUGfGkfWW+xPUTqy4LoX3xge3sgwNePOA
         4v9PVW6n8geH/gjJTkeTRu8yPSy+ioqJSeeGUlsGd0KPTqV4Qh3Y/6EJC/LcB/xcc3OJ
         2R2bB+9H+Ag09foidC4RrzmdjWgKj4saC3xY1m+Naov8pz/KzU6JudVA12Am9mtFixmB
         X/rwqam0hUYF9kqL5QIfG82GmNqq8nFaFtS5NBesIZ38kGjDBIsIP5j6/Sze6u/kSTMF
         9OQA==
X-Gm-Message-State: AC+VfDzB9Ly+iTAYwU/Xi3z1lTSVh72fSwQx/1Gx2rFysJvKkNt3rUTs
        41oNo4dv9wAMtY41WEDAgPvc4Q==
X-Google-Smtp-Source: ACHHUZ41rdel5fOclCH4/4izzymU8dbmTPEyJUF0GLFepqnRJjlMlPqbIhWBAvN0OdUZdC7qFQI1DQ==
X-Received: by 2002:a05:6a20:3d8e:b0:105:53:998 with SMTP id s14-20020a056a203d8e00b0010500530998mr465056pzi.12.1686004358419;
        Mon, 05 Jun 2023 15:32:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id bd6-20020a170902830600b001b016313b27sm7099553plb.88.2023.06.05.15.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 15:32:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q6Ikd-008G9M-0c;
        Tue, 06 Jun 2023 08:32:35 +1000
Date:   Tue, 6 Jun 2023 08:32:35 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kirill Tkhai <tkhai@ya.ru>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2 0/3] mm: Make unregistration of super_block shrinker
 more faster
Message-ID: <ZH5ig590WleaH1Ed@dread.disaster.area>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168599103578.70911.9402374667983518835.stgit@pro.pro>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 10:02:46PM +0300, Kirill Tkhai wrote:
> This patch set introduces a new scheme of shrinker unregistration. It allows to split
> the unregistration in two parts: fast and slow. This allows to hide slow part from
> a user, so user-visible unregistration becomes fast.
> 
> This fixes the -88.8% regression of stress-ng.ramfs.ops_per_sec noticed
> by kernel test robot:
> 
> https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
> 
> ---
> 
> Kirill Tkhai (2):
>       mm: Split unregister_shrinker() in fast and slow part
>       fs: Use delayed shrinker unregistration

Did you test any filesystem other than ramfs?

Filesystems more complex than ramfs have internal shrinkers, and so
they will still be running the slow synchronize_srcu() - potentially
multiple times! - in every unmount. Both XFS and ext4 have 3
internal shrinker instances per mount, so they will still call
synchronize_srcu() at least 3 times per unmount after this change.

What about any other subsystem that runs a shrinker - do they have
context depedent shrinker instances that get frequently created and
destroyed? They'll need the same treatment.

Seriously, part of changing shrinker infrastructure is doing an
audit of all the shrinker instances to determine how the change will
impact those shrinkers, and if the same structural changes are
needed to those implementations.

I don't see any of this being done - this looks like a "slap a bandaid
over the visible symptom" patch set without any deeper investigation
of the scope of the issue having been gained.

Along with all shrinkers now running under a SRCU critical region
and requiring a machine wide synchronisation point for every
unregister_shrinker() call made, the ability to repeated abort
global shrinker passes via external SRCU expediting, and now an
intricate locking and state dance in do_shrink_slab() vs
unregister_shrinker, I can't say I'm particularly liking any of
this, regardles of the benefits it supposedly provides.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
