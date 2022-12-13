Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9E064BE38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 22:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiLMVIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 16:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiLMVIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:08:18 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4498B7D
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 13:08:17 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 4so1184278plj.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 13:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8HtIOqMFkoM34DxhjL/n1UjANbrd2BbdUnJs701v9bU=;
        b=gFTQesWe1p8qbij43jJlOA5s2Z+ZdK864v1mdzOop2wsVl4GGJpW9b1/uzOgyN2dfa
         oPe5GZG32Fx5qbHz/J12jxUV2btgB2/Vq1XNuhVUtuO+qPgSA8/+fEc086cxHKi5dxPP
         ZsRr302/bZ7wYxUNdKLYkcogr7KIX4cnhORFSrSOg4jg6NcluUzRsT6YyF+LFAVCC0wq
         Ft6b4Sf2/axdJTgktsoXky9h1ax1rujuX927/YxwzdyU2g1b/R9pH3OEnABeD+3Wx/aW
         cVr/Dj4q+644bTxk0CDevuAoq3noHNq/MUK9tqaG6uxsBZeg/r5KL2gDewPb2EYrKoPq
         Y/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HtIOqMFkoM34DxhjL/n1UjANbrd2BbdUnJs701v9bU=;
        b=RWVs3bMA5aXvVeHLHevQ0uo67K+dFGBY8K/eO7h8lldV9eN6As7FXXhEGYGEk4F9fc
         IRzQealRQ65akYNpeSF1UL3iY+8XhZPvZS7SwNi1AjUApuvM8a/RYEp5Xq6YJSBIigNr
         xmpSbBz7NGcTR56wxDSVb0vYSCXIr3hxDTIsB6egW6vX6fpGWcHO7JHWNMv+cMwXUxEB
         jRAOKMuLmUGZgHyYPmFW/v3c8X+Rfj37cpdA2dXgJ48dapzX7NofCtrleRVSogWOYpjV
         JRgne+VejBjUzCIt2SBZrkv0WpRpNB/VGjdsjBXv3J8deGqy2AQNHJqMLppmt3OxbttU
         3/AA==
X-Gm-Message-State: ANoB5pmeolKI+U5yEv4DMbp0ltkadjzip0bgM39bGKZY41XUE4L1hizd
        EXf1u3hxtR7WaMOmYlwo4Go1pg==
X-Google-Smtp-Source: AA0mqf5PKy4Bgjg27CIgo/9nyiWllBduH1BDL6LfuycxOAXlxCSnRn2CKVZqwGw///0vtuh3GviWXg==
X-Received: by 2002:a17:902:ce07:b0:180:f32c:7501 with SMTP id k7-20020a170902ce0700b00180f32c7501mr22220749plg.0.1670965697402;
        Tue, 13 Dec 2022 13:08:17 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017d97d13b18sm349507plb.65.2022.12.13.13.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 13:08:17 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5CVZ-0085ad-Sd; Wed, 14 Dec 2022 08:08:13 +1100
Date:   Wed, 14 Dec 2022 08:08:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] pagemap: add mapping_clear_large_folios()
 wrapper
Message-ID: <20221213210813.GW3600936@dread.disaster.area>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-3-aalbersh@redhat.com>
 <Y5i8igBLu+6OQt8H@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5i8igBLu+6OQt8H@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 05:55:22PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 13, 2022 at 06:29:26PM +0100, Andrey Albershteyn wrote:
> > Add wrapper to clear mapping's large folio flag. This is handy for
> > disabling large folios on already existing inodes (e.g. future XFS
> > integration of fs-verity).
> 
> I have two problems with this.  One is your use of __clear_bit().
> We can use __set_bit() because it's done as part of initialisation.
> As far as I can tell from your patches, mapping_clear_large_folios() is
> called on a live inode, so you'd have to use clear_bit() to avoid races.

I think we can do without mapping_clear_large_folios() - we
already have precedence for this sort of mapping state change with
the DAX inode feature flag.  That is, we change the on-disk state in
the ioctl context, but we don't change the in-memory inode state.
Instead, we mark it I_DONTCACHEi to get it turfed from memory with
expediency. Then when it is re-instantiated, we see the on-disk
state and then don't enable large mappings on that inode.

That will work just fine here, I think.

> The second is that verity should obviously be enhanced to support
> large folios (and for that matter, block sizes smaller than PAGE_SIZE).
> Without that, this is just a toy or a prototype.  Disabling large folios
> is not an option.

Disabling large folios is very much an option. Filesystems must opt
in to large mapping support, so they can also choose to opt out.
i.e. large mappings is a filesystem policy decision, not a core
infrastructure decision. Hence how we disable large mappings
for fsverity enabled inodes is open to discussion, but saying we
can't opt out of an optional feature is entirely non-sensical.

> I'm happy to work with you to add support for large folios to verity.
> It hasn't been high priority for me, but I'm now working on folio support
> for bufferhead filesystems and this would probably fit in.

Yes, we need fsverity to support multipage folios, but modifying
fsverity is outside the scope of initially enabling fsverity support
on XFS.  This patch set is about sorting out the on-disk format
changes and interfacing with the fsverity infrastructure to enable
the feature to be tested and verified.

Stuff like large mapping support in fsverity is a future concern,
not a show-stopper for initial feature support. We don't need every
bell and whistle in the initial merge....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
