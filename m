Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1175063417E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 17:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiKVQ3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 11:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiKVQ3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:29:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE802F037;
        Tue, 22 Nov 2022 08:29:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF6E31F85D;
        Tue, 22 Nov 2022 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669134557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4/RJcDx5W5MDWxatsZO6Jcd+cYSccjZheprFRMkSho=;
        b=X60dEluFtp4cLi1JihULzmkzaAA9/k4ioOG0n7SnZjElr35p11yH8f4Bssb8T6zKnqjhw2
        BDEDmmllzzQfnE37AD6LBoQboXkTfOwklpWC3spbAYDRkpU5ZxaFtM8EabO2lg17w4JmPI
        FG84E0lRMDGpjDhIqVm+gTJfS8SspQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669134557;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4/RJcDx5W5MDWxatsZO6Jcd+cYSccjZheprFRMkSho=;
        b=tytwOJur3SCnNybSVppd+YvRZnEtonPJqvXEuE1IgRt5Krn2SkTFWXTND8eoiVlqfQBoI0
        i1KrLu2gVmy/a2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E82B13AA1;
        Tue, 22 Nov 2022 16:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h9BSEt34fGMmOQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 22 Nov 2022 16:29:17 +0000
Message-ID: <8bb93984-a2f4-2029-7cec-bea659e77b6c@suse.cz>
Date:   Tue, 22 Nov 2022 17:29:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v1 09/20] mm/gup: reliable R/O long-term
 pinning in COW mappings
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-10-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221116102659.70287-10-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/22 11:26, David Hildenbrand wrote:
> We already support reliable R/O pinning of anonymous memory. However,
> assume we end up pinning (R/O long-term) a pagecache page or the shared
> zeropage inside a writable private ("COW") mapping. The next write access
> will trigger a write-fault and replace the pinned page by an exclusive
> anonymous page in the process page tables to break COW: the pinned page no
> longer corresponds to the page mapped into the process' page table.
> 
> Now that FAULT_FLAG_UNSHARE can break COW on anything mapped into a
> COW mapping, let's properly break COW first before R/O long-term
> pinning something that's not an exclusive anon page inside a COW
> mapping. FAULT_FLAG_UNSHARE will break COW and map an exclusive anon page
> instead that can get pinned safely.
> 
> With this change, we can stop using FOLL_FORCE|FOLL_WRITE for reliable
> R/O long-term pinning in COW mappings.
> 
> With this change, the new R/O long-term pinning tests for non-anonymous
> memory succeed:
>   # [RUN] R/O longterm GUP pin ... with shared zeropage
>   ok 151 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP pin ... with memfd
>   ok 152 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP pin ... with tmpfile
>   ok 153 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP pin ... with huge zeropage
>   ok 154 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP pin ... with memfd hugetlb (2048 kB)
>   ok 155 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP pin ... with memfd hugetlb (1048576 kB)
>   ok 156 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with shared zeropage
>   ok 157 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with memfd
>   ok 158 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with tmpfile
>   ok 159 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with huge zeropage
>   ok 160 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with memfd hugetlb (2048 kB)
>   ok 161 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with memfd hugetlb (1048576 kB)
>   ok 162 Longterm R/O pin is reliable
> 
> Note 1: We don't care about short-term R/O-pinning, because they have
> snapshot semantics: they are not supposed to observe modifications that
> happen after pinning.
> 
> As one example, assume we start direct I/O to read from a page and store
> page content into a file: modifications to page content after starting
> direct I/O are not guaranteed to end up in the file. So even if we'd pin
> the shared zeropage, the end result would be as expected -- getting zeroes
> stored to the file.
> 
> Note 2: For shared mappings we'll now always fallback to the slow path to
> lookup the VMA when R/O long-term pining. While that's the necessary price
> we have to pay right now, it's actually not that bad in practice: most
> FOLL_LONGTERM users already specify FOLL_WRITE, for example, along with
> FOLL_FORCE because they tried dealing with COW mappings correctly ...
> 
> Note 3: For users that use FOLL_LONGTERM right now without FOLL_WRITE,
> such as VFIO, we'd now no longer pin the shared zeropage. Instead, we'd
> populate exclusive anon pages that we can pin. There was a concern that
> this could affect the memlock limit of existing setups.
> 
> For example, a VM running with VFIO could run into the memlock limit and
> fail to run. However, we essentially had the same behavior already in
> commit 17839856fd58 ("gup: document and work around "COW can break either
> way" issue") which got merged into some enterprise distros, and there were
> not any such complaints. So most probably, we're fine.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

