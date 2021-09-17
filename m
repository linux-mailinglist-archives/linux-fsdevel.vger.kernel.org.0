Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8010440F7E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 14:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244413AbhIQMiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 08:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244395AbhIQMiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:38:20 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6792AC061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 05:36:58 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a66so16914164qkc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BhAiNAxekh+7Mk4Iygi3KYU65IFuuL7Kb47IBfGnIfk=;
        b=XYEKyeF3NBbv3oexjiDdpLa1UYdACvkjSdZjJtMcVA2hBLN84ycWkeniyFvaGUdODc
         v93cZBGyQlIukacn7sdoEU6tbrSVnQAS0zzNAg7Vgg3WbgWjQ4x+5PelGf2mm7zAtwI4
         1TPznxdBEAxL5LdBwJJLsCogwEgj8raQylqjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BhAiNAxekh+7Mk4Iygi3KYU65IFuuL7Kb47IBfGnIfk=;
        b=U5u3YP2L7LdPam5RWfumMEsfgkNLHyCr+Twdwhz7UcjUKPDtLkS1IxhZx8SEO9/cri
         ekGmF+tRtSXVrDLnS1L/RlE6iTpcURrC8Ix/t3iRxTZB8w+Ehn8QVj9Il2BZAt0rDc7l
         xYx7BVeNYoVHIEyf7E3Dy3ZBY374H/nIypb2dLsos/TslqPRz5cpV6V3NGV/f6GW5K4j
         LH4DkBSDGY5yPDucaLA1aulF3pI+t5r2hkISKfB//Vm23FxtmMVeOf3GGvObZqaUgpHS
         wDay9snXtbAfuQFUHqAXEHlGa51FBbsufLUU3grQD6MnDCcj409qRPHSbJGjHxCEbUSr
         c7gA==
X-Gm-Message-State: AOAM533DQeHO59gxri9+44pmawQzwGfCI0JrFXTSt4mfLq6B7+diBMVY
        uBIFjkz7t/R24wpe3piGf4p+LA==
X-Google-Smtp-Source: ABdhPJzZAaopSRBJzCpDjUAffjFDI4E1KmOJQ2MtKxVGVsqIikUweblxv4vWt7BBaPgSNtXZ5dlN8g==
X-Received: by 2002:a05:620a:799:: with SMTP id 25mr10319005qka.119.1631882217154;
        Fri, 17 Sep 2021 05:36:57 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id d129sm4583358qkf.136.2021.09.17.05.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 05:36:56 -0700 (PDT)
Date:   Fri, 17 Sep 2021 08:36:54 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Chris Mason <clm@fb.com>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
Message-ID: <20210917123654.73sz5p2yjtd3a2np@meerkat.local>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
 <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
 <YUI5bk/94yHPZIqJ@mit.edu>
 <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
 <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
 <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
 <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
 <261D65D8-7273-4884-BD01-2BF8331F4034@fb.com>
 <20210916210046.ourwrk6uqeisi555@meerkat.local>
 <f8561816ab06cedf86138a4ad64e7ff7b33e2c07.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8561816ab06cedf86138a4ad64e7ff7b33e2c07.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 07:14:11AM -0400, James Bottomley wrote:
> > I would caution that Google docs aren't universally accessible. China
> > blocks access to many Google resources, and now Russia purportedly
> > does the same. Perhaps a similar effect can be reached with a git
> > repository with limited commit access? At least then commits can be
> > attested to individual authors.
> 
> In days of old, when knights were bold and cloud silos weren't
> invented, we had an ancient magic handed down by the old gods who spoke
> non type safe languages.  They called it wiki and etherpad ... could we
> make use of such tools today without committing heresy against our
> cloud overlords?

You mean, like https://pad.kernel.org ? :)

However, a large part of why I was suggesting a git repo is because it is
automatically redistributable, clonable, and verifiable using builtin git
tools. We have end-to-end attestation with git, but we don't have it with
etherpad or a wiki. If the goal is to use a document that solicits acks and
other input across subsystems, then having a tamper-evident backend may be
important.

-K
