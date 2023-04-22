Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D626EB64F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 02:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjDVAPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 20:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjDVAPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 20:15:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C0E56
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 17:14:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b51fd2972so2300870b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 17:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1682122497; x=1684714497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFKti6NhFrOmzRAC+SHrdFDeKbNA3mUM9FV9DFzwcIY=;
        b=YFGDGJg+ycE0mNmKO4+mMxKlyNIeLyuiw3BMeu7/FLkdr9I7ue2w6t8LGmkLEryGCq
         aSueVAqkePVUC2bFRZNHMsqoqTTZapcFXkSWoSxWX5LNi0NEMo3DpFS/DY4BQhUjhZkD
         ei+0auvF6ES9BqdBcOQ3B7szfVz9qrZTVv1B5d8vvivr4oarGy7gqpUgjECURVPTNOM8
         b7IraIQW5URwK5J/jVTx6zA/38KMYSXFOhbPYEl2EQvgP+czTYMeKImIfYqvycbGHHUY
         eXJo646zdyKoWzbYlDgZGjqVsbuE6lv4c2vPTsD7nBXbSme6NRNTTHcSlPZyv0mZhVn0
         1/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682122497; x=1684714497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFKti6NhFrOmzRAC+SHrdFDeKbNA3mUM9FV9DFzwcIY=;
        b=NzeICKUbgi4rhXqkrZ/MMQuNQvewvi+IrGVn50Wop/A3B2GdtgWkRAc8OGuAz+zTx+
         cojX5OkXrxY8Qra/zLkYfaXFD7a8KvT0Ld90+kDB6dGY0xy7zWqFk1olDHwjE7ywp/5F
         Qd35vSg5Owxs2rH7gXwRteG59DM9+ooxgD0ip6rNnnigyg66bpCttq2FzUWNhB/cRu6B
         9c//99Ih5dawpT400dqsczNZoIf7ogeHew2nGv7U2zJBr0UO/yIuZ4RrrPqLJBuVEGHV
         d54B48mIJB2jAH1H7U0cvjuURI+ZJcxd5J+yWd6VDCMCXFF2kYSoKfX2bFdc557grBbi
         RAcg==
X-Gm-Message-State: AAQBX9dpyntAj+YNyLjzGs6usMcIOH7demqDJ09gkV/OWty2SnsBDDm4
        yOo+VFrqzT7dkBsR+zhBqaZKSA==
X-Google-Smtp-Source: AKy350ZwCB2cO5PjKw8A5mYFxgInZC/72E653X9oHmykJSFde1WXxXFAjEl6WR9nQRZVxGPb1WVXjQ==
X-Received: by 2002:a05:6a21:3396:b0:f0:6aaf:1abf with SMTP id yy22-20020a056a21339600b000f06aaf1abfmr10590477pzb.4.1682122497145;
        Fri, 21 Apr 2023 17:14:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id b3-20020a631b03000000b0050f93a3586fsm3004610pgb.37.2023.04.21.17.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 17:14:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pq0ty-006FW0-2f; Sat, 22 Apr 2023 10:14:54 +1000
Date:   Sat, 22 Apr 2023 10:14:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, SSDR Gost Dev <gost.dev@samsung.com>
Subject: Re: [PATCH] mm/filemap: allocate folios according to the blocksize
Message-ID: <20230422001454.GQ447837@dread.disaster.area>
References: <CGME20230414134914eucas1p1f0b08409dce8bc946057d0a4fa7f1601@eucas1p1.samsung.com>
 <20230414134908.103932-1-hare@suse.de>
 <2466fa23-a817-1dee-b89f-fcbeaca94a9e@samsung.com>
 <a826abe1-332f-22db-982c-ecec67a40585@suse.de>
 <1c76a3fe-5b7a-6f22-78e1-da4a54497ecd@samsung.com>
 <20230420150355.GG360881@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420150355.GG360881@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 20, 2023 at 08:03:55AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 20, 2023 at 02:28:36PM +0200, Pankaj Raghav wrote:
> > On 2023-04-20 14:19, Hannes Reinecke wrote:
> > >>
> > >> **Questions on the future work**:
> > >>
> > >> As willy pointed out, we have to do this `order = mapping->host->i_blkbits - PAGE_SHIFT` in
> > >> many places. Should we pursue something that willy suggested: encapsulating order in the
> > >> mapping->flags as a next step?[1]
> > >>
> > >>
> > >> [1] https://lore.kernel.org/lkml/ZDty+PQfHkrGBojn@casper.infradead.org/
> 
> I wouldn't mind XFS gaining a means to control folio sizes, personally.
> At least that would make it easier to explore things like copy on write
> with large weird file allocation unit sizes (2MB, 28k, etc).

[random historical musings follow]

Ah, how things go full circle. This is how XFS originally worked on
Irix - it had read and write IO sizes that it used to control the
size of buffers allocated ifor caching data in the per-inode chunk
cache. That stuff was in the original port to Linux, we even had a
mount option to allow users to determine preferred IO sizes
(biosize) but that was removed in 2019 ago because it hadn't
done anything for more than a decade.

That was done around the same time the mp->m_readio_blocks and
mp->m_writeio_blocks variables that it originally influenced were
removed.  Extent allocation sizes are still influenced this way by
the allocsize mount option and m_writeio_blocks was renamed
m_allocsize_blocks to keep this functionality for extent
allocation...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
