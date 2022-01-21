Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF36D49604C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 15:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380906AbiAUOEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 09:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380922AbiAUODT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:03:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F740C061746;
        Fri, 21 Jan 2022 06:03:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91274B81F88;
        Fri, 21 Jan 2022 14:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01E1C340E1;
        Fri, 21 Jan 2022 14:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642773796;
        bh=VhaycQsVQhO294Y7zOKRAe6+Mf/V7XSOrj7+ZIMjYSo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=b+0S+RDr0VIJeqXMOjASn/VrVGOW476y29TiRcfTXzCo/blGYiQiv5ZMc0S0/cJLR
         6wQ/PFNdFUJ+L70hvtHt2yVIyEr3we2HHVLHqurXzqLw2zcXxs8qH+epQlx+MHLoee
         JvG0Gv/HVeJPN2HCPEwudsID1I9l5XjjJZkTR6dWqOwC8153mDSpeqc/KMebGf8B5o
         UUTAEJFhS1yKfGouU+8eAc/fXFrw4L3ZI+On2ae/cO/ive6DH8IJkeMwOLKUOip/nL
         /yS5gf0TUbaIpR+4xtHuQZNE7OeNUJsnGsWV7bZ9If1ux4yJXMnlIzLCHAUHsPylOx
         ayPX4Lgp/6UPw==
Message-ID: <35bb39af7b59920dc6160d69581cca987e8f4a36.camel@kernel.org>
Subject: Re: [PATCH 2/3] ceph: Uninline the data on a file opened for writing
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 21 Jan 2022 09:03:14 -0500
In-Reply-To: <2883819.1642438775@warthog.procyon.org.uk>
References: <YeWdlR7nsBG8fYO2@casper.infradead.org>
         <164243678893.2863669.12713835397467153827.stgit@warthog.procyon.org.uk>
         <164243679615.2863669.15715941907688580296.stgit@warthog.procyon.org.uk>
         <2883819.1642438775@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
> I wonder if the uninlining code should lock the inode while it does it and the
> truncation code should do uninlining too.
> 

It probably should have done uninlining on truncate(). OTOH, the old
code never did this, so I'm not inclined to add that in. 

I'd feel differently if we were looking to keep the inline_data as a
feature, long-term, but we aren't. The plan is to keep this feature
limping along in the kclient until the last ceph release that supports
inline_data is no longer supported in the field, at which point we'll
rip support out altogether.

We officially marked it deprecated in the Octopus release, and I was
hoping to remove it from ceph in Quincy (which should ship this
spring). We still need the cephfs-scrub utility to walk the fs and
uninline any files that are still inlined so we can support people on
upgrades. That work isn't finished yet. See:

    https://tracker.ceph.com/issues/52916

-- 
Jeff Layton <jlayton@kernel.org>
