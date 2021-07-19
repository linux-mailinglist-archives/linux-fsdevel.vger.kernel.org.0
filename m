Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D52F3CEF44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389764AbhGSVgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385224AbhGSSwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:52:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8D1C0617A7
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 12:22:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y42so32098006lfa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRKNjK3HDiyg7MZUU6xzfGsB6oi9LOaFsq3T/zTDatI=;
        b=TmVBuZNqv/jmsUcMG14H63atqMF/gg01Eskbcp6RQq2COYAPPbdrQdz8StZJOrWneW
         ViMrEnqGW4PsoFl85gC5x+OljVg9GWa3KzkO/WgOpAXCPkX5jM+3somNUNWooAEL0QZt
         KJxUdnJWdmgiMNzmtO9o+dMnja1cusLmGBQ4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRKNjK3HDiyg7MZUU6xzfGsB6oi9LOaFsq3T/zTDatI=;
        b=P6+qOFajLCUGA2dTPJRobv+hi55+Eerw4up72AEs1ceCZOhPqCasYXXFuFrD/by2vl
         MGwPzwu9teScE8+f7egLhSpz9jHqkIX0I3eW5Ek3Uj+WxdGU21uwfLtOaXz90rceu2xK
         dg+Lz7VPiYlS7IPBwaMvD0fgr3UohiZlZUGdIvexb4x/csFwL6RnaIt37nL78hpxf/WN
         25ltrhVbZLhg6Mikn6kVgvfWws11AimDWWV+GT07c5IwFBcPmFCOccE/BPZE6D78wEDa
         TYcLXBjsDdw6eCnxfBAJl7qXe9x1C2jpT+sXzzeYXNPUgTh70zxqwqoDGWjnRlAzYaPf
         pHbw==
X-Gm-Message-State: AOAM532qX/R2GgTUxvLrccsuTi+fPIs9G7fyal4hS+eSRqnTbF4lspnq
        C+cRMcskSJl6eA0Y3sSNmqR9lQcOWTxGk9LC
X-Google-Smtp-Source: ABdhPJxEP1rXlSebiNS4LoRjC2LsFO7IGrqe/9hCeBaKWbh/8/GEBQPDwRKCHgBlTiMb1ypmlbMytg==
X-Received: by 2002:a05:6512:38c1:: with SMTP id p1mr20206742lft.50.1626723081244;
        Mon, 19 Jul 2021 12:31:21 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id w17sm1357057lfd.126.2021.07.19.12.31.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 12:31:20 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id b26so32118926lfo.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 12:31:20 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr18099945lfa.421.1626723079907;
 Mon, 19 Jul 2021 12:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210718223932.2703330-1-agruenba@redhat.com>
In-Reply-To: <20210718223932.2703330-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Jul 2021 12:31:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBKeA=obJOc5VRP38=ffm2dCfVmKmy5PLAgs3rysoEtw@mail.gmail.com>
Message-ID: <CAHk-=wjBKeA=obJOc5VRP38=ffm2dCfVmKmy5PLAgs3rysoEtw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] gfs2: Fix mmap + page fault deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 18, 2021 at 3:39 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> here's an update to the gfs2 mmap + page faults fix that implements
> Linus's suggestion of disabling page faults while we're holding the
> inode glock.

Apart from some wording/naming issues, I think this looks a _lot_
better, and should fix the fundamental and underlying deadlock
properly.

So Ack from me with the trivial suggestions I sent to the individual patches.

            Linus
