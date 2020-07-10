Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93321B3EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGJL2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 07:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJL2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:28:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CE6C08C5CE;
        Fri, 10 Jul 2020 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3D7HcbVvasTwDLZD4YAaihs84eO23KPCl16ZChSDu2M=; b=R+thKef1a76pE65/41vHX+3lv3
        8rKgvdJkIb+n1O571lv2KUon0j/BUoUWCdRGZPxW7CeOtjVXoqp0bnXVreGM6reSeE3fLmkaILdkX
        g/X09WiEsiacoldznMOBN8qu7deTd7tWYPGj0PBsD2TjtLae5TOBfR+WG2WVLfShipAU2zfEeRkku
        9OREHHOza/y6f/p/Wy/AYo5sVBRXv7FS86PNDt/l7g3U3wbWLM/CZdtQTGMCvezJVZ2onIQ7H2AfD
        8QOthqDQ3vmQbXubYLzXvB1L79kj6oZ3mYAsLg8sekkCCzA8PwvZOFvU4t0tc9MRyfmh3yOgvg3G7
        V3oHT3nw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtrCF-0006JB-S9; Fri, 10 Jul 2020 11:28:04 +0000
Date:   Fri, 10 Jul 2020 12:28:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Changming Liu <charley.ashbringer@gmail.com>,
        keescook@chromium.org, mcgrof@kernel.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: add bound to panic_timeout to prevent overflow
Message-ID: <20200710112803.GI12769@casper.infradead.org>
References: <1594351343-11811-1-git-send-email-charley.ashbringer@gmail.com>
 <b50e8198-ca2e-eb44-ed71-e4ca27f48232@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b50e8198-ca2e-eb44-ed71-e4ca27f48232@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 08:31:39PM -0700, Randy Dunlap wrote:
> > +/* this is needed for setting boundery for panic_timeout to prevent it from overflow*/
> 
>                                  boundary (or max value)                       overflow */
> 
> > +static int panic_time_max = INT_MAX / 1000;

Or just simplify the comment.

/* Prevent overflow in panic() */

Or perhaps better, fix panic() to not overflow.

-		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
+		for (i = 0; i / 1000 < panic_timeout; i += PANIC_TIMER_STEP) {

you probably also want to change i to be a long long or the loop may never
terminate.
