Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA5A7735FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 03:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjHHBd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 21:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjHHBd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:33:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6F4E67;
        Mon,  7 Aug 2023 18:33:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72DB02227F;
        Tue,  8 Aug 2023 01:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691458410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHD25iwqZs5SHKNGey/680tL/xqtANxzcX1lQhpSHQA=;
        b=aSuwIC3zNESn8CqSZW+DUH817cAdB56MwV9eq0KzG161RXrY7+AGfBlKUvFM6bPUvD3ob8
        c2vK3JpafoF6joXSd6XV56s8Mbd32g+0eD0A7b7YHDGZf1mQDpXphDlaS1qE9BhpXxcFYW
        /I7hhO2maLBKdzkatBhn3uRXYBxk4Ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691458410;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHD25iwqZs5SHKNGey/680tL/xqtANxzcX1lQhpSHQA=;
        b=oipWzIuyuy6LSE3GEMoMTWhklVkw3hvM7j2MF51x1iQNOzpJJZPvSj3hIp5KKn2zIR5rA5
        KDs/dWzZvjszB0Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3330713910;
        Tue,  8 Aug 2023 01:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dVvrBmqb0WSBVwAAMHmgww
        (envelope-from <krisman@suse.de>); Tue, 08 Aug 2023 01:33:30 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v4 3/7] libfs: Validate negative dentries in
 case-insensitive directories
In-Reply-To: <20230804044156.GB1954@sol.localdomain> (Eric Biggers's message
        of "Thu, 3 Aug 2023 21:41:56 -0700")
Organization: SUSE
References: <20230727172843.20542-1-krisman@suse.de>
        <20230727172843.20542-4-krisman@suse.de>
        <20230729042048.GB4171@sol.localdomain> <875y5w10ye.fsf@suse.de>
        <20230804044156.GB1954@sol.localdomain>
Date:   Mon, 07 Aug 2023 21:33:28 -0400
Message-ID: <87msz29v2v.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Thu, Aug 03, 2023 at 01:37:45PM -0400, Gabriel Krisman Bertazi wrote:
>> Eric Biggers <ebiggers@kernel.org> writes:
>> 
>> > On Thu, Jul 27, 2023 at 01:28:39PM -0400, Gabriel Krisman Bertazi wrote:
>> >>   - In __lookup_slow, either the parent inode is read locked by the
>> >>     caller (lookup_slow), or it is called with no flags (lookup_one*).
>> >>     The read lock suffices to prevent ->d_name modifications, with the
>> >>     exception of one case: __d_unalias, will call __d_move to fix a
>> >>     directory accessible from multiple dentries, which effectively swaps
>> >>     ->d_name while holding only the shared read lock.  This happens
>> >>     through this flow:
>> >> 
>> >>     lookup_slow()  //LOOKUP_CREATE
>> >>       d_lookup()
>> >>         ->d_lookup()
>> >>           d_splice_alias()
>> >>             __d_unalias()
>> >>               __d_move()
>> >> 
>> >>     Nevertheless, this case is not a problem because negative dentries
>> >>     are not allowed to be moved with __d_move.
>> >
>> > Isn't it possible for a negative dentry to become a positive one concurrently?
>> 
>> Do you mean d_splice_alias racing with a dentry instantiation and
>> __d_move being called on a negative dentry that is turning positive?
>> 
>> It is not possible for __d_move to be called with a negative dentry for
>> d_splice_alias, since the inode->i_lock is locked during __d_find_alias,
>> so it can't race with __d_instantiate or d_add. Then, __d_find_alias
>> can't find negative dentries in the first place, so we either have a
>> positive dentry, in which case __d_move is fine with regard to
>> d_revalidate_name, or we don't have any aliases and don't call
>> __d_move.
>> 
>> Can you clarify what problem you see here?
>> 
>
> I agree that negative dentries can't be moved --- I pointed this out earlier
> (https://lore.kernel.org/linux-fsdevel/20230720060657.GB2607@sol.localdomain).
> The question is whether if ->d_revalidate sees a negative dentry, when can it
> assume that it remains a negative dentry for the remainder of ->d_revalidate.
> I'm not sure there is a problem, I just don't understand your
> explanation.

I see. Thanks for clarifying, as I had previously misunderstood your
point.

So, first of all, if d_revalidate itself is not a creation, it doesn't
matter, because we won't touch ->d_name. We might invalidate a valid
dentry, but that is ok.  The problem would be limited to d_revalidate
being on the creation path, where the parent (read-)lock is held.  The
problem would be doing the memcmp(), while the dentry is turned positive
(d_instantiate), while someone else moves the name.

For the dentry to be turned positive during a d_revalidate, it would
then have to race with d_add or with d_instantiate.  d_add shouldn't be
possible since we are holding the parent inode lock (at least
read-side), which will serialize file creation.

From my understanding of the code, d_instantiate also can't race with
d_revalidate for the same reason - is also serialized by the parent
inode lock, which is acquired in filename_create. At least for all paths
in ext4/f2fs. In fact, I'm failing to find a case where the lock is not
taken when instantiating a dentry, but I'm unsure if this is a guarantee
or just an artifact of the code.

It seems to be safe in the current code, but I don't know if it is a
guarantee.  Can anyone comment on this?

-- 
Gabriel Krisman Bertazi
 
