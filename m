Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA07E65461B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 19:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiLVStv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 13:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLVStm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:49:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D6120F4C;
        Thu, 22 Dec 2022 10:49:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52E69B81F46;
        Thu, 22 Dec 2022 18:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F847C433EF;
        Thu, 22 Dec 2022 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671734979;
        bh=esvXnle1q5+xJ9oU7lbX6Lc9X4hVCJBNGfUntfQ9p8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2p4QRrg4+Eo6uR0owX7gFqaGTtU5tZx8aqaI7642fWqR46XlfUJrSk33QFfHk4P1c
         hw+5J1AusVjjLriR6EAUg8y6KVRY/wV91u2VZLFMaFZzDMC8TvGmBGt64E8NgvOXIO
         70PYDQLNKMqvwMyg3j/rheYINrWqtYu0QDDfqbKE=
Date:   Thu, 22 Dec 2022 10:49:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yu Zhao <yuzhao@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: add vma_has_locality()
Message-Id: <20221222104937.795d2a134ac59c8244d9912c@linux-foundation.org>
In-Reply-To: <20221222061341.381903-1-yuanchu@google.com>
References: <20221222061341.381903-1-yuanchu@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Dec 2022 22:13:40 -0800 Yuanchu Xie <yuanchu@google.com> wrote:

> From: Yu Zhao <yuzhao@google.com>
> 
> Currently in vm_flags in vm_area_struct, both VM_SEQ_READ and
> VM_RAND_READ indicate a lack of locality in accesses to the vma. Some
> places that check for locality are missing one of them. We add
> vma_has_locality to replace the existing locality checks for clarity.

I'm all confused.  Surely VM_SEQ_READ implies locality and VM_RAND_READ
indicates no-locality?
