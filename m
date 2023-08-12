Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757FB779CA9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 04:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjHLClt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 22:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjHLClt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:41:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E79C268C;
        Fri, 11 Aug 2023 19:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ADD06422F;
        Sat, 12 Aug 2023 02:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C349C433C8;
        Sat, 12 Aug 2023 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691808107;
        bh=Qf0UrKAKMrDNExp3AQ1BgZvKh1gbqbBiuVEpYRftFYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6JQnBlN6gPmRaJcxSle3PgLqulDOpl6MrlQtLwU2djzM9v6MFqzrfW6iIL/vNYkq
         gyUqetOQzUya+qHJC1Iib0L83q+CcCH1k5F0DSldK6nDNEtrIm27bd0u+0BmbqdIGO
         kqvHWyLhLuGQhhLVgSA4mHpu4ROacoNAnqfDXILsLNG1hjjPOpvUSvIDMNpGRTFuD7
         yDNPaTg+KF2/Mp7m0iQuw7WQo00MtYitS4Dya2TPmbQz9WA/y2cVFyaMaJKoaWLdU5
         mf8dAbv724oV7pG6f+83UyqYnnPVW5Y+lNKTuUqt7yJwDVqxZMZ94P9itFMgTBbM3h
         Ru3S/R+5TgO/A==
Date:   Fri, 11 Aug 2023 19:41:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v5 06/10] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230812024145.GD971@sol.localdomain>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-7-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812004146.30980-7-krisman@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 08:41:42PM -0400, Gabriel Krisman Bertazi wrote:
> +	/*
> +	 * Filesystems will call into d_revalidate without setting
> +	 * LOOKUP_ flags even for file creation (see lookup_one*
> +	 * variants).  Reject negative dentries in this case, since we
> +	 * can't know for sure it won't be used for creation.
> +	 */
> +	if (!flags)
> +		return 0;
> +
> +	/*
> +	 * If the lookup is for creation, then a negative dentry can
> +	 * only be reused if it's a case-sensitive match, not just a
> +	 * case-insensitive one.  This is needed to make the new file be
> +	 * created with the name the user specified, preserving case.
> +	 */
> +	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
> +		/*
> +		 * ->d_name won't change from under us in the creation
> +		 * path only, since d_revalidate during creation and
> +		 * renames is always called with the parent inode
> +		 * locked.  It isn't the case for all lookup callpaths,
> +		 * so ->d_name must not be touched outside
> +		 * (LOOKUP_CREATE|LOOKUP_RENAME_TARGET) context.
> +		 */
> +		if (dentry->d_name.len != name->len ||
> +		    memcmp(dentry->d_name.name, name->name, name->len))
> +			return 0;
> +	}

This is still really confusing to me.  Can you consider the below?  The code is
the same except for the reordering, but the explanation is reworked to be much
clearer (IMO).  Anything I am misunderstanding?

	/*
	 * If the lookup is for creation, then a negative dentry can only be
	 * reused if it's a case-sensitive match, not just a case-insensitive
	 * one.  This is needed to make the new file be created with the name
	 * the user specified, preserving case.
	 *
	 * LOOKUP_CREATE or LOOKUP_RENAME_TARGET cover most creations.  In these
	 * cases, ->d_name is stable and can be compared to 'name' without
	 * taking ->d_lock because the caller holds dir->i_rwsem for write.
	 * (This is because the directory lock blocks the dentry from being
	 * concurrently instantiated, and negative dentries are never moved.)
	 *
	 * All other creations actually use flags==0.  These come from the edge
	 * case of filesystems calling functions like lookup_one() that do a
	 * lookup without setting the lookup flags at all.  Such lookups might
	 * or might not be for creation, and if not don't guarantee stable
	 * ->d_name.  Therefore, invalidate all negative dentries when flags==0.
	 */
	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
		if (dentry->d_name.len != name->len ||
		    memcmp(dentry->d_name.name, name->name, name->len))
			return 0;
	}
	if (!flags)
		return 0;
