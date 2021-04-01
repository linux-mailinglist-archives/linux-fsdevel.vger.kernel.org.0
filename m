Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271A9350C74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 04:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhDACPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 22:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhDACPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:15:21 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD14C061574;
        Wed, 31 Mar 2021 19:15:19 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRmr7-001X2U-Bm; Thu, 01 Apr 2021 02:14:45 +0000
Date:   Thu, 1 Apr 2021 02:14:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v31 07/12] landlock: Support filesystem access-control
Message-ID: <YGUslUPwp85Zrp4t@zeniv-ca.linux.org.uk>
References: <20210324191520.125779-1-mic@digikod.net>
 <20210324191520.125779-8-mic@digikod.net>
 <d2764451-8970-6cbd-e2bf-254a42244ffc@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2764451-8970-6cbd-e2bf-254a42244ffc@digikod.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:33:50PM +0200, Mickaël Salaün wrote:

> > +static inline u64 unmask_layers(
> > +		const struct landlock_ruleset *const domain,
> > +		const struct path *const path, const u32 access_request,
> > +		u64 layer_mask)
> > +{
> > +	const struct landlock_rule *rule;
> > +	const struct inode *inode;
> > +	size_t i;
> > +
> > +	if (d_is_negative(path->dentry))
> > +		/* Continues to walk while there is no mapped inode. */
				     ^^^^^
Odd comment, that...

> > +static int check_access_path(const struct landlock_ruleset *const domain,
> > +		const struct path *const path, u32 access_request)
> > +{

> > +	walker_path = *path;
> > +	path_get(&walker_path);

> > +	while (true) {
> > +		struct dentry *parent_dentry;
> > +
> > +		layer_mask = unmask_layers(domain, &walker_path,
> > +				access_request, layer_mask);
> > +		if (layer_mask == 0) {
> > +			/* Stops when a rule from each layer grants access. */
> > +			allowed = true;
> > +			break;
> > +		}
> > +
> > +jump_up:
> > +		if (walker_path.dentry == walker_path.mnt->mnt_root) {
> > +			if (follow_up(&walker_path)) {
> > +				/* Ignores hidden mount points. */
> > +				goto jump_up;
> > +			} else {
> > +				/*
> > +				 * Stops at the real root.  Denies access
> > +				 * because not all layers have granted access.
> > +				 */
> > +				allowed = false;
> > +				break;
> > +			}
> > +		}
> > +		if (unlikely(IS_ROOT(walker_path.dentry))) {
> > +			/*
> > +			 * Stops at disconnected root directories.  Only allows
> > +			 * access to internal filesystems (e.g. nsfs, which is
> > +			 * reachable through /proc/<pid>/ns/<namespace>).
> > +			 */
> > +			allowed = !!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
> > +			break;
> > +		}
> > +		parent_dentry = dget_parent(walker_path.dentry);
> > +		dput(walker_path.dentry);
> > +		walker_path.dentry = parent_dentry;
> > +	}
> > +	path_put(&walker_path);
> > +	return allowed ? 0 : -EACCES;

That's a whole lot of grabbing/dropping references...  I realize that it's
an utterly tactless question, but... how costly it is?  IOW, do you have
profiling data?

> > +/*
> > + * pivot_root(2), like mount(2), changes the current mount namespace.  It must
> > + * then be forbidden for a landlocked process.

... and cross-directory rename(2) can change the tree topology.  Do you ban that
as well?

[snip]

> > +static int hook_path_rename(const struct path *const old_dir,
> > +		struct dentry *const old_dentry,
> > +		const struct path *const new_dir,
> > +		struct dentry *const new_dentry)
> > +{
> > +	const struct landlock_ruleset *const dom =
> > +		landlock_get_current_domain();
> > +
> > +	if (!dom)
> > +		return 0;
> > +	/* The mount points are the same for old and new paths, cf. EXDEV. */
> > +	if (old_dir->dentry != new_dir->dentry)
> > +		/* For now, forbids reparenting. */
> > +		return -EACCES;

You do, apparently, and not in a way that would have the userland fall
back to copy+unlink.  Lovely...  Does e.g. git survive such restriction?
Same question for your average package build...
