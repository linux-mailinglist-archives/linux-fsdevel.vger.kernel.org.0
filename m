Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB55D6022C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 05:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiJRDl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 23:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiJRDku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:40:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CF54456C;
        Mon, 17 Oct 2022 20:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YzwUUY+E76c13KAWk70zUViOOJ9NwBhs+8H0DwCsKbA=; b=BBc5nxP03Jv0SM7AWIpvgEtJ1X
        MBxZWFeOoy6NhClx1UkCkXKMVuKMVbOWkc/mHmZkSV+iMbxsXyopwYUFPHNkcl4I+4i1nr6RSzqy+
        jWjvRxElP/Iaj0PDd/NOH7A86G1oKM/0ekNtxLv4FoR3ap9PcUrLH4R+rcLeIH6WFYcNMc3PSqS0f
        qMO7Qy0K9Pm49Tk/nQOOBJAyX+BOR5W9ZGgR33vwKqJNMHHJyf9gNncrivD9tQOnTqM6PY8HapB+h
        AaiMHYrVLIDGcJgmnB47/MkAMpww2gzdXpQKl2AsbMGC/ySUYUtSIdaZdTPN3N2hhx/3f4lf/52mB
        jE8+69wQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okcyj-00AKNx-SV; Tue, 18 Oct 2022 03:09:18 +0000
Date:   Tue, 18 Oct 2022 04:09:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <Y04Y3RNq6D2T9rVw@casper.infradead.org>
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org>
 <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org>
 <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:52:19AM +0800, Zhaoyang Huang wrote:
> On Mon, Oct 17, 2022 at 11:55 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Oct 17, 2022 at 01:34:13PM +0800, Zhaoyang Huang wrote:
> > > On Fri, Oct 14, 2022 at 8:12 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Fri, Oct 14, 2022 at 01:30:48PM +0800, zhaoyang.huang wrote:
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > Bellowing RCU stall is reported where kswapd traps in a live lock when shrink
> > > > > superblock's inode list. The direct reason is zombie page keeps staying on the
> > > > > xarray's slot and make the check and retry loop permanently. The root cause is unknown yet
> > > > > and supposed could be an xa update without synchronize_rcu etc. I would like to
> > > > > suggest skip this page to break the live lock as a workaround.
> > > >
> > > > No, the underlying bug should be fixed.
> >
> >     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Understand. IMHO, find_get_entry actruely works as an open API dealing
> with different kinds of address_spaces page cache, which requires high
> robustness to deal with any corner cases. Take the current problem as
> example, the inode with fault page(refcount=0) could remain on the
> sb's list without live lock problem.

But it's a corner case that shouldn't happen!  What else is going on
at the time?  Can you reproduce this problem easily?  If so, how?
