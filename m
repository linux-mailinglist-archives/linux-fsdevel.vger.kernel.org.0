Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB73581B2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 22:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbiGZUiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 16:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiGZUiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:38:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD20610CB;
        Tue, 26 Jul 2022 13:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MrxN4DGbGTYYZaiw9voKnrV7JGzIxILGyyKiVP9KZHc=; b=iFPA5jJNcpywUVwAKK8E4MUHia
        3VNzspTAbTfpP8HYvOAPgH9N0AeyKnMnq00rIAuejZ+T1LVOaE6Mm2qJcsJ7TRIDMJ4WxLqLY7vc+
        uqWcNXGx5mOYEFUfyHq9VKZdd07y+bssg0r8y4XBKphZNrn7sTJM58l+Zh2k/TDRgHOMS09yz9Kc3
        w9qAgl+XW+Qj9kqIL7tZr8hAklt5dwScM4DvsuQLqC2wCVgsMMy0pRmaGXjpWMQsm/aS8lrWucpu6
        S3lWwCvkAGRH18fvOVjaBXDC/F8oDqW8tfmyg51EFVwCs/XxhCnyYgTQByKNJ1xyqOa05VAKEAA/Z
        ipM2OT9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGRJZ-002JaV-IR; Tue, 26 Jul 2022 20:38:01 +0000
Date:   Tue, 26 Jul 2022 21:38:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfsplus: Convert kmap() to kmap_local_page() in bitmap.c
Message-ID: <YuBQqe345DR2hBsa@casper.infradead.org>
References: <20220724205007.11765-1-fmdefrancesco@gmail.com>
 <A2FB0201-8342-481B-A60C-32A2B0494D33@dubeyko.com>
 <Yt7Y6so92vXTOI+Q@casper.infradead.org>
 <YuA8dgXPoDklBryE@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuA8dgXPoDklBryE@iweiny-desk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:11:50PM -0700, Ira Weiny wrote:
> On Mon, Jul 25, 2022 at 06:54:50PM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 25, 2022 at 10:17:13AM -0700, Viacheslav Dubeyko wrote:
> > > Looks good. Maybe, it makes sense to combine all kmap() related modifications in HFS+ into
> > > one patchset?
> > 
> > For bisection, I'd think it best to leave them separate?
> 
> I'm not quite sure I understand why putting the individual patches into a
> series makes bisection easier?  It does make sense to keep individual patches.

If somebody reports a bug, bisection will tell you which of these
kmap-conversion patches is at fault, reducing the amount of brainpower
you have to invest in determining where the bug is.
