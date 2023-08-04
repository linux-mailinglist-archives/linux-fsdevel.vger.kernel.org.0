Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55A6770677
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjHDQ5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 12:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHDQ5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:57:31 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E7469A
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 09:57:25 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-790c6d966e0so86045239f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1691168245; x=1691773045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fLs6vLbC3bot13xgwrJ/fB2v8UZa1GQgyp/C81/2sXw=;
        b=BQY5zzs/9I6VY6xyhPL8yq1cl+TLPbV3XxYmr4qSB+Za88/G2jhf/8k76NYDcE7Oi3
         rU3ucAGOJA9FCr8AjxaFYYi4vg2b4GCVddq4kI81RtSDaH2vcAdEMTpQ45zqBLi1eaxf
         mHUOR2hY26v/em/o5OD44PUMC10nDsd9mzQY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691168245; x=1691773045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLs6vLbC3bot13xgwrJ/fB2v8UZa1GQgyp/C81/2sXw=;
        b=g0mz4fU8ZoYsup2i8Zgggt8sTN/bSOE6Uy9dUidps9D5CjApyV3vKmzhg8tEPALOWS
         xjZ5dS+y2KDQ+Mji1K7GUpKD3bTDZGokyvXF9lajz/n9zChKFSTRQzzH9Ti0vFqGvB4l
         17p6W32gNOTscuFQ6tquvY999F2G/4uP3YzZaLCvQm048TID/VC290YqIrWi1dp/U2u2
         bgDaOBvMxS9buo9zAbloCrR6yzhD5g/yNr1/f/SYgdt/Plm6lAHtBx8DF6abXXMLNZLO
         uJr+QdoNpl+n7ZytvD5TU8nKQWaejt4GehJjrtle31TWh2FlYv489D/1Nb8S2dwC4MTW
         LuBg==
X-Gm-Message-State: AOJu0Yyj5cardA4x6AjT2GjMvPFkjWiUeoOj39iDiotAYBTef6Xhpz9/
        bkEkiOJbYrX23TqQrSJ25uT/dg==
X-Google-Smtp-Source: AGHT+IHU3+wLh7lUmQRFHahUjU0LpvS8KkYhfTtHOyxinRVgWiVu/pjJ9WcEu15SHijdHdKkUr0kEw==
X-Received: by 2002:a5d:8d95:0:b0:790:f866:d716 with SMTP id b21-20020a5d8d95000000b00790f866d716mr1101255ioj.15.1691168244913;
        Fri, 04 Aug 2023 09:57:24 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:9478:4be::79:1a])
        by smtp.gmail.com with ESMTPSA id z11-20020a6b0a0b000000b007791e286fdbsm753260ioi.21.2023.08.04.09.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:57:24 -0700 (PDT)
Date:   Fri, 4 Aug 2023 11:57:22 -0500
From:   Frederick Lawler <fred@cloudflare.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Dao <dqminh@cloudflare.com>, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, djwong@kernel.org
Subject: Re: Kernel NULL pointer deref and data corruptions with xfs on 6.1
Message-ID: <ZM0t8rYZewA3dO0W@CMGLRV3>
References: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
 <ZMHkLA+r2K6hKsr5@casper.infradead.org>
 <CA+wXwBQur9DU7mVa961KWpL+cn1BNeZbU+oja+SKMHhEo1D0-g@mail.gmail.com>
 <ZMJizCdbm+JPZ8gp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMJizCdbm+JPZ8gp@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Thu, Jul 27, 2023 at 01:27:56PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 27, 2023 at 11:25:33AM +0100, Daniel Dao wrote:
> > On Thu, Jul 27, 2023 at 4:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Jul 21, 2023 at 11:49:04AM +0100, Daniel Dao wrote:
> > > > We do not have a reproducer yet, but we now have more debugging data
> > > > which hopefully
> > > > should help narrow this down. Details as followed:
> > > >
> > > > 1. Kernel NULL pointer deferencences in __filemap_get_folio
> > > >
> > > > This happened on a few different hosts, with a few different repeated addresses.
> > > > The addresses are 0000000000000036, 0000000000000076,
> > > > 00000000000000f6. This looks
> > > > like the xarray is corrupted and we were trying to do some work on a
> > > > sibling entry.
> > >
> > > I think I have a fix for this one.  Please try the attached.
> > 
> > For some reason I do not see the attached patch. Can you resend it, or
> > is it the same
> > one as in https://bugzilla.kernel.org/show_bug.cgi?id=216646#c31 ?
> 
> Yes, that's the one, sorry.

I setup a kernel with this patch to deploy out. It'll take some time to
see any results from that. I did run your multiorder.c changes with/without
the change to lib/xarray.c and that seemed to work as intended. I didn't see
any regressions across multiple seeds with our kernel config.

Fred
