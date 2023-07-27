Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB37653E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 14:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjG0M2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 08:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbjG0M2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:28:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80530CA;
        Thu, 27 Jul 2023 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=0SHwtlLfdLykm91VDjKonBsfjtpcmLBc8lJqYZToBcg=; b=D9EKpOfhiN9nSQhGjNtFFOB/5J
        IvoEznWKphYvGec9XS3FDaLewEcIxHC3ECqpdiPtciChaSPmdJnvaaQTPRIcMWw53ITYejobJi1QD
        vF6RYxVTJ3bvRt63gOVBNbGgp11XHjkqwdarkDR9IGkOdUJ38OS3rQ6MrlumhKynj1UUvgTQy1ErQ
        ErRrW5vmoqqJfnmFf5OZfpiFG1v8O9ZhhpIyWeO4gdB/EFnqNBgXl9y71BYZtOHKEu0bA+htek+sC
        qn09JvHVWJ7ohLt1iFUvG869wEVjKgh3981XyKTBB9xlkOAmc8TyXWMaH03xAAuswqgRqa8Wqp4HJ
        m+CVd12Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qP060-007Sp6-P9; Thu, 27 Jul 2023 12:27:56 +0000
Date:   Thu, 27 Jul 2023 13:27:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Dao <dqminh@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, djwong@kernel.org
Subject: Re: Kernel NULL pointer deref and data corruptions with xfs on 6.1
Message-ID: <ZMJizCdbm+JPZ8gp@casper.infradead.org>
References: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
 <ZMHkLA+r2K6hKsr5@casper.infradead.org>
 <CA+wXwBQur9DU7mVa961KWpL+cn1BNeZbU+oja+SKMHhEo1D0-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+wXwBQur9DU7mVa961KWpL+cn1BNeZbU+oja+SKMHhEo1D0-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:25:33AM +0100, Daniel Dao wrote:
> On Thu, Jul 27, 2023 at 4:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jul 21, 2023 at 11:49:04AM +0100, Daniel Dao wrote:
> > > We do not have a reproducer yet, but we now have more debugging data
> > > which hopefully
> > > should help narrow this down. Details as followed:
> > >
> > > 1. Kernel NULL pointer deferencences in __filemap_get_folio
> > >
> > > This happened on a few different hosts, with a few different repeated addresses.
> > > The addresses are 0000000000000036, 0000000000000076,
> > > 00000000000000f6. This looks
> > > like the xarray is corrupted and we were trying to do some work on a
> > > sibling entry.
> >
> > I think I have a fix for this one.  Please try the attached.
> 
> For some reason I do not see the attached patch. Can you resend it, or
> is it the same
> one as in https://bugzilla.kernel.org/show_bug.cgi?id=216646#c31 ?

Yes, that's the one, sorry.
