Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB614217F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 02:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgATBff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 20:35:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41284 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgATBff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 20:35:35 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itLyS-00Bl2j-If; Mon, 20 Jan 2020 01:35:28 +0000
Date:   Mon, 20 Jan 2020 01:35:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v3 5/9] vfs: Fold casefolding into vfs
Message-ID: <20200120013528.GY8904@ZenIV.linux.org.uk>
References: <20200117214246.235591-1-drosen@google.com>
 <20200117214246.235591-6-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117214246.235591-6-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 01:42:42PM -0800, Daniel Rosenberg wrote:
> Ext4 and F2fs are both using casefolding, and they, along with any other
> filesystem that adds the feature, will be using identical dentry_ops.
> Additionally, those dentry ops interfere with the dentry_ops required
> for fscrypt once we add support for casefolding and encryption.
> Moving this into the vfs removes code duplication as well as the
> complication with encryption.
> 
> Currently this is pretty close to just moving the existing f2fs/ext4
> code up a level into the vfs,

... buggering the filesystems (and boxen) that never planned to use
that garbage.

> @@ -247,7 +248,19 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
>  	 * be no NUL in the ct/tcount data)
>  	 */
>  	const unsigned char *cs = READ_ONCE(dentry->d_name.name);
> +#ifdef CONFIG_UNICODE
> +	struct inode *parent = dentry->d_parent->d_inode;

What happens if dentry gets moved under you?  And that's not mentioning the joy
of extra cachelines to shit the cache with.  For every sodding dentry in the
hashchain you are walking.

> +	if (unlikely(needs_casefold(parent))) {
> +		const struct qstr n1 = QSTR_INIT(cs, tcount);
> +		const struct qstr n2 = QSTR_INIT(ct, tcount);
> +		int result = utf8_strncasecmp(dentry->d_sb->s_encoding,
> +						&n1, &n2);

Is that safe in face of renames?  We are *NOT* guaranteed ->d_lock here;
->d_name can change under you just fine.  False negatives are OK, but
there's a lot more ways for the things to go wrong.

>  static int link_path_walk(const char *name, struct nameidata *nd)
>  {

> +#ifdef CONFIG_UNICODE
> +		if (needs_casefold(nd->path.dentry->d_inode)) {
> +			struct qstr str = QSTR_INIT(name, PATH_MAX);
> +
> +			hname = kmalloc(PATH_MAX, GFP_ATOMIC);
> +			if (!hname)
> +				return -ENOMEM;
> +			hlen = utf8_casefold(nd->path.dentry->d_sb->s_encoding,
> +						&str, hname, PATH_MAX);
> +		}
> +		hash_len = hash_name(nd->path.dentry, hname ?: name);
> +		kfree(hname);
> +		hname = NULL;
> +#else
>  		hash_len = hash_name(nd->path.dentry, name);
> -
> +#endif

Are you serious?
	1) who said that ->d_inode is stable here?  If we are in RCU mode,
it won't be.
	2) page-sized kmalloc/kfree *ON* *COMPONENT* *AFTER* *COMPONENT*?

> +static inline bool needs_casefold(const struct inode *dir)
> +{
> +	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
> +			(!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir));

... and again, you are pulling in a lot of cachelines.

<understatement> IMO the whole thing is not a good idea. </understatement>
