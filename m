Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B393369CBDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 14:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjBTNRb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 08:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBTNRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:17:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324DC1A677;
        Mon, 20 Feb 2023 05:17:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0103B80C9F;
        Mon, 20 Feb 2023 13:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67ADC433D2;
        Mon, 20 Feb 2023 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676899042;
        bh=aK7/lUghxm4/K4b3qdHBRELpUECkYr5KgsvOJsR33WI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9BtoYtGS9YW5yEB2JEa3aa8s6ESdelGXK0wIU1H3CSL3CBNJo7vI8UxqlaqACUsn
         L5sVLnGybMby7WPQfTY++XUywqOAGJkGrDqEAtrn7/QK7vXPAQD6QA/vMzzX49sayi
         ccKIXEUZTGD1iJnU1vhLBYKjT1y0FAF73P5qkt7mbKn1Y+kBovNBGTHnLTRuOetIns
         pjtcebUcDfQSgmBQOQAcKZr89qfiTHbISXe5YShBeubnZgtaMcFhogz067Uuf/Gzft
         0x29Cuf9IUNBPczhjAlNJ3AtNA7QbxPxppYrHwA3qgJZRLOSGVxzInUOwN25T3dVEZ
         9Djarp8mtAA+w==
Date:   Mon, 20 Feb 2023 15:17:02 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y/NyzkiZPTBi3Rhc@kernel.org>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <Y+9SjpwS9LsRKQz0@kernel.org>
 <05962e92-9d14-eaf9-2e0b-d683986c9d7f@collabora.com>
 <da84e16e-ba8f-db2a-fbc5-c05fe730758c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da84e16e-ba8f-db2a-fbc5-c05fe730758c@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 20, 2023 at 04:38:10PM +0500, Muhammad Usama Anjum wrote:
> On 2/20/23 3:38 PM, Muhammad Usama Anjum wrote:
> >>> +#define PAGEMAP_BITS_ALL		(PAGE_IS_WRITTEN | PAGE_IS_FILE |	\
> >>> +					 PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
> >>> +#define PAGEMAP_NON_WRITTEN_BITS	(PAGE_IS_FILE |	PAGE_IS_PRESENT | PAGE_IS_SWAPPED)
> >>> +#define IS_WP_ENGAGE_OP(a)		(a->flags & PAGEMAP_WP_ENGAGE)
> >>> +#define IS_GET_OP(a)			(a->vec)
> >>> +#define HAS_NO_SPACE(p)			(p->max_pages && (p->found_pages == p->max_pages))
> >>> +
> >>> +#define PAGEMAP_SCAN_BITMAP(wt, file, present, swap)	\
> >>> +	(wt | file << 1 | present << 2 | swap << 3)
> >>> +#define IS_WT_REQUIRED(a)				\
> >>> +	((a->required_mask & PAGE_IS_WRITTEN) ||	\
> >>> +	 (a->anyof_mask & PAGE_IS_WRITTEN))
> >> All these macros are specific to pagemap_scan_ioctl() and should be
> >> namespaced accordingly, e.g. PM_SCAN_BITS_ALL, PM_SCAN_BITMAP etc.
> >>
> >> Also, IS_<opname>_OP() will be more readable as PM_SCAN_OP_IS_<opname> and
> >> I'd suggest to open code IS_WP_ENGAGE_OP() and IS_GET_OP() and make
> >> HAS_NO_SPACE() and IS_WT_REQUIRED() static inlines rather than macros.
> > Will do in next version.
> > 
> 
> IS_WP_ENGAGE_OP() and IS_GET_OP() which can be renamed to
> PM_SCAN_OP_IS_WP() and PM_SCAN_OP_IS_GET() seem better to me instead of
> open code as they seem more readable to me. I can open code if you insist.

I'd suggest to see how the rework of pagemap_scan_pmd_entry() paves out. An
open-coded '&' is surely clearer than a macro/function, but if it's buried
in a long sequence of conditions, it may be not such clear win.
 
> -- 
> BR,
> Muhammad Usama Anjum

-- 
Sincerely yours,
Mike.
