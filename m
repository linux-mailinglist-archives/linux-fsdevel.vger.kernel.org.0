Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DDA653C35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 07:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiLVGiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 01:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLVGiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:38:15 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9E9D66
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 22:38:15 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3bf4ade3364so15736417b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 22:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y4gSIgF28RollbPsw54/hu0E4Ut6AYG+KoQQV7+mh+o=;
        b=EFrAkjRoSsc9qlQOvrpQS79cB/pX+uIyaLHJM0xu660UrgFGEc6I1WHKVh6aX/IQfC
         abrpqQ+bv91iHCh3XaoTUn4bd/S9H3yh6iCw43U9pAG0dyCpkIUa0X1PvNhWEcoDjCOU
         jaIlDOTU+yS4rfS/FFCbOu+v86G7QHrJjKgMZ6vlyxglwMGX5v4KiwPXwqcmiQqwAEkk
         Tudr2yfCLyZWHiSwppAgNoT3aD3GINIO2gMNQONiMfUeVPbKhQPLdLzGQ7U7NCay4762
         wT5fLb4Oy9hUlLgcSZMoA8qkG/ToLOEbJrfAchmcl7bxRWM83lndH5DqBCaCw1GeXN0r
         SxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4gSIgF28RollbPsw54/hu0E4Ut6AYG+KoQQV7+mh+o=;
        b=G5viQQL6e9LyTI3N1+xEZ9wpolRExSXa4bwYIh7SlWVxFvPzBbqIErlXnLiH5zsLk7
         VwXLAU+Yyq4EzN0grMNqpD8yA9xIcjJ69leS58PoYx1zlEtoukKTchUZ3s6gv7HgBmFk
         QUeRxVX0nCgU/4zuurLGANQ8DfRRzvVv8iZ8GoLv6h7NwY0vGyBmWKXyA0oVINYj1d2l
         58as2z2Xe8ALSfzvu6l1mZcS0DB+1QeyZWC+nJ8hDsd+FsRlQIlUtGTzfS7S9xYpMMmE
         08fFujkOcaswp4zrOxtxco+WaRmaTL2tw4Ix0oqp+1VjAgYKgMtHt9up7X8pfQHlRB1x
         Gb9w==
X-Gm-Message-State: AFqh2kp4ZgIFlJ9PkwXkxhxgu8vI70xYJ1F8j4pz7DOq85muCCIxhdV0
        FUaSRk7tt3sf+iPym9+IAPNwrU/kHR21IP9HYeHUsQ==
X-Google-Smtp-Source: AMrXdXvD1+PT2JK6VvxehwDuBOw0Nai13a3cFth/l36puA2jAPIs0K4es53MCuGL5ybdNu0otZw0VOMuZkuY/P5S1/E=
X-Received: by 2002:a0d:d609:0:b0:459:ef5d:529c with SMTP id
 y9-20020a0dd609000000b00459ef5d529cmr616450ywd.211.1671691094167; Wed, 21 Dec
 2022 22:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20221222061341.381903-1-yuanchu@google.com>
In-Reply-To: <20221222061341.381903-1-yuanchu@google.com>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Wed, 21 Dec 2022 22:38:03 -0800
Message-ID: <CAJj2-QHCb-yJyQpEAAnEYEFvUnVGCRJ+hBzx6BGvrAkNJ=X9mw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add vma_has_locality()
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>
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

I forgot to add the Ack from Johannes earlier[1]

[1] https://lore.kernel.org/all/Y36PF972kOK3ADvx@cmpxchg.org/


Acked-by: Johannes Weiner <hannes@cmpxchg.org>
