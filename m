Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344D7245A09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 01:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgHPXJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Aug 2020 19:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgHPXJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Aug 2020 19:09:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8274C061786
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Aug 2020 16:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o1yGlNHkaTO6aDYXYPbCQWx9AKxnH13YpSUgTpWcfxo=; b=B0WGUpCqveJJYzoelIQHjacDq0
        XKx0eABrRTBsIWYyG9ueA33utUYE1xotAp2d+kHj/cdS15asY9dLpmFEPWDa3GgIl72pLdOdVXFyG
        ua8P3KeWSTRHNlWGWXWPc5ivPJrVsWs3taf2tgEGEA9mz9cvPHV207xXiOFGxIysVqDVAnowIF/4A
        wERGxwvOTUlpMIoqk73qdU3sY+2VSbstKd7pj4mSyY1yAW62IMxoSc2z73tLvQr5ECxaJV2dR97Fg
        KRrHArlKf/Pwk/L1OgN1UIOqor5Lka/D9r2np0o/d/Tob6HGq6UxTax+MfxIB4RBzUZppzmOcoOpL
        yR+zGyGg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7Rm0-0000Xp-My; Sun, 16 Aug 2020 23:09:08 +0000
Date:   Mon, 17 Aug 2020 00:09:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200816230908.GI17456@casper.infradead.org>
References: <20200728105503.GE2699@work-vm>
 <12480108.dgM6XvcGr8@silver>
 <20200812143323.GF2810@work-vm>
 <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200816225620.GA28218@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 08:56:20AM +1000, Dave Chinner wrote:
> Indeed, most filesystems will not be able to implement ADS as
> xattrs. xattrs are implemented as atomicly journalled metadata on
> most filesytems, they cannot be used like a seekable file by
> userspace at all. If you want ADS to masquerade as an xattr, then
> you have to graft the entire file IO path onto filesytsem xattrs,
> and that just ain't gonna work without a -lot- of development in
> every filesystem that wants to support ADS.
> 
> We've already got a perfectly good presentation layer for user data
> files that are accessed by file descriptors (i.e. directories
> containing files), so that should be the presentation layer you seek
> to extend.
> 
> IOWs, trying to use abuse xattrs for ADS support is a non-starter.

One thing Dave didn't mention is that a directory can have xattrs,
forks and files (and acls).  So your presentation layer needs to not
confuse one thing for another.

I don't understand why a fork would be permitted to have its own
permissions.  That makes no sense.  Silly Solaris.
