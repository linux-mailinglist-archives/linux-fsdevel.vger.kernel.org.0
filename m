Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8829C631B7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 09:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiKUIdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 03:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiKUIdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:33:08 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A94DF31;
        Mon, 21 Nov 2022 00:33:08 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 72A3668C7B; Mon, 21 Nov 2022 09:33:03 +0100 (CET)
Date:   Mon, 21 Nov 2022 09:33:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] afs: Stop implementing ->writepage()
Message-ID: <20221121083303.GB27500@lst.de>
References: <20221121071704.GC23882@lst.de> <166876785552.222254.4403222906022558715.stgit@warthog.procyon.org.uk> <150667.1669019337@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150667.1669019337@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 08:28:57AM +0000, David Howells wrote:
> > That would be much preferred over the for_write_begin hack, given that
> > write_begin really isn't a well defined method but a hacky hook for
> > legacy write implementations.
> 
> So I don't need to worry about the control group stuff?  I'll still need some
> way to flush a conflicting write whatever mechanism is being used to write to
> the page cache.

cgroup is used for throttling writeback.  If you need to flush conflicting
writes I can't see how interacting with the cgroups benefits anyone.

An as far as I can tell afs doesn't support cgroup writeback to start
with.
