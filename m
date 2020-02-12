Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D74015A10B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 07:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgBLGGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 01:06:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLGGp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:06:45 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20AE2206ED;
        Wed, 12 Feb 2020 06:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581487604;
        bh=l14Pn3KEL9YjzF1tPgOKaV7EFnEulcGerPufvbmsbT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5hgBd1bdd/1YHYNsBxsxgHhUKtp/yLRqow31sWL4QpSNfOvdiTIIPgVDMyiAGJqg
         XUT1ZKQCNzV6zDB/nYfmYOsQBd6GPJPIW692CSRtURC/qPWn7rFN0+Tggepd4CFCDC
         toZnWhAiEsjvVOMYcB1lfDxfzgO1q24ahIVd4gpI=
Date:   Tue, 11 Feb 2020 22:06:42 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 6/8] f2fs: Handle casefolding with Encryption
Message-ID: <20200212060642.GJ870@sol.localdomain>
References: <20200208013552.241832-1-drosen@google.com>
 <20200208013552.241832-7-drosen@google.com>
 <20200212051013.GG870@sol.localdomain>
 <20200212055511.GL23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212055511.GL23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:55:11AM +0000, Al Viro wrote:
> On Tue, Feb 11, 2020 at 09:10:13PM -0800, Eric Biggers wrote:
> 
> > How about:
> > 
> > int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
> > 		    u8 *de_name, size_t de_name_len, bool quick)
> > {
> > 	const struct super_block *sb = parent->i_sb;
> > 	const struct unicode_map *um = sb->s_encoding;
> > 	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
> > 	struct qstr entry = QSTR_INIT(de_name, de_name_len);
> > 	int ret;
> > 
> > 	if (IS_ENCRYPTED(parent)) {
> 
> oops.  parent->d_inode is unstable here; could have become NULL by that
> point.
> 
> > 	if (quick)
> > 		ret = utf8_strncasecmp_folded(um, name, &entry);
> > 	else
> > 		ret = utf8_strncasecmp(um, name, &entry);
> > 	if (ret < 0) {
> > 		/* Handle invalid character sequence as either an error
> > 		 * or as an opaque byte sequence.
> > 		 */
> 
> Really?  How would the callers possibly tell mismatch from an
> error?  And if they could, would would they *do* with that
> error, seeing that it might be an effect of a race with
> rename()?
> 
> Again, ->d_compare() is NOT given a stable name.  Or *parent.  Or
> (parent->d_inode).

After the patch earlier in the series that created generic_ci_d_compare() and
switched f2fs to use it, f2fs_ci_compare() is only called when the filesystem is
actually searching a directory, not from ->d_compare().  So the names and
parent->d_inode are stable in it.

But, that also means the GFP_ATOMIC isn't needed, and f2fs_ci_compare() should
be made 'static'.

- Eric
