Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466CF49C073
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 02:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiAZBJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 20:09:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42272 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiAZBJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:09:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEBCCB81B99;
        Wed, 26 Jan 2022 01:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C1BC340E0;
        Wed, 26 Jan 2022 01:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643159342;
        bh=D6r77K7QjaFLL+Ex50/C3+VaPdgBBea9XHVhawpPP5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cfIVlgBxdxoEmDlzxN8MLdZiDeqfVMs3F9R44x1EEDi+FAcc219spoDmj/bUz+Llv
         h5JdE3MYN7DlL3+6DvlIKyfve25qK4t/2jBcjqDCi5sYv2yBNTNSHibXSD3wYTXTIt
         MuNS0xHZw3u41EGgehRxBHDemS/y4UWPqGR1HW3E=
Date:   Tue, 25 Jan 2022 17:09:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2] proc/vmcore: fix possible deadlock on concurrent
 mmap and read
Message-Id: <20220125170900.472fdb649312e77a4a60d9da@linux-foundation.org>
In-Reply-To: <20220119193417.100385-1-david@redhat.com>
References: <20220119193417.100385-1-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Jan 2022 20:34:17 +0100 David Hildenbrand <david@redhat.com> wrote:

> Lockdep noticed that there is chance for a deadlock if we have
> concurrent mmap, concurrent read, and the addition/removal of a
> callback.
> 
> As nicely explained by Boqun:
> 
> "
> Lockdep warned about the above sequences because rw_semaphore is a fair
> read-write lock, and the following can cause a deadlock:
> 
> 	TASK 1			TASK 2		TASK 3
> 	======			======		======
> 	down_write(mmap_lock);
> 				down_read(vmcore_cb_rwsem)
> 						down_write(vmcore_cb_rwsem); // blocked
> 	down_read(vmcore_cb_rwsem); // cannot get the lock because of the fairness
> 				down_read(mmap_lock); // blocked

I'm wondering about cc:stable.  It's hard to believe that this is
likely to be observed in real life.  But the ongoing reports of lockdep
splats will be irritating.

