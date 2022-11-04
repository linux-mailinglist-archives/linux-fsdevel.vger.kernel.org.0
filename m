Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805E2618F20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 04:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKDDhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 23:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKDDhQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:37:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9E960F6
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 20:37:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b5so3356746pgb.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 20:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kCztCif6DGnUVPea69d1j6HBte1tInJ//NGbT2adCtA=;
        b=uj2thbHtG/d+GBBCufhO7rN+QkuEm7zsR1utnZpf1jQ6jQI6apkQTpUS2wcEmA9aNC
         VnDMe2rmlwjjtPUJR6RVdf+UJIK/YCtwiDAFrNIV7Nt++fXhl9nREiFkHf0RyMEPfvfO
         onGWmNN1ovJwkvkYC6fzzHZz7zyvVev9H3OguSEusghpv0YPPtdfeKpV8TCgCnMYqtfc
         Ksic71C8032fBMagPD7RLDMZgSbzkcCWA6HBFsZEVIK8PskhHmcNukEVkFYsBkmvmeoC
         g/qCQdT1fcwEOyEG1ZYfH8GugnyK0CKLKk6hzKwIFkwwhNd+ojc6bS3gdGaV6YzySSoe
         prLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCztCif6DGnUVPea69d1j6HBte1tInJ//NGbT2adCtA=;
        b=Z8qat19jMzeKojjd3kqsBqUu66SJuv05FrxOHwTf2D16f6/1oCW/Kyx73gtEzd5trC
         5b3Ra0TwJX8fBwYf3i0zAYu793UKtlbWymmSWW3rYssJya1ry+vIzVywqRzYsUfdcJFY
         yDdBUOSiTIBbbJfzw9Pcvw6n5c8nvwYwiiMxf8WA9bi188K4W4w1Sn6vMKHTUfiumhaH
         ZL5cr7VhoO+LdzZUUxQT0SPyAXSi20sjjQlz6/AfSmP81wNMgPdPKME9EvjfeD1lPbXc
         XEBmiLX+8AQoar8H8Ep0cYcY+D9PXDDaA30Gdt8H+5J2/90zvyUDylvxo/STNKEBZrfQ
         nAmw==
X-Gm-Message-State: ACrzQf1CB1PmP5TAw3Mugiy06uL+tu40yTCRpfCFMEBf45qqYeVusy/t
        w8hrkBecZJQZEIWUc0sCRKX8hQ==
X-Google-Smtp-Source: AMsMyM7NwhgMGw/Ejg/10+QrYuOi1WfTIe60hww1ZNfzsfJwCZnIyT2jB8JwYZIzMahLdSnJ6wzgKQ==
X-Received: by 2002:a05:6a00:2396:b0:56c:b770:eda6 with SMTP id f22-20020a056a00239600b0056cb770eda6mr33239633pfc.38.1667533023291;
        Thu, 03 Nov 2022 20:37:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b001830ed575c3sm1430190pla.117.2022.11.03.20.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:37:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oqnVr-00A1XB-Bm; Fri, 04 Nov 2022 14:36:59 +1100
Date:   Fri, 4 Nov 2022 14:36:59 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Vishal Moola <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 04/23] page-writeback: Convert write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <20221104033659.GA2703033@dread.disaster.area>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
 <20220901220138.182896-5-vishal.moola@gmail.com>
 <20221018210152.GH2703033@dread.disaster.area>
 <Y2RAdUtJrOJmYU4L@fedora>
 <20221104003235.GZ2703033@dread.disaster.area>
 <Y2R8rRr0ZdrlT32m@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2R8rRr0ZdrlT32m@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 07:45:01PM -0700, Darrick J. Wong wrote:
> On Fri, Nov 04, 2022 at 11:32:35AM +1100, Dave Chinner wrote:
> > On Thu, Nov 03, 2022 at 03:28:05PM -0700, Vishal Moola wrote:
> > > On Wed, Oct 19, 2022 at 08:01:52AM +1100, Dave Chinner wrote:
> > > > On Thu, Sep 01, 2022 at 03:01:19PM -0700, Vishal Moola (Oracle) wrote:
> > > > > -			BUG_ON(PageWriteback(page));
> > > > > -			if (!clear_page_dirty_for_io(page))
> > > > > +			BUG_ON(folio_test_writeback(folio));
> > > > > +			if (!folio_clear_dirty_for_io(folio))
> > > > >  				goto continue_unlock;
> > > > >  
> > > > >  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> > > > > -			error = (*writepage)(page, wbc, data);
> > > > > +			error = writepage(&folio->page, wbc, data);
> > > > 
> > > > Yet, IIUC, this treats all folios as if they are single page folios.
> > > > i.e. it passes the head page of a multi-page folio to a callback
> > > > that will treat it as a single PAGE_SIZE page, because that's all
> > > > the writepage callbacks are currently expected to be passed...
> > > > 
> > > > So won't this break writeback of dirty multipage folios?
> > > 
> > > Yes, it appears it would. But it wouldn't because its already 'broken'.
> > 
> > It is? Then why isn't XFS broken on existing kernels? Oh, we don't
> > know because it hasn't been tested?
> > 
> > Seriously - if this really is broken, and this patchset further
> > propagating the brokeness, then somebody needs to explain to me why
> > this is not corrupting data in XFS.
> 
> It looks like iomap_do_writepage finds the folio size correctly
> 
> 	end_pos = folio_pos(folio) + folio_size(folio);
> 
> and iomap_writpage_map will map out the correct number of blocks
> 
> 	unsigned nblocks = i_blocks_per_folio(inode, folio);
> 
> 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> 
> right?

Yup, that's how I read it, too.

But my recent experience with folios involved being repeatedly
burnt by edge case corruptions due to multipage folios showing up
when and where I least expected them.

Hence doing a 1:1 conversion of page based code to folio based code
and just assuming large folios will work without any testing seems
akin to playing russian roulette with loose cannons that have been
doused with napalm and then set on fire by an air-dropped barrel
bomb...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
