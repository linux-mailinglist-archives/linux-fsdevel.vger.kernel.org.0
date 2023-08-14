Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0E077BFEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 20:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjHNSmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 14:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjHNSmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3CCE73;
        Mon, 14 Aug 2023 11:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E87F628ED;
        Mon, 14 Aug 2023 18:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DA8C433C8;
        Mon, 14 Aug 2023 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692038536;
        bh=cRZ0oe4bGlgMnSjDZmU1ziyvNS/S6FdTSbvDRpoiBVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=smEVnz1dXlTZYP+snx+W94hNAvr5efHMO9iywxqCxACPnx7o1llXZSAd1PADdsTks
         W0JGwBYKhcQg2g00Wdv2eXHtHnL3NjvOq/ONxPrFmYKbzbmWAHaiYVUA47EXfNLzmz
         NJhUirjgDx4/MePzu1VQXsr4oH7h6/Wdjj2xzmglehsEkI4mtgBMHndjQe6ss4gRAj
         smEQKPTlw/5bi5eTEJBlIWLwrL0hWUltprMGyc8QCUTkJG9jqoJUUjiEI6izNDHqDe
         y2kDbQJxk4e2BwFanRKIZOq3MBEPR0ZLaBMT4kYFCSdFaYtG//kXD/GQdhRaqQMlm1
         U1yogfMOOVlPA==
Date:   Mon, 14 Aug 2023 11:42:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v5 06/10] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230814184214.GB1171@sol.localdomain>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-7-krisman@suse.de>
 <20230812024145.GD971@sol.localdomain>
 <87a5ut7k62.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5ut7k62.fsf@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:50:13AM -0400, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Fri, Aug 11, 2023 at 08:41:42PM -0400, Gabriel Krisman Bertazi wrote:
> >> +	/*
> >> +	 * Filesystems will call into d_revalidate without setting
> >> +	 * LOOKUP_ flags even for file creation (see lookup_one*
> >> +	 * variants).  Reject negative dentries in this case, since we
> >> +	 * can't know for sure it won't be used for creation.
> >> +	 */
> >> +	if (!flags)
> >> +		return 0;
> >> +
> >> +	/*
> >> +	 * If the lookup is for creation, then a negative dentry can
> >> +	 * only be reused if it's a case-sensitive match, not just a
> >> +	 * case-insensitive one.  This is needed to make the new file be
> >> +	 * created with the name the user specified, preserving case.
> >> +	 */
> >> +	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
> >> +		/*
> >> +		 * ->d_name won't change from under us in the creation
> >> +		 * path only, since d_revalidate during creation and
> >> +		 * renames is always called with the parent inode
> >> +		 * locked.  It isn't the case for all lookup callpaths,
> >> +		 * so ->d_name must not be touched outside
> >> +		 * (LOOKUP_CREATE|LOOKUP_RENAME_TARGET) context.
> >> +		 */
> >> +		if (dentry->d_name.len != name->len ||
> >> +		    memcmp(dentry->d_name.name, name->name, name->len))
> >> +			return 0;
> >> +	}
> >
> > This is still really confusing to me.  Can you consider the below?  The code is
> > the same except for the reordering, but the explanation is reworked to be much
> > clearer (IMO).  Anything I am misunderstanding?
> >
> > 	/*
> > 	 * If the lookup is for creation, then a negative dentry can only be
> > 	 * reused if it's a case-sensitive match, not just a case-insensitive
> > 	 * one.  This is needed to make the new file be created with the name
> > 	 * the user specified, preserving case.
> > 	 *
> > 	 * LOOKUP_CREATE or LOOKUP_RENAME_TARGET cover most creations.  In these
> > 	 * cases, ->d_name is stable and can be compared to 'name' without
> > 	 * taking ->d_lock because the caller holds dir->i_rwsem for write.
> > 	 * (This is because the directory lock blocks the dentry from being
> > 	 * concurrently instantiated, and negative dentries are never moved.)
> > 	 *
> > 	 * All other creations actually use flags==0.  These come from the edge
> > 	 * case of filesystems calling functions like lookup_one() that do a
> > 	 * lookup without setting the lookup flags at all.  Such lookups might
> > 	 * or might not be for creation, and if not don't guarantee stable
> > 	 * ->d_name.  Therefore, invalidate all negative dentries when flags==0.
> > 	 */
> > 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
> > 		if (dentry->d_name.len != name->len ||
> > 		    memcmp(dentry->d_name.name, name->name, name->len))
> > 			return 0;
> > 	}
> > 	if (!flags)
> > 		return 0;
> 
> I don't see it as particularly better or less confusing than the
> original. but I also don't mind taking it into the next iteration.
> 

Your commit message is still much longer and covers some quite different details
which seem irrelevant to me.  So if you don't see my explanation as being much
different, I think we're still not on the same page.  I hope that I'm not
misunderstanding anything, in which I believe that what I wrote above is a good
explanation and your commit message should be substantially simplified.
Remember, longer != better.  Keep things as simple as possible.

- Eric
