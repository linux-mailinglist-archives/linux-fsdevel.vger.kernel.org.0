Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34698619200
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 08:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKDHa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKDHaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:30:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB5829C90;
        Fri,  4 Nov 2022 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8/6nFd/9Yw6G0MwlVvIvQwnNcOFLIOEDrPk58fnkNds=; b=dcgMKeLsztWeuK97NWIh2GyK9y
        o3JidhwEhpmid22u2p044X9tuwcNgw8H0iqmoWpalfdf+FcKKvrXYtQWUN0eMAMyMpxSdVZ/Dj4pR
        F4/eH+HoPaPfS+NAORDYPeb2y4orJwhodmU9xWdZjxHquMzX/vQsbmA0jXoW6akcgDPcafQgRzMZJ
        jJlEMKq5d8jVPHBJZhhecj0giAs2X0iE/4ledw8Icc5dyW22AgckSBksgaNM0hVi2rZzcLiTD+de7
        RakryhpzmxhB/0R6ej1CpDDttjguSNNSN3sRsNIQls/NyU4S2RfCwskFvYNITkXgR/vLGZV8uIj5Y
        fo149Ajw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqrAB-002mKb-Qq; Fri, 04 Nov 2022 07:30:51 +0000
Date:   Fri, 4 Nov 2022 00:30:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <Y2S/q11ijXEqr8ue@infradead.org>
References: <Y2IyTx0VwXMxzs0G@infradead.org>
 <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <20221028210422.GC3600936@dread.disaster.area>
 <Y19EXLfn8APg3adO@casper.infradead.org>
 <7699.1667487070@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7699.1667487070@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 02:51:10PM +0000, David Howells wrote:
> > > filesystems right now.  Dave Howells' netfs infrastructure is trying
> > > to solve the problem for everyone (and he's been looking at iomap as
> > > inspiration for what he's doing).
> > 
> > Btw, I never understod why the network file systems don't just use
> > iomap.  There is nothing block specific in the core iomap code.
> 
> It calls creates and submits bio structs all over the place.  This seems to
> require a blockdev.

The core iomap code (fs/iomap/iter.c) does not.  Most users of it
are block device centric right now, but for example the dax.c uses
iomap for byte level DAX accesses without ever looking at a bdev,
and seek.c and fiemap.c do not make any assumptions on the backend
implementation.
