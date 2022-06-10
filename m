Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CE2546FF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 01:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348793AbiFJXUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 19:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347331AbiFJXUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:20:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9EF3FAE
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 16:19:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gl15so761772ejb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFUZ/4X/JukFzJtRWCj5IwVqnR0commkjm8Ld9IJoQA=;
        b=AoxxrgfmaiG7fB01rWVX7//fR7hc8pfPaO6KuFkmEJpDpFR/HpqhwLdFQM6dVgzan3
         DB7+Ryy9LWRyARZSjDc1y62fbB3v6E3HNwslaXd4JIbxny9dkIOf8ftYNIIBC41esAeu
         4Gv6sMSeEfJjJ4Ad3imZr/QdI/L/mCWsQLeaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFUZ/4X/JukFzJtRWCj5IwVqnR0commkjm8Ld9IJoQA=;
        b=kOc/w5JGVoaB0dfp1CU6zM6VxbqPs+3ZVfMzqutEbWcBpr/zdBDSEoUlolZBPbyGYm
         loU2QsMxgU86fltv1qKOhJtVepFMkwJt1hoRWKudOPm/MR4cebEA8R4Q4fJOmrzIYL7z
         swpYaWH8ucy92idkkGzj/9gI4S+5oSSf2+cxy2QMK3F0sRta2NX5Rc3ZRLca6bl/1GbS
         /F5abFK7q//4w5lFlpAnKuesKvWEO+sQttmRx+n36qnUU6GB7yy8PmMVxBcEeNV7QS58
         Xb0SruS8lOYhGP9JycI6F/a2p3nm0YrjHQchghCGO87ZHGNAt6jGypzdG7AEbQie005R
         4Vag==
X-Gm-Message-State: AOAM530kSlXRLwJS7REkwHrZOR2pF+DpS7xdXlpnUGdsQAnxJEF5LLSq
        rVBMSx2hhAuAbLXgyDyotfeGeysp9D+ohtRI
X-Google-Smtp-Source: ABdhPJy6N9+dFeejmbDr9JqrSwJKIgbTh6TwSyQM8a9wHfl3H1m1D0RJmei8ReRj6d+FQhYuRT6dFA==
X-Received: by 2002:a17:906:33cc:b0:711:609f:8a63 with SMTP id w12-20020a17090633cc00b00711609f8a63mr29709335eja.128.1654903196922;
        Fri, 10 Jun 2022 16:19:56 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id q4-20020a50aa84000000b0042617ba638esm343800edc.24.2022.06.10.16.19.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 16:19:55 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso351090wml.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 16:19:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3485:b0:39c:7db5:f0f7 with SMTP id
 a5-20020a05600c348500b0039c7db5f0f7mr2015707wmq.8.1654903194928; Fri, 10 Jun
 2022 16:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <165489100590.703883.11054313979289027590.stgit@warthog.procyon.org.uk>
In-Reply-To: <165489100590.703883.11054313979289027590.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jun 2022 16:19:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgeW2nF5MZzmx6cPmS8mbq0kjP+VF5V76LNDLDjJ64hUA@mail.gmail.com>
Message-ID: <CAHk-=wgeW2nF5MZzmx6cPmS8mbq0kjP+VF5V76LNDLDjJ64hUA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] netfs, afs: Cleanups
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Jeff Layton <jlayton@kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:56 PM David Howells <dhowells@redhat.com> wrote:
>
> Here are some cleanups, one for afs and a couple for netfs:

Pulled,

               Linus
