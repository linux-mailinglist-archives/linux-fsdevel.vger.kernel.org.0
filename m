Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37545490F4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 18:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbiAQRUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 12:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243331AbiAQRTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:19:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EAEC0617A9;
        Mon, 17 Jan 2022 09:15:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56FA6612FD;
        Mon, 17 Jan 2022 17:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA2DC36AE3;
        Mon, 17 Jan 2022 17:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642439731;
        bh=UQftQvftWJGq9tAqRXsbVT9t3nswoZP5zPfvoEhb4kM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n8q50GcfwX4AU6CwRUVIy/IgXwiT0Fv0d74qXz0THWW40f4dgBBAtYKd/1MhFuaev
         EkHMdKHBFlOIwa9erlkLPxSjm3Y6TnGIqMjfnblwfr02eW953hxsSDSJ/pgeTXSo3e
         NYmvXYiYRkdL3bI+vCWSMNs63YPMAAwPL/saO6C6BOQzU8fjDyZo/gray0nH7O+YnE
         ogq3wpqZk18I08Oluj56ILk60bXyt6CZwke/kJjzUR9GHV1Gk7sNPrSkg1ETb8/kSz
         2BMQRs/BBN9i1pchSMRF1VMFyzVcYqTMMdM7+c6yu08j7wWYwrEIZ/q3kgZkrlBon6
         h4CQZBbJql9CA==
Message-ID: <ce72aab52c513a03df15a373fb9f30c8b3f9ebce.camel@kernel.org>
Subject: Re: [PATCH 2/3] ceph: Uninline the data on a file opened for writing
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 17 Jan 2022 12:15:30 -0500
In-Reply-To: <2883819.1642438775@warthog.procyon.org.uk>
References: <YeWdlR7nsBG8fYO2@casper.infradead.org>
         <164243678893.2863669.12713835397467153827.stgit@warthog.procyon.org.uk>
         <164243679615.2863669.15715941907688580296.stgit@warthog.procyon.org.uk>
         <2883819.1642438775@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-01-17 at 16:59 +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > +	if (folio_test_uptodate(folio))
> > > +		goto out_put_folio;
> > 
> > Er ... if (!folio_test_uptodate(folio)), perhaps?  And is it even
> > worth testing if read_mapping_folio() returned success?  I feel like
> > we should take ->readpage()'s word for it that success means the
> > folio is now uptodate.
> 
> Actually, no, I shouldn't need to do this since it comes out with the page
> lock still held.
> 
> > > +	len = i_size_read(inode);
> > > +	if (len >  folio_size(folio))
> > 
> > extra space.  Plus, you're hardcoding 4096 below, but using folio_size()
> > here which is a bit weird to me.
> 
> As I understand it, 4096 is the maximum length of the inline data, not
> PAGE_SIZE, so I have to be careful when doing a DIO read because it might
> start after the data - and there's also truncate to consider:-/
> 

The default is 4k for the userland client, and the kernel client had it
hardcoded at 4k (though it seemed to swap in PAGE_SIZE in random places
in the code).

I think the MDS allows the client to inline an arbitrary size of data
but there are probably some limits I don't see. I have no idea how the
client is intended to discover this value...

The whole inlining feature was somewhat half-baked, IMNSHO.

> I wonder if the uninlining code should lock the inode while it does it and the
> truncation code should do uninlining too.
> 

Probably. This code is on the way out of ceph and (eventually) the
kernel, so I'm not inclined to worry too much about subtle bugs in here.
-- 
Jeff Layton <jlayton@kernel.org>
