Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2ED759D3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjGSS1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 14:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjGSS1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:27:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FECC1FE1;
        Wed, 19 Jul 2023 11:27:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6A2F200A9;
        Wed, 19 Jul 2023 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689791226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhOyZ0ZdWLkpby1Iqtq7SFOqx2lnmUd32VWJ4JlD36g=;
        b=q1pdcQZFX7fifseO0xceZtJzp64S4KFfju3lzq3XamQ4l+/jrkC9W9yY8ELdzRNXOKk9pm
        BxzTE/f0OoOHt6g8jiCH/YXB2SKcw8cb7yjf3TDZcYy8TYspyfp2qdkRZzeqQfbICZTcP+
        8b50YM1XhfVza9lBxrUkCPGEPW8NeKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689791226;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhOyZ0ZdWLkpby1Iqtq7SFOqx2lnmUd32VWJ4JlD36g=;
        b=7zQHJhTWV4xn+EbDtJEI8gXkRtL3feXW+bzV28gFBd4UZIC1ArWepTBVRpeIMHZKE7+4qB
        Kzm9IpgtZrSQnuBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74C9D1361C;
        Wed, 19 Jul 2023 18:27:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SwbvFvoquGS1QwAAMHmgww
        (envelope-from <krisman@suse.de>); Wed, 19 Jul 2023 18:27:06 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 4/7] libfs: Support revalidation of encrypted
 case-insensitive dentries
Organization: SUSE
References: <20230422000310.1802-1-krisman@suse.de>
        <20230422000310.1802-5-krisman@suse.de>
        <20230714053135.GD913@sol.localdomain> <87h6q1580a.fsf@suse.de>
        <20230718221040.GA1005@sol.localdomain>
Date:   Wed, 19 Jul 2023 14:27:05 -0400
In-Reply-To: <20230718221040.GA1005@sol.localdomain> (Eric Biggers's message
        of "Tue, 18 Jul 2023 15:10:40 -0700")
Message-ID: <874jlz69l2.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> Why would order matter?  If either "feature" wants the dentry to be invalidated,
> then the dentry gets invalidated.

For instance, I was wondering makes sense for instance to memcmp d_name for
!DCACHE_NOKEY_NAME or if we wanted fscrypt_d_revalidate to come first.

>> Note we will start creating negative dentries in casefold directories after
>> patch 6/7, so unless we disable it here, we will start calling
>> fscrypt_d_revalidate for negative+casefold.
>
> fscrypt_d_revalidate() only cares about the DCACHE_NOKEY_NAME flag, so that's
> not a problem.

..I see now it is the first thing checked in fscrypt_d_revalidate.

>> Should I just drop this hunk?  Unless you are confident it works as is, I
>> prefer to add this support in stages and keep negative dentries of
>> encrypted+casefold directories disabled for now.
>
> Unless I'm missing something, I think you're overcomplicating it.

Not overcomplicating. I'm just not familiar with fscrypt details enough to be
sure I could enable it.  But yes, it seems safe.

> It should
> just work if you don't go out of your way to prohibit this case.  I.e., just
> don't add the IS_ENCRYPTED(dir) check to generic_ci_d_revalidate().

I'll drop the check. And resend.

Thanks,

-- 
Gabriel Krisman Bertazi
