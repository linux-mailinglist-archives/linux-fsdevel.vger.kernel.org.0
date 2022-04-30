Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C565A515A39
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 06:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiD3ED7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 00:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbiD3ED5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 00:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F24C186D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 21:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651291223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sKB6FlYNwY4+wlgwk3rv/2ltFqVWdp3lmtPGlyyyGGo=;
        b=ETSEpC1Grbg5pv+cyJS2gGr2EuAsb+K4EJsx/8DzCLJCuwNqkThpERRqUH/5miiW/I0yDn
        WsA7Ikn8+A8aGqnzzldBqkbe3epsP4d0b06AlhKAmm4i2Y83vYC0pwwgVxX/byPwVZhJW1
        P6CPSOc+fDUG6lcg0MJNqLwECbz60Io=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-yFBqdz3yOlCJsUkk-aZrrQ-1; Sat, 30 Apr 2022 00:00:21 -0400
X-MC-Unique: yFBqdz3yOlCJsUkk-aZrrQ-1
Received: by mail-wr1-f69.google.com with SMTP id y13-20020adfc7cd000000b0020ac7c7bf2eso3712088wrg.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 21:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKB6FlYNwY4+wlgwk3rv/2ltFqVWdp3lmtPGlyyyGGo=;
        b=XkmLB86mODHmHcg03EWjpw7KsdKjD8HxccB3cquoMCq0uM8zN6gS1VdYBqRtw38nRT
         jZ472X9qZupU+RPEKYELVkKzVSsgPma5E2UgetzoB4S6T8MrSRRGIs2YAqD6FoT2ovko
         Jvlf4B0NFXAl/oST+InMD4VWvQ7NQI/rMMDyWoKuAcb/MIAmIGrhvJDQHeasxbIJxpzn
         /ZHxTbhAAPKjhNCE8ctaXm7QUrNn7CS09UzofgD1QZhV+n0Zv9+m3ZQTLMvg1h+aSKtG
         +nGbZXxHerYi7B8ByFYpr7a0yyCUhLdVWNwgwaASq7O2Cps9LNRVa7DtN12Sk+sE2Ns4
         OyJA==
X-Gm-Message-State: AOAM532pdWpAaH5SnOuo+kI5uW2F1n22xcjafdBu+qmQX5B9uZmD480m
        O6hQ0Sd9fB3f/7kNayRqzxBxcPLr8qJNMGrjT0YG9o07m/Joi1i7X9KAP+8uF9kPe4RRDqjMB+c
        ZMxzrUVazhLDmPh/IcaCRKbAvyNZOdofCy1S8KHOkng==
X-Received: by 2002:adf:ee81:0:b0:206:1b32:d6f2 with SMTP id b1-20020adfee81000000b002061b32d6f2mr1559778wro.144.1651291219822;
        Fri, 29 Apr 2022 21:00:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyLeeVtNgwwU9RGNYZQkn5+DYkg+QFnnf5jW3HF7IgxWHGisBGg3RhxLrXZWdxkQaYbA/ce/QbaCUurXmPnwo=
X-Received: by 2002:adf:ee81:0:b0:206:1b32:d6f2 with SMTP id
 b1-20020adfee81000000b002061b32d6f2mr1559762wro.144.1651291219592; Fri, 29
 Apr 2022 21:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
In-Reply-To: <20220421234837.3629927-1-kent.overstreet@gmail.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Sat, 30 Apr 2022 12:00:08 +0800
Message-ID: <CALu+AoSP8QASexVOsJqbiqNH-HcdcJHjBd-=t1EJZ7sPUVTK=w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Printbufs & shrinker OOM reporting
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kent,
On Fri, 22 Apr 2022 at 07:56, Kent Overstreet <kent.overstreet@gmail.com> wrote:
>
> Debugging OOMs has been one of my sources of frustration, so this patch series
> is an attempt to do something about it.
>
> The first patch in the series is something I've been slowly evolving in bcachefs
> for years: simple heap allocated strings meant for appending to and building up
> structured log/error messages. They make it easy and straightforward to write
> pretty-printers for everything, which in turn makes good logging and error
> messages something that just happens naturally.
>
> We want it here because that means the reporting I'm adding to shrinkers can be
> used by both OOM reporting, and for the sysfs (or is it debugfs now) interface
> that Roman is adding.
>

I added the kexec list in cc.  It seems like a nice enhancement to oom
reporting.
I suspect kdump tooling need changes to retrieve the kmsg log from
vmcore, could you confirm it?  For example makedumpfile, crash, and
kexec-tools (its vmcore-dmesg tool).


> This patch series also:
>  - adds OOM reporting on shrinkers, reporting on top 10 shrinkers (in sorted
>    order!)
>  - changes slab reporting to be always-on, also reporting top 10 slabs in sorted
>    order
>  - starts centralizing OOM reporting in mm/show_mem.c
>
> The last patch in the series is only a demonstration of how to implement the
> shrinker .to_text() method, since bcachefs isn't upstream yet.
>
> Kent Overstreet (4):
>   lib/printbuf: New data structure for heap-allocated strings
>   mm: Add a .to_text() method for shrinkers
>   mm: Centralize & improve oom reporting in show_mem.c
>   bcachefs: shrinker.to_text() methods
>
>  fs/bcachefs/btree_cache.c     |  18 ++-
>  fs/bcachefs/btree_key_cache.c |  18 ++-
>  include/linux/printbuf.h      | 140 ++++++++++++++++++
>  include/linux/shrinker.h      |   5 +
>  lib/Makefile                  |   4 +-
>  lib/printbuf.c                | 271 ++++++++++++++++++++++++++++++++++
>  mm/Makefile                   |   2 +-
>  mm/oom_kill.c                 |  23 ---
>  {lib => mm}/show_mem.c        |  14 ++
>  mm/slab.h                     |   6 +-
>  mm/slab_common.c              |  53 ++++++-
>  mm/vmscan.c                   |  75 ++++++++++
>  12 files changed, 587 insertions(+), 42 deletions(-)
>  create mode 100644 include/linux/printbuf.h
>  create mode 100644 lib/printbuf.c
>  rename {lib => mm}/show_mem.c (78%)
>
> --
> 2.35.2
>

Thanks
Dave

