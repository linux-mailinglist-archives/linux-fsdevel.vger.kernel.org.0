Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996A5114277
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfLEOVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 09:21:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729240AbfLEOVE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:21:04 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90EC121823;
        Thu,  5 Dec 2019 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575555662;
        bh=zFPFhAPwFWCzlgPTd18hCv5TcuyxPL4nvClVVvLvz5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h73GFGrdmIfVr3nGlDrmXEnV6YTMrFPbSPNxt5lqAY5XTsc/zZSKHaRwYBI2A8WVm
         bj1QN5si2RvU7UQhUgmdVHHYFhHJU1eOYAWIuM9D+SRKDNmqlvBZikkGLnmxW3udRZ
         +9qyA4M3AqlGoLe0cs1wPi+rgRqZC8FcboX43b2E=
Date:   Thu, 5 Dec 2019 14:20:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org,
        paul@paul-moore.com, neilb@suse.de, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] selinux: fall back to ref-walk upon
 LSM_AUDIT_DATA_DENTRY too
Message-ID: <20191205142057.GB10647@willie-the-truck>
References: <20191121145245.8637-1-sds@tycho.nsa.gov>
 <20191121145245.8637-2-sds@tycho.nsa.gov>
 <20191122161131.GB26530@ZenIV.linux.org.uk>
 <18fef491-bee5-fbf6-a3b8-113150f324b4@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18fef491-bee5-fbf6-a3b8-113150f324b4@tycho.nsa.gov>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 22, 2019 at 11:27:37AM -0500, Stephen Smalley wrote:
> On 11/22/19 11:11 AM, Al Viro wrote:
> > On Thu, Nov 21, 2019 at 09:52:45AM -0500, Stephen Smalley wrote:
> > > commit bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> > > passed down the rcu flag to the SELinux AVC, but failed to adjust the
> > > test in slow_avc_audit() to also return -ECHILD on LSM_AUDIT_DATA_DENTRY.
> > > Previously, we only returned -ECHILD if generating an audit record with
> > > LSM_AUDIT_DATA_INODE since this was only relevant from inode_permission.
> > > Return -ECHILD on either LSM_AUDIT_DATA_INODE or LSM_AUDIT_DATA_DENTRY.
> > > LSM_AUDIT_DATA_INODE only requires this handling due to the fact
> > > that dump_common_audit_data() calls d_find_alias() and collects the
> > > dname from the result if any.
> > > Other cases that might require similar treatment in the future are
> > > LSM_AUDIT_DATA_PATH and LSM_AUDIT_DATA_FILE if any hook that takes
> > > a path or file is called under RCU-walk.
> > > 
> > > Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> > > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > ---
> > >   security/selinux/avc.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > > index 74c43ebe34bb..f1fa1072230c 100644
> > > --- a/security/selinux/avc.c
> > > +++ b/security/selinux/avc.c
> > > @@ -779,7 +779,8 @@ noinline int slow_avc_audit(struct selinux_state *state,
> > >   	 * during retry. However this is logically just as if the operation
> > >   	 * happened a little later.
> > >   	 */
> > > -	if ((a->type == LSM_AUDIT_DATA_INODE) &&
> > > +	if ((a->type == LSM_AUDIT_DATA_INODE ||
> > > +	     a->type == LSM_AUDIT_DATA_DENTRY) &&
> > >   	    (flags & MAY_NOT_BLOCK))
> > 
> > IDGI, to be honest.  Why do we bother with slow path if MAY_NOT_BLOCK has
> > been given?  If we'd run into "there's something to report" case, we
> > are not on the fastpath anymore.  IOW, why not have
> >          audited = avc_audit_required(requested, avd, result, 0, &denied);
> >          if (likely(!audited))
> >                  return 0;
> > 	if (flags & MAY_NOT_BLOCK)
> > 		return -ECHILD;
> >          return slow_avc_audit(state, ssid, tsid, tclass,
> >                                requested, audited, denied, result,
> >                                a, flags);
> > in avc_audit() and be done with that?
> 
> That works for me; we would also need to do the same in
> selinux_inode_permission().  We can then stop passing flags down to
> slow_avc_audit() entirely.

I'm new to looking at this code, but that would certainly have helped me to
understand it when I was reading it a couple of weeks back! So, for what
it's worth, you can count me in favour.

Cheers,

Will
