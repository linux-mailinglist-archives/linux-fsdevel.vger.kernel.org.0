Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B10E7464F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 23:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjGCVhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 17:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCVhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:37:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED8188
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 14:37:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666ecb21f86so3983396b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jul 2023 14:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1688420242; x=1691012242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1yYukfh+CgT+RxPOIniYqFZ33Swz4P1lYS5Scmtogs=;
        b=kUFS60rsh5WTEJERHjyUxocc9x8/sIb0CCEV3Mb397K4x8Oa5rJfvHeRaT59GJ0QpL
         5LFiAax33DKQsKW3rHL0a4YHnP+W5Bx7R5hGDP1M4IM0wn+19ykFk5aFaIOxWRS1p7Fw
         fvLEi3h3wqNQRxlsgiEGgaV5iN611wanRHq7TcYir4Z4QN3RazbqII3Fnz+k0bIZLwvg
         T7NQS1C1OvVCLdFKoTRef3NWUz4r1+0J8I9K2BCffZQfbzciAoeT9YokSwMCELO2KG1k
         XHxH9zo1CXpklV0U+L/d8YLbgX4AvdEeaSsZ1M38ObzyJjWALai0/EjO/jRlUd+7l+oA
         b96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688420242; x=1691012242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1yYukfh+CgT+RxPOIniYqFZ33Swz4P1lYS5Scmtogs=;
        b=LNrwXZe2LhglZ3BKhjDKLr0JUL4gKjzAd5AaDa5MuqEuKiPl/EqoAh85tvnUXmAzXh
         SF/AcM2i0P9pf05i0NATayiDv61Ob6zNnL/zwENI9WIpHXj9pjVP2UaUD6Has7drXnKb
         WYbkl6lR5f/AqAMvzbb5WFjkBofEQOI3VBw4Z/50T1NpsJaBugKQXB3QPaXvsaiPe5OP
         5MnzBnGZUyP4hwK0fwtwhW2Me3Aec8rIWlIrtztcwVCAcunNt/G8jili0XWW409Pm+1l
         gci8Rkp3AsdAhiRjENeCTgdpa1vxkqWW1BCmeLeiEOlCLwjyYIZzJrFoIR3zVTyClbfM
         WTbg==
X-Gm-Message-State: ABy/qLagKBU7Jn3RMHRNYyZ8I5J3ZVu0P9uz+7XeIe72XaBjAPVVD0W9
        b3Vz89xlqeMLLOkXnH3nXCFafw==
X-Google-Smtp-Source: APBJJlG8cAJr0dpzAku3LWshZd9EoTaSBaJgZu/e4IEXhV2kYUK6+we/zvcjNSf+3BBEFenCLDMxag==
X-Received: by 2002:a05:6a00:14ce:b0:67f:1d30:9e51 with SMTP id w14-20020a056a0014ce00b0067f1d309e51mr15869878pfu.33.1688420242210;
        Mon, 03 Jul 2023 14:37:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-53-194.pa.vic.optusnet.com.au. [49.186.53.194])
        by smtp.gmail.com with ESMTPSA id r9-20020a63ec49000000b0050a0227a4bcsm15393528pgj.57.2023.07.03.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:37:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qGRET-001lTl-2i;
        Tue, 04 Jul 2023 07:37:17 +1000
Date:   Tue, 4 Jul 2023 07:37:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] writeback: Account the number of pages written back
Message-ID: <ZKM/jUXRjlq19AXN@dread.disaster.area>
References: <20230628185548.981888-1-willy@infradead.org>
 <20230702130615.b72616d7f03b3ab4f6fc8dab@linux-foundation.org>
 <ZKIuu6uQQJIQE640@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKIuu6uQQJIQE640@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 03, 2023 at 03:13:15AM +0100, Matthew Wilcox wrote:
> On Sun, Jul 02, 2023 at 01:06:15PM -0700, Andrew Morton wrote:
> > On Wed, 28 Jun 2023 19:55:48 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > 
> > > nr_to_write is a count of pages, so we need to decrease it by the number
> > > of pages in the folio we just wrote, not by 1.  Most callers specify
> > > either LONG_MAX or 1, so are unaffected, but writeback_sb_inodes()
> > > might end up writing 512x as many pages as it asked for.
> > 
> > 512 is a big number,  Should we backport this?
> 
> I'm really not sure.  Maybe?  I'm hoping one of the bots comes up with a
> meaningful performance change as a result of this patch and we find out.

XFS is the only filesystem this would affect, right? AFAIA, nothing
else enables large folios and uses writeback through
write_cache_pages() at this point...

In which case, I'd be surprised if much difference, if any, gets
noticed by anyone.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
