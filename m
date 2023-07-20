Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5C75A601
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 08:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGTGHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 02:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjGTGHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:07:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DACF1726;
        Wed, 19 Jul 2023 23:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F7B261803;
        Thu, 20 Jul 2023 06:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A63CC433C8;
        Thu, 20 Jul 2023 06:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689833219;
        bh=ATRHNxsx0KOdc01QXU+SmoK3XGS6Va9sh8ZyyVbVPfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyPUMMUxvNkv3yZ/FSAU7kqaddkPFQJJu8GTD+JhuUwd9t7XriZJ54UoryX00sLaz
         9KREbqaLO0tWpbm3Y1/K4qJ00zOObyA0nufudEWRCzCaK02rgzeogQo5Bt2JuwzPOh
         DxiXfTovTbr+8rAjEJD+/7VV08HRHGZGM6P7VkE28IiQB4XkvFlXzOw2Ex48RqS2i5
         STzrAeWCEBcv9Z2/owqBuyGez4JOjdsi0WuW+g2u0yafgS/Ecf5yk/LhdPQAU/SXT/
         YCgMyCwAXUBrzgzdI8onrcDS7r3dG+X3X6PYC5AJmABkqlkDxHMoCw7F4sz83++Tjn
         mYKWcFj7MEa4w==
Date:   Wed, 19 Jul 2023 23:06:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v3 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230720060657.GB2607@sol.localdomain>
References: <20230719221918.8937-1-krisman@suse.de>
 <20230719221918.8937-4-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719221918.8937-4-krisman@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 06:19:14PM -0400, Gabriel Krisman Bertazi wrote:
> +static inline int generic_ci_d_revalidate(struct dentry *dentry,
> +					  const struct qstr *name,
> +					  unsigned int flags)

This shouldn't be 'inline', since it can't be inlined into anywhere anyway.

> +		if (dir && needs_casefold(dir)) {
> +			/*
> +			 * Filesystems will call into d_revalidate without
> +			 * setting LOOKUP_ flags even for file creation(see
> +			 * lookup_one* variants).  Reject negative dentries in
> +			 * this case, since we can't know for sure it won't be
> +			 * used for creation.
> +			 */
> +			if (!flags)
> +				return 0;
> +
> +			/*
> +			 * Negative dentries created prior to turning the
> +			 * directory case-insensitive cannot be trusted, since
> +			 * they don't ensure any possible case version of the
> +			 * filename doesn't exist.
> +			 */
> +			if (!d_is_casefold_lookup(dentry))
> +				return 0;
> +
> +			if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
> +				/*
> +				 * ->d_name won't change from under us in the
> +				 * creation path only, since d_revalidate during
> +				 * creation and renames is always called with
> +				 * the parent inode locked.  It isn't the case
> +				 * for all lookup callpaths, so ->d_name must
> +				 * not be touched outside
> +				 * (LOOKUP_CREATE|LOOKUP_RENAME_TARGET) context.
> +				 */
> +				if (dentry->d_name.len != name->len ||
> +				    memcmp(dentry->d_name.name, name->name, name->len))
> +					return 0;
> +			}
> +		}

This would be easier to follow if the '!flags' and 'flags & (LOOKUP_CREATE |
LOOKUP_RENAME_TARGET)' sections were adjacent to each other.  They group
together logically, since they both deal with the following problem: "when the
lookup might be for creation, invalidate the negative dentry if it might not be
a case-sensitive match".  (And it would help if there was a comment explaining
that problem.)  The d_is_casefold_lookup() check solves a different problem.

I'm also having trouble understanding exactly when ->d_name is stable here.
AFAICS, unfortunately the VFS has an edge case where a dentry can be moved
without its parent's ->i_rwsem being held.  It happens when a subdirectory is
"found" under multiple names.  The VFS doesn't support directory hard links, so
if it finds a second link to a directory, it just moves the whole dentry tree to
the new location.  This can happen if a filesystem image is corrupted and
contains directory hard links.  Coincidentally, it can also happen in an
encrypted directory due to the no-key name => normal name transition...

But, negative dentries are never moved, at all.  (__d_move() even WARNs if you
ask it to move a negative dentry.)  That feels like that would make everything
else irrelevant here, though your patchset doesn't mention this.  I suppose the
problem would be what if the dentry is made positive concurrently.

I'm struggling to find an ideal solution here.  Maybe ->d_lock should just be
taken for the name comparison.  That is legal here, and it reliably synchronizes
with the dentry being moved, without having to consider anything else.

So, the following is probably what I'd do.  I'd be interested to hear your
thoughts, though:

			/*
			 * A negative dentry that was created before the
			 * directory became case-insensitive can't be trusted,
			 * since it doesn't ensure any possible case version of
			 * the filename doesn't exist.
			 */
			if (!d_is_casefold_lookup(dentry))
				return 0;

			/*
			 * If the lookup is for creation, then a negative dentry
			 * can only be reused if it's a case-sensitive match,
			 * not just a case-insensitive one.  This is required to
			 * provide case-preserving semantics.
			 *
			 * In some cases (lookup_one_*()), the lookup intent is
			 * unknown, resulting in flags==0 here.  So we have to
			 * assume that flags==0 is potentially a creation.
			 */
			if (flags == 0 ||
			    (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))) {
				bool match;

				spin_lock(&dentry->d_lock);
				match = (dentry->d_name.len == name->len &&
					 memcmp(dentry->d_name.name, name->name,
						name->len) == 0);
				spin_unlock(&dentry->d_lock);
				if (!match)
					return 0;
			}
