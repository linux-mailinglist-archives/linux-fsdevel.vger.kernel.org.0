Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24EE221A4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 04:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGPCrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 22:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGPCrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:47:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54AEC061755;
        Wed, 15 Jul 2020 19:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8E+1WsDCZAHxb3rJiCkb4POuVVDV4pdIYyzqSLIjPhA=; b=cSxB4rzvbv4fv5RF+v0MBSo5I/
        Gsi0Y1jPJJYiQguyDb+kW0x0DcquN+OiXdKZH1jqVzWrIaQjBcSztIKbs++T6i6fsaL6NPUqhSe4z
        WvbxlYDOXk0A5fnmvromJ+7BIBOBt4MZpZn17+WrdsszAFGOR77gdpBVAhVJrZoA5TwAgzgeUUlNM
        7aVnN+ZWFHe3ba0ONPV7OTNG5lIIO22UiGAD8LjdguuMEVXNtBDR42J60AXHdrPqaevvfA2A7fj8L
        ZTGjgYnCtpchePfIdM0vYEjhKDFksLvr/IzHR0g2HslGpRm62Fjpt7AaWIaIa7BIDCUY4GiLinVLE
        2XFjqIag==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvtva-00026F-0X; Thu, 16 Jul 2020 02:47:18 +0000
Date:   Thu, 16 Jul 2020 03:47:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/direct-io: avoid data race on ->s_dio_done_wq
Message-ID: <20200716024717.GJ12769@casper.infradead.org>
References: <20200713033330.205104-1-ebiggers@kernel.org>
 <20200715013008.GD2005@dread.disaster.area>
 <20200715023714.GA38091@sol.localdomain>
 <20200715080144.GF2005@dread.disaster.area>
 <20200715161342.GA1167@sol.localdomain>
 <20200716014656.GJ2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716014656.GJ2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:46:56AM +1000, Dave Chinner wrote:
> And why should we compromise performance on hundreds of millions of
> modern systems to fix an extremely rare race on an extremely rare
> platform that maybe only a hundred people world-wide might still
> use?

I thought that wasn't the argument here.  It was that some future
compiler might choose to do something absolutely awful that no current
compiler does, and that rather than disable the stupid "optimisation",
we'd be glad that we'd already stuffed the source code up so that it
lay within some tortuous reading of the C spec.

The memory model is just too complicated.  Look at the recent exchange
between myself & Dan Williams.  I spent literally _hours_ trying to
figure out what rules to follow.

https://lore.kernel.org/linux-mm/CAPcyv4jgjoLqsV+aHGJwGXbCSwbTnWLmog5-rxD2i31vZ2rDNQ@mail.gmail.com/
https://lore.kernel.org/linux-mm/CAPcyv4j2+7XiJ9BXQ4mj_XN0N+rCyxch5QkuZ6UsOBsOO1+2Vg@mail.gmail.com/

Neither Dan nor I are exactly "new" to Linux kernel development.  As Dave
is saying here, having to understand the memory model is too high a bar.

Hell, I don't know if what we ended up with for v4 is actually correct.
It lokos good to me, but *shrug*

https://lore.kernel.org/linux-mm/159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com/
