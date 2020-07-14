Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0F21F2F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 15:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgGNNqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 09:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNNqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:46:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B184C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3mnyL6r5eT0wels9ByoH56W8522qyVv5Ukd8KIp6PHc=; b=SlHirJpLqqSFqI0k1wcJYHXDaf
        lRND2RxiNGn8Ci8T8H7wciLmBaIXl27rQePBb5BCWV+E3WWVKEgq1WV/t//LUZQGFO54DX9qEH1bL
        A+ENkYQOVkIRp+M5C6PG3Ku/WWywryPM2FX8sg7x6ddgBDXphw6EIiZrYnQl68Ai3afWCn/NODG21
        p1sf0xLqpk08DPAEfQxmn2iNzZrw6JKQPQORoH9qDwDsx1YqWNhz4EtC8OtWoXyHunpxH0L1cuvB9
        8dKcwPhpQNlpazAuLotDzSRhtsUnzGYvayN0Lm4+eQbXPaXT72e3KRGGDpCs7Ibb/crX+WXT8ad4+
        g1WPDr2A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvLGN-0006fm-UG; Tue, 14 Jul 2020 13:46:27 +0000
Date:   Tue, 14 Jul 2020 14:46:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Unexpected behavior from xarray - Is it expected?
Message-ID: <20200714134627.GC12769@casper.infradead.org>
References: <9c7b1024-d81e-6038-7e01-6747c897d79e@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c7b1024-d81e-6038-7e01-6747c897d79e@plexistor.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:24:18PM +0300, Boaz Harrosh wrote:
> Matthew Hi
> 
> First I want to thank you for the great xarray tool. I use it heavily with great joy & ease
> 
> However I have encountered a bug in my code which I did not expect, as follows:
> 
> I need code in the very hot-path that is looping on the xarray in an unusual way.
> What I need is to scan a range from x-x+l but I need to break on first "hole" ie.
> first entry that was not __xa_store() to. So I am using this loop:
> 	rcu_read_lock();
> 
> 	for (xae = xas_load(&xas); xae; xae = xas_next(&xas)) {
> 		...
> 	}
> 
> Every thing works fine and I usually get a NULL from xas_next() (or xas_load())
> on first hole, And the loop exits.
> 
> But in the case that I have entered a *single* xa_store() *at index 0*, but then try
> to GET a range 0-Y I get these unexpected results:
> 	xas_next() will return the same entry repeatedly

I thought this was fixed in commit 91abab83839aa2eba073e4a63c729832fdb27ea1
Do you have that commit in your tree?
