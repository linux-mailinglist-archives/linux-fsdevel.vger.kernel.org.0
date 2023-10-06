Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB8A7BB093
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 05:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJFDsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 23:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjJFDsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:48:13 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC478DE
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 20:48:11 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59bebd5bdadso20382367b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 20:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696564091; x=1697168891; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BzpawJSlmNG1RzfXiwjSDiv93YoIZJw/vsqhpYIp/Q=;
        b=f/OGuaCU0SoRSGcpMPW2fHUjM6DB4d7woZmS/34qt0pWhC60F/wcBp4C4cgYbZRkvC
         oabv8CMt/UnM1Ujvi+j1PcagsrXvhcynEXrLnGb1rAo7MXvQvCERZQo1NjpRnITOqkzv
         XbyzkEBit8q86/06hkiCzCx1ghuAFE1Df9R4pXWqbxYxZQ2Z2pMjA+YHDDs0Sp7uA71X
         Qqie+Gt0E2yscQDPAsKcIqa4ep81fcNuVQsPOmxH8ZhG+smO7cgWKmEt51lrlUld5CUa
         eLxQgdI6wQbnvq7PFdXch/JmunzjIlozqWmfV1GrYecJnZMvJT5uzGL/Z4+5EDWmmeR3
         XlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696564091; x=1697168891;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BzpawJSlmNG1RzfXiwjSDiv93YoIZJw/vsqhpYIp/Q=;
        b=D5yu+chE1+sNyBJU1Kr+R0PwMqZWofDzLUj8lPmjzfqbR8hdTZDvGw2q80zMRJ1KdU
         qVlaYAUnEHyDKgzrWXBuYmNmhbkXvNsB6O9nIyPa8yoxf5xGv3UI0eD6qEWJKxtBMY3s
         FVvD6QqorQUSm8rLdjp1DOAqqOfCy8la7MjNy9y9d5qcXdfNCddTEkaMHvwIVXNJqTTk
         gRWqL655pYCeJM2dj5w4YmZ4JjBkbq22Tub3AbB547l1RbGruIRVENbsH1H1HxuRxgVp
         T3hMNDXsqBLWy+IEdUEiRMNemeZhMfiJKyBcHGX7187FVuA5H9xG43HBhWo/NdhNThXK
         7eWw==
X-Gm-Message-State: AOJu0YzG5p1E4bR1hmLutVLxq7c0CN7g+Ib4uKJZFuOR9UjNJGq/4l4Y
        g5FuRMwpMC614wQEFOS9G56qpSM9KI+BgRDsqyGnkw==
X-Google-Smtp-Source: AGHT+IFKYo13giuoU4JAbm3Yxs/mA1pEeUedUhqlOL/xzX3G8nGF4rXRIqpPGjn+oxsWrsZlrRyivg==
X-Received: by 2002:a0d:d54f:0:b0:5a1:f0f8:4280 with SMTP id x76-20020a0dd54f000000b005a1f0f84280mr7981311ywd.22.1696564090019;
        Thu, 05 Oct 2023 20:48:10 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v143-20020a814895000000b0059be3d854b1sm978159ywa.109.2023.10.05.20.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 20:48:08 -0700 (PDT)
Date:   Thu, 5 Oct 2023 20:48:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jan Kara <jack@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Vlastmil Babka <vbabka@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/8] shmem: factor shmem_falloc_wait() out of
 shmem_fault()
In-Reply-To: <20231003131853.ramdlfw5s6ne4iqx@quack3>
Message-ID: <b2947c43-b7c6-5e50-ae55-81757efc1adb@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com> <6fe379a4-6176-9225-9263-fe60d2633c0@google.com> <20231003131853.ramdlfw5s6ne4iqx@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 3 Oct 2023, Jan Kara wrote:
> On Fri 29-09-23 20:27:53, Hugh Dickins wrote:
> > That Trinity livelock shmem_falloc avoidance block is unlikely, and a
> > distraction from the proper business of shmem_fault(): separate it out.
> > (This used to help compilers save stack on the fault path too, but both
> > gcc and clang nowadays seem to make better choices anyway.)
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks a lot for all these reviews, Jan.  (And I particularly enjoyed
your "Autumn cleaning" remark: sweeping up the leaves, I've been glad
to have "Autumn Almanac" running through my head since reading that.)

> 
> Looking at the code I'm just wondering whether the livelock with
> shmem_undo_range() couldn't be more easy to avoid by making
> shmem_undo_range() always advance the index by 1 after evicting a page and
> thus guaranteeing a forward progress... Because the forward progress within
> find_get_entries() is guaranteed these days, it should be enough.

I'm not sure that I understand your "advance the index by 1" comment.
Since the "/* If all gone or hole-punch or unfalloc, we're done */"
change went in, I believe shmem_undo_range() does make guaranteed
forward progress; but its forward progress is not enough.

I would love to delete all that shmem_falloc_wait() strangeness;
and your comment excited me to look, hey, can we just delete all that
stuff now, instead of shifting it aside?  That would be much nicer.

And if I'd replied to you yesterday, I'd have been saying yes we can.
But that's because I hadn't got far enough through re-reading the
various July 2014 3.16-rc mail threads.  I had been excited to find
myself posting a revert of the patch; before reaching Sasha's later
livelock which ended up with "belt and braces" retaining the
shmem_falloc wait while adding the "If all gone or hole-punch" mod.

https://marc.info/?l=linux-kernel&m=140487864819409&w=2
though that thread did not resolve, and morphed into lockdep moans.

So I've reverted to my usual position: that it's conceivable that
something has changed meanwhile, to make that Trinity livelock no
longer an issue (in particular, i_mmap_mutex changed to i_mmap_rwsem,
and much later unmap_mapping_range() changed to only take it for read:
but though that change gives hope, I suspect it would turn out to be
ineffectual against the livelock); but that would have to be proved.

If there's someone who can re-demonstrate Sasha's Trinity livelock
on 3.16-with-shmem-falloc-wait-disabled, or re-demonstrate it on any
later release-with-shmem-falloc-wait-disabled, but demonstrate that
the livelock does not occur on 6.6-rc-with-shmem-falloc-wait-disabled
(or that plus some simple adjustment of hacker's choosing): that would
be great news, and we could delete all this - though probably not
without bisecting to satisfy ourselves on what was the crucial change.

But I never got around to running up Trinity to work on it originally,
nor in the years since, nor do I expect to soon.  (Vlastimil had a
good simple technique for demonstrating a part of the problem, but
fixing that part turned out not fix the whole issue with Trinity.)

Hugh
