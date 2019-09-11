Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50128B04B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 21:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfIKT5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 15:57:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbfIKT5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 15:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9jE3mtkHHko+7r8PMAvmKkCu21SGOTAKiQ2sFX5q1e8=; b=YuuZ1SR9/A3UTMvsgjSd5CDmd
        Bht4qf7T7gzPP6ceP3qR0rUCabFLX3Ofmr1X48wwNvc7OioQfaRQY15yoV7wM8Md+Lttifi18jP4N
        2zoqeakteIneE6RomJ18Svhc3HMcSNpA9808NWbTJed7wGaWgOW4NIpEuLgedepcI9h5LOFReSKD8
        3JDMy6OdPsmFtRfTBIR+HfAyJMgJ+Jnj8cBaaEyynEzWbevqJ6Z1x/AzF0dzQP9Uw1L3uZzKSJVM/
        TwSAA+eEApViP9KU8PZo0eQ0O/NEK3imDNt2fcN+0/CxKA18HaTn+i8NqOpUxE/Zb8FY+MwvYdPuH
        GiGSo8+Vg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i88kL-0007F3-I8; Wed, 11 Sep 2019 19:57:45 +0000
Date:   Wed, 11 Sep 2019 12:57:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
Message-ID: <20190911195745.GI29434@bombadil.infradead.org>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911150537.19527-6-longman@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 11, 2019 at 04:05:37PM +0100, Waiman Long wrote:
> To remove the unacceptable delays, we have to limit the amount of wait
> time on the mmap_sem. So the new down_write_timedlock() function is
> used to acquire the write lock on the mmap_sem with a timeout value of
> 10ms which should not cause a perceivable delay. If timeout happens,
> the task will abandon its effort to share the PMD and allocate its own
> copy instead.

If you do a v2, this is *NOT* the mmap_sem.  It's the i_mmap_rwsem
which protects a very different data structure from the mmap_sem.

> +static inline bool i_mmap_timedlock_write(struct address_space *mapping,
> +					 ktime_t timeout)
> +{
> +	return down_write_timedlock(&mapping->i_mmap_rwsem, timeout);
> +}
