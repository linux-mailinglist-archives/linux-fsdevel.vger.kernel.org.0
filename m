Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C70A7830B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 21:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjHUSzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 14:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHUSzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:55:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E016315;
        Mon, 21 Aug 2023 11:53:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D99B22BEF;
        Mon, 21 Aug 2023 18:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692644008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nd67bGfV1KhCemr7IE4Dyv8OFK+mAXQ8eNOnMuZJU1Y=;
        b=yOcguDz1a0LAVX4UvhR8ca45H5AahyHKyLZ45z0o2XxhR6AzDrq+Yrj+qu65l9TBNZm1p/
        1jJm3WZEmU6uIPiBvQYv57UtKHpvpY46ZnQyr8Hsiarzjgu03EKmBJBRtdn5C1tBRzZOwk
        W9Uh4nzQL+PC2ICwCg7yFnIFcrXcs1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692644008;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nd67bGfV1KhCemr7IE4Dyv8OFK+mAXQ8eNOnMuZJU1Y=;
        b=hVOmNCKJNw1sHxkFh1gX1fF+I762Xot715XhVhJDX41uM/onCZWkBV8mXdE4vpvbLnDlHa
        NqsN9DllNJfaObCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9C391330D;
        Mon, 21 Aug 2023 18:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Bw5hM6ey42QodQAAMHmgww
        (envelope-from <krisman@suse.de>); Mon, 21 Aug 2023 18:53:27 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, viro@zeniv.linux.org.uk,
        tytso@mit.edu, jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v6 0/9] Support negative dentries on case-insensitive
 ext4 and f2fs
In-Reply-To: <20230821-derart-serienweise-3506611e576d@brauner> (Christian
        Brauner's message of "Mon, 21 Aug 2023 17:52:37 +0200")
Organization: SUSE
References: <20230816050803.15660-1-krisman@suse.de>
        <20230817170658.GD1483@sol.localdomain>
        <20230821-derart-serienweise-3506611e576d@brauner>
Date:   Mon, 21 Aug 2023 14:53:26 -0400
Message-ID: <871qfwns61.fsf@suse.de>
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

Christian Brauner <brauner@kernel.org> writes:

> On Thu, Aug 17, 2023 at 10:06:58AM -0700, Eric Biggers wrote:
>> On Wed, Aug 16, 2023 at 01:07:54AM -0400, Gabriel Krisman Bertazi wrote:
>> > Hi,
>> > 
>> > This is v6 of the negative dentry on case-insensitive directories.
>> > Thanks Eric for the review of the last iteration.  This version
>> > drops the patch to expose the helper to check casefolding directories,
>> > since it is not necessary in ecryptfs and it might be going away.  It
>> > also addresses some documentation details, fix a build bot error and
>> > simplifies the commit messages.  See the changelog in each patch for
>> > more details.
>> > 
>> > Thanks,
>> > 
>> > ---
>> > 
>> > Gabriel Krisman Bertazi (9):
>> >   ecryptfs: Reject casefold directory inodes
>> >   9p: Split ->weak_revalidate from ->revalidate
>> >   fs: Expose name under lookup to d_revalidate hooks
>> >   fs: Add DCACHE_CASEFOLDED_NAME flag
>> >   libfs: Validate negative dentries in case-insensitive directories
>> >   libfs: Chain encryption checks after case-insensitive revalidation
>> >   libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
>> >   ext4: Enable negative dentries on case-insensitive lookup
>> >   f2fs: Enable negative dentries on case-insensitive lookup
>> > 
>> 
>> Looks good,
>> 
>> Reviewed-by: Eric Biggers <ebiggers@google.com>
>
> Thanks! We're a bit too late for v6.6 with this given that this hasn't
> even been in -next. So this will be up for v6.7.

Targeting 6.7 is fine by me. will you pick it up through the vfs tree? I
prefer it goes through there since it mostly touches vfs.

-- 
Gabriel Krisman Bertazi
