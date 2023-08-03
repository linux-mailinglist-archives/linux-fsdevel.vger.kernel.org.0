Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3CB76F0C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjHCRh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 13:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjHCRhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:37:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E552F10B;
        Thu,  3 Aug 2023 10:37:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9BDF3218EB;
        Thu,  3 Aug 2023 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691084267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nUrIcCgKfn8Ln+psoMSqthh4paG1THVbdii5u1kozU8=;
        b=OGxF/Y/oYJ1fU84+6F/RoPLLg35d4x0oZCxn7NJYfsPYaWyvnRyXHf4DpYhnHIw3AkH3PX
        BJZstYEbB8LUqRjqLjnTpX/TyqqePgq5GT48C61y8Lb4rZ9K2dtS1h0Smt0EYdOu76tQNZ
        CvchZify8FuYF5UYOBMlpefOsxln22g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691084267;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nUrIcCgKfn8Ln+psoMSqthh4paG1THVbdii5u1kozU8=;
        b=ho8JvdBvLvswROYHxKBwf9LRoHGI9RbaY2o/N43xAICwJABGHb/t2edJT1Nkm29HchCy3L
        qOnMv5JMwYiyM3CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DDA3134B0;
        Thu,  3 Aug 2023 17:37:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CX3WEOvly2R3fQAAMHmgww
        (envelope-from <krisman@suse.de>); Thu, 03 Aug 2023 17:37:47 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v4 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Organization: SUSE
References: <20230727172843.20542-1-krisman@suse.de>
        <20230727172843.20542-4-krisman@suse.de>
        <20230729042048.GB4171@sol.localdomain>
Date:   Thu, 03 Aug 2023 13:37:45 -0400
In-Reply-To: <20230729042048.GB4171@sol.localdomain> (Eric Biggers's message
        of "Fri, 28 Jul 2023 21:20:48 -0700")
Message-ID: <875y5w10ye.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Thu, Jul 27, 2023 at 01:28:39PM -0400, Gabriel Krisman Bertazi wrote:
>>   - In __lookup_slow, either the parent inode is read locked by the
>>     caller (lookup_slow), or it is called with no flags (lookup_one*).
>>     The read lock suffices to prevent ->d_name modifications, with the
>>     exception of one case: __d_unalias, will call __d_move to fix a
>>     directory accessible from multiple dentries, which effectively swaps
>>     ->d_name while holding only the shared read lock.  This happens
>>     through this flow:
>> 
>>     lookup_slow()  //LOOKUP_CREATE
>>       d_lookup()
>>         ->d_lookup()
>>           d_splice_alias()
>>             __d_unalias()
>>               __d_move()
>> 
>>     Nevertheless, this case is not a problem because negative dentries
>>     are not allowed to be moved with __d_move.
>
> Isn't it possible for a negative dentry to become a positive one concurrently?

Do you mean d_splice_alias racing with a dentry instantiation and
__d_move being called on a negative dentry that is turning positive?

It is not possible for __d_move to be called with a negative dentry for
d_splice_alias, since the inode->i_lock is locked during __d_find_alias,
so it can't race with __d_instantiate or d_add. Then, __d_find_alias
can't find negative dentries in the first place, so we either have a
positive dentry, in which case __d_move is fine with regard to
d_revalidate_name, or we don't have any aliases and don't call
__d_move.

Can you clarify what problem you see here?

-- 
Gabriel Krisman Bertazi
