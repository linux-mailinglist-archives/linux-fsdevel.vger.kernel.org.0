Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED59E3A9A85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhFPMdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 08:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhFPMdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:33:50 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314ABC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 05:31:44 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id l25so903039vsb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drmK1l9ZAYnCw4AU0VAPo5P0a5EA+tE1PwSwVaZH2ns=;
        b=TrwK1cHrsTvLbt/FsI5y2KOeR9N0daQjCPIw+/ozCkYGOE/EVt8KrmaLmnupNOtalm
         VXXH3I0Qf90gFbYuvh8jpSQ2LnIpzh4EqKaG3woAarOzy1N82xbdDqd9Aft4gaFRVi/4
         /jYSYjCow99Y4ZGQvEFEMdWUIpAfRpQLdqkFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drmK1l9ZAYnCw4AU0VAPo5P0a5EA+tE1PwSwVaZH2ns=;
        b=DuPA+UiPQ2PegVkD1YvObeN/bcaGHxMu/amvKEpRGnO8AHgp1IvXA46ZHga6wt46Nd
         g8/Gq6c2QBS++p4BawNazD38Ib6besRbekMOGNqJVnq7ik1YL6sb8yamx65x5xsRy52T
         8BfN5AfkSCMKPuIE8zVYXamw1ezeKZ8Zs4j7xGMXcrwGFHJewMiUCB6FBHxXCtHeVtbN
         qol0pxP0xI3ewON9g4vUqI6JUPXOupATQJpLj4jqYp67QPTatjk42i8JKORHLYUf+UGB
         IS4gP0MtcTcHrnjOF/o7Dg5FEy5ZvhmyLAQlWjJMUZxpYBiaChOVkxSSGS5aOrpas5mP
         eVRA==
X-Gm-Message-State: AOAM5309PIxhKcPY+9Cuw0B31ODFjbr7ZWzxs1Xr0iOSSFI/BP+xCDm4
        BLVl6NDhLaDlw52tmHV+9N6kUl3pNT2tsGZgeOeQNcgqL4c=
X-Google-Smtp-Source: ABdhPJwU4TG3bflQtBUIV1kT17BBBRLLSwbJ/amzK0gyVEHbf8wXwD3Cw6rexMzF/avWgOdUz0MOKdYODW+XsmXc5+c=
X-Received: by 2002:a67:bb14:: with SMTP id m20mr10648645vsn.0.1623846703321;
 Wed, 16 Jun 2021 05:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <016b2fe2-0d52-95c9-c519-40b14480587a@gmail.com>
In-Reply-To: <016b2fe2-0d52-95c9-c519-40b14480587a@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Jun 2021 14:31:32 +0200
Message-ID: <CAJfpeguzkDQ5VL3m19jrepf1YjFeJ2=q99TurTX6DRpAKz+Omg@mail.gmail.com>
Subject: Re: Possible bogus "fuse: trying to steal weird page" warning related
 to PG_workingset.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Thomas Lindroth <thomas.lindroth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 14 Jun 2021 at 11:56, Thomas Lindroth <thomas.lindroth@gmail.com> wrote:
>
> Hi. I recently upgraded to kernel series 5.10 from 4.19 and I now get warnings like
> this in dmesg:
>
> page:00000000e966ec4e refcount:1 mapcount:0 mapping:0000000000000000 index:0xd3414 pfn:0x14914a
> flags: 0x8000000000000077(locked|referenced|uptodate|lru|active|workingset)
> raw: 8000000000000077 ffffdc7f4d312b48 ffffdc7f452452c8 0000000000000000
> raw: 00000000000d3414 0000000000000000 00000001ffffffff ffff8fd080123000
> page dumped because: fuse: trying to steal weird page
>
> The warning in fuse_check_page() doesn't check for PG_workingset which seems to be what
> trips the warning. I'm not entirely sure this is a bogus warning but there used to be
> similar bogus warnings caused by a missing PG_waiters check. The PG_workingset
> page flag was introduced in 4.20 which explains why I get the warning now.
>
> I only get the new warning if I do writes to a fuse fs (mergerfs) and at the same
> time put the system under memory pressure by running many qemu VMs.

AFAICT fuse is trying to steal a pagecache page from a pipe buffer
created by splice(2).    The page looks okay, but I have no idea what
PG_workingset means in this context.

Matthew, can you please help?

Thanks,
Miklos
