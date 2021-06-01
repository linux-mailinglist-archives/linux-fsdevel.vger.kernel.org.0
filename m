Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9740397A37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 20:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhFASwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 14:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhFASwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:52:15 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B00C061574;
        Tue,  1 Jun 2021 11:50:33 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c20so15390791qkm.3;
        Tue, 01 Jun 2021 11:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XGHKI8ma4DK7J7qlYbA/NiKeB0z2A5W21OWmsXuND3M=;
        b=RIclKYcWUb8FOvCG4c2/M+STw5k+Yoy29gyIrXWjuVp7NBtj1aAkUVRdIhvbBT1rb2
         DSjzbWt+w2ABi7B8hE2IwHN/QLU3J7JYJiRo6L92kSPAQBKRKEgzh1rat5mITZuCb9bE
         am2MuCMaLPCwX/GfvlgmQM3eu902g64myP6RnVGe2F9H/E/RQJklGw4oSJa6FOhPRVYt
         RVeCJp/2Xi91FqUlmPrNCNjSUohWVBfrDx5M3di7Sib233ygkuJYf3TX4uujXiIeHJ2d
         NrYEcKBCPxgOr8c1b6GHxOVAM0CbXsK1Pbg/FV/atu/iWJjfK1IHBfVZOm91gTwNnWtY
         HAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XGHKI8ma4DK7J7qlYbA/NiKeB0z2A5W21OWmsXuND3M=;
        b=MhxxcVcDxbIwJyzN40QYshNqMS1ZF+u1g+4CwY0xbYI4VzwejN0GFXQo1OXpxwkQZ3
         RvBJOmskHf7lZxHhCfJMrqIhYVTYnO1KquXZt9tw3IjK41L2W2xJlX2t6167wj4XdgS/
         zbC7ohyStMcZe5PJHQQlaU/PgwayMItR5DaCbHF1zKcU/kkHzIT7XoHmb23m2f7nUHXU
         zBaBaRCFHGrMMNZ5lzV2k2oxBcRD0vBdW96zKzqh1PrzAp9RUkrui6GsBcQCGOgo9Auu
         KSCKHONjSg90S1gUvY1v6mTjB5VERZmgc4EnS0T2wH4j7MXpHaTvIKFnNPLnOGgUQETN
         U/og==
X-Gm-Message-State: AOAM532SYH52TRRqI5kW5kDc8fv7LmeY2RAbE36J7ehkgdWWgMrsnrcj
        +A4wHRrh2RpesDKc4xOhV1ju+JkPiQqe
X-Google-Smtp-Source: ABdhPJx7SlZPu5N/mzg+OmXO73KStJf/96ORnbQqpYpEWzZpYP5pBO08hJgMtpclq3vD6DfkOdVCGw==
X-Received: by 2002:a37:b143:: with SMTP id a64mr23850330qkf.492.1622573432410;
        Tue, 01 Jun 2021 11:50:32 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a23sm11689560qkl.6.2021.06.01.11.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 11:50:31 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:50:28 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] generic/{455,457,482}: make dmlogwrites tests
 work on bcachefs
Message-ID: <YLaBdAxSrK0s4xEP@moria.home.lan>
References: <20210525221955.265524-1-kent.overstreet@gmail.com>
 <20210525221955.265524-7-kent.overstreet@gmail.com>
 <YLOQuagLB3LhKPOl@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLOQuagLB3LhKPOl@desktop>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 30, 2021 at 09:18:49PM +0800, Eryu Guan wrote:
> On Tue, May 25, 2021 at 06:19:54PM -0400, Kent Overstreet wrote:
> > bcachefs has log structured btree nodes, in addition to a regular
> > journal, which means that unless we replay to markers in the log in the
> > same order that they happened and are careful to avoid writing in
> > between replaying to different events - we need to wipe and start fresh
> > each time.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > ---
> >  tests/generic/455 | 14 ++++++++++++++
> >  tests/generic/457 | 14 ++++++++++++++
> >  tests/generic/482 | 27 ++++++++++++++++++++-------
> >  3 files changed, 48 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tests/generic/455 b/tests/generic/455
> > index 5b4b242e74..6dc46c3c72 100755
> > --- a/tests/generic/455
> > +++ b/tests/generic/455
> > @@ -35,6 +35,17 @@ _require_dm_target thin-pool
> >  
> >  rm -f $seqres.full
> >  
> > +_reset_dmthin()
> > +{
> > +    # With bcachefs, we need to wipe and start fresh every time we replay to a
> > +    # different point in time - if we see metadata from a future point in time,
> > +    # or an unrelated mount, bcachefs will get confused:
> > +    if [ "$FSTYP" = "bcachefs" ]; then
> > +	_dmthin_cleanup
> > +	_dmthin_init $devsize $devsize $csize $lowspace
> > +    fi
> > +}
> 
> I think we probably could make it a common helper, and currently only
> bcachefs needs reset, and more log structured filesystems may be
> supported in the future.

I think it might be better to wait until we have more dmlogwrites tests or
another filesystem that needs this - I don't think this would be a good common
helper as is, it's too coupled to what the tests are doing - factoring out
helpers just because you spot identical code is an anti pattern when there isn't
a good notion of what you're abstracting

Right now 455 and 457 are basically identical anyways, factoring out a single
helper and ignoring the rest doesn't make much sense to me.
