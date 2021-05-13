Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1909737F8E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 15:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhEMNjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 09:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhEMNjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 09:39:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC79C061574;
        Thu, 13 May 2021 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7qdcsekCpDC0XbH1OXVUDI58yFo8Z7At/i6/i0XMALI=; b=tfkCjdPhG2JWyiamQqLUcVIUaa
        XIAK/k2n62tt+Wbf/46OEwAYMQmA+a7bxfjCQNJeofqSoJn1tx8g09UAvpof8TiISSa9sOFxVSN8w
        nCvW92rZta0Ztby0RSYVTKYOkyXuxIu5khMZE9L+bS3UvMSj+aeeIUOr7y/BZ0s3moMIBGnmRaaSy
        08Fy6gD4Ww+T7IVNTy+9uiKfwl9bw9+Ie3saiCuYJSsI+W//LBbl1U4U9o+0MyqTusGI62zeRBaCe
        sAGJMylp/ZwrTaXz1ygWi77JLYrKiU3A1rF9dV6x19gN9MMMDWs8rVF6qFAXnGsUza3T3lvP2KglO
        Sl13Etjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lhBU3-009Sko-72; Thu, 13 May 2021 13:35:00 +0000
Date:   Thu, 13 May 2021 14:34:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Removing readpages aop
Message-ID: <YJ0q6/Oe5yJ+H+Tn@casper.infradead.org>
References: <YJvwVq3Gl35RQrIe@casper.infradead.org>
 <CAH2r5msOQsdeknBdTsfMXYzrb5=NuKEBPc4WD1CkYp10t19Guw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msOQsdeknBdTsfMXYzrb5=NuKEBPc4WD1CkYp10t19Guw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 02:28:41PM -0500, Steve French wrote:
> I don't have any objections as long as:
> - we see at least mild performance benefit (or at least we are
> confident that no performance loss)

Nobody's complained of a performance loss in the other ~30 filesystems
which have already been converted (some almost a year ago).  And CIFS
has one of the more convoluted readpages implementation, so I'd expect
a higher likelihood of a performance gain from CIFS.

> - it passes regression tests (the usual xfstest bucket)
> - it doesn't complicate the code too much (sounds like it actually
> might simplify it, but needs a little more work)
> - make sure that the usual tuning parms still work (e.g. "rsize" and
> "rasize" mount options) or we can figure out a sane way to autotune
> readhead so those wouldn't be needed for any workload

One of the enhancements added as part of the recent netfs merge
was readahead_expand().  Take a look at it and see if it works for you.

> But currently since we get the most benefit from multichannel (as that
> allows even better parallelization of i/o) ... I have been focused on
> various multichannel issues (low credit situations, reconnect, fall
> back to different channels when weird errors, adjusting channels
> dynamically when server adds or removes adapters on the fly) for the
> short term

Understood.  Only so many hours in the day.

I think
https://lore.kernel.org/linux-fsdevel/1794123.1605713481@warthog.procyon.org.uk/
is the most recent version, but as Dave notes, it needs attention from
somebody who knows the CIFS code better.
