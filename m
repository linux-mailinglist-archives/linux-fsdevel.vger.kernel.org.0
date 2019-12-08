Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955BD1160B8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 06:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfLHFeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 00:34:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58056 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLHFeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 00:34:19 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idpCY-0002jN-19; Sun, 08 Dec 2019 05:33:54 +0000
Date:   Sun, 8 Dec 2019 05:33:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v18] fs: Add VirtualBox guest shared folder (vboxsf)
 support
Message-ID: <20191208053350.GS4203@ZenIV.linux.org.uk>
References: <20191125140839.4956-1-hdegoede@redhat.com>
 <20191125140839.4956-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125140839.4956-2-hdegoede@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 25, 2019 at 03:08:39PM +0100, Hans de Goede wrote:

> +	list_for_each_entry(b, &sf_d->info_list, head) {
> +try_next_entry:
> +		if (ctx->pos >= cur + b->entries) {
> +			cur += b->entries;
> +			continue;
> +		}
> +
> +		/*
> +		 * Note the vboxsf_dir_info objects we are iterating over here
> +		 * are variable sized, so the info pointer may end up being
> +		 * unaligned. This is how we get the data from the host.
> +		 * Since vboxsf is only supported on x86 machines this is not
> +		 * a problem.
> +		 */
> +		for (i = 0, info = b->buf; i < ctx->pos - cur; i++) {
> +			size = offsetof(struct shfl_dirinfo, name.string) +
> +			       info->name.size;
> +			info = (struct shfl_dirinfo *)((uintptr_t)info + size);

Yecchhh...
	1) end = &info->name.string[info->name.size];
	   info = (struct shfl_dirinfo *)end;
please.  Compiler can and will optimize it just fine.
	2) what guarantees the lack of overruns here?

> +{
> +	bool keep_iterating;
> +
> +	for (keep_iterating = true; keep_iterating; ctx->pos += 1)
> +		keep_iterating = vboxsf_dir_emit(dir, ctx);

Are you sure you want to bump ctx->pos when vboxsf_dir_emit() returns false?

> +static int vboxsf_dir_create(struct inode *parent, struct dentry *dentry,
> +			     umode_t mode, int is_dir)
> +{
> +	struct vboxsf_inode *sf_parent_i = VBOXSF_I(parent);
> +	struct vboxsf_sbi *sbi = VBOXSF_SBI(parent->i_sb);
> +	struct shfl_createparms params = {};
> +	int err;
> +
> +	params.handle = SHFL_HANDLE_NIL;
> +	params.create_flags = SHFL_CF_ACT_CREATE_IF_NEW |
> +			      SHFL_CF_ACT_FAIL_IF_EXISTS |
> +			      SHFL_CF_ACCESS_READWRITE |
> +			      (is_dir ? SHFL_CF_DIRECTORY : 0);
> +	params.info.attr.mode = (mode & 0777) |
> +				(is_dir ? SHFL_TYPE_DIRECTORY : SHFL_TYPE_FILE);
> +	params.info.attr.additional = SHFLFSOBJATTRADD_NOTHING;
> +
> +	err = vboxsf_create_at_dentry(dentry, &params);

That's... interesting.  What should happen if you race with rename of
grandparent?  Note that *parent* is locked here; no deeper ancestors
are.

The same goes for removals.

> +static const char *vboxsf_get_link(struct dentry *dentry, struct inode *inode,
> +				   struct delayed_call *done)
> +{
> +	struct vboxsf_sbi *sbi = VBOXSF_SBI(inode->i_sb);
> +	struct shfl_string *path;
> +	char *link;
> +	int err;
> +
> +	if (!dentry)
> +		return ERR_PTR(-ECHILD);
> +
> +	path = vboxsf_path_from_dentry(sbi, dentry);
> +	if (IS_ERR(path))
> +		return (char *)path;

ERR_CAST(path)

> +	/** No additional information is available / requested. */
> +	SHFLFSOBJATTRADD_NOTHING = 1,

<unprintable>
Well, unpronounceable, actually...

> +	switch (opt) {
> +	case opt_nls:
> +		if (fc->purpose != FS_CONTEXT_FOR_MOUNT) {
> +			vbg_err("vboxsf: Cannot reconfigure nls option\n");
> +			return -EINVAL;
> +		}
> +		ctx->nls_name = param->string;
> +		param->string = NULL;

Umm...  What happens if you are given several such?  A leak?

> +{
> +	int err;
> +
> +	err = vboxsf_setup();
> +	if (err)
> +		return err;
> +
> +	return vfs_get_super(fc, vfs_get_independent_super, vboxsf_fill_super);

	return get_tree_nodev(fc, vboxsf_fill_super);
please,

> +static int vboxsf_reconfigure(struct fs_context *fc)
> +{
> +	struct vboxsf_sbi *sbi = VBOXSF_SBI(fc->root->d_sb);
> +	struct vboxsf_fs_context *ctx = fc->fs_private;
> +	struct inode *iroot;
> +
> +	iroot = ilookup(fc->root->d_sb, 0);
> +	if (!iroot)
> +		return -ENOENT;

Huh?  If that's supposed to be root directory inode, what's wrong
with ->d_sb->s_root->d_inode?

> +	path = dentry_path_raw(dentry, buf, PATH_MAX);
> +	if (IS_ERR(path)) {
> +		__putname(buf);
> +		return (struct shfl_string *)path;

ERR_CAST(path)...
