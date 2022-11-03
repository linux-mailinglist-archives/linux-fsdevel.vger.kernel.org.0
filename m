Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75F1618921
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 21:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKCUA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 16:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKCUA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:00:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5768118399
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JDTbYfEmE3RY3MZnLfPL1ZPNsP+BGq776YUqoN8YClA=; b=sbZdKprEaVfJx/edQIzRaKiJ5+
        inrE/lq7yT3nf/hICqSNRo2RiMXQiAWodJ7ZlP9iSPqeHBkxY1lOHaeM11D0t/XWXdKEjfpMlt5sv
        2bT7L05fdVbHj5Hsi+OM+w2WKTrFitXwO8n3Dk9Kp16LvRlygT5/yiaZpTuv+nku8CL/rC5Qldr+z
        jO9d504AL7j4FsL/sE6rBjk2fzLERGcIzoy9K8kAuhWmbF+GLfvODtE2TwCecn1pdj2RkYOqT/uCA
        CiBYT6VYwtLt4GrlT8GHkM9Xoo83pt674NIf+mgSTLeqxGYLllVg7cfDBS4FkeTMvtZtyO0JaU463
        QzDUyhEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqgO1-006kW0-9q; Thu, 03 Nov 2022 20:00:25 +0000
Date:   Thu, 3 Nov 2022 20:00:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: xarray, fault injection and syzkaller
Message-ID: <Y2Qd2dBqpOXuJm22@casper.infradead.org>
References: <Y2QR0EDvq7p9i1xw@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2QR0EDvq7p9i1xw@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 04:09:04PM -0300, Jason Gunthorpe wrote:
> Hi All,
> 
> I wonder if anyone has some thoughts on this - I have spent some time
> setting up syzkaller for a new subsystem and I've noticed that nth
> fault injection does not reliably cause things like xa_store() to
> fail.
> 
> It seems the basic reason is that xarray will usually do two
> allocations, one in an atomic context which fault injection does
> reliably fail, but then it almost always follows up with a second
> allocation in a non-atomic context that doesn't fail because nth has
> become 0.

Hahaha.  I didn't intentionally set out to thwart memory allocation
fault injection.  Realistically, do we want it to fail though?
GFP_KERNEL allocations of small sizes are supposed to never fail.
(for those not aware, node allocations are 576 bytes; typically the slab
allocator bundles 28 of them into an order-2 allocation).

I think a simple solution if we really do want to make allocations fail
is to switch error injection from "fail one allocation per N" to "fail
M allocations per N".  eg, 7 allocations succeed, 3 allocations fail,
7 succeed, 3 fail, ...  It's more realistic because you do tend to see
memory allocation failures come in bursts.
