Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1458415A0E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 06:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgBLFzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 00:55:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59876 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgBLFzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:55:18 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1kzP-00BGKg-Vq; Wed, 12 Feb 2020 05:55:12 +0000
Date:   Wed, 12 Feb 2020 05:55:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
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
Message-ID: <20200212055511.GL23230@ZenIV.linux.org.uk>
References: <20200208013552.241832-1-drosen@google.com>
 <20200208013552.241832-7-drosen@google.com>
 <20200212051013.GG870@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212051013.GG870@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:10:13PM -0800, Eric Biggers wrote:

> How about:
> 
> int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
> 		    u8 *de_name, size_t de_name_len, bool quick)
> {
> 	const struct super_block *sb = parent->i_sb;
> 	const struct unicode_map *um = sb->s_encoding;
> 	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
> 	struct qstr entry = QSTR_INIT(de_name, de_name_len);
> 	int ret;
> 
> 	if (IS_ENCRYPTED(parent)) {

oops.  parent->d_inode is unstable here; could have become NULL by that
point.

> 	if (quick)
> 		ret = utf8_strncasecmp_folded(um, name, &entry);
> 	else
> 		ret = utf8_strncasecmp(um, name, &entry);
> 	if (ret < 0) {
> 		/* Handle invalid character sequence as either an error
> 		 * or as an opaque byte sequence.
> 		 */

Really?  How would the callers possibly tell mismatch from an
error?  And if they could, would would they *do* with that
error, seeing that it might be an effect of a race with
rename()?

Again, ->d_compare() is NOT given a stable name.  Or *parent.  Or
(parent->d_inode).
