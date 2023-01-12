Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50B666679E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 01:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjALA3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 19:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjALA3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:29:40 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FD82F799
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 16:29:39 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id bj3so14304710pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 16:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdjJ+qFPHeS00NuxsuodVT0aLef/544WpbdFPG95vJc=;
        b=daIIUN9/u4Kn/9NvlKYXfIj5izCgVmqoQZkPuNo3ujpktk9/zGBnZRjcDxCNhHL1Qe
         NNJOPEKKIW02Ps5O+ZHH+OsXiP8BNcTus40O8FHtXyiCosEDynWf/SrqhFaRwVKNoiqA
         oT/uzjEsrr97r7K8jJudZAm7v9zVGfsvljXS7f/FfOEjb2sRoNQstEBUVVZHJqZ+xCdQ
         7AdDFUZEpv2NYUpgpHIGxi736F93t8iPIllmDMmRnqEqCef4wYa4/YqRefQJXDLbN0vR
         PNXzRqfKLissxNE66cd7YaV5xrpl4esALfpVL4zdcyx7eW7e+MDlZn13dGMSLg1ah/vT
         9x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdjJ+qFPHeS00NuxsuodVT0aLef/544WpbdFPG95vJc=;
        b=uQWeLPiyyGnRWY6lwg5wNn/7xy33VxL79pDB4hhwhk/D+xHAr4NtF9SQ0E8SkL3br/
         kgHdrlnHVlJ3R0z+97Q05eLhbiqbJVQuDXCIWFFGYiIFp4qnyaUg15sh8XkDiMdReOJY
         MPMSKbANfQVFKSWejXcByg8jz3KpviFBYlrqJWwYfXMbTEAZaIHIPyccYcLXuUtmodIU
         Yq/IghvPG+0c1xqLi9xtpoRVTZv7uJdQgehQF3zieSHLLrYQACtersOPXbYy1aCqtQ9x
         umrbPq0VS3JASyG0UjtX9TeuPdUf5rpz1qiWgHVDo1nNMvMfjlsCYyash1G3igSLngLd
         hhuA==
X-Gm-Message-State: AFqh2krhB2VX2Z2d74+rZRcvsxQ1RXViy3uSp99W/PXRDEROBnm82kti
        BjxcuGL1NIuprGZs5CRCJmT6oQ==
X-Google-Smtp-Source: AMrXdXvDN7KNcW+rVaCYvuc2ZDsQTd8oduFefihia9SWmhk9PtRvfRa1f5oPODbU2jAm5uDd4h04Ng==
X-Received: by 2002:a17:902:e345:b0:192:b3d5:44ff with SMTP id p5-20020a170902e34500b00192b3d544ffmr38335681plc.26.1673483379139;
        Wed, 11 Jan 2023 16:29:39 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b001886ff822ffsm4210774plg.186.2023.01.11.16.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 16:29:38 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pFlTL-001z5b-LR; Thu, 12 Jan 2023 11:29:35 +1100
Date:   Thu, 12 Jan 2023 11:29:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        Catherine Hoang <catherine.hoang@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 02/14] xfs: document the general theory underlying online
 fsck design
Message-ID: <20230112002935.GD360264@dread.disaster.area>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825188.682859.4316880168755743654.stgit@magnolia>
 <e195587838b284fea6e27934d4bdee210851a40e.camel@oracle.com>
 <Y79InBUODrIaLDmC@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y79InBUODrIaLDmC@magnolia>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 03:39:08PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 11, 2023 at 01:25:12AM +0000, Allison Henderson wrote:
> > On Fri, 2022-12-30 at 14:10 -0800, Darrick J. Wong wrote:
> > > +Primary metadata objects are the simplest for scrub to process.
> > > +The principal filesystem object (either an allocation group or an
> > > inode) that
> > > +owns the item being scrubbed is locked to guard against concurrent
> > > updates.
> > > +The check function examines every record associated with the type
> > > for obvious
> > > +errors and cross-references healthy records against other metadata
> > > to look for
> > > +inconsistencies.
> > > +Repairs for this class of scrub item are simple, since the repair
> > > function
> > > +starts by holding all the resources acquired in the previous step.
> > > +The repair function scans available metadata as needed to record all
> > > the
> > > +observations needed to complete the structure.
> > > +Next, it stages the observations in a new ondisk structure and
> > > commits it
> > > +atomically to complete the repair.
> > > +Finally, the storage from the old data structure are carefully
> > > reaped.
> > > +
> > > +Because ``xfs_scrub`` locks a primary object for the duration of the
> > > repair,
> > > +this is effectively an offline repair operation performed on a
> > > subset of the
> > > +filesystem.
> > > +This minimizes the complexity of the repair code because it is not
> > > necessary to
> > > +handle concurrent updates from other threads, nor is it necessary to
> > > access
> > > +any other part of the filesystem.
> > > +As a result, indexed structures can be rebuilt very quickly, and
> > > programs
> > > +trying to access the damaged structure will be blocked until repairs
> > > complete.
> > > +The only infrastructure needed by the repair code are the staging
> > > area for
> > > +observations and a means to write new structures to disk.
> > > +Despite these limitations, the advantage that online repair holds is
> > > clear:
> > > +targeted work on individual shards of the filesystem avoids total
> > > loss of
> > > +service.
> > > +
> > > +This mechanism is described in section 2.1 ("Off-Line Algorithm") of
> > > +V. Srinivasan and M. J. Carey, `"Performance of On-Line Index
> > > Construction
> > > +Algorithms" <https://dl.acm.org/doi/10.5555/645336.649870>`_,
> > Hmm, this article is not displaying for me.  If the link is abandoned,
> > probably there's not much need to keep it around
> 
> The actual paper is not directly available through that ACM link, but
> the DOI is what I used to track down a paper copy(!) of that paper as
> published in a journal.

PDF version here:

https://minds.wisconsin.edu/bitstream/handle/1793/59524/TR1047.pdf?sequence=1

-Dave.
-- 
Dave Chinner
david@fromorbit.com
