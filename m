Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A926C927A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Mar 2023 07:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCZFD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 01:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCZFD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 01:03:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A957AF39;
        Sat, 25 Mar 2023 22:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k4rVIUAgbVmPVdh+2w/2nG22Kv+j5tPnLwsCx7fNYF0=; b=F/mz5ZO9GTl5hYlKgNqBETFhyH
        7ceXXU1h+Jh5HitcN9VzvD3Eg44q2Filrb1aCy/YP82BsQAuC3eI0S2uMqkIAa+Ze1SSg8H3q3awm
        uVaDFGNfOjpdbq4pKySvuG6zKwHXlqtR/1QBahCU46Lf5w/2DmFRnpm9aI/NSGyBhApZ7K10Ltoyh
        su/ACZ3f08KWlWZPh2fgUL7xg07FOPNtaRzRUK0P3cm5EstyOCDjs6NQ/wHvLJM0+cGyq5vZUNt2s
        tLcpJN8bx/33exWsrrkovAkWOhTmrvlsAfY4t6OCaxplgLSbRkz5VkrkT6y1TUhEaqdzybQ5u1GMP
        kjcqSjkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgIXl-0020lr-2Z;
        Sun, 26 Mar 2023 05:03:49 +0000
Date:   Sun, 26 Mar 2023 06:03:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com
Subject: Re: [PATCH 1/7] fs: Expose name under lookup to d_revalidate hook
Message-ID: <20230326050349.GE3390869@ZenIV>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-2-krisman@collabora.com>
 <20230323143320.GC136146@mit.edu>
 <ZB74FsfDDUegrqqx@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB74FsfDDUegrqqx@mit.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 25, 2023 at 09:33:10AM -0400, Theodore Ts'o wrote:
> On Thu, Mar 23, 2023 at 10:33:20AM -0400, Theodore Ts'o wrote:
> > On Wed, Jun 22, 2022 at 03:45:57PM -0400, Gabriel Krisman Bertazi wrote:
> > > Negative dentries support on case-insensitive ext4/f2fs will require
> > > access to the name under lookup to ensure it matches the dentry.  This
> > > adds an optional new flavor of cached dentry revalidation hook to expose
> > > this extra parameter.
> > > 
> > > I'm fine with extending d_revalidate instead of adding a new hook, if
> > > it is considered cleaner and the approach is accepted.  I wrote a new
> > > hook to simplify reviewing.
> > > 
> > > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > 
> > Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> > 
> > Al, could you take a look and see if you have any objections?
> 
> Ping, Al, any objsections if I take Gabriel's patch series via the
> ext4 tree?

The really subtle part is ->d_name stability in there.  We probably are OK
as it is with the current tree (at least I hope so), but it really needs
to be documented - the proof of correctness is not straightforward and it's
going to be brittle; it's not obvious that this memcmp() relies upon the
parent being locked in all cases when we get to calling it.  And if that
ever becomes not true, we have a hard-to-debug source of occasional oopsen ;-/

It can be done without reliance on locking - take a look at the vicinity of
dentry_cmp() in fs/dcache.c for example of such, but it's very much not
a blind memcmp().  And I suspect that it would be an overkill here.

In any case, that needs to be discussed in commit message and clearly
spelled out.  Otherwise it's a trouble waiting to happen.
