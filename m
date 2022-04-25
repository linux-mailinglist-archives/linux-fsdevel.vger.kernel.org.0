Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE86450E04F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 14:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiDYMdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 08:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiDYMdS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:33:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B764731;
        Mon, 25 Apr 2022 05:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e/nSWGUN3FIAmeOGnERJTpavdH8S5PvkJMrvIlmos0A=; b=EUnNGTKsPcwlrnrm2PDN6Y/5Ae
        IAYZ0jEuutiZ9TSmOs3HZujZ2EhDcaB7xMcGaM3Z32Yvm77yKwh9Sc+aF8iphnrgVD3lH3FnCWJe2
        bBNrqojxDAGwGUEyXW060fHziSPtDE3+meG0khkIxx8z1PoI8+xKB6xa+VjK1E8mMlJTuTLSV7vlU
        GnOfWEdG4+NBcLA66dKydOSJqwAaQXALOdDYQ2xQ91T6kCgzvv1rWkBF+y4YsqjfktHIHwx/LHK0T
        FGkEV+ByPiaJ1B6vFSXDK4/DigWFiq0+YGcyHScm7ykrfWrGWeQYTfDgJV3JUNZAR1++pi8Bu9gW0
        e0ReSM9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nixqz-008geI-66; Mon, 25 Apr 2022 12:30:09 +0000
Date:   Mon, 25 Apr 2022 13:30:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 14/14] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
Message-ID: <YmaUUezsM+AS5R4y@casper.infradead.org>
References: <Yk9V/03wgdYi65Lb@casper.infradead.org>
 <Yk5W6zvvftOB+80D@casper.infradead.org>
 <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
 <164928630577.457102.8519251179327601178.stgit@warthog.procyon.org.uk>
 <469869.1649313707@warthog.procyon.org.uk>
 <3118843.1650888461@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3118843.1650888461@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 01:07:41PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > OK.  You suggested that releasepage was an acceptable place to call it.
> > How about we have AS_RELEASE_ALL (... or something ...) and then
> > page_has_private() becomes a bit more complicated ... to the point
> > where we should probably get rid of it (by embedding it into
> > filemap_release_folio():
> 
> I'm not sure page_has_private() is quite so easy to get rid of.
> shrink_page_list() and collapse_file(), for example, use it to conditionalise
> a call to try_to_release_page() plus some other bits.

That's what I was saying.  Make the calls to try_to_release_page()
unconditional and delete page_has_private() because it only confuses
people who should actually be using PagePrivate().

> I think that, for the moment, I would need to add a check for AS_RELEASE_ALL
> to page_has_private().
> 
> David
> 
> 
