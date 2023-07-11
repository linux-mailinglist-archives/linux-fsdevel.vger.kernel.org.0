Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE47574E2C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 02:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGKAr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 20:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjGKAr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:47:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97826AF
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 17:47:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8ad907ba4so25361425ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 17:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1689036445; x=1691628445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QSJ4o+Lrgv9bVrzUJLTl/861qqJsTQQarDnBk/c55Fc=;
        b=f9L5Bi+TDfF8dSNl1Xp6x6Qt6+xr7LcVgpQDg9YPs215B0P65lnZAK4QVoG4EhvoPz
         CIBAuUvugM/YUgffDBa8SXNgKl3f3E4hYR5hKzO65Y0ff2lKnSEPpJwS+OHz9olqZiwe
         ZPs6j0C5n+mObYbwkUhR9u0O3cYzkglw8AILahrUxZyfbZu80oe47k03BeTxOBYx1Djg
         d3ZcfblJpWGSMzOdy+JKwO19Q2JGRKa9wjpizeb701yFjMFaakifdAyvEees+i+mmqLm
         WjXBZ9/xIk6fdT1XuZUm+Xchl1L2mAQfdu53ZJMs7vos25KUWg+Hn8vqikIgowEkKwTp
         W5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689036445; x=1691628445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSJ4o+Lrgv9bVrzUJLTl/861qqJsTQQarDnBk/c55Fc=;
        b=l3ngy1mOrc/motbC/KCgIyWzEt6Z1i6mj8mOzRVsvdtrLhpzpH0H3WAqI5w8SghK5O
         XYsbMEOniuGPV60AwIsKCl6L+X28nwRY+rJb1ucYZwKo1dWvureNu/zxPKojKQFVIEJC
         PHkJrDcuuQZgWKyh80P6rEDPVNfrqrf+gIITMlXoK4CqQUN8hawNOtGgAPVKOTZLGY+J
         ELqjKsubKEMnp/9rM4HHnP84RbzZOqfpqd6W6S0+1QVb+MGlbctBPQ2wWmw3lMc7h3xo
         8oWOHHNulCx+4fykn0odHpe7LyyVhEtzyjFqgu/+L3FAGb6v+23TpL5Lw6liNYI8Ckxx
         kmZg==
X-Gm-Message-State: ABy/qLblpOU8Sfv6qbNBVXlJhEnBRtdAc+aYM2+tDF8Dz/LFdlLG4Y5f
        chwaP1U/hMiAvG6bgijLO9kLS/RIrRs2T4wI3iQ=
X-Google-Smtp-Source: APBJJlHEWV+eZ+6RMc+5adTNnbPd7hwg9iC6ISXb8BEOQMES5BfGqajGT1gDl8TwSxVBsHb3cCOF/g==
X-Received: by 2002:a17:902:e80d:b0:1b8:b436:bef3 with SMTP id u13-20020a170902e80d00b001b8b436bef3mr12716814plg.24.1689036445024;
        Mon, 10 Jul 2023 17:47:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-246-40.pa.nsw.optusnet.com.au. [49.180.246.40])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902854400b001aad714400asm475138plo.229.2023.07.10.17.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:47:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qJ1XF-004avJ-2L;
        Tue, 11 Jul 2023 10:47:21 +1000
Date:   Tue, 11 Jul 2023 10:47:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZKymmc7viDIjd7Mm@dread.disaster.area>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-8-willy@infradead.org>
 <ZKybP22DRs1w4G3a@bombadil.infradead.org>
 <ZKydSZM70Fd2LW/q@casper.infradead.org>
 <ZKygcP5efM2AE/nr@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKygcP5efM2AE/nr@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 05:21:04PM -0700, Luis Chamberlain wrote:
> On Tue, Jul 11, 2023 at 01:07:37AM +0100, Matthew Wilcox wrote:
> > The caller hints at the
> > folio size it wants, and this code you're highlighting limits it to be
> > less than MAX_PAGECACHE_ORDER.
> 
> Yes sorry, if the write size is large we still max out at MAX_PAGECACHE_ORDER
> naturally. I don't doubt the rationale that that is a good idea.
> 
> What I'm curious about is why are we OK to jump straight to MAX_PAGECACHE_ORDER
> from the start and if there are situations where perhaps a a
> not-so-aggressive high order may be desriable. How do we know?

Decades of experience optimising IO and allocation on extent based
filesystems tell us this is the right thing to do. i.e. we should
always attempt to allocate the largest contiguous range possible for
the current operation being performed. This almost always results in
the minimum amount of metadata and overhead to index and manage the
data being stored.

There are relatively few situations where this is not the right
thing to do, but that is where per-inode behavioural control options
like extent size hints come into play....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
