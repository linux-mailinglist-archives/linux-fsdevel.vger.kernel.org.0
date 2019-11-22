Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D82310757A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 17:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKVQLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 11:11:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46434 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVQLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:11:35 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYBWt-0008E6-1N; Fri, 22 Nov 2019 16:11:31 +0000
Date:   Fri, 22 Nov 2019 16:11:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, will@kernel.org,
        neilb@suse.de, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] selinux: fall back to ref-walk upon
 LSM_AUDIT_DATA_DENTRY too
Message-ID: <20191122161131.GB26530@ZenIV.linux.org.uk>
References: <20191121145245.8637-1-sds@tycho.nsa.gov>
 <20191121145245.8637-2-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121145245.8637-2-sds@tycho.nsa.gov>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:52:45AM -0500, Stephen Smalley wrote:
> commit bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> passed down the rcu flag to the SELinux AVC, but failed to adjust the
> test in slow_avc_audit() to also return -ECHILD on LSM_AUDIT_DATA_DENTRY.
> Previously, we only returned -ECHILD if generating an audit record with
> LSM_AUDIT_DATA_INODE since this was only relevant from inode_permission.
> Return -ECHILD on either LSM_AUDIT_DATA_INODE or LSM_AUDIT_DATA_DENTRY.
> LSM_AUDIT_DATA_INODE only requires this handling due to the fact
> that dump_common_audit_data() calls d_find_alias() and collects the
> dname from the result if any.
> Other cases that might require similar treatment in the future are
> LSM_AUDIT_DATA_PATH and LSM_AUDIT_DATA_FILE if any hook that takes
> a path or file is called under RCU-walk.
> 
> Fixes: bda0be7ad994 ("security: make inode_follow_link RCU-walk aware")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/avc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 74c43ebe34bb..f1fa1072230c 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -779,7 +779,8 @@ noinline int slow_avc_audit(struct selinux_state *state,
>  	 * during retry. However this is logically just as if the operation
>  	 * happened a little later.
>  	 */
> -	if ((a->type == LSM_AUDIT_DATA_INODE) &&
> +	if ((a->type == LSM_AUDIT_DATA_INODE ||
> +	     a->type == LSM_AUDIT_DATA_DENTRY) &&
>  	    (flags & MAY_NOT_BLOCK))

IDGI, to be honest.  Why do we bother with slow path if MAY_NOT_BLOCK has
been given?  If we'd run into "there's something to report" case, we
are not on the fastpath anymore.  IOW, why not have
        audited = avc_audit_required(requested, avd, result, 0, &denied);
        if (likely(!audited))
                return 0;
	if (flags & MAY_NOT_BLOCK)
		return -ECHILD;
        return slow_avc_audit(state, ssid, tsid, tclass,
                              requested, audited, denied, result,
                              a, flags);
in avc_audit() and be done with that?

It's not just whether we *can* collect whatever audit might want; do
we want to try and make an audit-spewing syscall marginally faster?
And "marginally" is all you'll get there, really...

We could do
        error = security_inode_follow_link(dentry, inode,
                                           nd->flags & LOOKUP_RCU);
        if (unlikely(error)) {
		if (error == -ECHILD && !unlazy_walk(nd))
			error = security_inode_follow_link(dentry, inode, 0);
		if (error)
			return ERR_PTR(error);
	}
in fs/namei.c:get_link() to slightly reduce the costs; that might or
might not be useful - I'd like to see profiling results first.  But
trying to push the actual "spew to audit" into RCU case?  What for?

