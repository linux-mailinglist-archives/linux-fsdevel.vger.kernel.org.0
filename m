Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBE77C0CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 21:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjHNT1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 15:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjHNT0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:26:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6519B9C;
        Mon, 14 Aug 2023 12:26:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 25A661F45B;
        Mon, 14 Aug 2023 19:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692041199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QorXVpMmp6KKSrCodB3zbD97W/z12lZeOZogm8hygqI=;
        b=lvkECSmw6TeAZfy/ZSr/L817+CFOVowjyv4vLLInhux4KLABt/vHjsVn8tBlBUvi4j/2I6
        +mK3gjcQJnLmySn+jm3V8DHo6E+lJMWEi4zZG0qRl7p6OlWDAUsD6bkkqagZst+24dizVa
        0p9aLllrZjQ81Dtj8CK3waL1d1hix24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692041199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QorXVpMmp6KKSrCodB3zbD97W/z12lZeOZogm8hygqI=;
        b=rFhK6BPxSibnhzrudHgEFQG2KX2GCwMqMZD0gcLYqI1epUtafobu2QxxxOq2Aobgi/loeF
        Ra9qAJ9Ot1tleoBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFA42138EE;
        Mon, 14 Aug 2023 19:26:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5cqWKu5/2mRUfQAAMHmgww
        (envelope-from <krisman@suse.de>); Mon, 14 Aug 2023 19:26:38 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 01/10] fs: Expose helper to check if a directory
 needs casefolding
In-Reply-To: <20230814191426.GC1171@sol.localdomain> (Eric Biggers's message
        of "Mon, 14 Aug 2023 12:14:26 -0700")
Organization: SUSE
References: <20230812004146.30980-1-krisman@suse.de>
        <20230812004146.30980-2-krisman@suse.de>
        <20230812015915.GA971@sol.localdomain> <875y5h7jld.fsf@suse.de>
        <20230814191426.GC1171@sol.localdomain>
Date:   Mon, 14 Aug 2023 15:26:32 -0400
Message-ID: <87bkf95st3.fsf@suse.de>
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

> On Mon, Aug 14, 2023 at 11:02:38AM -0400, Gabriel Krisman Bertazi wrote:
>> 
>> Also, this patchset has been sitting for years before the latest
>> discussions, and I'm tired of it, so I'm happy to keep this
>> discussion for another time.  Will drop this patch and just check
>> IS_CASEFOLDED in ecryptfs for the next iteration.
>> 
>> I'll follow up with another case-insensitive cleanup patchset I've been
>> siting on forever, which includes this patch and will restart this
>> discussion, among others.
>> 
>
> Well, as we know unfortunately filesystem developers are in short supply, and
> doing proper reviews (identifying issues and working closely with the patchset
> author over multiple iterations to address them, as opposed to just slapping on
> a Reviewed-by) is very time consuming.  Earlier this year I tried to get the
> Android Systems team, which is ostensibly responsible for Android's use of
> casefolding, to take a look, but their entire feedback was just "looks good to
> me".  Also, the fact that this patchset originally excluded the casefold+encrypt
> case technically made it not applicable to Android, and discouraged me from
> taking a look since encryption is my focus.  Sorry for not taking a look sooner.
>
> Anyway, thanks for doing this, and I think it's near the finish line now.  Once

On the contrary, thank *you* for your review. I always appreciate your
feedback, particularly since you are always able to find the corner
cases I missed. That, and your responsiveness, are the reasons I always
put you in my --cc list since v1 for anything related to unicode/fs :)



-- 
Gabriel Krisman Bertazi
