Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97393739263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 00:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjFUWS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 18:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjFUWS6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543161739;
        Wed, 21 Jun 2023 15:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA99C61698;
        Wed, 21 Jun 2023 22:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6BCC433C0;
        Wed, 21 Jun 2023 22:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1687385936;
        bh=53tS1I0N40ES60UY2MzzEHFLVoHFZs8JVif+NrqbUR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RMKtd2l6NAdgqOYzztGrpCrzM2TgcEejVsCZKMtu7S+UUaDf0xD00x5P7/fQIPRcr
         IEkdp94KfVRKWZ04wJA+PeX8ep6JuG18BBTQtAdikv9egwtXY0SDeLG4bUldRDy/KP
         KKmOuU4gVXe+trU5l9opJQcemyg7JcOL0Qy1sfiw=
Date:   Wed, 21 Jun 2023 15:18:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] Revert
 "page cache: fix page_cache_next/prev_miss off by one"
Message-Id: <20230621151855.318449527a851cc0bb62fb34@linux-foundation.org>
In-Reply-To: <20230621212403.174710-1-mike.kravetz@oracle.com>
References: <20230621212403.174710-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Jun 2023 14:24:02 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> This reverts commit 9425c591e06a9ab27a145ba655fb50532cf0bcc9
> 
> The reverted commit fixed up routines primarily used by readahead code
> such that they could also be used by hugetlb.  Unfortunately, this
> caused a performance regression as pointed out by the Closes: tag.
> 
> The hugetlb code which uses page_cache_next_miss will be addressed in
> a subsequent patch.

Often these throughput changes are caused by rather random
alignment/layout changes and the code change itself was innocent.

Do we have an explanation for this regression, or was it a surprise?
