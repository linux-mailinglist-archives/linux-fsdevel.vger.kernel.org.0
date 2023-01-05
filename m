Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FA665E289
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 02:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjAEBjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 20:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAEBjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:39:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162A2009;
        Wed,  4 Jan 2023 17:39:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECF33B81983;
        Thu,  5 Jan 2023 01:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97678C433EF;
        Thu,  5 Jan 2023 01:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672882737;
        bh=Hba6ddPoEuFTAiIDFk8w8K0/JAQAQv7vkxWx0br15B0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dTardMPjP6dU0Nt3lM/chNUUy2Ia0ipFBa82JnL+BAQDimpfCGwbvTkIwTmXwc2OJ
         OIWCs0xbqjRK5ZtRyWd9GW4oW0BZYDOHuNPOMxr7n1d0/1tsJ/H++ZkCi9UR8H5Ss9
         gHXUcp4AeRhRk67n6rU7CEpSu0SZtzc/OtUcJoeA=
Date:   Wed, 4 Jan 2023 17:38:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     hughd@google.com, hannes@cmpxchg.org, david@redhat.com,
        vincent.whitchurch@axis.com, seanjc@google.com, rppt@kernel.org,
        shy828301@gmail.com, pasha.tatashin@soleen.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@Oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        bagasdotme@gmail.com, suleiman@google.com, steven@liquorix.net,
        heftig@archlinux.org, cuigaosheng1@huawei.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
Message-Id: <20230104173855.48e8734a25c08d7d7587d508@linux-foundation.org>
In-Reply-To: <20230105000241.1450843-1-surenb@google.com>
References: <20230105000241.1450843-1-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed,  4 Jan 2023 16:02:40 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> free_anon_vma_name() is missing a check for anonymous shmem VMA which
> leads to a memory leak due to refcount not being dropped.  Fix this by
> calling anon_vma_name_put() unconditionally. It will free vma->anon_name
> whenever it's non-NULL.
> 
> Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")

A cc:stable is appropriate here, yes?
