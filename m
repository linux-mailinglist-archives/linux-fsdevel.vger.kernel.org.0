Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177206C31F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 13:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCUMn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 08:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUMnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:43:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF28F945;
        Tue, 21 Mar 2023 05:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DF3DB8166B;
        Tue, 21 Mar 2023 12:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A45C433EF;
        Tue, 21 Mar 2023 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679402534;
        bh=DJXLZL3qhKzSZg0yYA16xG9Xycg6KPkRYGZFn8WH8io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHb1kWo4K2q7A8RJ+a3MaCsVbB0HMoAhyUpsj2mqPMF3eqeBeLI/+UgU6QIQjNF7/
         Xeqmzcy6PPqUka8X1duBZ3hfNMGq2ndukzPKDawLPp8N/KJNIoviON91Wn+2rffEI2
         VV3GXliTpV5VcqAryDSFyY04QYNVuepAnLBjnh2CvhmLZFltie1Pv2SVTPOCiwJg6m
         qgCb91dg54pggiW1iSzoMdCYna6cATElLFGz1yAjC86VAvyISgHOwiLCal4Vg/ofB3
         YcSg4p5MWyi8ntAVr/EgkfBg3J/K7/83iVamyyz5Mx1meJvFGgT2LAxex2b84XDUCA
         GHNCtAZuWHP4Q==
Date:   Tue, 21 Mar 2023 14:41:53 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
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
Subject: Re: [PATCH v11 0/7] Implement IOCTL to get and optionally clear info
 about PTEs
Message-ID: <ZBmmEfgq8QBAKPFN@kernel.org>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309115818.170dd5ef2cde7b58b9354ecd@linux-foundation.org>
 <CANaxB-wGLbM9U_dK=kzs+r5Xy358aKZ0=J_zODiLOcng+dbXog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANaxB-wGLbM9U_dK=kzs+r5Xy358aKZ0=J_zODiLOcng+dbXog@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:30:00AM -0700, Andrei Vagin wrote:
> On Thu, Mar 9, 2023 at 11:58 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu,  9 Mar 2023 18:57:11 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> >
> > > The information related to pages if the page is file mapped, present and
> > > swapped is required for the CRIU project [5][6]. The addition of the
> > > required mask, any mask, excluded mask and return masks are also required
> > > for the CRIU project [5].
> >
> > It's a ton of new code and what I'm not seeing in here (might have
> > missed it?) is a clear statement of the value of this feature to our
> > users.
> >
> > I see hints that CRIU would like it, but no description of how valuable
> > this is to CRIU's users.
> 
> Hi Andrew,
> 
> The current interface works for CRIU, and I can't say we have anything
> critical with it right now.
> 
> On the other hand, the new interface has a number of significant improvements:
> 
> * it is more granular and allows us to track changed pages more
>   effectively. The current interface can clear dirty bits for the entire
>   process only. In addition, reading info about pages is a separate
>   operation. It means we must freeze the process to read information
>   about all its pages, reset dirty bits, only then we can start dumping
>   pages. The information about pages becomes more and more outdated,
>   while we are processing pages. The new interface solves both these
>   downsides. First, it allows us to read pte bits and clear the
>   soft-dirty bit atomically. It means that CRIU will not need to freeze
>   processes to pre-dump their memory. Second, it clears soft-dirty bits
>   for a specified region of memory. It means CRIU will have actual info
>   about pages to the moment of dumping them.
> 
> * The new interface has to be much faster because basic page filtering
>   is happening in the kernel. With the old interface, we have to read
>   pagemap for each page.

There is still a caveat in using userfaultfd for tracking dirty pages in
CRIU because we still don't support C/R of processes that use uffd. 
 
> Thanks,
> Andrei
> 
> >
> > So please spend some time preparing this info.
> >
> > Also, are any other applications of this feature anticipated?  If so,
> > what are they?
> >
> > IOW, please sell this stuff to us!

-- 
Sincerely yours,
Mike.
