Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE29B765B8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjG0Spz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 14:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjG0Spy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:45:54 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F2030ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 11:45:51 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58459a6f42cso13377997b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690483551; x=1691088351;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xHqQdtYyIKnXn6qUgFeRTtspxRDzyjax3eG0j/WwVz4=;
        b=zh8FeBjDQPL/RFGJ70RfZmhjLnD8uo8vBA+9VWjPEUsiu1t3viexxnpmTYeRQ8XS5T
         7dOfj7lPalLleT3SLnPmViwBYrnv9gfMeClC+MKzyOXyJeBjIxR2jF786VUWVvRfa0Hu
         qKNBCOPvemAItG6umswXKAwg4UnOx0uUw2Vjy4cnpCZpMFnj9sKrxQmF0qzf9vuY7gRk
         dWIorUrO7l2m0FqtGLHkCn2wrWnhZmttDJVgMfdNOl8/F1D3exXv/xuNbFsXSWYgxa1Z
         pHhbyBLF00evV9u21d0Ca2zi4MXF/TU0XuJMEhUgg9/E82EWRyVamNepRLKtRdZKRnUj
         J7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483551; x=1691088351;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHqQdtYyIKnXn6qUgFeRTtspxRDzyjax3eG0j/WwVz4=;
        b=jy/q+yV+f4mkZ7OGz6NHzeRLPWwjHV7cnKNSnN8C3e+ygs2OEJQ/lylEPp3HfI6w6u
         y4DsvLHDbrU3nm2HiHasqO0DO0Fn/wHYSrInV+fd3LL5obpMjOp4VU6w8zRD/rqbF134
         dMI6OkmuPjnBXyHrubt5nAz+0jyGKFxiCkUe9lcfTXZwXTgSoUO9QIppAF3tAd/dKIHn
         CPbuNuHH5vLUgq6aciExKHss9dmdoNIlzYIDdeT1Qm+vV7V0StOF9WYwURFKP13LSmN9
         PagLVDN+rRhYVDS/arBPw4Lrn8PxU24wcJ3SAaSnybYle0532j/Vn0W5NkTuxzpAQZrR
         EvtQ==
X-Gm-Message-State: ABy/qLaGXjquyRma8MVkIlCEnqfUsU6h9AI0s6QkjyqbKxSSN402BElE
        XhdWlOhaxfBcJKOdPYSy4QoXZw==
X-Google-Smtp-Source: APBJJlFh+/7L8UPelmuN+xS5LpMKXzgv8aDs7ZmvYMo0Qd7Cz+1PS7CAOfoClCp8nwSuDxsp2pJlnw==
X-Received: by 2002:a0d:fec3:0:b0:565:ba4e:84fc with SMTP id o186-20020a0dfec3000000b00565ba4e84fcmr84674ywf.50.1690483550907;
        Thu, 27 Jul 2023 11:45:50 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q64-20020a815c43000000b005837633d9cbsm562742ywb.64.2023.07.27.11.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:45:50 -0700 (PDT)
Date:   Thu, 27 Jul 2023 11:45:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Howells <dhowells@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] shmem: Fix splice of a missing page
In-Reply-To: <175119.1690476440@warthog.procyon.org.uk>
Message-ID: <b0d380c-d5d6-6ab1-67b5-8dc514127f8f@google.com>
References: <20230727093529.f235377fabec606e16c20679@linux-foundation.org> <20230727161016.169066-1-dhowells@redhat.com> <20230727161016.169066-2-dhowells@redhat.com> <175119.1690476440@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jul 2023, David Howells wrote:
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > This is already in mm-unstable (and hence linux-next) via Hugh's
> > "shmem: minor fixes to splice-read implementation"
> > (https://lkml.kernel.org/r/32c72c9c-72a8-115f-407d-f0148f368@google.com)
> 
> And I've already reviewed it:-)

I'm not sure whether that ":-)" is implying (good-natured) denial.

You reviewed the original on 17 April, when Jens took it into his tree;
then it vanished in a rewrite, and you didn't respond when I asked about
that on 28 June; then you were Cc'ed when I sent it to Andrew on 23 July
(where I explained about dropping two mods but keeping your Reviewed-by).

This version that Andrew has in mm-unstable includes the hwpoison fix
that we agreed on before, in addition to the len -> part fix.

Hugh
