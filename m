Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD9758265
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 18:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjGRQrd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjGRQr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:47:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BC710D2;
        Tue, 18 Jul 2023 09:47:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02C3D21835;
        Tue, 18 Jul 2023 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689698847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0gG/SrZGF5/s3yIgwzjFlba62tVC4bEASQFHFHTinDw=;
        b=sCqIZIaeY+lZmLjsOPsAbQI7GvoRp+QnzyxAweo04VRhB02G7zlyPODdtnMibPbRArJBXD
        EmKHbQr2G1Hg/mlor+k1OhYUl6g3r4QossnKRSkX+YcTTQxPScxqx/r35yGnTw3fNEyVf5
        ghYS+pV/sSq88EFejZe58ccHS7UeR7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689698847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0gG/SrZGF5/s3yIgwzjFlba62tVC4bEASQFHFHTinDw=;
        b=5Agcg3CzsovgtmLs9P2htHWvOOKunhSV4WopA6/9BhjEF+Ts1aNnzWoRaa1U1bHqG+xwJc
        Fil0WRvm5Z4c3BAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0405134B0;
        Tue, 18 Jul 2023 16:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id llAuKR7CtmTiUwAAMHmgww
        (envelope-from <krisman@suse.de>); Tue, 18 Jul 2023 16:47:26 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     brauner@kernel.org, tytso@mit.edu,
        linux-f2fs-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2 3/7] libfs: Validate negative dentries in
 case-insensitive directories
References: <20230422000310.1802-1-krisman@suse.de>
        <20230422000310.1802-4-krisman@suse.de>
        <20230714050028.GC913@sol.localdomain>
Date:   Tue, 18 Jul 2023 12:47:25 -0400
In-Reply-To: <20230714050028.GC913@sol.localdomain> (Eric Biggers's message of
        "Thu, 13 Jul 2023 22:00:28 -0700")
Message-ID: <87pm4p5fqa.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> I notice that the existing vfat_revalidate_ci() in fs/fat/namei_vfat.c behaves
> differently in the 'flags == 0' case:
>
>
> 	/*
> 	 * This may be nfsd (or something), anyway, we can't see the
> 	 * intent of this. So, since this can be for creation, drop it.
> 	 */
> 	if (!flags)
> 		return 0;
>
> I don't know whether that's really needed, but have you thought about this?

Hi Eric,

I didn't look much into it before because, as you know, the vfat
case-insensitive implementation is completely different than the
ext4/f2fs code. But I think you are on to something.

The original intent of this check was to safeguard against the case
where d_revalidate would be called without nameidata from the filesystem
helpers. The filesystems don't give the purpose of the lookup
(nd->flags) so there is no way to tell if the dentry is being used for
creation, and therefore we can't rely on the negative dentry for ci. The
path is like this:

lookup_one_len(...)
  __lookup_hash(..., nd = NULL)
     cached_lookup(...)
       do_revalidate(parent, name, nd)
         dentry->d_op->d_revalidate(parent, nd);

Then !nd was dropped to pass flags directly around 2012, which
overloaded the flags meaning. Which means, d_revalidate can
still be called for creation without (LOOKUP_CREATE|...). For
instance, in nfsd_create.  I wasn't considering this.

This sucks, because we don't have enough information to avoid the name
check in this case, so we'd also need memcmp there.  Except it won't be
safe. because callers won't necessarily hold the parent lock in the path
below.

 lookup_one_unlocked()
   lookup_dcache()
      d_revalidate()  // called unlocked

Thus, I'll have to add a similar:

  if (!flags)
    return 0;

Ahead of the is_creation check.  It will solve it.

But i think the issue is in VFS.  the lookup_one_* functions should have
proper lookup flags, such that d_revalidate can tell the purpose of the
lookup.

-- 
Gabriel Krisman Bertazi
