Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6A46F799C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 01:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjEDXHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 19:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjEDXHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 19:07:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D41387C
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 16:07:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6438d95f447so789148b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 May 2023 16:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683241661; x=1685833661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHavU7b++EdxxQ22ZGGLwIbxD+Nbs7Rp71uaaeR4ax8=;
        b=IB4/C9RqnwVRnxZSBi6qJQIjFROerjiQJYMIzD6f5y9fkAA3sacIngrgECO6D9+F7z
         pOfrdBCW9N7BbTuklYOvXjCiv/19tNWVdaa3Zp1UEQUfcEt8JCBmViFg1d3kD3f7BeWK
         uwQ/O9Zz/MNpsrnWajqx8rfmXjan32ObBK7OV1IIPTyUNcU/akYeRY+I/kPXez/ijArr
         Jwv76icAio1qTl4rzj81Aaklm3//Q1dolo+sBBvmSnCvwVQnUc5VQGF3g2+/fDFOP0sg
         AoC+Xh5JtZG4znoF1ijmxwDlWOUmOFnkRMSH29qSan15fjrHlkdMu/tLpKicxUfQtevK
         KzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683241661; x=1685833661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHavU7b++EdxxQ22ZGGLwIbxD+Nbs7Rp71uaaeR4ax8=;
        b=Dnr5IRWt7pj5AU/PhNC+QSrGOEgxGqMRBomB8u9KqREKWeHMZPd+m/Sh7hepHxSZ+t
         XyMC8aCHmiEVlkVvn3OFYCreItgxy7qKMqrTe5aUOWwCxgCWfk6k+hnIJqKIKywSOTx+
         s4VFQVP6y0tURhtQNF0I1849xf+y61QZqpcps1jdz0kj9Lfvm6OLRiAMyXb6J2z938SM
         dNBsXG59vG0TQYJU3CNQOrXovkZkN4RxeeYUq1Dflt7ekFT+HhthAHpyerjjF5f+TBa/
         2+uj7rnP99UMgotfsEvTnmw5tGLCQIW6HEPT6rhoHZzwHnvRWYMbQ430BxsHumpHQBBe
         nftw==
X-Gm-Message-State: AC+VfDyBOmO56G8gkEfiFvuiQZyd2oHoVAHhIa0gaV63NwGDVjiEuBvL
        C6KcnH9Ul1//z/IT4OUSOkm8Mw==
X-Google-Smtp-Source: ACHHUZ5MoaJgTrSOj5stgXzaVIgXk8YiDWf+wdpl7iab5LUNSH4lgZjNdO61pSnHZtJLTSUHxfuqiQ==
X-Received: by 2002:a05:6a00:1a8b:b0:643:8610:1023 with SMTP id e11-20020a056a001a8b00b0064386101023mr3903338pfv.17.1683241661497;
        Thu, 04 May 2023 16:07:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b0063d2bb0d107sm191083pfn.64.2023.05.04.16.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 16:07:40 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pui2y-00BQJv-PM; Fri, 05 May 2023 09:07:36 +1000
Date:   Fri, 5 May 2023 09:07:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: always respect QUEUE_FLAG_STABLE_WRITES on the block
 device
Message-ID: <20230504230736.GA2651828@dread.disaster.area>
References: <20230504105624.9789-1-idryomov@gmail.com>
 <20230504135515.GA17048@lst.de>
 <ZFO+R0Ud6Yx546Tc@casper.infradead.org>
 <20230504155556.t6byee6shgb27pw5@quack3>
 <ZFPacOW6XMq+o4YU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFPacOW6XMq+o4YU@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 05:16:48PM +0100, Matthew Wilcox wrote:
> On Thu, May 04, 2023 at 05:55:56PM +0200, Jan Kara wrote:
> > For bdev address_space that's easy but what Ilya also mentioned is a
> > problem when 'stable_write' flag gets toggled on the device and in that
> > case having to propagate the flag update to all the address_space
> > structures is a nightmare...
> 
> We have a number of flags which don't take effect when modified on a
> block device with a mounted filesystem on it.  For example, modifying
> the readahead settings do not change existing files, only new ones.
> Since this flag is only modifiable for debugging purposes, I think I'm
> OK with it not affecting already-mounted filesystems.  It feels like a
> decision that reasonable people could disagree on, though.

I think an address space flag makes sense, because then we don't
even have to care about the special bdev sb/inode thing -
folio->mapping will already point at the bdev mapping and so do the
right thing.

That is, if the bdev changes stable_write state, it can toggle the
AS_STABLE_WRITE flag on it's inode->i_mapping straight away and all
the folios and files pointing to the bdev mapping will change
behaviour immediately.  Everything else retains the same behaviour
we have now - the stable_write state is persistent on the superblock
until the filesystem mount is cycled.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
