Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67CF64BE3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 22:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiLMVKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 16:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbiLMVKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:10:15 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74E155BA
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 13:10:14 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c7so3064647pfc.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 13:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hadOBlhZ0LgV9SDQeQd2Aydc95qiZ+JqtdMXDKY6ntw=;
        b=r6mFUEuTxSGL6nPKeQaBsPNILzGlWE26+u0Qfep9+Rbkj1gUoWODw0dA8zTcoE/axO
         ZhTWW5bdzr7h0ECnGwjYiKr5wYztGLebHMIexWD6d7PetIa1gDmC7wm3h+ixuK/OgJCM
         yUHrp4FFmE7XYnykG29Hxh6DcP4+qGinpekWyhu6jYMhNay1kv+XSUCEC2r8phVP4/6d
         QjyXPlCkioZ092OCeLhgF1W+7OhP0ukwawqoahPFtSQ+JRxwwB5EXj0W7S7H+IENfI+7
         I4dtGJjRblP3mVv0X4m6ONiBx1/BC+MtXgBUjCjYsRxQ5BHO34UxNs5oPezGwYTkQtne
         KqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hadOBlhZ0LgV9SDQeQd2Aydc95qiZ+JqtdMXDKY6ntw=;
        b=MCiebFz9wW8PWHAwz9n5wwayvZiSjVarxS3qloANBxbkDlH4wvmoz/rs/Ds2CGerWf
         8MIp4a/MEsJvRNX06VWEaBv+g9DAwnrnJUpm54DS3emKTSrrJI1eZJkwzWA9h++UQZhV
         L0s3dM9KXMXHs0RDgA412jsg2z7zqQCPeiyoHqMzLCqgLW5Y12nCJoYEFFSAuTTwFRyw
         2H7vVSTOB4hTMicIq1AA8UzNWThsuVEy68mjsBUjrvYbIzdLDaNPj5nQDLG491osqFIS
         A9NCUeWLcn8nE4ROigr6yRylese6ZjowYqU3Sfc+m3KeFA+6ITwN56yGx+yDPCmRfgh/
         4uxQ==
X-Gm-Message-State: ANoB5pmE6hCN6MW+WRLOqyI38iG6/8+0E382kVD2yacQh6W1nvf2T6Kt
        8MvJV0zQCttgQcr083J9Rw1FcHyKqJFUer4h
X-Google-Smtp-Source: AA0mqf6o0CFF/uAYsJFXasGYiQ/c9HujQxHgJ2Zih6hOCbrcPL9R5Nc0LXOypClKLFSDHHMXmZbPdw==
X-Received: by 2002:a62:7983:0:b0:577:8d87:d8f4 with SMTP id u125-20020a627983000000b005778d87d8f4mr22643807pfc.34.1670965813777;
        Tue, 13 Dec 2022 13:10:13 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id a197-20020a621ace000000b00574d8d64560sm8329302pfa.175.2022.12.13.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 13:10:13 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5CXS-0085by-SF; Wed, 14 Dec 2022 08:10:10 +1100
Date:   Wed, 14 Dec 2022 08:10:10 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] pagemap: add mapping_clear_large_folios()
 wrapper
Message-ID: <20221213211010.GX3600936@dread.disaster.area>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-3-aalbersh@redhat.com>
 <Y5i8igBLu+6OQt8H@casper.infradead.org>
 <Y5jTosRngrhzPoge@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5jTosRngrhzPoge@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:33:54AM -0800, Eric Biggers wrote:
> On Tue, Dec 13, 2022 at 05:55:22PM +0000, Matthew Wilcox wrote:
> > I'm happy to work with you to add support for large folios to verity.
> > It hasn't been high priority for me, but I'm now working on folio support
> > for bufferhead filesystems and this would probably fit in.
> 
> I'd be very interested to know what else is needed after commit 98dc08bae678
> ("fsverity: stop using PG_error to track error status") which is upstream now,
> and
> https://lore.kernel.org/linux-fsdevel/20221028224539.171818-1-ebiggers@kernel.org/T/#u
> ("fsverity: support for non-4K pages") which is planned for 6.3.

Did you change the bio interfaces to iterate a bvec full of
variable sized folios, or does it still expect a bio to only have
PAGE_SIZE pages attached to it?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
