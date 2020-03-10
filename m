Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA96D17F346
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 10:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCJJQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 05:16:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40812 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgCJJQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:16:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id p2so13995748wrw.7;
        Tue, 10 Mar 2020 02:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fz3n4QEA4mMM+MBbJX+cMGlCMEaVSqf4LwkZvYcSZEw=;
        b=EBXKq4nxdeL99uimUiCAa5Xl5Xc4upafB0sj6Esq6i//ChMnp9K3N7evpVDOeqJsE7
         89lp2Ybs5CJ2dnFjQd5zSd0uuI4VIgmoEb4H83sT9heUyaufAmHZUkcMDv5T1+1gD+Ln
         HFbTBydYQNjtzh7gVPMm2hGucEsypZfnp0+uZRVcpiL5A7U7yLqIQvBtYfOYMB8hp9+R
         Fr/Qgu1aLl0gY8Xpzi6m47RijqVdFdn6StQqBXsQVHIMyqXHzlebU5KRBPis0Be4PQHM
         PdwldUhTJ0fsuP4qFqpXLjRZ+IIL0tz4ndi83SYICqCTjF2uHRfF863A8OtoPdEEOmYn
         YgrQ==
X-Gm-Message-State: ANhLgQ2kYBj7mBmUf80iWIaWLxtyPn0aMVxn5NjcMgk0n4//nmtwv0BK
        luYf5UNTl2OhgYDi3YO6o3E=
X-Google-Smtp-Source: ADFU+vszMTJIkVmx1ZNqIN9KzQ8vaeAT6TaRYkPc1p0pHRH6nNgZB8aQkPvG80FiR8Kt9mo3LxxChg==
X-Received: by 2002:adf:92c2:: with SMTP id 60mr9876964wrn.177.1583831798497;
        Tue, 10 Mar 2020 02:16:38 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id j14sm65506521wrn.32.2020.03.10.02.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 02:16:37 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:16:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-team@fb.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200310091637.GC8447@dhcp22.suse.cz>
References: <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
 <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com>
 <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
 <20200308141923.GI25745@shell.armlinux.org.uk>
 <CAK8P3a2Gz5H_fcNtW0yCCjO1cRNa0nyd568sDYR0nNphu49YqQ@mail.gmail.com>
 <20200309140439.GL25745@shell.armlinux.org.uk>
 <CAK8P3a1HEhwie1uUObQMJyGcs_WSwz4Gj81tAWXZX4d2ff77XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1HEhwie1uUObQMJyGcs_WSwz4Gj81tAWXZX4d2ff77XA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am worried this went quite tangent to the original patch under
discussion here, but let me clarify at least one point.

On Mon 09-03-20 16:04:54, Arnd Bergmann wrote:
> On Mon, Mar 9, 2020 at 3:05 PM Russell King - ARM Linux admin
[...]
> > What happened to requests for memory from highmem being able to be
> > sourced from lowmem if highmem wasn't available?  That used to be
> > standard kernel behaviour.
> 
> AFAICT this is how it's supposed to work, but for some reason it
> doesn't always. I don't know the details, but have heard of recent
> complaints about it. I don't think it's the actual get_free_pages
> failing, but rather some heuristic looking at the number of free pages.

This is indeed the case. There are low memory reserves which are not
allowed for requests which can be satisfied from higher zones. This is
the case for many many years. Just have a look at lowmem_reserve and
their usage in __zone_watermark_ok. The layout of the reserves can be
configured by /proc/sys/vm/lowmem_reserve_ratio.

HTH
-- 
Michal Hocko
SUSE Labs
