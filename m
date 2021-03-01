Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB94328EE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbhCATkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 14:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbhCATgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:36:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65071C061756;
        Mon,  1 Mar 2021 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NDfBkHfJYw2TUJvFExAsMqhe6z86NDmN0AHfQTw8fM0=; b=HnDUq5z1DcSWtJDoeCqk5G3ZWD
        VMJFMZS2K/68HbIqNvsiH2cwiPs+4lFZfnhYyEqRBu5wgSnFLQvI133AzG6+KbIku06NX0r3Ix23r
        ES+8ZGvRf4IcbzJFWQOBIorhionxboWurd5vxWrR7IN1YQjeMQqFTyCSLFjBG+go9150MDMBSpVrF
        kqleZaWAf0ABqVS2BgbNReOe8fgRAZcpI1QqyF1DLLIvIJwRGVN29hESnL73Iw5qdx0mJVNax6MwP
        GfeOfqGiHSbvJb/7KwL4EzPFB1+euXw5VLITYdEQB0BF5ijGq1RLYAqUYvn6YAMbttAA7jqpcYOgJ
        iTxXsBfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGoKP-00G8cr-7j; Mon, 01 Mar 2021 19:35:44 +0000
Date:   Mon, 1 Mar 2021 19:35:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Drew DeVault <sir@cmpwn.com>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
Message-ID: <20210301193537.GS2723601@casper.infradead.org>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <20210228022440.GN2723601@casper.infradead.org>
 <C9KT3SWXRPPA.257SY2N4MVBZD@taiga>
 <20210228040345.GO2723601@casper.infradead.org>
 <C9L7SV0Z2GZR.K2C3O186WDJ7@taiga>
 <20210301190903.GD14881@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301190903.GD14881@fieldses.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 02:09:03PM -0500, J. Bruce Fields wrote:
> On Sun, Feb 28, 2021 at 08:57:20AM -0500, Drew DeVault wrote:
> > On Sat Feb 27, 2021 at 11:03 PM EST, Matthew Wilcox wrote:
> > > > 1. Program A creates a directory
> > > > 2. Program A is pre-empted
> > > > 3. Program B deletes the directory
> > > > 4. Program A creates a file in that directory
> > > > 5. RIP
> > >
> > > umm ... program B deletes the directory. program A opens it in order to
> > > use openat(). program A gets ENOENT and exits, confused. that's the
> > > race you're removing here -- and it seems fairly insignificant to me.
> > 
> > Yes, that is the race being eliminated here. Instead of this, program A
> > has an fd which holds a reference to the directory, so it just works. A
> > race is a race. It's an oversight in the API.
> 
> Step 4 still fails either way, because you can't create a file in an
> unlinked directory, even if you hold a reference to that directory.
> What's the behavior change at step 4 that you're hoping for?

If step 3 is 'mv foo bar', then the behaviour change will be that the
files still get created, just as bar/quux, instead of foo/quux.  It's not
clear to me this is necessarily an improvement in behaviour.

(as an aside, i think there's a missing feature in posix -- being able
to atomically replace one directory with another.  you can atomically
replace one file with another with hard links, but since you can't
hardlink a directory, you can't do the same trick.  Maybe you should
just always move files out of a directory instead of moving directories
as a single operation)
