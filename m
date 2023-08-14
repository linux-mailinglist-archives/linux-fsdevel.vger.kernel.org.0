Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E98377BC4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 17:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjHNPDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 11:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjHNPCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:02:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DBD1B5;
        Mon, 14 Aug 2023 08:02:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A6A51F383;
        Mon, 14 Aug 2023 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692025360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/H/2o4RppNFPDmpoYKz4dITYrINffqG3kACebc9ICo=;
        b=GGuWgyQSxAyOOlwxy/D1+Yrum/6XYqs1RbqS2+NLpkhUsDDCtAyhLON5RO9aXzP8mpXz6F
        Dt8QZ6VU8vceInhhPQ3z0Z0UXUxV0r7VREIgVLrHFY81Ip8PLujayQNMqT9nSDeuakGqmU
        Vn++EQQ5yxXEhKYCtfLXrtwSeKvzyek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692025360;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/H/2o4RppNFPDmpoYKz4dITYrINffqG3kACebc9ICo=;
        b=fzR8OmiTLhjrRN1BK3+uS4DwisfVMIqY/1qy/BKrdt4yKU12hsuilcQOh6CRhmd6Ss+L0t
        zJPncdUMEZ8p3ADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17AE5138EE;
        Mon, 14 Aug 2023 15:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7FV4OQ9C2mT2CwAAMHmgww
        (envelope-from <krisman@suse.de>); Mon, 14 Aug 2023 15:02:39 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 01/10] fs: Expose helper to check if a directory
 needs casefolding
In-Reply-To: <20230812015915.GA971@sol.localdomain> (Eric Biggers's message of
        "Fri, 11 Aug 2023 18:59:15 -0700")
Organization: SUSE
References: <20230812004146.30980-1-krisman@suse.de>
        <20230812004146.30980-2-krisman@suse.de>
        <20230812015915.GA971@sol.localdomain>
Date:   Mon, 14 Aug 2023 11:02:38 -0400
Message-ID: <875y5h7jld.fsf@suse.de>
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

> On Fri, Aug 11, 2023 at 08:41:37PM -0400, Gabriel Krisman Bertazi wrote:
>> In preparation to use it in ecryptfs, move needs_casefolding into a
>> public header and give it a namespaced name.
>> 
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> ---
>>  fs/libfs.c         | 14 ++------------
>>  include/linux/fs.h | 21 +++++++++++++++++++++
>>  2 files changed, 23 insertions(+), 12 deletions(-)
>> 
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index 5b851315eeed..8d0b64cfd5da 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -1381,16 +1381,6 @@ bool is_empty_dir_inode(struct inode *inode)
>>  }
>>  
>>  #if IS_ENABLED(CONFIG_UNICODE)
>> -/*
>> - * Determine if the name of a dentry should be casefolded.
>> - *
>> - * Return: if names will need casefolding
>> - */
>> -static bool needs_casefold(const struct inode *dir)
>> -{
>> -	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding;
>> -}
>> -
>>  /**
>>   * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
>>   * @dentry:	dentry whose name we are checking against
>> @@ -1411,7 +1401,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
>>  	char strbuf[DNAME_INLINE_LEN];
>>  	int ret;
>>  
>> -	if (!dir || !needs_casefold(dir))
>> +	if (!dir || !dir_is_casefolded(dir))
>>  		goto fallback;
>>  	/*
>>  	 * If the dentry name is stored in-line, then it may be concurrently
>> @@ -1453,7 +1443,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
>>  	const struct unicode_map *um = sb->s_encoding;
>>  	int ret = 0;
>>  
>> -	if (!dir || !needs_casefold(dir))
>> +	if (!dir || !dir_is_casefolded(dir))
>>  		return 0;
>>  
>>  	ret = utf8_casefold_hash(um, dentry, str);
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 6867512907d6..e3b631c6d24a 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -3213,6 +3213,27 @@ static inline bool dir_relax_shared(struct inode *inode)
>>  	return !IS_DEADDIR(inode);
>>  }
>>  
>> +/**
>> + * dir_is_casefolded - Safely determine if filenames inside of a
>> + * directory should be casefolded.
>> + * @dir: The directory inode to be checked
>> + *
>> + * Filesystems should usually rely on this instead of checking the
>> + * S_CASEFOLD flag directly when handling inodes, to avoid surprises
>> + * with corrupted volumes.  Checking i_sb->s_encoding ensures the
>> + * filesystem knows how to deal with case-insensitiveness.
>> + *
>> + * Return: if names will need casefolding
>> + */
>> +static inline bool dir_is_casefolded(const struct inode *dir)
>> +{
>> +#if IS_ENABLED(CONFIG_UNICODE)
>> +	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding;
>> +#else
>> +	return false;
>> +#endif
>> +}
>
> To be honest I've always been confused about why the ->s_encoding check is
> there.  It looks like Ted added it in 6456ca6520ab ("ext4: fix kernel oops
> caused by spurious casefold flag") to address a fuzzing report for a filesystem
> that had a casefolded directory but didn't have the casefold feature flag set.
> It seems like an unnecessarily complex fix, though.  The filesystem should just
> reject the inode earlier, in __ext4_iget().  And likewise for f2fs.  Then no
> other code has to worry about this problem.
>
> Actually, f2fs already does it, as I added it in commit f6322f3f1212:
>
>         if ((fi->i_flags & F2FS_CASEFOLD_FL) && !f2fs_sb_has_casefold(sbi)) {
>                 set_sbi_flag(sbi, SBI_NEED_FSCK);
>                 f2fs_warn(sbi, "%s: inode (ino=%lx) has casefold flag, but casefold feature is off",
>                           __func__, inode->i_ino);
>                 return false;
>         }
>
> So just __ext4_iget() needs to be fixed.  I think we should consider doing that
> before further entrenching all the extra ->s_encoding checks.
>
> Also I don't understand why this needs to be part of your patch series anyway.
> Shouldn't eCryptfs check IS_CASEFOLDED() anyway?

While I agree with Ted's point about how this change is tiny compared to
the benefit of preventing casefold-related superblock corruptions on
runtime (and we want to keep it being done in ext4),  I also agree with
you that we don't need to check it also in ecryptfs.  But, I'll preserve
it in d_revalidate, since it is what we are currently doing in
d_compare/d_hash.

Also, this patchset has been sitting for years before the latest
discussions, and I'm tired of it, so I'm happy to keep this
discussion for another time.  Will drop this patch and just check
IS_CASEFOLDED in ecryptfs for the next iteration.

I'll follow up with another case-insensitive cleanup patchset I've been
siting on forever, which includes this patch and will restart this
discussion, among others.

-- 
Gabriel Krisman Bertazi
