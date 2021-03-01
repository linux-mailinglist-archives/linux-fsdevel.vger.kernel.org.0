Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4FD328D98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 20:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbhCATOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 14:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbhCATKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:10:18 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08618C061756;
        Mon,  1 Mar 2021 11:09:04 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 580932501; Mon,  1 Mar 2021 14:09:03 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 580932501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614625743;
        bh=fx08SB4p4laIiZ9WJfR8nFHYQh/buf1pMVpOaKYR+GU=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=y4Ylmae1mUZaQR1v44qdwyjN/Q9y5UdUyUAW1kPwUFAukO3nDahtUWvsMVRRbu0zQ
         HS0MV/drqw6+5vj7r37jHIVEBW74WG3WG8sdH53vrZ4Qm8yfhWfq0rUSH3pYbEpO4E
         4B+G8L3S6lV4ytTE0qwbDo8ywFRxH84/lA6/kUVE=
Date:   Mon, 1 Mar 2021 14:09:03 -0500
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
Message-ID: <20210301190903.GD14881@fieldses.org>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <20210228022440.GN2723601@casper.infradead.org>
 <C9KT3SWXRPPA.257SY2N4MVBZD@taiga>
 <20210228040345.GO2723601@casper.infradead.org>
 <C9L7SV0Z2GZR.K2C3O186WDJ7@taiga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9L7SV0Z2GZR.K2C3O186WDJ7@taiga>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 28, 2021 at 08:57:20AM -0500, Drew DeVault wrote:
> On Sat Feb 27, 2021 at 11:03 PM EST, Matthew Wilcox wrote:
> > > 1. Program A creates a directory
> > > 2. Program A is pre-empted
> > > 3. Program B deletes the directory
> > > 4. Program A creates a file in that directory
> > > 5. RIP
> >
> > umm ... program B deletes the directory. program A opens it in order to
> > use openat(). program A gets ENOENT and exits, confused. that's the
> > race you're removing here -- and it seems fairly insignificant to me.
> 
> Yes, that is the race being eliminated here. Instead of this, program A
> has an fd which holds a reference to the directory, so it just works. A
> race is a race. It's an oversight in the API.

Step 4 still fails either way, because you can't create a file in an
unlinked directory, even if you hold a reference to that directory.
What's the behavior change at step 4 that you're hoping for?

--b.
