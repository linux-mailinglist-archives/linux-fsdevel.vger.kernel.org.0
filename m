Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13F409BDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 20:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346588AbhIMSLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 14:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346562AbhIMSLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:11:35 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45886C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Sep 2021 11:10:19 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g11so8905622qtk.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Sep 2021 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CrTVtOmuoVf96nTz7kdFQqbCSVSV3Q0MJ1SBqM620bA=;
        b=rz8dgkQc9No0pdPKYoTN02+zFUzynYahwSz0IDpfNXzhpDj9cUye/fY4OMS9zG1tRi
         5ciewBsc9nwisACmpHlIWZ3wxX2L+7AgD3ff0mYtnk9TCXin1RANN2wSDyTQgvdVMpw6
         U+uQMLb7b+iyqAarJxk3vHZWPN3JCEaCm6CXnJoLuXLyhCS0LbWomjixD4MrxQnR3S8j
         U3IWknP8CN0rfpAhJ0O0C8wurzEmSDBsMUEnCGCayf2Q3jDlbHIm2QB+kAghaDA9m8b4
         Pkd7R8QiwhuoCnNuqcI1iH+DiVesej6zB7o4rrPzzYRfMf55BUxL9i6W8ECN6vy77fe2
         Qk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CrTVtOmuoVf96nTz7kdFQqbCSVSV3Q0MJ1SBqM620bA=;
        b=fNDMxdB65bRFjeNtDZTYaesPNw0xDZWJckJaKP0WVxyzuEA2LMuxOauInJAQNSyo+4
         tUot2OC2YBVKw4X2ALbgD3V/cHOmB5Y2G/4RgFvqxl0GENoLa3MADwF5VCEcJ9ZOhP6n
         dUhMClkF9nUnwpHHFrSzMo8M1QGnlCDZrvadNTjCKnbijFzdJ/fX6j7I2NfN700+xOra
         j1TkzQMjVCSpHbnYwL5joYeNFSmaW2rTUSQ/Ntc5xVEEzL6dmcrFV+tUEqiF63XAjO2J
         wCqw2AbEWcXPFzXa/2gpP6/+497+OSKUJY5cljrQD50iUOz8rSbt35c9HabNGnKsLNaN
         0Uhw==
X-Gm-Message-State: AOAM533G0bongDvMhxALeIwLxrAONsDT8e2QOdtt4j8FDL6kRHdUfUEJ
        fDTw+zYADUYzxbovfyuuudo3E/KUAYLjGQ==
X-Google-Smtp-Source: ABdhPJxNvWeBzeXxgZ6yLYj86fQHbWdUKXNVfIYcjfa6FiOPfjujqLW6MccyXCdfczNfqFKptn6JgA==
X-Received: by 2002:ac8:7dc6:: with SMTP id c6mr817719qte.25.1631556618418;
        Mon, 13 Sep 2021 11:10:18 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id b12sm5554868qkk.3.2021.09.13.11.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:10:17 -0700 (PDT)
Date:   Mon, 13 Sep 2021 14:12:12 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YT+UfEH72o+Uabxv@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <20210911012324.6vb7tjbxvmpjfhxv@box.shutemov.name>
 <YT82zg6UE9DtQLhL@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT82zg6UE9DtQLhL@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:32:30PM +0200, Michal Hocko wrote:
> The existing code (fs or other subsystem interacting with MM) is
> going to require quite a lot of changes to move away from struct
> page notion but I do not see folios to add fundamental blocker
> there.

The current folio seems to do quite a bit of that work, actually. But
it'll be undone when the MM conversion matures the data structure into
the full-blown new page.

It's not about hopes and dreams, it's the simple fact that the patches
do something now that seems very valuable, but which we'll lose again
over time. And avoiding that is a relatively minor adjustment at this
time compared to a much larger one later on.

So yeah, it's not really a blocker. It's just a missed opportunity to
lastingly disentangle struct page's multiple roles when touching all
the relevant places anyway. It's also (needlessly) betting that
compound pages can be made into a scalable, reliable, and predictable
allocation model, and proliferating them into fs/ based on that.

These patches, and all the ones that will need to follow to finish the
conversion, are exceptionally expensive. It would have been nice to
get more out of this disruption than to identify the relatively few
places that genuinely need compound_head(), and having a datatype for
N contiguous pages. Is there merit in solving those problems? Sure. Is
it a robust, forward-looking direction for the MM space that justifies
the cost of these and later patches? You seem to think so, I don't.

It doesn't look like we'll agree on this. But I think I've made my
points several times now, so I'll defer to Linus and Andrew.
