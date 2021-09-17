Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE5741010A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 00:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbhIQWDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 18:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbhIQWDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:03:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88039C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 15:02:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i4so38880864lfv.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=znAe7ewx7rCSOAdsfm/NBUX+TUdTojIOSWYXmGT9kJY=;
        b=BiV/2Re8gTOEq754wm9xZr5SQTOn6jjqymEgSYMv/GPL37PMahL91jKVHZGSuxMQ/Y
         FpCVnXYOAefaT505OcZixPlQEyFF7emGaGoCcqyaa7u5+Haj7FlHN6KjNUY0O0iZ75zD
         b6pwrA6rQhAZNxIRkuZCLwM+udhUX4qCzZ00urqfyItObHUfW5VYEi+UX7rtDt16Gi9C
         XSRvBKiuo0aDlcRyteieFM2UYe3w4t4mNG3k1ZsqhLGVMEEND1U+m5WO5ZHUZYUyCmCx
         YSS1VH09OP14J1ADc6/JQ5Wj3sk07N60cGmqYI5tnERyT5CoCVVD7Xe91gITm7SXbRrp
         pReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=znAe7ewx7rCSOAdsfm/NBUX+TUdTojIOSWYXmGT9kJY=;
        b=QXXHjLnxX+QFNa4Uj8vfuQJycsjqo1ktfYbWpIqzHyItUvqTpHD7zZy40mPWqXpRbz
         1NZfLAwQVi70GUDXljkNkvI6JTsbbqAg5xPIK9WNSkinX+7QG1fqM8a1MYyzT8LziACa
         MoFnUUaI9WvLw4vHCkLrCcDIldrfr3Gdvh7/SBHNPbs9Og+R2PN1b4HCGN2JJvmwqe9/
         xCZKhk+vVFSYgesX81NZGeo3c7PA4QifMBv9TaJqjaVxO4h0CuhtovJhlC+A8Ke+r5YB
         CzYvaTAIkJrMzoyfSSC46509VYa+wLTKQmCpgsq/piL15t/kM0rnlDPFPmMDsNmfdmbB
         02IA==
X-Gm-Message-State: AOAM531cadcfzrsBrsBrB+D/CS3Aqq8vTl2qWW/wltTj4sWDKNRAqJ2q
        HzY7A4i7lGn6s1BFyN69rRlyKg==
X-Google-Smtp-Source: ABdhPJyf4+itBme+L5CJNkEh3rv/yMj9GUuPX48RaK3E/af8ir/KWxFqHjLMEmbr1OBIHEQbNgBRKg==
X-Received: by 2002:a05:6512:344f:: with SMTP id j15mr9427594lfr.56.1631916131856;
        Fri, 17 Sep 2021 15:02:11 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o21sm616352lfu.4.2021.09.17.15.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 15:02:11 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 52ECD103041; Sat, 18 Sep 2021 01:02:09 +0300 (+03)
Date:   Sat, 18 Sep 2021 01:02:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kent Overstreet <kent.overstreet@gmail.com>
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
Message-ID: <20210917220209.zhac33jiqtxvdttk@box>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
 <20210917205735.tistsacwwzkcdklx@box.shutemov.name>
 <YUUF1WsAoWGmeAJ4@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUUF1WsAoWGmeAJ4@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 05:17:09PM -0400, Kent Overstreet wrote:
> On Fri, Sep 17, 2021 at 11:57:35PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Sep 17, 2021 at 12:31:36PM -0400, Johannes Weiner wrote:
> > > I didn't suggest to change what the folio currently already is for the
> > > page cache. I asked to keep anon pages out of it (and in the future
> > > potentially other random stuff that is using compound pages).
> > 
> > It would mean that anon-THP cannot benefit from the work Willy did with
> > folios. Anon-THP is the most active user of compound pages at the moment
> > and it also suffers from the compound_head() plague. You ask to exclude
> > anon-THP siting *possible* future benefits for pagecache.
> > 
> > Sorry, but this doesn't sound fair to me.
> 
> I'm less concerned with what's fair than figuring out what the consensus is so
> we can move forward. I agree that anonymous THPs could benefit greatly from
> conversion to folios - but looking at the code it doesn't look like much of that
> has been done yet.
> 
> I understand you've had some input into the folio patches, so maybe you'd be
> best able to answer while Matthew is away - would it be fair to say that, in the
> interests of moving forward, anonymous pages could be split out for now? That
> way the MM people gain time to come to their own consensus and we can still
> unblock the FS work that's already been done on top of folios.

I can't answer for Matthew.

Anon conversion patchset doesn't exists yet (but it is in plans) so
there's nothing to split out. Once someone will come up with such patchset
he has to sell it upstream on its own merit.

Possible future efforts should not block code at hands. "Talk is cheap.
Show me the code."

-- 
 Kirill A. Shutemov
