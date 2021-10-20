Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248D94351DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhJTRtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhJTRs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:48:57 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBB8C061770;
        Wed, 20 Oct 2021 10:46:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t16so3757467qto.5;
        Wed, 20 Oct 2021 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0QHGLrhaXKpKpvs2TLQ73EmV4pXkj4boxSmu6rBcYBI=;
        b=QC2enIqbJU5zyGxfY2qJ+RKsttNvVlJw5ESsHPsKytBXHbft+70CDnDsgh+ktV9nVS
         Ts3CB7N1bU+AWe+OoT1iNM1fQ7/Qz03jgjrlfO6mTCuZabvAu2CTXBiv0diXxQVvVGVk
         tDHB0EB6JbKCWxoyYxuB9QQyvD6xB1Qi2j7kE9xm7LZ17SgKzSbWEMakcDG4qMGJPnOv
         hBD3LuP4H/LBxZUatwQPeZrFAdGd5Xptq6oi41LeQvkwpetKYmVpWDMnscZlq02PvGan
         not7BsHZ+nPN45uw0swS3CzZwxDbqsaoG6TG8P7RztE2ss7m9HtkojuZWMZ1xdmpGkv7
         Ii3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0QHGLrhaXKpKpvs2TLQ73EmV4pXkj4boxSmu6rBcYBI=;
        b=ELs0JIGH2+W1KtTBmvQPCrF4rfWnz3nsHKeEn5X1Pvbd/lTwUpDKhIjEzEMfScxyvw
         lYc9u7Bb93pSwZvnPgXhSEwLOBLN3Nai9RQrNmbOvaQpuQB1MLcATm0zIcuhg7XMoyuK
         HyA2IZFSmV08Bu8fJOuZ4dDbSgA3+cLbWbmr6xsrmr24VLDl0wVofbtEZ+RdJfjtTKCr
         c+NJfjge862wR+btatV/qgK0QZIgOqe37Sskc/kj+jcSkdSkopKREi8ldNOXo73K7RPd
         O4tuqe8nMRU7CRpiIc+4V7VvL6+GVdB85ND+19HilOAYbspD3P2gypeDt4/6PCalzhxu
         lkLw==
X-Gm-Message-State: AOAM531Qwk/vxNTpA6jfKC5THviR4MVNlWhy+Y4FioF2gt9lYXQToQw1
        td/hbYVirw6ytEcUSG22Hw==
X-Google-Smtp-Source: ABdhPJxvVuQj4BfHA6bCmmzmmBWzVAvnlqxouqMH/WH0eCclkcW4pXMJyOWKO5jl7FEMLmODG9nAIQ==
X-Received: by 2002:ac8:7458:: with SMTP id h24mr550357qtr.355.1634751987832;
        Wed, 20 Oct 2021 10:46:27 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j184sm1326545qkd.74.2021.10.20.10.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:46:27 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:46:25 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Splitting struct page into multiple types - Was: re: Folio
 discussion recap -
Message-ID: <YXBV8cFDPTzneeGu@moria.home.lan>
References: <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW25EDqynlKU14hx@moria.home.lan>
 <YW3dByBWM0dSRw/X@cmpxchg.org>
 <YW7uN2p8CihCDsln@moria.home.lan>
 <20211019170603.GA15424@hsiangkao-HP-ZHAN-66-Pro-G1>
 <YW8Bm77gZgVG2ga4@casper.infradead.org>
 <20211019175419.GA22532@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019175419.GA22532@hsiangkao-HP-ZHAN-66-Pro-G1>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 01:54:20AM +0800, Gao Xiang wrote:
> On Tue, Oct 19, 2021 at 06:34:19PM +0100, Matthew Wilcox wrote:
> > It looks like this will be quite a large change to how erofs handles
> > compressed blocks, but if you're open to taking this on, I'd be very happy.
> 
> For ->lru, it's quite small, but it sacrifices the performance. Yet I'm
> very glad to do if some decision of this ->lru field is determined.

I would be very appreciative if you were willing to do the work, and I know
others would be too. These kinds of cleanups may seem small individually, but
they make a _very_ real difference when we're looking kernel-wide at how
possible these struct page changes may be - and even if they don't happen, it
really helps understandability of the code if we can move towards a single
struct field always being used for a single purpose in our core data types.
