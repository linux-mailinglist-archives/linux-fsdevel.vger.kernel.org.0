Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37EC69767E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 07:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjBOGiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 01:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjBOGiH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:38:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5116244A9;
        Tue, 14 Feb 2023 22:38:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F23DB81F8C;
        Wed, 15 Feb 2023 06:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98798C433D2;
        Wed, 15 Feb 2023 06:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676443080;
        bh=nbfks5SxqpR0gszR04yvv2KhvKHnEe8MOnFIrLhiFeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=banI3owiXJMy4ikQsPCws6BAl+NVP/yRML79hRHm+Cnwifzt7jE2PIYEV62dfrP45
         C1Wu4BDDNJQjjLFHzsCJh+5tVobqqS0SE3axS851ssrcuRWzv1TUjO7KcI7R+UmVky
         Fv5GTCz3DtvW2/ILGMCQzooaPjvDQFr99L6sKhDmm3TSkIiLvrC7emttWZCiE4oIQm
         kCfrOMyyoCHgvK/PjzKTwqQvUNA5Zmne6PUB+hwZAG7jaD1/VMkt15ZO6Nlajuqkbd
         /niuTN2iphHLaPwTwbCfDLY9hU2bldFDVUX0+WAdwP1LKi67U0IFoExjnTSXSJsVFS
         sPJNIO/4dBqrQ==
Date:   Wed, 15 Feb 2023 08:37:43 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nadav Amit <namit@vmware.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Subject: Re: [PATCH] mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to install
 WP PTEs
Message-ID: <Y+x9tx8faNzvZAug@kernel.org>
References: <20230214215046.1187635-1-axelrasmussen@google.com>
 <Y+wIdeu3Lw/3kmXg@casper.infradead.org>
 <CAJHvVciR=inDaKnmCfCQsxgBsJB6eQVDXQw67o0Foc9ofgbuow@mail.gmail.com>
 <Y+woHZ3AHe3quadT@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+woHZ3AHe3quadT@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 07:32:29PM -0500, Peter Xu wrote:
> On Tue, Feb 14, 2023 at 02:37:51PM -0800, Axel Rasmussen wrote:
> > Agreed, it would likely be a nice cleanup. Peter, any objections? I
> > wouldn't mind writing a commit to do this sort of refactor, and rebase
> > my change on top of that.
> 
> No objection here.  Personally I actually prefer keeping the parameters
> around if possible because it's straightforward and no thinking of any
> possible indirect accesses all over the place. But maybe growing as long as
> 8 is still a moot point..  It's just that I don't really know whether it'll
> look that good if we put everything into a struct*.
> 
> Things like src_start/dst_start/.. do not look good to be there: each layer
> could loop over its own range of start/end/... so even if not in the
> function parameter we'll need a variable to hold them anyway.
> 
> But I do see a few low hanging fruits:
> 
>   - I don't see why we need to pass over mmap_changing over all of the
>     __mcopy_atomic() callers.  One chance is we simply pass in the ctx* to
>     replace "dst_mm + mmap_changing".

Now ctx* is completely private to fs/userfaultfd.c and I think it'd be
better to keep it this way.
 
>   - Merge mcopy_atomic_mode and mode, having last 2 bits for the existing
>     three modes, then bit 3 for WP, good enough to set it for the new case.

Agree, having flags instead of an enum and bools sounds better to me.
 
>   - Optionally, we can avoid passing over dst_mm/src_mm all around, when
>     dst_vma/src_vma is there?

+1
 
> How about we start from simple?
> 
> -- 
> Peter Xu
> 

-- 
Sincerely yours,
Mike.
