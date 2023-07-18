Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45965758599
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 21:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGRTeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 15:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGRTeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:34:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D7198D;
        Tue, 18 Jul 2023 12:34:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 912B521228;
        Tue, 18 Jul 2023 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689708854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nfRfgiokLRl5nqf7y5XFPbUJv0GuTL/H7C55bO7v3R4=;
        b=cDrfz3Bxd3Nd94VFgL2JVO8njdKs183T68KwWa+HKUDHdGI4+lryOaPHUxSmejrApiOfr0
        D/uaaLm82JxebaF1tnpXJdSInbh1FTMQsm7swQhggH66EAFEjvbzcBfkZ2xbh2zmJNftVM
        4GEhE7V8Pw/YWR6lp0cAzGw+1yJPuSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689708854;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nfRfgiokLRl5nqf7y5XFPbUJv0GuTL/H7C55bO7v3R4=;
        b=NQiOerI24agrAV49xPs4KDHdoE/FPKXqLjVaD+XVZCNr66B3f73Bp098UjLLk5Z9RLAmVl
        RBcw3XRxPIsiOCAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57904134B0;
        Tue, 18 Jul 2023 19:34:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fVW6DzbptmQaIgAAMHmgww
        (envelope-from <krisman@suse.de>); Tue, 18 Jul 2023 19:34:14 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 4/7] libfs: Support revalidation of encrypted
 case-insensitive dentries
References: <20230422000310.1802-1-krisman@suse.de>
        <20230422000310.1802-5-krisman@suse.de>
        <20230714053135.GD913@sol.localdomain>
Date:   Tue, 18 Jul 2023 15:34:13 -0400
In-Reply-To: <20230714053135.GD913@sol.localdomain> (Eric Biggers's message of
        "Thu, 13 Jul 2023 22:31:35 -0700")
Message-ID: <87h6q1580a.fsf@suse.de>
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

> On Fri, Apr 21, 2023 at 08:03:07PM -0400, Gabriel Krisman Bertazi wrote:
>> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>> 
>> Preserve the existing behavior for encrypted directories, by rejecting
>> negative dentries of encrypted+casefolded directories.  This allows
>> generic_ci_d_revalidate to be used by filesystems with both features
>> enabled, as long as the directory is either casefolded or encrypted, but
>> not both at the same time.
>> 
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> ---
>>  fs/libfs.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index f8881e29c5d5..0886044db593 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -1478,6 +1478,9 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
>>  		const struct inode *dir = READ_ONCE(parent->d_inode);
>>  
>>  		if (dir && needs_casefold(dir)) {
>> +			if (IS_ENCRYPTED(dir))
>> +				return 0;
>> +
>
> Why not allow negative dentries in case-insensitive encrypted directories?
> I can't think any reason why it wouldn't just work.

TBH, I'm not familiar with the details of combined encrypted+casefold
support to be confident it works.  This patch preserves the current
behavior of disabling them for encrypted+casefold directories.

I suspect it might require extra work that I'm not focusing on this
patchset.  For instance, what should be the order of
fscrypt_d_revalidate and the checks I'm adding here? Note we will start
creating negative dentries in casefold directories after patch 6/7, so
unless we disable it here, we will start calling fscrypt_d_revalidate
for negative+casefold.

Should I just drop this hunk?  Unless you are confident it works as is, I
prefer to add this support in stages and keep negative dentries of
encrypted+casefold directories disabled for now.

-- 
Gabriel Krisman Bertazi
