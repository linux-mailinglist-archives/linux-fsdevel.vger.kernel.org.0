Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18776C2FAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 11:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCUK6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 06:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjCUK6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:58:22 -0400
Received: from harvie.cz (harvie.cz [77.87.242.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B40E87688;
        Tue, 21 Mar 2023 03:58:20 -0700 (PDT)
Received: from anemophobia.amit.cz (unknown [31.30.84.130])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by harvie.cz (Postfix) with ESMTPSA id A641818037F;
        Tue, 21 Mar 2023 11:58:19 +0100 (CET)
From:   Tomas Mudrunka <tomas.mudrunka@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rppt@kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, tomas.mudrunka@gmail.com
Subject: Re: Re: [PATCH] Add results of early memtest to /proc/meminfo
Date:   Tue, 21 Mar 2023 11:58:12 +0100
Message-Id: <20230321105812.9257-1-tomas.mudrunka@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230317165637.6be5414a3eb05d751da7d19f@linux-foundation.org>
References: <20230317165637.6be5414a3eb05d751da7d19f@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_PASS,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> meminfo is rather top-level and important.  Is this data sufficiently
> important to justify a place there?

There is already "HardwareCorrupted" which is similar, but for
errors reported by ECC, so it makes sense to have both in single place.

> Please describe the value.  The use-case(s).  Why would people want
> this?

When running large fleet of devices without ECC RAM it's currently not
easy to do bulk monitoring for memory corruption. You have to parse dmesg,
but that's ring buffer so the error might disappear after some time.
In general i do not consider dmesg to be great API to query RAM status.

In several companies i've seen such errors remain undetected and cause
issues for way too long. So i think it makes sense to provide monitoring
API, so that we can safely detect and act upon them.

> Comment layout is unconventional.

Fixed in PATCH v2

> Coding style is unconventional (white spaces).
> I expect this code would look much cleaner if some temporaries were used.

Fixed in PATCH v2

> I don't understand this logic anyway.  Why not just print the value of
> early_memtest_bad_size>>10 and be done with it.

I think 0 should be reported only when there was no error found at all.
If memtest detect 256 corrupt bytes it would report 0 kB without such logic.
Rounding down to 0 like that is not a good idea in my opinion,
because it will hide the fact something is wrong with the RAM in such case.
Therefore i've added logic that prevents rounding down to 0.

> The name implies a bool, but the comment says otherwise.

Fixed in PATCH v2

> It's a counter, but it's used as a boolean.  Why not make it bool, and do

Fixed in PATCH v2

> Also, your email client is replacing tabs with spaces.

Fixed in PATCH v2
