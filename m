Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6617515A157
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 07:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgBLGeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 01:34:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgBLGen (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:34:43 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53335206DB;
        Wed, 12 Feb 2020 06:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581489282;
        bh=CzRudUeDo+wVwa7/TNw7sOyO0DwUDMqITe6/PlMG8AQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4g4lNmp0zgUEvD5Jg1HZ/pSYEOYUwWzEbd72XucSsanE7PW6E7KaMoizocCC9c/t
         fLsIxOWqbCUmHAYQrB/RRoUcW3yXF6qgwvTwkbZNe8+cBgUnJcRi5dGGEeKdxlXsX9
         ZfevMBE0eHrc3SnIROac5ZH1k6H9MTGLrsW4OB+M=
Date:   Tue, 11 Feb 2020 22:34:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 2/8] fs: Add standard casefolding support
Message-ID: <20200212063440.GL870@sol.localdomain>
References: <20200208013552.241832-1-drosen@google.com>
 <20200208013552.241832-3-drosen@google.com>
 <20200208021216.GE23230@ZenIV.linux.org.uk>
 <CA+PiJmTYbEA-hgrKwtp0jZXqsfYrzgogOZ0Pt=gTCtqhBfnqFA@mail.gmail.com>
 <20200210234207.GJ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210234207.GJ23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 11:42:07PM +0000, Al Viro wrote:
> On Mon, Feb 10, 2020 at 03:11:13PM -0800, Daniel Rosenberg wrote:
> > On Fri, Feb 7, 2020 at 6:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Fri, Feb 07, 2020 at 05:35:46PM -0800, Daniel Rosenberg wrote:
> > >
> > >
> > > Again, is that safe in case when the contents of the string str points to
> > > keeps changing under you?
> > 
> > I'm not sure what you mean. I thought it was safe to use the str and
> > len passed into d_compare. Even if it gets changed under RCU
> > conditions I thought there was some code to ensure that the name/len
> > pair passed in is consistent, and any other inconsistencies would get
> > caught by d_seq later. Are there unsafe code paths that can follow?
> 
> If you ever fetch the same byte twice, you might see different values.
> You need a fairly careful use of READ_ONCE() or equivalents to make
> sure that you don't get screwed over by that.
> 
> Sure, ->d_seq mismatch will throw the result out, but you need to make
> sure you won't oops/step on uninitialized memory/etc. in process.
> 
> It's not impossible to get right, but it's not trivial and you need all
> code working with that much more careful than normal for string handling.

It looks like this is a real problem, not just a "theoretical" data race.
For example, see:

utf8ncursor():
        /* The first byte of s may not be an utf8 continuation. */
        if (len > 0 && (*s & 0xC0) == 0x80)
                return -1;

and then utf8byte():
                } else if ((*u8c->s & 0xC0) == 0x80) {
                        /* This is a continuation of the current character. */
                        if (!u8c->p)
                                u8c->len--;
                        return (unsigned char)*u8c->s++;

The first byte of the string is checked in two different functions, so it's very
likely to be loaded twice.  In between, it could change from a non-continuation
byte to a continuation byte.  That would cause the string length to be
decremented from 0 to UINT_MAX.  Then utf8_strncasecmp() would run beyond the
bounds of the string until something happened to mismatch.

That's just an example that I found right away; there are probably more.

IMO, this needs to be fixed before anyone can actually use the ext4 and f2fs
casefolding stuff.

I don't know the best solution.  One option is to fix fs/unicode/ to handle
concurrently modified strings.  Another could be to see what it would take to
serialize lookups and renames for casefolded directories...

- Eric
