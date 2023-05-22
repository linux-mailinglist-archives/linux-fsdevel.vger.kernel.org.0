Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE6770BBA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjEVLWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 07:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjEVLWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 07:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04F4469B
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684754139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ErJsD6gxDGRQaeAO9BScMIVK796rMvXqIF7Umb7pOzI=;
        b=cJ6c5X54rqB6sK8D0QnpX8O1tV3tnXbs6tAW/haR+i5X/41BVp1s4L+nfL+cMMTCzhZGgV
        bXf0h9F3d3aciFdHbTsmt5GjT3vZN6I57FvWHc2qT3viyL0qpEpdTGzviuRT3IF5TJUdfs
        4gPFpA3ZhV6GDJlwhvcO8T8YVkeWElc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-xrBfZkq6OA-HfkdQ0AfMpQ-1; Mon, 22 May 2023 07:15:38 -0400
X-MC-Unique: xrBfZkq6OA-HfkdQ0AfMpQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f6accf92e2so7898841cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 04:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684754137; x=1687346137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErJsD6gxDGRQaeAO9BScMIVK796rMvXqIF7Umb7pOzI=;
        b=CjzmYFFU0o6nYVI1UJb9X8oPLXToNJu17kQdvaeMJ800U/09ZN/VslkSFvfapuaK+i
         2CkQQE5OAUgTwjAOD8uVrNq22bASIF/dpRfCh2QZI0Z942O1jZHYdqiWxP1sQdJcRrcK
         E66+TxI78z5VaLKK3u7/qFdxO46n1OjoREQOvcEWgeLIbOuA8nhw+zq+qu0l4owocwvK
         VQFwSHQ0QJKTCA6B6UHiTmG9TrvuNEPqxQX9xTWW28wYotZTHlj4fPbIetRYNYWpLRDx
         CQTOoNeo/8uC09TGS9NSUAsda8EYjeLtUvJAy1k944lMl5RoU16EWDoLmIOIluWllnrg
         2YfA==
X-Gm-Message-State: AC+VfDzh+VqpnYFtTk3ZWn/lnW1IJIlkT2JEGWwR24VUetAcshK1wG7P
        mJTwkGA5rEKESdo1WUugG6Op1kQ/ZNCn8rVHnPhRiRXVCsiXcCL+NnkXsJKfpO/ZlXuRztzFqDM
        AzsmBt2Jcdlqs1mvWVDXHzPVpP8MWh54GKQ==
X-Received: by 2002:a05:622a:1052:b0:3f4:d3a7:9827 with SMTP id f18-20020a05622a105200b003f4d3a79827mr19129379qte.25.1684754137582;
        Mon, 22 May 2023 04:15:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Ic4D5pCR+2P4o1appFOqj2U8un1L9eD+at04xBY8YouywUfP9FZpE7eW81++SzMw6Ou8qvA==
X-Received: by 2002:a05:622a:1052:b0:3f4:d3a7:9827 with SMTP id f18-20020a05622a105200b003f4d3a79827mr19129362qte.25.1684754137311;
        Mon, 22 May 2023 04:15:37 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id gd12-20020a05622a5c0c00b003f215cfab53sm1976980qtb.53.2023.05.22.04.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:15:36 -0700 (PDT)
Date:   Mon, 22 May 2023 07:18:07 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve
 performance
Message-ID: <ZGtPbzLtTsXChVLY@bfoster>
References: <ZGZPJWOybo+hQVLy@casper.infradead.org>
 <87ttw5ugse.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttw5ugse.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 10:03:05AM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Thu, May 18, 2023 at 06:23:44AM -0700, Christoph Hellwig wrote:
> >> On Wed, May 17, 2023 at 02:48:12PM -0400, Brian Foster wrote:
> >> > But I also wonder.. if we can skip the iop alloc on full folio buffered
> >> > overwrites, isn't that also true of mapped writes to folios that don't
> >> > already have an iop?
> >>
> >> Yes.
> >
> > Hm, well, maybe?  If somebody stores to a page, we obviously set the
> > dirty flag on the folio, but depending on the architecture, we may
> > or may not have independent dirty bits on the PTEs (eg if it's a PMD,
> > we have one dirty bit for the entire folio; similarly if ARM uses the
> > contiguous PTE bit).  If we do have independent dirty bits, we could
> > dirty only the blocks corresponding to a single page at a time.
> >
> > This has potential for causing some nasty bugs, so I'm inclined to
> > rule that if a folio is mmaped, then it's all dirty from any writable
> > page fault.  The fact is that applications generally do not perform
> > writes through mmap because the error handling story is so poor.
> >
> > There may be a different answer for anonymous memory, but that doesn't
> > feel like my problem and shouldn't feel like any FS developer's problem.
> 
> Although I am skeptical too to do the changes which Brian is suggesting
> here. i.e. not making all the blocks of the folio dirty when we are
> going to call ->dirty_folio -> filemap_dirty_folio() (mmaped writes).
> 
> However, I am sorry but I coudn't completely follow your reasoning
> above. I think what Brian is suggesting here is that
> filemap_dirty_folio() should be similar to complete buffered overwrite
> case where we do not allocate the iop at the ->write_begin() time.
> Then at the writeback time we allocate an iop and mark all blocks dirty.
> 

Yeah... I think what Willy is saying (i.e. to not track sub-page dirty
granularity of intra-folio faults) makes sense, but I'm also not sure
what it has to do with the idea of being consistent with how full folio
overwrites are implemented (between buffered or mapped writes). We're
not changing historical dirtying granularity either way. I think this is
just a bigger picture thought for future consideration as opposed to
direct feedback on this patch..

> In a way it is also the similar case as for mmapped writes too but my
> only worry is the way mmaped writes work and it makes more
> sense to keep the dirty state of folio and per-block within iop in sync.
> For that matter, we can even just make sure we always allocate an iop in
> the complete overwrites case as well. I didn't change that code because
> it was kept that way for uptodate state as well and based on one of your
> inputs for complete overwrite case.
> 

Can you elaborate on your concerns, out of curiosity?

Either way, IMO it also seems reasonable to drop this behavior for the
basic implementation of dirty tracking (so always allocate the iop for
sub-folio tracking as you suggest above) and then potentially restore it
as a separate optimization patch at the end of the series.

That said, I'm not totally clear why it exists in the first place, so
that might warrant some investigation. Is it primarily to defer
allocations out of task write/fault contexts? To optimize the case where
pagecache is dirtied but truncated or something and thus never written
back? Is there any room for further improvement where the alloc could be
avoided completely for folio overwrites instead of just deferred? Was
that actually the case at some point and then something later decided
the iop was needed at writeback time, leading to current behavior?

Brian

> Though I agree that we should ideally be allocatting & marking all
> blocks in iop as dirty in the call to ->dirty_folio(), I just wanted to
> understand your reasoning better.
> 
> Thanks!
> -ritesh
> 

