Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6876377C0C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjHNT07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 15:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjHNT05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20769C;
        Mon, 14 Aug 2023 12:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70EFC64CD2;
        Mon, 14 Aug 2023 19:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FC3C433C7;
        Mon, 14 Aug 2023 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692041215;
        bh=fjg4DjZzMYIVF7iw7C5dHBm34b2v2P4Jmnd1pWojAaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxFaMJ9s/uADemNqFKoXvhhIhBt8PlFreQ3fm8aaV+KmgTwvSwcZ5qsDiQouPBGCq
         sPuJQs5g5hBM617V6qDCWSn5v/GFI7RNDbWZyGH/Zxl8tngrJrTJZw5gyJQ+oBX9/H
         5XpdcW26nThq4heeV5ygOCcIvQjnhEGLQMB2MYf1xv6PKMXCTwiybjSn9yNZiWxkI0
         P7qmEYql2qoQUJM0DxIeHubgVBVTevljUbcU9CV7hXkaeRL9CLGwhGdRkdLy3BZZ5Z
         R3EgLxCYjafUnO17Hhdzj+c0YF4gIJ2rc30qU/3UVKQpaYyPOl8IJ6XPKACtnp5sBy
         N2+KxU3PROCTw==
Date:   Mon, 14 Aug 2023 12:26:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v5 06/10] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230814192654.GE1171@sol.localdomain>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-7-krisman@suse.de>
 <20230812024145.GD971@sol.localdomain>
 <87a5ut7k62.fsf@suse.de>
 <20230814184214.GB1171@sol.localdomain>
 <87fs4l5t1e.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs4l5t1e.fsf@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 03:21:33PM -0400, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Mon, Aug 14, 2023 at 10:50:13AM -0400, Gabriel Krisman Bertazi wrote:
> >> Eric Biggers <ebiggers@kernel.org> writes:
> >> 
> >> > On Fri, Aug 11, 2023 at 08:41:42PM -0400, Gabriel Krisman Bertazi wrote:
> >> >> +	/*
> >> >> +	 * Filesystems will call into d_revalidate without setting
> >> >> +	 * LOOKUP_ flags even for file creation (see lookup_one*
> >> >> +	 * variants).  Reject negative dentries in this case, since we
> >> >> +	 * can't know for sure it won't be used for creation.
> >> >> +	 */
> >> >> +	if (!flags)
> >> >> +		return 0;
> >> >> +
> >> >> +	/*
> >> >> +	 * If the lookup is for creation, then a negative dentry can
> >> >> +	 * only be reused if it's a case-sensitive match, not just a
> >> >> +	 * case-insensitive one.  This is needed to make the new file be
> >> >> +	 * created with the name the user specified, preserving case.
> >> >> +	 */
> >> >> +	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
> >> >> +		/*
> >> >> +		 * ->d_name won't change from under us in the creation
> >> >> +		 * path only, since d_revalidate during creation and
> >> >> +		 * renames is always called with the parent inode
> >> >> +		 * locked.  It isn't the case for all lookup callpaths,
> >> >> +		 * so ->d_name must not be touched outside
> >> >> +		 * (LOOKUP_CREATE|LOOKUP_RENAME_TARGET) context.
> >> >> +		 */
> >> >> +		if (dentry->d_name.len != name->len ||
> >> >> +		    memcmp(dentry->d_name.name, name->name, name->len))
> >> >> +			return 0;
> >> >> +	}
> >> >
> >> > This is still really confusing to me.  Can you consider the below?  The code is
> >> > the same except for the reordering, but the explanation is reworked to be much
> >> > clearer (IMO).  Anything I am misunderstanding?
> >> >
> >> > 	/*
> >> > 	 * If the lookup is for creation, then a negative dentry can only be
> >> > 	 * reused if it's a case-sensitive match, not just a case-insensitive
> >> > 	 * one.  This is needed to make the new file be created with the name
> >> > 	 * the user specified, preserving case.
> >> > 	 *
> >> > 	 * LOOKUP_CREATE or LOOKUP_RENAME_TARGET cover most creations.  In these
> >> > 	 * cases, ->d_name is stable and can be compared to 'name' without
> >> > 	 * taking ->d_lock because the caller holds dir->i_rwsem for write.
> >> > 	 * (This is because the directory lock blocks the dentry from being
> >> > 	 * concurrently instantiated, and negative dentries are never moved.)
> >> > 	 *
> >> > 	 * All other creations actually use flags==0.  These come from the edge
> >> > 	 * case of filesystems calling functions like lookup_one() that do a
> >> > 	 * lookup without setting the lookup flags at all.  Such lookups might
> >> > 	 * or might not be for creation, and if not don't guarantee stable
> >> > 	 * ->d_name.  Therefore, invalidate all negative dentries when flags==0.
> >> > 	 */
> >> > 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
> >> > 		if (dentry->d_name.len != name->len ||
> >> > 		    memcmp(dentry->d_name.name, name->name, name->len))
> >> > 			return 0;
> >> > 	}
> >> > 	if (!flags)
> >> > 		return 0;
> >> 
> >> I don't see it as particularly better or less confusing than the
> >> original. but I also don't mind taking it into the next iteration.
> >> 
> >
> > Your commit message is still much longer and covers some quite different details
> > which seem irrelevant to me.  So if you don't see my explanation as being much
> > different, I think we're still not on the same page.  I hope that I'm not
> > misunderstanding anything, in which I believe that what I wrote above is a good
> > explanation and your commit message should be substantially simplified.
> > Remember, longer != better.  Keep things as simple as possible.
> 
> I think we are on the same page regarding the code.  I was under the
> impression your suggestion was regarding the *code comment* you proposed
> to replace, and not the commit message.  I don't see your code comment
> to be much different than the original.
> 
> The commit message has information accumulated on previous discussions,
> including the conclusions from the locking discussion Viro requested.
> I'll reword it too for the next iteration to see if I can make it more
> concise.
> 

Yes, I was talking about the code comment, but the commit message is explaining
the same thing so it needs to be consistent (or have the commit message just
reference the code).  As-is they seem to be in contradiction.

- Eric
