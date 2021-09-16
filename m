Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A1D40EBE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 23:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbhIPVCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 17:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIPVCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:02:10 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB8C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 14:00:49 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id a12so5102916qvz.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XY/Teazy9P6tj5jZnNzs42oJHvS9/ClFdNvyApSBfaA=;
        b=U76FJWxjXsR695AetexNJ0nBBpXVRjEd0L4R7nWQP/RfLbvpin08Q3KIXYpJ7uou8O
         zjlSd3sK+gPDjhw6w3aUnoT7llrTAZMoOY8EAF1vCaSf3Uxu09AQ4aWoALh3GSxL8EJg
         n8XW7nHbac/RQ4q44GppxRT3Xx5Gkfb+vuVXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XY/Teazy9P6tj5jZnNzs42oJHvS9/ClFdNvyApSBfaA=;
        b=r1hDNWsq+3eX/v9B4+K6vtxouldiF58De3YZoKzsM9Nf1odFgBpalw3xBS+0X4XCQX
         PfXJQCAmydBDcjMmUIn193wODC1nWlm49urFAMDIjJ0QR6nArm+gBnsUcHoEndSP2l83
         TpHpOIt27gxDkRcKaETG/i/02Jdsre9CVQ7as5oh/XhmIVrbfAH3UUt9DLQ/02dLV+5r
         DVqvRde5/OQ2tVLj4JbyDHvKWsSKjsWt7U9YAtedzEc9/Wg4i7l8P1Jz2xuxkgg3Kslh
         Hh6HQjzbsJbU/H9OEWYkvnn5HmDupCfI2j8zCIUhsAtvpU/5x3VOzCTMjoCw83E+bud0
         wlFg==
X-Gm-Message-State: AOAM530cTlhZzhwnJWXpR4NHTq95Zl2Xa40snuitckKfTeycOz++7qnQ
        PnRbSTTccG12yv/w74etrb7TBhootcEIqA==
X-Google-Smtp-Source: ABdhPJzRSpC3A1mfWFQOft5OaD6EocQHYKzpJtVtwwvnabXpR06y6FFlIZ7jN6kNWp6GC8NHVKCdWw==
X-Received: by 2002:a05:6214:2ec:: with SMTP id h12mr7450962qvu.1.1631826048795;
        Thu, 16 Sep 2021 14:00:48 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id b13sm2674731qtb.13.2021.09.16.14.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 14:00:48 -0700 (PDT)
Date:   Thu, 16 Sep 2021 17:00:46 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Chris Mason <clm@fb.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <20210916210046.ourwrk6uqeisi555@meerkat.local>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
 <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
 <YUI5bk/94yHPZIqJ@mit.edu>
 <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
 <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
 <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
 <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
 <261D65D8-7273-4884-BD01-2BF8331F4034@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <261D65D8-7273-4884-BD01-2BF8331F4034@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 08:38:13PM +0000, Chris Mason wrote:
> Agree here.  Mailing lists make it really hard to figure out when these
> conflicts are resolved, which is why I love using google docs for that part.

I would caution that Google docs aren't universally accessible. China blocks
access to many Google resources, and now Russia purportedly does the same.
Perhaps a similar effect can be reached with a git repository with limited
commit access? At least then commits can be attested to individual authors.

> A living document with a single source of truth on key design points, work
> remaining, and stakeholders who are responsible for ack/nack decisions.
> Basically if you don’t have edit permissions on the document, you’re not one
> of the people that can say no.
> 
> If you do have edit permissions, you’re expected to be on board with the
> overall goal and help work through the design/validation/code/etc until
> you’re ready to ack it, or until it’s clear the whole thing isn’t going to
> work.  If you feel you need to have edit permissions, you’ve got a defined
> set of people to talk with about it.
> 
> It can’t completely replace the mailing lists, but it can take a lot of the
> archeology out of understanding a given patch series and figuring out if
> it’s actually ready to go.

You can combine the two and use mailing lists as the source of truth by using
Link: tags in commits to make it easy to verify history and provenance.

-K
