Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197732FF40C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 20:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbhAUTMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 14:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbhAUTK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:10:56 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C8C061756;
        Thu, 21 Jan 2021 11:09:38 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7790068A6; Thu, 21 Jan 2021 14:09:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7790068A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611256177;
        bh=N/byAs1v6tc9Fx3ki4Hix9OpQ2b4N7bUlr5L+Udyz04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v12SGAI5TdTGVdUXLNRFq4bYEJiB3wwXNox11gArFVnndbZSQLf36kKRFo95UyeQY
         CO7QjlprxG0AHzpbsAXIme2ZNIcWn0te5LWMp6nGA+4cNMBpacJ9xmATTjhLCoftDm
         vFchlftsuiau3nyD/mo1dMyfCGV87yqk3pnkw+U0=
Date:   Thu, 21 Jan 2021 14:09:37 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Takashi Iwai <tiwai@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 00/25] Network fs helper library & fscache kiocb API
Message-ID: <20210121190937.GE20964@fieldses.org>
References: <20210121174306.GB20964@fieldses.org>
 <20210121164645.GA20964@fieldses.org>
 <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
 <1794286.1611248577@warthog.procyon.org.uk>
 <1851804.1611255313@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1851804.1611255313@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:55:13PM +0000, David Howells wrote:
> J. Bruce Fields <bfields@fieldses.org> wrote:
> 
> > > Fixing this requires a much bigger overhaul of cachefiles than this patchset
> > > performs.
> > 
> > That sounds like "sometimes you may get file corruption and there's
> > nothing you can do about it".  But I know people actually use fscache,
> > so it must be reliable at least for some use cases.
> 
> Yes.  That's true for the upstream code because that uses bmap.

Sorry, when you say "that's true", what part are you referring to?

> I'm switching
> to use SEEK_HOLE/SEEK_DATA to get rid of the bmap usage, but it doesn't change
> the issue.
> 
> > Is it that those "bridging" blocks only show up in certain corner cases
> > that users can arrange to avoid?  Or that it's OK as long as you use
> > certain specific file systems whose behavior goes beyond what's
> > technically required by the bamp or seek interfaces?
> 
> That's a question for the xfs, ext4 and btrfs maintainers, and may vary
> between kernel versions and fsck or filesystem packing utility versions.

So, I'm still confused: there must be some case where we know fscache
actually works reliably and doesn't corrupt your data, right?

--b.
