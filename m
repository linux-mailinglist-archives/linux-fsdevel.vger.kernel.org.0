Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F4F7743EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjHHSNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjHHSMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:12:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF4372853
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 10:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CC0262880
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 17:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CD3C433C8;
        Tue,  8 Aug 2023 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691515034;
        bh=qvYqk+F8pkdTt4vnITeahRhYRXKJkWi86tvpBQmbEtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sTqf5cWJMnzqVpuYIbmsinhPG4rL/Z+RrGC1iE3Z4N61UmEqTmONyBqPW7BQ0KG9c
         cELK/QIytu63DlTEJLCOny9qR60HYBWA+m4IPb+fRsh6AOmCs8PkNwPw3k12udf7nD
         9Pxp1WFagghvTh657mN0ozaHgC8XjQXhgkHX+wdk=
Date:   Tue, 8 Aug 2023 10:17:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, david@redhat.com,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, riel@surriel.com
Subject: Re: [PATCH v1] proc/ksm: add ksm stats to /proc/pid/smaps
Message-Id: <20230808101713.766c270cc0465c3938f24182@linux-foundation.org>
In-Reply-To: <20230808170858.397542-1-shr@devkernel.io>
References: <20230808170858.397542-1-shr@devkernel.io>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue,  8 Aug 2023 10:08:58 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> With madvise and prctl KSM can be enabled for different VMA's. Once it
> is enabled we can query how effective KSM is overall. However we cannot
> easily query if an individual VMA benefits from KSM.
> 
> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
> how many of the pages are KSM pages.
> 
> Here is a typical output:
> 
> 7f420a000000-7f421a000000 rw-p 00000000 00:00 0
> Size:             262144 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:               51212 kB
> Pss:                8276 kB
> Shared_Clean:        172 kB
> Shared_Dirty:      42996 kB
> Private_Clean:       196 kB
> Private_Dirty:      7848 kB
> Referenced:        15388 kB
> Anonymous:         51212 kB
> KSM:               41376 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:             202016 kB
> SwapPss:            3882 kB
> Locked:                0 kB
> THPeligible:    0
> ProtectionKey:         0
> ksm_state:          0
> ksm_skip_base:      0
> ksm_skip_count:     0
> VmFlags: rd wr mr mw me nr mg anon
> 
> This information also helps with the following workflow:
> - First enable KSM for all the VMA's of a process with prctl.
> - Then analyze with the above smaps report which VMA's benefit the most
> - Change the application (if possible) to add the corresponding madvise
> calls for the VMA's that benefit the most

smaps is documented in Documentation/filesystems/proc.rst, please. 
(And it looks a bit out of date).

Did you consider adding this info to smaps_rollup as well?

