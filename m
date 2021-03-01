Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764D73290D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 21:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbhCAUQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 15:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242427AbhCAULG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:11:06 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6FEC061788;
        Mon,  1 Mar 2021 12:10:03 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 563F235BD; Mon,  1 Mar 2021 15:10:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 563F235BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614629402;
        bh=9RzUNuAmBgiEurJcvyMwQZZDCBAcHA/knUacpHohAco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m86Vv4mFxnE6qiMYakktAUKhi5I62RjVdmWAuzWzwfT2f38p4M4h1L5CHBOP5Nr3V
         09mcVwULV/ptAVwPO25s9mFBYhO60DkKKj1MJj5dWWoaC2j7p072XXy6MKzxKQoxqW
         VkAVdCcvaD7DQWZ+w1nLDRCekXs7xaSK/fa2oVvs=
Date:   Mon, 1 Mar 2021 15:10:02 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Drew DeVault <sir@cmpwn.com>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
Message-ID: <20210301201002.GA16303@fieldses.org>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <20210228022440.GN2723601@casper.infradead.org>
 <C9KT3SWXRPPA.257SY2N4MVBZD@taiga>
 <20210228040345.GO2723601@casper.infradead.org>
 <C9L7SV0Z2GZR.K2C3O186WDJ7@taiga>
 <20210301190903.GD14881@fieldses.org>
 <20210301193537.GS2723601@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301193537.GS2723601@casper.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 07:35:37PM +0000, Matthew Wilcox wrote:
> On Mon, Mar 01, 2021 at 02:09:03PM -0500, J. Bruce Fields wrote:
> > On Sun, Feb 28, 2021 at 08:57:20AM -0500, Drew DeVault wrote:
> > > On Sat Feb 27, 2021 at 11:03 PM EST, Matthew Wilcox wrote:
> > > > > 1. Program A creates a directory
> > > > > 2. Program A is pre-empted
> > > > > 3. Program B deletes the directory
> > > > > 4. Program A creates a file in that directory
> > > > > 5. RIP
> > > >
> > > > umm ... program B deletes the directory. program A opens it in order to
> > > > use openat(). program A gets ENOENT and exits, confused. that's the
> > > > race you're removing here -- and it seems fairly insignificant to me.
> > > 
> > > Yes, that is the race being eliminated here. Instead of this, program A
> > > has an fd which holds a reference to the directory, so it just works. A
> > > race is a race. It's an oversight in the API.
> > 
> > Step 4 still fails either way, because you can't create a file in an
> > unlinked directory, even if you hold a reference to that directory.
> > What's the behavior change at step 4 that you're hoping for?
> 
> If step 3 is 'mv foo bar', then the behaviour change will be that the
> files still get created, just as bar/quux, instead of foo/quux.  It's not
> clear to me this is necessarily an improvement in behaviour.

Oh, OK.

Yeah, it'd be useful to have some more detail on how this would be used.

--b.

> (as an aside, i think there's a missing feature in posix -- being able
> to atomically replace one directory with another.  you can atomically
> replace one file with another with hard links, but since you can't
> hardlink a directory, you can't do the same trick.  Maybe you should
> just always move files out of a directory instead of moving directories
> as a single operation)
