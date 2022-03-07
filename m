Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB464D0383
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiCGP6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbiCGP6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:58:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790267D00F;
        Mon,  7 Mar 2022 07:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WrCk5Zjz4zeQvJI59w3Y1NYye/gptEQDerS0Psr1TZ4=; b=wW7FyJ7wdAgP5ZxLNFEf3eQpn9
        s8zqFBSs7eoLCpygyX9Z4BS+JtlrW3VXFyql7r4copov9R+nc+r3Nnf6PiKouoQ3GnzE/lX4O9lA5
        qtqgL9RKeZTtgw8gRuuv/SFUIU5CglX+vJdOpIkh3XPo2fAv6370VZMHInrLYfgtq0VgKP8mbn98U
        BGM12OyvkgjC+U3Uz3Ql1bFFylM+W9CTN4fhip9qJ9LDDtx5Zwk0+/CZBJZu4TvAonJOfFmJNBQQj
        fG7eq9hrelFEh0pr9otbFYrrr622HUWFXIFB1E0lSVCG7DB/Ig2g5G/VZ49wcOXg1BS2R65TowNqr
        LeKXy8DQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRFjB-000kY3-Ou; Mon, 07 Mar 2022 15:56:53 +0000
Date:   Mon, 7 Mar 2022 07:56:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Chris Wilson <chris@chris-wilson.co.uk>, G@iki.fi,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        zhangyiru <zhangyiru3@huawei.com>,
        Alexey Gladkov <legion@kernel.org>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        linux-mips@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, codalist@coda.cs.cmu.edu,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] MAP_POPULATE for device memory
Message-ID: <YiYrRWMp1akXY8Vb@infradead.org>
References: <20220306053211.135762-1-jarkko@kernel.org>
 <YiSb7tsUEBRGS+HA@casper.infradead.org>
 <YiW4yurDXSifTYUt@infradead.org>
 <YiYIv9guOgClLKT8@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiYIv9guOgClLKT8@iki.fi>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 03:29:35PM +0200, Jarkko Sakkinen wrote:
> So what would you suggest to sort out the issue? I'm happy to go with
> ioctl if nothing else is acceptable.

PLenty of drivers treat all mmaps as if MAP_POPULATE was specified,
typically by using (io_)remap_pfn_range.  If there any reason to only
optionally have the pre-fault semantics for sgx?  If not this should
be really simple.  And if we have a real need for it to be optional
we'll just need to find a sane way to pass that information to ->mmap.
