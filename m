Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB807790D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 15:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjHKNcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 09:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHKNcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:32:39 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D0F2D52;
        Fri, 11 Aug 2023 06:32:38 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RMl8c53QwzH1;
        Fri, 11 Aug 2023 15:32:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1691760756; bh=NfrgfFGHCga9/EC5NbBTXDZZMQ+au5SsG2T+NouDd98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrLplw1VKNapfSiTZM0ge43vU7/4YDPbdoM8upUMUpGUcvwmbVp2S1UWV1X9oowhK
         2LW9XDZUrqRegyaDh1es58iNHcJhmITsYCWxHUS6avG+8V9flhoJREZaFx4Hz5Tr9e
         xHbAy866iRFY572fHAogvK8ZCPWs9vKxuxZF9i3C601NDP84vpWwJx2KEflpIQzAf3
         2i4DDZ31Y2P5RnRZBmU5DwHDLg/COv2TbaCKYZsSI2hhLe5kHHMz2VDJ7xVuVfPthy
         E5ZR16V6YjH02Tl15rTTUWcotslLVJHCDb7ND4kC+kKsQyxri7RBlVIEb1EogZ/pBW
         P6IYc0Bt7r64w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Fri, 11 Aug 2023 15:32:31 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <emmir@google.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v28 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZNY4bz1450enHxlG@qmqm.qmqm.pl>
References: <20230809061603.1969154-1-usama.anjum@collabora.com>
 <20230809061603.1969154-3-usama.anjum@collabora.com>
 <CABb0KFGqDo8hFohqpXewoquyLVZUhG-bRHxpw_PYXzGW9wXofQ@mail.gmail.com>
 <97de19a3-bba2-9260-7741-cd5b6f4581e9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97de19a3-bba2-9260-7741-cd5b6f4581e9@collabora.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 05:02:44PM +0500, Muhammad Usama Anjum wrote:
> On 8/10/23 10:32 PM, Michał Mirosław wrote:
> > On Wed, 9 Aug 2023 at 08:16, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
[...]
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> > [...]
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +static unsigned long pagemap_thp_category(pmd_t pmd)
> >> +{
> >> +       unsigned long categories = PAGE_IS_HUGE;
> >> +
> >> +       if (pmd_present(pmd)) {
> >> +               categories |= PAGE_IS_PRESENT;
> >> +               if (!pmd_uffd_wp(pmd))
> >> +                       categories |= PAGE_IS_WRITTEN;
> >> +               if (is_zero_pfn(pmd_pfn(pmd)))
> >> +                       categories |= PAGE_IS_PFNZERO;
> >> +       } else if (is_swap_pmd(pmd)) {
> >> +               categories |= PAGE_IS_SWAPPED;
> >> +               if (!pmd_swp_uffd_wp(pmd))
> >> +                       categories |= PAGE_IS_WRITTEN;
> >> +       }
> >> +
> >> +       return categories;
> >> +}
> > I guess THPs can't be file-backed currently, but can we somehow mark
> > this assumption so it can be easily found if the capability arrives?
> Yeah, THPs cannot be file backed. Lets not care for some feature which may
> not arrive in several years or eternity.

Yes, it might not arrive. But please add at least a comment, so that it
is clearly visible that lack if PAGE_IS_FILE here is intentional.

> >> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >> +
> >> +#ifdef CONFIG_HUGETLB_PAGE
> >> +static unsigned long pagemap_hugetlb_category(pte_t pte)
> >> +{
> >> +       unsigned long categories = PAGE_IS_HUGE;
> >> +
> >> +       if (pte_present(pte)) {
> >> +               categories |= PAGE_IS_PRESENT;
> >> +               if (!huge_pte_uffd_wp(pte))
> >> +                       categories |= PAGE_IS_WRITTEN;
> >> +               if (!PageAnon(pte_page(pte)))
> >> +                       categories |= PAGE_IS_FILE;
> >> +               if (is_zero_pfn(pte_pfn(pte)))
> >> +                       categories |= PAGE_IS_PFNZERO;
> >> +       } else if (is_swap_pte(pte)) {
> >> +               categories |= PAGE_IS_SWAPPED;
> >> +               if (!pte_swp_uffd_wp_any(pte))
> >> +                       categories |= PAGE_IS_WRITTEN;
> >> +       }
> > 
> > BTW, can a HugeTLB page be file-backed and swapped out?
> Accourding to pagemap_hugetlb_range(), file-backed HugeTLB page cannot be
> swapped.

Here too a comment that leaving out this case is intentional would be useful.

> > [...]
> >> +       walk_start = p.arg.start;
> >> +       for (; walk_start < p.arg.end; walk_start = p.arg.walk_end) {
[...[
> >> +               ret = mmap_read_lock_killable(mm);
> >> +               if (ret)
> >> +                       break;
> >> +               ret = walk_page_range(mm, walk_start, p.arg.end,
> >> +                                     &pagemap_scan_ops, &p);
> >> +               mmap_read_unlock(mm);
[...]
> >> +               if (ret != -ENOSPC || p.arg.vec_len - 1 == 0 ||
> >> +                   p.found_pages == p.arg.max_pages)
> >> +                       break;
> > 
> > The second condition is equivalent to `p.arg.vec_len == 1`, but why is
> > that an ending condition? Isn't the last entry enough to gather one
> > more range? (The walk could have returned -ENOSPC due to buffer full
> > and after flushing it could continue with the last free entry.)
> Now we are walking the entire range walk_page_range(). We don't break loop
> when we get -ENOSPC as this error may only mean that the temporary buffer
> is full. So we need check if max pages have been found or output buffer is
> full or ret is 0 or any other error. When p.arg.vec_len = 1 is end
> condition as the last entry is in cur. As we have walked over the entire
> range, cur must be full after which the walk returned.
> 
> So current condition is necessary. I've double checked it. I'll change it
> to `p.arg.vec_len == 1`.

If we have walked the whole range, then the loop will end anyway due to
`walk_start < walk_end` not held in the `for()`'s condition.

[...]
> >> +/*
> >> + * struct pm_scan_arg - Pagemap ioctl argument
> >> + * @size:              Size of the structure
> >> + * @flags:             Flags for the IOCTL
> >> + * @start:             Starting address of the region
> >> + * @end:               Ending address of the region
> >> + * @walk_end           Address where the scan stopped (written by kernel).
> >> + *                     walk_end == end informs that the scan completed on entire range.
> > 
> > Can we ensure this holds also for the tagged pointers?
> No, we cannot.

So this need explanation in the comment here. (Though I'd still like to
know how the address tags are supposed to be used from someone that
knows them.)

Best Regards
Michał Mirosław
