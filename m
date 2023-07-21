Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF475C5DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 13:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGUL30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGUL3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:29:25 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D923A2130;
        Fri, 21 Jul 2023 04:29:23 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4R6nQ93Z3Bz9Y;
        Fri, 21 Jul 2023 13:29:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1689938962; bh=iiAFm9Sb0xeMdwNiMPT537AwN2yZokM1k5EHJ7ew/xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CITTn8ZBorD+QLr77S4YxyuYT4mwKVe5sMOoyy/x1P46BMUtqAp/oQV/BuCfRACok
         5lmz7dU2wWqyVsSlMNrzIeNvfxdzrKxcPrbkc29tYr7rqJPqDEnwIyce+pwD7VnNtW
         cevaMD0WFH8aKLavhw4KaSv4Wx0R3lkWDvlcp4wzrwP8jFB0UyVk4kMdBkCS7F+qXX
         sWI9wtP899gxOBHzjP/IkT9NosXiTsPGsWLGyIVlHgBVh2RYfhhBmNAMjuC1CDFKkL
         +0rrUEDVUs2la0KrXe+nXee0UrctCmDp6/g+Vk/5vrucDuYP41lQvx90NOTQ38/nkQ
         idOcLrPlT1agA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Fri, 21 Jul 2023 13:29:20 +0200
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
Message-ID: <ZLpsEGZkeQECO08M@qmqm.qmqm.pl>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 21, 2023 at 03:48:22PM +0500, Muhammad Usama Anjum wrote:
> On 7/21/23 12:28 AM, Michał Mirosław wrote:
> > This is a massaged version of patch by Muhammad Usama Anjum [1]
> > to illustrate my review comments and hopefully push the implementation
> > efforts closer to conclusion. The changes are:
> Thank you so much for this effort. I also want to reach conclusion. I'll
> agree with all the changes which don't affect me. But some requirements
> aren't being fulfilled with this current design.
[...]
> #define PAGE_IS_WPASYNC		(1 << 0)
> #define PAGE_IS_WRITTEN		(1 << 1)
> You have another new flag PAGE_IS_WPASYNC. But there is no application of
> PAGE_IS_WPASYNC. We must not add a flag which don't have any user.

BTW, I'm not sure I got the PAGE_IS_WPASYNC naming right - this is to
designate pages that can be write-protected (are UFFD-registered I believe).

Best Regards
Michał Mirosław
