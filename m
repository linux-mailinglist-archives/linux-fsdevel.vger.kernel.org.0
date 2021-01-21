Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC632FF134
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 17:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbhAUQ7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 11:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbhAUPts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:49:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABE8C06174A;
        Thu, 21 Jan 2021 07:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZL81M5BEqTudNah5tQWg3R+0k1d+KEs2wiEIXk0AHyU=; b=e3+fCJZ4+c/Bd3YFXUnB7wc2QG
        zNZApZUXVsJIXgnQ3uDIrk+MdHuBf/EAIQAJSnrt6uQWYQQLnG987ACUBhaoUtT4BMyP/mF3Vnu+o
        Sn3t0XGgrj/oantRFYObogGn5kFFTLcFx66G5HjEw0Q1G4zvbIqlp5lU8wjt+2Ih1jIWXudnMZVIE
        EdVihksh4xOV1tWg+RnHNpWlmqeYz41Fcqlop7WHGueLMzdxE08vtnXSgAf24+aIk1aE13JpWuHx0
        nQebCiUviossBNnJbDfhqJ/XS9RyRy4zHsANcSszrwiWOxpBQJ//Ou5+u8CsNXSVlCCBxAOkNBPY5
        5my++V+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2cBU-00HDop-6A; Thu, 21 Jan 2021 15:47:51 +0000
Date:   Thu, 21 Jan 2021 15:47:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Zhongwei Cai <sunrise_l@sjtu.edu.cn>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Mingkai Dong <mingkaidong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        Rajesh Tadakamadla <rajesh.tadakamadla@hpe.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: Expense of read_iter
Message-ID: <20210121154744.GQ2260413@casper.infradead.org>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com>
 <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
 <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com>
 <1224425872.715547.1610703643424.JavaMail.zimbra@sjtu.edu.cn>
 <20210120044700.GA4626@dread.disaster.area>
 <20210120141834.GA24063@quack2.suse.cz>
 <alpine.LRH.2.02.2101200951070.24430@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2101200951070.24430@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:12:01AM -0500, Mikulas Patocka wrote:
> Do you have some idea how to optimize the generic code that calls 
> ->read_iter?

Yes.

> It might be better to maintain an f_iocb_flags in the
> struct file and just copy that unconditionally.  We'd need to remember
> to update it in fcntl(F_SETFL), but I think that's the only place.

Want to give that a try?
