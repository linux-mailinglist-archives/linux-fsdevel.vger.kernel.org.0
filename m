Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB5487BA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 18:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiAGRv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 12:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiAGRv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:51:56 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF5C061574
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jan 2022 09:51:55 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5tP7-000Of2-0Y; Fri, 07 Jan 2022 17:51:53 +0000
Date:   Fri, 7 Jan 2022 17:51:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namei: clear nd->root.mnt before O_CREAT unlazy
Message-ID: <Ydh9uKldc0cbusbt@zeniv-ca.linux.org.uk>
References: <20220105180259.115760-1-bfoster@redhat.com>
 <4a13a560520e1ef522fcbb9f7dfd5e8c88d5b238.camel@themaw.net>
 <YdfVG56XZnkePk7c@zeniv-ca.linux.org.uk>
 <YdfngxyGWatLfa5h@zeniv-ca.linux.org.uk>
 <Ydh5If9ON/fRs7+N@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydh5If9ON/fRs7+N@bfoster>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 07, 2022 at 12:32:17PM -0500, Brian Foster wrote:

> > Other problems here (aside of whitespace damage - was that a
> > cut'n'paste of some kind?  Looks like 8859-1 NBSP for each
> > leading space...) are
> 
> Hmm.. I don't see any whitespace damage, even if I pull the patch back
> from the mailing list into my tree..?

That had occured in Ian's reply, almost certainly.  Looks like whatever
he's using for MUA (Evolution?) is misconfigured into doing whitespace
damage - his next mail (in utf8, rather than 8859-1) had a scattering of
U+00A0 in it...  Frankly, I'd never seen a decent GUI MUA, so I've no
real experience with that thing and no suggestions on how to fix that.

> > 	* misleading name of the new helper - it sounds like
> > "non-RCU side of complete_walk()" and that's not what it does
> 
> The intent was the opposite, of course. :P I'm not sure how you infer
> the above from _rcu(), but I'll name the helper whatever. Suggestions?

s/non-// in the above (I really had been half-asleep).  What I'm
saying is that this name invites an assumption that in RCU case
complete_walk() is equivalent to it.  Which is wrong - that's
what complete_walk() does as the first step if it needs to get
out of RCU mode.
