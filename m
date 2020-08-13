Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7469A24398D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHMMCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgHMMBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:01:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AE4C061757;
        Thu, 13 Aug 2020 05:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i41Yc10MxJ8SD/RmIm1p0LXK6Fe4vVxPBwR0fO9tHsU=; b=wUkEP4gznD8yhOKXfehUrg6u+p
        4PCOcBf33WvByOdBvWwLPp6R8/WwxJlEYyQ3CY9ej+Zc55i7MERAd+5CuKACgEOMwJkJpICIjvu6D
        4s1dRmOfQoghu7xdIO1fYpsEAEON7cEh4NTueg4+NtGD15C7xchhSji6EQqceguowmv1PUXzJ7Nts
        a0pAqKr+kEI15dkeOFh7FsqIvbIZKziG+7HYp+GACowqL/3hO1OafqdRTUrgk5GEc79FmzQH2KoHP
        UeKSdlIY4bl8Zozt8Pc5cSWRv3VGquq0YjgcJVVK0c7xUZQ0+VQiSFpdainJpwi+h0C1SJd8c8qzl
        p9a5QjuA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6Bu5-0003VD-3H; Thu, 13 Aug 2020 12:00:17 +0000
Date:   Thu, 13 Aug 2020 13:00:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     peterz@infradead.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jacob Wen <jian.w.wen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: insert a general SMP memory barrier before
 wake_up_bit()
Message-ID: <20200813120017.GH17456@casper.infradead.org>
References: <20200813024438.13170-1-jian.w.wen@oracle.com>
 <20200813073115.GA15436@infradead.org>
 <20200813114050.GW2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813114050.GW2674@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 01:40:50PM +0200, peterz@infradead.org wrote:
> On Thu, Aug 13, 2020 at 08:31:15AM +0100, Christoph Hellwig wrote:
> > On Thu, Aug 13, 2020 at 10:44:38AM +0800, Jacob Wen wrote:
> > > wake_up_bit() uses waitqueue_active() that needs the explicit smp_mb().
> > 
> > Sounds like the barrier should go into wake_up_bit then..
> 
> Oh, thanks for reminding me..
> 
> https://lkml.kernel.org/r/20190624165012.GH3436@hirez.programming.kicks-ass.net
> 
> I'll try and get back to that.

+++ b/drivers/bluetooth/btmtkuart.c
@@ -340,11 +340,8 @@ static int btmtkuart_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (hdr->evt == HCI_EV_VENDOR) {
 		if (test_and_clear_bit(BTMTKUART_TX_WAIT_VND_EVT,
-				       &bdev->tx_state)) {
-			/* Barrier to sync with other CPUs */
-			smp_mb__after_atomic();
+				       &bdev->tx_state))
 			wake_up_bit(&bdev->tx_state, BTMTKUART_TX_WAIT_VND_EVT);
-		}
 	}
 
 	return 0;

It'd be nice to be able to write:

	if (hdr->evt == HCI_EV_VENDOR)
		test_clear_and_wake_up_bit(&bdev->tx_state,
						BTMTKUART_TX_WAIT_VND_EVT);

... maybe with a better name.
