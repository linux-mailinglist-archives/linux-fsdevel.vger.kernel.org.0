Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB50877C118
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 21:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjHNTxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 15:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjHNTw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:52:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C8FA;
        Mon, 14 Aug 2023 12:52:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5E1A21863;
        Mon, 14 Aug 2023 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692042776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fnp8DJ6XQ4hPYRcJy/nsfcfTRDpO230iMwFulsuB2qI=;
        b=wByIaV0BL2fwDFE3J5nsBdtkQzW7TreNuCuEN9lhHwgEgoYnFC1XQ93HdN5G8rOWbFZMhT
        tYxwmAMaIzfjoeFuqurMetjJH488jmFcc+609XpKGN0/2SoF7f4o87MxQ9u9dgYsojQf8R
        gfiL8hOR5f58OntElmGyYzTSop523WI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692042776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fnp8DJ6XQ4hPYRcJy/nsfcfTRDpO230iMwFulsuB2qI=;
        b=cBEhiBwHrNtCo9a8pCW2gguVJaQI0PcZNTAmf9QC7ki0cTi3TSsJQD9u5PuWwtOIa1RfJm
        wFZ7kc4vL+LxF4CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 766A6138E2;
        Mon, 14 Aug 2023 19:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LGLCFBiG2mSGCAAAMHmgww
        (envelope-from <krisman@suse.de>); Mon, 14 Aug 2023 19:52:56 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/3] ext4: reject casefold inode flag without casefold
 feature
In-Reply-To: <20230814192406.GD1171@sol.localdomain> (Eric Biggers's message
        of "Mon, 14 Aug 2023 12:24:06 -0700")
Organization: SUSE
References: <20230814182903.37267-1-ebiggers@kernel.org>
        <20230814182903.37267-2-ebiggers@kernel.org> <87jztx5tle.fsf@suse.de>
        <20230814192406.GD1171@sol.localdomain>
Date:   Mon, 14 Aug 2023 15:52:54 -0400
Message-ID: <877cpx5rl5.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Mon, Aug 14, 2023 at 03:09:33PM -0400, Gabriel Krisman Bertazi wrote:
>> Eric Biggers <ebiggers@kernel.org> writes:
>> 
>> > From: Eric Biggers <ebiggers@google.com>
>> >
>> > It is invalid for the casefold inode flag to be set without the casefold
>> > superblock feature flag also being set.  e2fsck already considers this
>> > case to be invalid and handles it by offering to clear the casefold flag
>> > on the inode.  __ext4_iget() also already considered this to be invalid,
>> > sort of, but it only got so far as logging an error message; it didn't
>> > actually reject the inode.  Make it reject the inode so that other code
>> > doesn't have to handle this case.  This matches what f2fs does.
>> >
>> > Note: we could check 's_encoding != NULL' instead of
>> > ext4_has_feature_casefold().  This would make the check robust against
>> > the casefold feature being enabled by userspace writing to the page
>> > cache of the mounted block device.  However, it's unsolvable in general
>> > for filesystems to be robust against concurrent writes to the page cache
>> > of the mounted block device.  Though this very particular scenario
>> > involving the casefold feature is solvable, we should not pretend that
>> > we can support this model, so let's just check the casefold feature.
>> > tune2fs already forbids enabling casefold on a mounted filesystem.
>> 
>> just because we can't fix the general issue for the entire filesystem
>> doesn't mean this case *must not* ever be addressed. What is the
>> advantage of making the code less robust against the syzbot code?  Just
>> check sb->s_encoding and be safe later knowing the unicode map is
>> available.
>> 
>
> Just to make sure, it sounds like you agree that the late checks of ->s_encoding
> are not needed and only __ext4_iget() should handle it, right?  That simplifies
> the code so it is obviously beneficial if we can do it.

Yes.  After we get the inode from __ext4_iget, I think it doesn't matter
if the user went behind our back straight to the block device and
changed the superblock to remove the feature bit. If we already loaded
->s_encoding, it won't be unloaded, so only checking at ext4_iget should
be enough, as far as I can tell.


-- 
Gabriel Krisman Bertazi
