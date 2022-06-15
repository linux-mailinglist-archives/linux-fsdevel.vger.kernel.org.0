Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7636254CA00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 15:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348465AbiFONku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 09:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiFONkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:40:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F405A36B7F;
        Wed, 15 Jun 2022 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dXp+jK4MrH7OEb332d6Ruc7/Sb9wEG92lN7ioJOCV7c=; b=T6gWnDr/RCAf2tuGlf98kWhaMi
        jz/yi6ouyKZkItIUDE5opGIcE7y7GVoJ9ZXqGp+VjxoQpzV2W04yd4+IRP/CL9PFiQs3Mr9iwG5GF
        5Kg/RMsB0vUsoEgKLldO9vSqb6UtvJoPHwMLfOxfFj0yKAwjmI3bFLpo5Vdc45yiF/ZJiibep6jPj
        aVJlq0eQOqdxE2WeVxXD2ETdLppV3LcxeirDhat9Ps6wVn7uiiV34YUF1CNNtjZPTGQj1EM3hAdKz
        MYFM7PMOpc5WOZGOh+sx+Yk969wJjaIGHGxFEh8O+sR0EEuDyhSmsVvcY287ahpIvukFd85kdLVlF
        WdQoEp/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1TGF-0015W2-It; Wed, 15 Jun 2022 13:40:43 +0000
Date:   Wed, 15 Jun 2022 14:40:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ikent@redhat.com, onestero@redhat.com
Subject: Re: [PATCH 1/3] radix-tree: propagate all tags in idr tree
Message-ID: <YqnhW2CI1kbJ3NqR@casper.infradead.org>
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-2-bfoster@redhat.com>
 <Yqm+jmkDA+um2+hd@infradead.org>
 <YqnXVMtBkS2nbx70@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqnXVMtBkS2nbx70@bfoster>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 15, 2022 at 08:57:56AM -0400, Brian Foster wrote:
> On Wed, Jun 15, 2022 at 04:12:14AM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 14, 2022 at 02:09:47PM -0400, Brian Foster wrote:
> > > The IDR tree has hardcoded tag propagation logic to handle the
> > > internal IDR_FREE tag and ignore all others. Fix up the hardcoded
> > > logic to support additional tags.
> > > 
> > > This is specifically to support a new internal IDR_TGID radix tree
> > > tag used to improve search efficiency of pids with associated
> > > PIDTYPE_TGID tasks within a pid namespace.
> > 
> > Wouldn't it make sense to switch over to an xarray here rather
> > then adding new features to the radix tree?
> > 
> 
> The xarray question crossed my mind when I first waded into this code
> and realized the idr tree seems to be some sort of offshoot or custom
> mode of the core radix tree. I eventually realized that the problem wrt
> to normal radix tree tags in the idr variant was that the tag
> propagation logic in the idr variant simply didn't care to handle
> traditional tags, presumably because they were unused in that mode. So
> this patch doesn't really add a feature to the radix-tree, it just fixes
> up some of the grotty idr tree logic to handle both forms of tags.
> 
> I assume it makes sense for this to move towards xarray in general, but
> I don't have enough context on either side to know what the sticking
> points are. In particular, does xarray support something analogous to
> IDR_FREE or otherwise solve whatever problem idr currently depends on it
> for (i.e. efficient id allocation)? I think Willy has done work in this
> area so I'm hoping he can chime in on some of that if he's put any
> thought into the idr thing specifically..

Without going into the history of the idr/radix-tree/xarray, the
current hope is that we'll move all users of the idr & radix tree
over to the xarray API.  It's fundamentally the same data structure
for all three now, just a question of the API change. 

The XArray does indeed have a way to solve the IDR_FREE problem;
you need to declare an allocating XArray:
https://www.kernel.org/doc/html/latest/core-api/xarray.html#allocating-xarrays

and using XA_MARK_1 and XA_MARK_2 should work the way you want them to.

