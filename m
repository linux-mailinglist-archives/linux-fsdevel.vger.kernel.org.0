Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C754100A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 23:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhIQVSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 17:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhIQVSf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:18:35 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB8CC061574;
        Fri, 17 Sep 2021 14:17:12 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a66so21703611qkc.1;
        Fri, 17 Sep 2021 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JGV/tPQh6K9SXsu6M8jwp1WUGbsoN50z6xi39yPO454=;
        b=Smgw4tU6Y4AxmzVm12rd2uvBzsJ9XKtA0olWaSdDsaRXQKeElaIsp2OqqGviHxTJkg
         OAgrbvvrD6gh5RF2rhkyrZ7AINWX8k6T2Z7pjJpevKa/rZF4auBZYbqHKT1Z9Zwun9jp
         STY8SzKEWAhS5p/gpq/JulNTUICyZgiNH7EaHF+cin4kSJPyl47n03nmFWGznGHcv5PN
         pBRzZQesmft1Z72Of0Ronwya3/SPAnNwz1siGoGBmfaoy6Y/leHKTkTmf+MUqknvIuO7
         orzPlAJBgnRoQSu7KDOgDcR2OUO56LAoLm57n4uFBOD+cXFFgEGCIZ7eu6yF4yLdgiZ/
         n62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JGV/tPQh6K9SXsu6M8jwp1WUGbsoN50z6xi39yPO454=;
        b=TOZOjvAyhSGkFtGUE30Db9rW1kc9Na/59K57IoRN/vKde18vjtPrxIeu6wBg3FUsOP
         cQFF1t423lOe0ausSqSnokmAAiAlTG3trqrAws3tGm0YZ/fQmWiZy9+bq5KGN/pDMpj3
         zuSDRBt+cN7YTnF4ZmzzQOia2IqxR5LbqsR6zWciwkABeAaT5SaQ/7+OJOAUiO/AdGO0
         /LY3PhpOYSnw3OYaBwRKUSZXVaEO8Zdmc9eOnCcdiqV3a6wjVDRqvJmb6Vb1hdPIdBTJ
         2uGTvRig5DNPSkevIvNEoj2TNwEH/iZt06ROJhQkVPQZq+jjBt0jKGX7YFhG9JNbHg2n
         NeBA==
X-Gm-Message-State: AOAM531LS0/u8uiLtGZe9BOJtD6hFIjLfZtcBJ3Vqliw/K7xBtdRIPtB
        SHt2O0DKMPOCEKrVPJzV++QCObl6aE1h
X-Google-Smtp-Source: ABdhPJzghVCbWAFxTuwjujq3dGdZrFkmoJ7O+Xlmc64lIjwI4sM5JnmspEziweAuTU6B7uzR4GB3rw==
X-Received: by 2002:a37:ab0d:: with SMTP id u13mr12597365qke.521.1631913432191;
        Fri, 17 Sep 2021 14:17:12 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m139sm4768882qke.18.2021.09.17.14.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:17:11 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:17:09 -0400
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
Message-ID: <YUUF1WsAoWGmeAJ4@moria.home.lan>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
 <20210917205735.tistsacwwzkcdklx@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917205735.tistsacwwzkcdklx@box.shutemov.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 11:57:35PM +0300, Kirill A. Shutemov wrote:
> On Fri, Sep 17, 2021 at 12:31:36PM -0400, Johannes Weiner wrote:
> > I didn't suggest to change what the folio currently already is for the
> > page cache. I asked to keep anon pages out of it (and in the future
> > potentially other random stuff that is using compound pages).
> 
> It would mean that anon-THP cannot benefit from the work Willy did with
> folios. Anon-THP is the most active user of compound pages at the moment
> and it also suffers from the compound_head() plague. You ask to exclude
> anon-THP siting *possible* future benefits for pagecache.
> 
> Sorry, but this doesn't sound fair to me.

I'm less concerned with what's fair than figuring out what the consensus is so
we can move forward. I agree that anonymous THPs could benefit greatly from
conversion to folios - but looking at the code it doesn't look like much of that
has been done yet.

I understand you've had some input into the folio patches, so maybe you'd be
best able to answer while Matthew is away - would it be fair to say that, in the
interests of moving forward, anonymous pages could be split out for now? That
way the MM people gain time to come to their own consensus and we can still
unblock the FS work that's already been done on top of folios.
