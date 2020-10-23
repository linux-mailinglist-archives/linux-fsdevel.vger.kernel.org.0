Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB18F296DE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 13:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463151AbgJWLmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 07:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463147AbgJWLmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:42:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83323C0613CE;
        Fri, 23 Oct 2020 04:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uTBzimS1PCb6rk5CYfmm7DQ57ZumL5IF6N2uuwCT5ic=; b=ACJo1cAnkf3SCtOXvhzF84HPAz
        utZFVfmrmNmBVfyFa5t0dItqVsR7LlM9a/jTwu2II5s5V7yF3kAfVMAnMzrXyZDJpdWcEwVJSnBdA
        ssO+4GIuRRj3bJhia6MZuAmiwlqfgDAZwC+arcGcmvM62SC4BkH/APIgbr+WE9JUWbkEsxQJv1T+8
        URB45+a6Ia7ysOI4DPNhoQMYW4TeQKE/LaC/YAFY5RH5zcgq+ifmOcQ6rd+lmpRFWMkpzlB1/MrUx
        w1PAwnEZ8ryBA9uzRY/Ptw2NcZNt8qJY6m1u4wwhuG9ZxAeJpjMOjMJrrw6GfqYiffp3/XudIOj1F
        F69t2U5g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVvSe-0007Yd-Ua; Fri, 23 Oct 2020 11:42:21 +0000
Date:   Fri, 23 Oct 2020 12:42:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] synchronous readpage for buffer_heads
Message-ID: <20201023114220.GY20115@casper.infradead.org>
References: <20201022152256.GU20115@casper.infradead.org>
 <25528b1a-7434-62cb-705a-7269d050bbc1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25528b1a-7434-62cb-705a-7269d050bbc1@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 23, 2020 at 08:22:07AM +0200, Hannes Reinecke wrote:
> On 10/22/20 5:22 PM, Matthew Wilcox wrote:
> Hmm. You are aware, of course, that hch et al are working on replacing bhs
> with iomap, right?

$ git shortlog --author=Wilcox origin/master -- fs/iomap |head -1
Matthew Wilcox (Oracle) (17):

But actually, I don't see anyone working on a mass migration of
filesystems from either using BHs directly or using the mpage code to
using iomap.  I have a summer student for next summer who I'm going to
let loose on this problem, but I fear buffer_heads will be with us for
a long time to come.

I mean, who's going to convert reiserfs to iomap?
$ git log --no-merges --since=2015-01-01 origin/master fs/reiserfs |grep -c ^comm
130

Not exactly a thriving development community.  It doesn't even support
fallocate.

> So wouldn't it be more useful to concentrate on the iomap code, and ensure
> that _that_ is working correctly?

Did that one first, then did mpage_readpage(), now I've moved on to
block_read_full_page().  Now I'm going to go back and redo iomap
with everything I learned doing block_read_full_page().  It's going
to use blk_completion.
