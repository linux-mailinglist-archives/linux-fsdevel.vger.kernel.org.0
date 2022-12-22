Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9236547F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 22:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiLVVhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 16:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiLVVhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:37:38 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5046123316
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 13:37:37 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id b189so2925634vsc.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 13:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UY/dj03+2QLtFIGYOy0a9bWGSATbW0khYgL/ikJla8o=;
        b=mdwlbJDCdzR8VvaKfUlQyFB/XJl+Ydb99idTwOsiNjFveD3lm4SStfRmmwahUVwKP7
         vA53fPLgfK/aqOcSWKhS1saWIEnqup4OB2SdWaamcmEn1t/DopUfE1gAc8aF0xz1w6hF
         YMrmAkmNR3/SH1Sb4SnVTQX3jKwtwBuLNeDOA6+pAFTApFAuZGP1/3WMbRVsoZ+tmMZD
         yBhEr8v6NvebAvviJwIDp/kyWt8XuAkcGpBI1ZT7DteWdkM4/kqYFUCcZlpUoJnc9c7m
         D3XbR8Hm4ZFyS5ox3VmXLlfqVhf9TA55VSbvz+4xQUYtwax6w0xRMZ3aE0dBndX6HdH6
         H71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UY/dj03+2QLtFIGYOy0a9bWGSATbW0khYgL/ikJla8o=;
        b=oGeh5xjg3AghSrc6Ck6RL5uD0WBAyCrNmLSprI1M1c3HdnjqS7RgspdQEbrj8LvHX/
         V89B5Ffqp25vUptoGeUTVTo+Sn6/57kgruINYNRg3B0rFC61ufQxvi479XEZmcAYmcEG
         4SSC6z3fFKhPbE0Qv/7FkWHhgLtZS11smh74HXlw2nbFSwGNGEh+DUEaC1Vw0ea8FQK4
         zEti9wsM5I2Q+C627dIN9+8qKsEshta0Dq9L85uI+5Gz3rHheygXU4OH81S9z7fCg5vO
         QLcIY2X3ZlHSBDdJJA/nIzFBEftKsF4TBgKgKqL4z/22ccfw+igEPaKf19CQfI7Cr9eX
         SaRQ==
X-Gm-Message-State: AFqh2koA7q8y/UnhLbcDRyM5Mc73ye5NeoNeUDDrd2twPHM4USyqWXCb
        BvItJILxQotojdHVd90Y4d5tBS9kF9WNoKxoIWY42g==
X-Google-Smtp-Source: AMrXdXu663kyFWtM+d50+anHGuSiOFw5R5pVVbRtV4SnkDdCD/UqxlbiHsAO6KucbzMaLBJ+rC+iD36qCZDstjNb9AI=
X-Received: by 2002:a67:fb51:0:b0:3af:5ff9:ed51 with SMTP id
 e17-20020a67fb51000000b003af5ff9ed51mr900180vsr.46.1671745056292; Thu, 22 Dec
 2022 13:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20221222061341.381903-1-yuanchu@google.com> <20221222061341.381903-2-yuanchu@google.com>
In-Reply-To: <20221222061341.381903-2-yuanchu@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 22 Dec 2022 14:37:00 -0700
Message-ID: <CAOUHufZhcJh8PdVtFuoOPWBWw_fWNAB61GndXoWjekYaubXTAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: support POSIX_FADV_NOREUSE for generic fadvise handler
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
        Michael Larabel <michael@michaellarabel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 21, 2022 at 11:13 PM Yuanchu Xie <yuanchu@google.com> wrote:

Thanks for following up on this.

> POSIX_FADV_NOREUSE allows an application to specify that accesses to
> file data does not follow LRU and is used only once. Since 2.6.18 this
> is a no-op. We add FMODE_NOREUSE, checked in vma_has_locality to prevent
> LRU activation.

This needs to include what you plan to write on the man page.

A few questions to answer:
1. Does this flag work with accesses via FDs?
2. If there is a random or sequential file VMA, should the user choose
this flag or the VMA flag or both? Consider a) how those flags affect
readahead; b) their scopes, i.e., per VMA or per file.

Please also follow up with Jens to add this flag to fio.

Micheal reported that SVT-AV1 regressed with MGLRU, which is the only
real one [1]. The following not only fixes the regression but also
improves the baseline. Please follow up on that as well.

--- a/Source/App/EncApp/EbAppMain.c
+++ b/Source/App/EncApp/EbAppMain.c
@@ -115,6 +115,7 @@ void init_memory_file_map(EbConfig* config) {
             fseeko(config->input_file, curr_loc, SEEK_SET); // seek
back to that location
 #ifndef _WIN32
             config->mmap.fd = fileno(config->input_file);
+            posix_fadvise(config->mmap.fd, 0, 0, POSIX_FADV_NOREUSE);
 #endif
         }
         config->mmap.file_frame_it = 0;

[1] https://openbenchmarking.org/result/2209259-PTS-MGLRU8GB57
