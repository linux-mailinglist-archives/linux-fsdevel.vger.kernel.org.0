Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2EBF12FDE8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 21:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgACU0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 15:26:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47201 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726050AbgACU0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 15:26:46 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 003KQ8JY013722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Jan 2020 15:26:09 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 522F24200AF; Fri,  3 Jan 2020 15:26:08 -0500 (EST)
Date:   Fri, 3 Jan 2020 15:26:08 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     linux-ext4@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH 4/8] vfs: Fold casefolding into vfs
Message-ID: <20200103202608.GB4253@mit.edu>
References: <20191203051049.44573-1-drosen@google.com>
 <20191203051049.44573-5-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203051049.44573-5-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 02, 2019 at 09:10:45PM -0800, Daniel Rosenberg wrote:
> @@ -228,6 +229,13 @@ static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char
>  
>  #endif
>  
> +bool needs_casefold(const struct inode *dir)
> +{
> +	return IS_CASEFOLDED(dir) &&
> +			(!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir));
> +}
> +EXPORT_SYMBOL(needs_casefold);
> +

I'd suggest adding a check to make sure that dir->i_sb->s_encoding is
non-NULL before needs_casefold() returns non-NULL.  Otherwise a bug
(or a fuzzed file system) which manages to set the S_CASEFOLD flag without having s_encoding be initialized might cause a NULL dereference.

Also, maybe make needs_casefold() an inline function which returns 0
if CONFIG_UNICODE is not defined?  That way the need for #ifdef
CONFIG_UNICODE could be reduced.

> @@ -247,7 +255,19 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
>  	 * be no NUL in the ct/tcount data)
>  	 */
>  	const unsigned char *cs = READ_ONCE(dentry->d_name.name);
> +#ifdef CONFIG_UNICODE
> +	struct inode *parent = dentry->d_parent->d_inode;
>  
> +	if (unlikely(needs_casefold(parent))) {
> +		const struct qstr n1 = QSTR_INIT(cs, tcount);
> +		const struct qstr n2 = QSTR_INIT(ct, tcount);
> +		int result = utf8_strncasecmp(dentry->d_sb->s_encoding,
> +						&n1, &n2);
> +
> +		if (result >= 0 || sb_has_enc_strict_mode(dentry->d_sb))
> +			return result;
> +	}
> +#endif

This is an example of how we could drop the #ifdef CONFIG_UNICODE
(moving the declaration of 'parent' into the #if statement) if
needs_casefold() always returns 0 if !defined(CONFIG_UNICODE).

> @@ -2404,7 +2424,22 @@ struct dentry *d_hash_and_lookup(struct dentry *dir, struct qstr *name)
>  	 * calculate the standard hash first, as the d_op->d_hash()
>  	 * routine may choose to leave the hash value unchanged.
>  	 */
> +#ifdef CONFIG_UNICODE
> +	unsigned char *hname = NULL;
> +	int hlen = name->len;
> +
> +	if (IS_CASEFOLDED(dir->d_inode)) {
> +		hname = kmalloc(PATH_MAX, GFP_ATOMIC);
> +		if (!hname)
> +			return ERR_PTR(-ENOMEM);
> +		hlen = utf8_casefold(dir->d_sb->s_encoding,
> +					name, hname, PATH_MAX);
> +	}
> +	name->hash = full_name_hash(dir, hname ?: name->name, hlen);
> +	kfree(hname);
> +#else
>  	name->hash = full_name_hash(dir, name->name, name->len);
> +#endif

Perhaps this could be refactored out?  It's also used in
link_path_walk() and lookup_one_len_common().

(Note, there was some strageness in lookup_one_len_common(), where
hname is freed twice, the first time using kvfree() which I don't
believe is needed.  But this can be fixed as part of the refactoring.)

	   	    	     	    	  - Ted
