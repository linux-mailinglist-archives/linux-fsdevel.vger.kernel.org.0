Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4CC410134
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 00:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhIQWXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 18:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhIQWXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:23:36 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08702C061574;
        Fri, 17 Sep 2021 15:22:14 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id p4so22133160qki.3;
        Fri, 17 Sep 2021 15:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/jPNdMJve/KWd/Y4SRkm6hTGIPVm3MyGY8DljibbqNI=;
        b=QqwLP3Us4ZVFTMjMgU5AFjn7iMsGnla2SZJ+LzOe8OdaUpcAAMFwrGir9T6ArgEGB7
         XCo2T64pSyhIwcval7f5pntFIBGxO7rHMYUYdF0clkWtKnQ+qKTKs7RVGxNLz6Jgg2WM
         wwQjnj+cGuVIUBATRj7IuU/XRYCY/I2YxjMf96jN6IT6I48/MzyJ7pmbw9JA+nRSmTzN
         M8GGPZceVzyHgJO4yzQPSSa2ewC8d96mTcZcOeeXqhDMDNkwSqE+g6bzT1iAKMSqNAXb
         tds16cEaXrrcCHZM6D2SqQ8uwqLWDZ934hEcpU2MmdlTWcR1naWFA5WhyzV2TRQKMsmy
         eWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/jPNdMJve/KWd/Y4SRkm6hTGIPVm3MyGY8DljibbqNI=;
        b=UMzFw2/9Y5IFo+LZBYGEX19MTyEz+yy7j7RLuswp+wZp1RsI1aQmfZxM8dVWO4MJK+
         BM1cd2kZ/xEfu9VqCiER5vN65YfNsCRhcCfkK3FW8kSzs7nMEgG5vvJbyjK1E2WB29lv
         0t0AwZCQZTdL44FlwoGqJAV2N9/60uwGg9uWMpCNMtTwadw85cOkl2xBEKlBnu+7Sh8z
         fAtALS2VYAGyjFfku1/GjgT4+8rNIkj/OFKrPi7t9e31gB2jZr5N102GKdgA9ksaezqm
         K1E484qqitgCCb3CKLjV/36LiHT9BB0ggG9L0yRO5WKK2Pav/e998r95hZHErgpKqJox
         i3Mw==
X-Gm-Message-State: AOAM532WVBgXAinAbv8zbmXm0470Bzp+nVRgv2UQ/EfYyQ/JmztLgl6t
        b8wXNz7IxD0UOJfJP2p9gsCkjy80r247
X-Google-Smtp-Source: ABdhPJyhxqWgAMwUMkp3GuqQcsFSxs2VvVCVehg+0V9IrYi7ta6rckoWQWSUGG2MuudeEO2p0knrHw==
X-Received: by 2002:a37:aa8f:: with SMTP id t137mr12790727qke.30.1631917322001;
        Fri, 17 Sep 2021 15:22:02 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a24sm3520757qtp.90.2021.09.17.15.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 15:22:01 -0700 (PDT)
Date:   Fri, 17 Sep 2021 18:21:59 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUUVB4hDI+7z1Raz@moria.home.lan>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
 <20210917205735.tistsacwwzkcdklx@box.shutemov.name>
 <YUUF1WsAoWGmeAJ4@moria.home.lan>
 <20210917220209.zhac33jiqtxvdttk@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917220209.zhac33jiqtxvdttk@box>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 18, 2021 at 01:02:09AM +0300, Kirill A. Shutemov wrote:
> I can't answer for Matthew.
> 
> Anon conversion patchset doesn't exists yet (but it is in plans) so
> there's nothing to split out. Once someone will come up with such patchset
> he has to sell it upstream on its own merit.

Perhaps we've been operating under some incorrect assumptions then. If the
current patch series doesn't actually touch anonymous pages - the patch series
does touch code in e.g. mm/swap.c, but looking closer it might just be due to
the (mis)organization of the current code - maybe there aren't any real
objections left?
