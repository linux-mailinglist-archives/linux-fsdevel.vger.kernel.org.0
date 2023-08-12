Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E677A067
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 16:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbjHLOWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Aug 2023 10:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbjHLOWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:22:16 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF54171F;
        Sat, 12 Aug 2023 07:22:18 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RNNCR1K35z8L;
        Sat, 12 Aug 2023 16:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1691850136; bh=u5bq7pd5Cv90/Zbgy2FhjyRSbq0SeJ3nBFKvllWi1eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3QN0PdbGboHQRbBeobFKVXGXglpVS0Mrl0gqCrK49+VoIjGt/OyVtf9lbfoSz5W7
         oXedUXsCMS59O0kX2vamz4MNt1flWx1AorUMh2Cc+gp7Gn/pbvaHsHb/n4JSDv1pfg
         v1By/PS1eu61cqPVOE3EtQ53iHf7pELje3zmG5My2sG/sjaL8GmlADrKRr0ANFf+JA
         hij/Eo1vOvA/gzdJR9QUOLskfTfw6WD77N1V+1DgRzPpsy3u/BDqGtlLsXT/tnRPHC
         MkPyYl5LxLUVuFu/NF/42rz04gFxscyMb6I63fmubnrp5lGQ4szPSjD2yxXnivZ69i
         AvvZCuk7olxxg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sat, 12 Aug 2023 16:22:09 +0200
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
Message-ID: <ZNeVkRo2ChHSpv6M@qmqm.qmqm.pl>
References: <20230809061603.1969154-1-usama.anjum@collabora.com>
 <20230809061603.1969154-3-usama.anjum@collabora.com>
 <CABb0KFGqDo8hFohqpXewoquyLVZUhG-bRHxpw_PYXzGW9wXofQ@mail.gmail.com>
 <97de19a3-bba2-9260-7741-cd5b6f4581e9@collabora.com>
 <ZNY4bz1450enHxlG@qmqm.qmqm.pl>
 <f80cc4b8-39ca-c410-655a-9abc377ec442@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f80cc4b8-39ca-c410-655a-9abc377ec442@collabora.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 08:30:16PM +0500, Muhammad Usama Anjum wrote:
> On 8/11/23 6:32 PM, Michał Mirosław wrote:
> > On Fri, Aug 11, 2023 at 05:02:44PM +0500, Muhammad Usama Anjum wrote:
> >> Now we are walking the entire range walk_page_range(). We don't break loop
> >> when we get -ENOSPC as this error may only mean that the temporary buffer
> >> is full. So we need check if max pages have been found or output buffer is
> >> full or ret is 0 or any other error. When p.arg.vec_len = 1 is end
> >> condition as the last entry is in cur. As we have walked over the entire
> >> range, cur must be full after which the walk returned.
> >>
> >> So current condition is necessary. I've double checked it. I'll change it
> >> to `p.arg.vec_len == 1`.
> > If we have walked the whole range, then the loop will end anyway due to
> > `walk_start < walk_end` not held in the `for()`'s condition.
> Sorry, for not explaining to-the-point.
> Why would we walk the entire range when we should recognize that the output
> buffer is full and break the loop?
> 
> I've test cases written for this case. If I remove `p.arg.vec_len == 1`
> check, there is infinite loop for walking. So we are doing correct thing here.

It seems there is a bug somewhere then. I'll take a look at v29.

> > [...]
> >>>> +/*
> >>>> + * struct pm_scan_arg - Pagemap ioctl argument
> >>>> + * @size:              Size of the structure
> >>>> + * @flags:             Flags for the IOCTL
> >>>> + * @start:             Starting address of the region
> >>>> + * @end:               Ending address of the region
> >>>> + * @walk_end           Address where the scan stopped (written by kernel).
> >>>> + *                     walk_end == end informs that the scan completed on entire range.
> >>>
> >>> Can we ensure this holds also for the tagged pointers?
> >> No, we cannot.
> > So this need explanation in the comment here. (Though I'd still like to
> > know how the address tags are supposed to be used from someone that
> > knows them.)
> I've looked at some documentations (presentations/talks) about tags. Tags
> is more like userspace feature. Kernel should just ignore them for our use
> case. I'll add comment.

Kernel does ignore them when reading, but what about returning a tagged
pointer? How that should work? In case of `walk_end` we can safely copy
the tag from `end` or `start` when we return exactly on of those. But what
about other addresses? When fed back as `start` any tag will work, so
the question is only what to do with pointers in the middle? We can clear
those of course - this should be mentioned in the doc - so userspace always
gets a predictable value (note: 'predictable' does not require treating
`start` and `end` the same way as addresses between them, just that what
happens is well defined). (I think making `walk_end` == `end` work
regardless of pointer tagging will make userspace happier, but I guess
doc will also make it workable. And I'm repeating myself. ;-)

Best Regards
Michał Mirosław
