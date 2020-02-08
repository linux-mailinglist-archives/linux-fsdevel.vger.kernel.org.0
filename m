Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E60661562AC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 03:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBHCM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 21:12:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52510 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgBHCM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 21:12:26 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j0FbU-0098pV-DJ; Sat, 08 Feb 2020 02:12:16 +0000
Date:   Sat, 8 Feb 2020 02:12:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 2/8] fs: Add standard casefolding support
Message-ID: <20200208021216.GE23230@ZenIV.linux.org.uk>
References: <20200208013552.241832-1-drosen@google.com>
 <20200208013552.241832-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208013552.241832-3-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:35:46PM -0800, Daniel Rosenberg wrote:

> +int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
> +			  const char *str, const struct qstr *name)
> +{
> +	const struct dentry *parent = READ_ONCE(dentry->d_parent);
> +	const struct inode *inode = READ_ONCE(parent->d_inode);
> +	const struct super_block *sb = dentry->d_sb;
> +	const struct unicode_map *um = sb->s_encoding;
> +	struct qstr entry = QSTR_INIT(str, len);
> +	int ret;
> +
> +	if (!inode || !needs_casefold(inode))
> +		goto fallback;
> +
> +	ret = utf8_strncasecmp(um, name, &entry);

Again, is that safe in case when the contents of the string str points to
keeps changing under you?
