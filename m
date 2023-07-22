Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD3F75D825
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jul 2023 02:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGVAW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 20:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGVAW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:22:26 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F32106;
        Fri, 21 Jul 2023 17:22:24 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4R76Z43pgsz5P;
        Sat, 22 Jul 2023 02:22:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1689985342; bh=uhOvPvV/7twD1TkGBE2kgdcyERPhWkNoVHqgcp7WTCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FG+j4BAYE0Ty7JMtC2MhcNgFEW4sl1U/DDSGmqKrKoPIOMIvIapiBWqR/m1Vt6qya
         DWvZly7it62FNDy9TMmi/khAkH9sFXi1vqhStAaB/Bd5x2niczrUMfoRCubQSaAbGs
         2/dUvylg/EuKQY16Gz/MJmpaIXaW13+WhD406uOtuVBrzHZgEs5GzTbHh5ZYJrhejQ
         oIj0tUT/VnPYthHQXHy1FkwUY/AZqfJySne9bDEeTZIcPjFwV4WUWYKjTKikJvAR+O
         4C90jpt4Jr7Nc8yXRSMYixEupdZJmnoCa/bw125UIE5qo9QQcddUntZ31SYwIO3eg6
         sNhC8D5GGCD2w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sat, 22 Jul 2023 02:22:19 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <emmir@google.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
Subject: Re: fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Message-ID: <ZLshOx1PTDa1WjBl@qmqm.qmqm.pl>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com>
 <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:50:19PM +0500, Muhammad Usama Anjum wrote:
> On 7/21/23 4:23 PM, Michał Mirosław wrote:
> > On Fri, Jul 21, 2023 at 03:48:22PM +0500, Muhammad Usama Anjum wrote:
> >> On 7/21/23 12:28 AM, Michał Mirosław wrote:
[...]
> >>>   d. change the ioctl to be a SCAN with optional WP. Addressing the
> >>> 	original use-case, GetWriteWatch() can be implemented as:
> >> As I've mentioned several times previously (without the name of
> >> ResetWriteWatch()) that we need exclusive WP without GET. This could be
> >> implemented with UFFDIO_WRITEPROTECT. But when we use UFFDIO_WRITEPROTECT,
> >> we hit some special case and performance is very slow. So with UFFD WP
> >> expert, Peter Xu we have decided to put exclusive WP in this IOCTL for
> >> implementation of ResetWriteWatch().
> >>
> >> A lot of simplification of the patch is made possible because of not
> >> keeping exclusive WP. (You have also written some quality code, more better.)
> >>>
> >>> 		memset(&args, 0, sizeof(args));
> >>> 		args.start = lpBaseAddress;
> >>> 		args.end = lpBaseAddress + dwRegionSize;
> >>> 		args.max_pages = *lpdwCount;
> >>> 		*lpdwGranularity = PAGE_SIZE;
> >>> 		args.flags = PM_SCAN_CHECK_WPASYNC;
> >>> 		if (dwFlags & WRITE_WATCH_FLAG_RESET)
> >>> 			args.flags |= PM_SCAN_WP_MATCHED;
> >>> 		args.categories_mask = PAGE_IS_WRITTEN;
> >>> 		args.return_mask = PAGE_IS_WRITTEN;
> > 
> > For ResetWriteWatch() you would:
> > 
> > args.flags = PM_SCAN_WP_MATCHING;
> > args.categories_mask = PAGE_IS_WPASYNC | PAGE_IS_WRITTEN;
> > args.return_mask = 0;
> > 
> > Or (if you want to error out if the range doesn't have WP enabled):
> > 
> > args.flags = PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC;
> > args.categories_mask = PAGE_IS_WRITTEN;
> > args.return_mask = 0;
> > 
> > (PM_SCAN_CHECK_WPASYNC is effectively adding PAGE_IS_WPASYNC to the
> > required categories.)
> Right. But we don't want to perform GET in case of ResetWriteWatch(). It'll
> be wasted effort to perform GET as well when we don't care about the dirty
> status of the pages.

This doesn't really do GET: return_mask == 0 means that there won't be any
ranges reported (and you can pass {NULL, 0} for arg.{vec, vec_len}). But
I've changed the no-GET criteria to vec == NULL (requires vec_len == 0).

> Is it possible for you to fix the above mentioned 3 things and send the
> patch for my testing:
> 1 Make GET optional
> 2 Detect partial THP WP operation and split
> 3 Optimization of moving this interesting logic to output() function
> 
> Please let me know if you cannot make the above fixes. I'll mix my patch
> version and your patch and fix these things up.

Sending as a reply.

Best Regards
Michał Mirosław
