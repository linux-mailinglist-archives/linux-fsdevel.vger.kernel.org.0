Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001D8487357
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 08:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiAGHLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 02:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiAGHLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:11:03 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510E0C061245
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jan 2022 23:11:03 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5jOt-000I7E-Gi; Fri, 07 Jan 2022 07:10:59 +0000
Date:   Fri, 7 Jan 2022 07:10:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namei: clear nd->root.mnt before O_CREAT unlazy
Message-ID: <YdfngxyGWatLfa5h@zeniv-ca.linux.org.uk>
References: <20220105180259.115760-1-bfoster@redhat.com>
 <4a13a560520e1ef522fcbb9f7dfd5e8c88d5b238.camel@themaw.net>
 <YdfVG56XZnkePk7c@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdfVG56XZnkePk7c@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 05:52:27AM +0000, Al Viro wrote:

> > Looks good, assuming Al is ok with the re-factoring.
> > Reviewed-by: Ian Kent <raven@themaw.net>
> 
> Ummm....  Mind resending that?  I'm still digging myself from under
> the huge pile of mail, and this seems to have been lost in process...

Non-obvious part is that current code only does this forgetting
the root when we are certain that we won't look at it later in
pathwalk.  IOW, it's guaranteed to be the same through the entire
thing.  This patch changes that; the final component may very well
be e.g. an absolute symlink.  We won't know that until we unlazy,
so we can't make forgetting conditional upon that.

I _think_ it's not going to lead to any problems, but I'll need to
take a good look at the entire thing after I get some sleep -
I'm about to fall down right now.

Other problems here (aside of whitespace damage - was that a
cut'n'paste of some kind?  Looks like 8859-1 NBSP for each
leading space...) are
	* misleading name of the new helper - it sounds like
"non-RCU side of complete_walk()" and that's not what it does
	* LOOKUP_CACHED needs to be mentioned in commit message
(it's incompatible with O_CREAT, so it couldn't occur on that
codepath - the transformation is an equivalent one, but that
ought to be mentioned)
	* the change I mentioned above needs to be in commit
message - this one is a lot more subtle.

Anyway, I'll look into that tomorrow - too sleepy right now
to do any serious analysis.
