Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3438A778366
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 00:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjHJWCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjHJWC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:02:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6602630FD;
        Thu, 10 Aug 2023 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XO1Zfx6GJ1l9WlDeH8/kq6dTqURz53+JSUpY8BZBxfk=; b=U75vcdAdN/gfb0u0MhA6ycdiaa
        jZIjL+a3hRs2kdcWbxAI2giPZCbMyZ/M9HjEqfL+gS7WzPUw3VglE9lLJvgN71wXk40idsXIO2yME
        rkFOgb0Zw2w2w/3jU9WgU/2RQlywQNha/h6PIXiYGMpFR4n2yJ/54vYB/CMg1X0npZgk5Ul902E/Z
        hSnEAR2Trk3+hfMryv/Qyt7GJKdtmB1BSEf5b1nJzVWzuDztA+MApBNvnvpzQeN2GW67u+4w9xyqB
        aV9/bBbFDdeHd9X78PcxJIDdIrsJA3IUg/wmQAn3qBZx0tLXgaDSuw3HJDnvasPM7TyNlZilS19ps
        mvdiU4Pw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUDiC-00EvmZ-1j; Thu, 10 Aug 2023 22:00:56 +0000
Date:   Thu, 10 Aug 2023 23:00:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, ying.huang@intel.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
Message-ID: <ZNVeF29xUXhDwB3U@casper.infradead.org>
References: <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
 <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com>
 <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
 <CAJuCfpERuCx6QvfejUkS-ysMxbzp3mFfhCbH=rDtt2UGzbwtyg@mail.gmail.com>
 <CAJuCfpH-drRnwqUqynTnvgqSjs=_Fwc0H_7h6nzsdztRef0oKw@mail.gmail.com>
 <CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=uD+BK6-oYX=ysQv5qQ@mail.gmail.com>
 <01e20a4a-35dc-b342-081f-0edaf8780f51@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e20a4a-35dc-b342-081f-0edaf8780f51@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:40:57AM +0200, David Hildenbrand wrote:
> I won't lie: all of these locking checks are a bit hard to get and possibly
> even harder to maintain.
> 
> Maybe better mmap unlock sanity checks as spelled out above might help
> improve part of the situation.
> 
> 
> And maybe some comments regarding the placement might help as well ;)

The placement was obvious; we can't call into drivers under the vma
lock.  Not until we've audited all of them.  I haven't yet had the
chance to figure out exactly what is being fixed with this patch ...
give me a few minutes.
