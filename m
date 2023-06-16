Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC78A733563
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 18:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjFPQHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFPQHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:07:08 -0400
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07C62D72
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 09:07:04 -0700 (PDT)
Date:   Fri, 16 Jun 2023 12:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686931622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1USo/ooQu2H7EgxmruGrjOf5Ce4S9FGHhwjIFSZcL8g=;
        b=AvYIpx2IZmfDjuE83FMHHGRVn5CHoIbLozXAhwVh2bD5fACJ29EVxnu2MCMm9d09OEipb0
        MgBFJDyj/QpsA3DesKX/8Wq3MHqu3wV57uW4yJuqfX7cUCLXM4Ps7pDBGLX2LGOBc8No7b
        9+LlES+CUK2YNrstj0ZkECR9Qpqy0vY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/7] RFC: high-order folio support for I/O
Message-ID: <ZIyIon3DCdA14pWR@moria.home.lan>
References: <20230614114637.89759-1-hare@suse.de>
 <cd816905-0e3e-6397-1a6f-fd4d29dfc739@suse.de>
 <ZInGbz6X/ZQAwdRx@casper.infradead.org>
 <b3fa1b77-d120-f86b-e02f-f79b6d13efcc@suse.de>
 <ZIpS9u4P43PgJwuj@dread.disaster.area>
 <df8e7a88-f540-af93-77dc-164262a5a3d0@suse.de>
 <ZIrRFwElpZsAnl4Q@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIrRFwElpZsAnl4Q@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:51:35PM +1000, Dave Chinner wrote:
> On Thu, Jun 15, 2023 at 08:21:10AM +0200, Hannes Reinecke wrote:
> > On 6/15/23 01:53, Dave Chinner wrote:
> > > On Wed, Jun 14, 2023 at 05:06:14PM +0200, Hannes Reinecke wrote:
> > > All you need to do now is run the BS > PS filesytems through a full
> > > fstests pass (reflink + rmap enabled, auto group), and then we can
> > > start on the real data integrity validation work. It'll need tens of
> > > billions of fsx ops run on it, days of recoveryloop testing, days of
> > > fstress based exercise, etc before we can actually enable it in
> > > XFS....
> > > 
> > Hey, c'mon. I do know _that_. All I'm saying is that now we can _start_
> > running tests and figure out corner cases (like NFS crashing on me :-).
> > With this patchset we now have some infrastructure in place making it
> > even _possible_ to run those tests.
> 
> I got to this same point several years ago. You know, that patchset
> that Luis went back to when he brought up this whole topic again?
> That's right when I started running fsx, and I realised it
> didn't cover FICLONERANGE, FIDEDUPERANGE and copy_file_range().
> 
> Yep, that's when we first realised we had -zero- test coverage of
> those operations. Darrick and I spent the next *3 months* pretty
> much rewriting the VFS level of those operations and fixing all the
> other bugs in the implementations, just so we could validate they
> worked correct on BS <= PS.

code coverage analysis...
