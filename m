Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0942767B3A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 14:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjAYNoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 08:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjAYNoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:44:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4B158644;
        Wed, 25 Jan 2023 05:44:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D917B21D5E;
        Wed, 25 Jan 2023 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674654241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u34cpBEDqJuX/95i5AIYMID3fDy0nUZRyfLJgqsz5JQ=;
        b=T20Q1uDkqAVpl0FcikqD5KUp1lmKDKcRNTTaBZS5AUTu4kmJxyMpeNPm1BVkvhM8294jTI
        3/eDrU5Z8ZRWRmy8N+LdYHGEmC7yyDXHxGs4gdX+BKGV8rm3mFCh7BdGL3UB1WbuhAxj0o
        SBjM5HMzd9JRHA0T7yam3HjlkNrPafE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674654241;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u34cpBEDqJuX/95i5AIYMID3fDy0nUZRyfLJgqsz5JQ=;
        b=Tx1TL2rjFXkpIMCkRQz+5pGFgKeywL+dyl4nm17v5ZJwYLWQZiv/tY3jn9rtqiDhto8Vyk
        r2T0Aq2g8b6n5LAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C87081339E;
        Wed, 25 Jan 2023 13:44:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GabnMCEy0WPtMQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 13:44:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 470C6A06B1; Wed, 25 Jan 2023 14:44:01 +0100 (CET)
Date:   Wed, 25 Jan 2023 14:44:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 RESEND 1/8] fs: uninline inode_query_iversion
Message-ID: <20230125134401.k3vsz6sc57ktx2oi@quack3>
References: <20230124193025.185781-1-jlayton@kernel.org>
 <20230124193025.185781-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124193025.185781-2-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-01-23 14:30:18, Jeff Layton wrote:
> Reviewed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reasonable. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c               | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/iversion.h | 38 ++------------------------------------
>  2 files changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index aada4e7c8713..17ecc47696e1 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1582,3 +1582,39 @@ bool inode_maybe_inc_iversion(struct inode *inode, bool force)
>  	return true;
>  }
>  EXPORT_SYMBOL(inode_maybe_inc_iversion);
> +
> +/**
> + * inode_query_iversion - read i_version for later use
> + * @inode: inode from which i_version should be read
> + *
> + * Read the inode i_version counter. This should be used by callers that wish
> + * to store the returned i_version for later comparison. This will guarantee
> + * that a later query of the i_version will result in a different value if
> + * anything has changed.
> + *
> + * In this implementation, we fetch the current value, set the QUERIED flag and
> + * then try to swap it into place with a cmpxchg, if it wasn't already set. If
> + * that fails, we try again with the newly fetched value from the cmpxchg.
> + */
> +u64 inode_query_iversion(struct inode *inode)
> +{
> +	u64 cur, new;
> +
> +	cur = inode_peek_iversion_raw(inode);
> +	do {
> +		/* If flag is already set, then no need to swap */
> +		if (cur & I_VERSION_QUERIED) {
> +			/*
> +			 * This barrier (and the implicit barrier in the
> +			 * cmpxchg below) pairs with the barrier in
> +			 * inode_maybe_inc_iversion().
> +			 */
> +			smp_mb();
> +			break;
> +		}
> +
> +		new = cur | I_VERSION_QUERIED;
> +	} while (!atomic64_try_cmpxchg(&inode->i_version, &cur, new));
> +	return cur >> I_VERSION_QUERIED_SHIFT;
> +}
> +EXPORT_SYMBOL(inode_query_iversion);
> diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> index e27bd4f55d84..6755d8b4f20b 100644
> --- a/include/linux/iversion.h
> +++ b/include/linux/iversion.h
> @@ -234,42 +234,6 @@ inode_peek_iversion(const struct inode *inode)
>  	return inode_peek_iversion_raw(inode) >> I_VERSION_QUERIED_SHIFT;
>  }
>  
> -/**
> - * inode_query_iversion - read i_version for later use
> - * @inode: inode from which i_version should be read
> - *
> - * Read the inode i_version counter. This should be used by callers that wish
> - * to store the returned i_version for later comparison. This will guarantee
> - * that a later query of the i_version will result in a different value if
> - * anything has changed.
> - *
> - * In this implementation, we fetch the current value, set the QUERIED flag and
> - * then try to swap it into place with a cmpxchg, if it wasn't already set. If
> - * that fails, we try again with the newly fetched value from the cmpxchg.
> - */
> -static inline u64
> -inode_query_iversion(struct inode *inode)
> -{
> -	u64 cur, new;
> -
> -	cur = inode_peek_iversion_raw(inode);
> -	do {
> -		/* If flag is already set, then no need to swap */
> -		if (cur & I_VERSION_QUERIED) {
> -			/*
> -			 * This barrier (and the implicit barrier in the
> -			 * cmpxchg below) pairs with the barrier in
> -			 * inode_maybe_inc_iversion().
> -			 */
> -			smp_mb();
> -			break;
> -		}
> -
> -		new = cur | I_VERSION_QUERIED;
> -	} while (!atomic64_try_cmpxchg(&inode->i_version, &cur, new));
> -	return cur >> I_VERSION_QUERIED_SHIFT;
> -}
> -
>  /*
>   * For filesystems without any sort of change attribute, the best we can
>   * do is fake one up from the ctime:
> @@ -283,6 +247,8 @@ static inline u64 time_to_chattr(struct timespec64 *t)
>  	return chattr;
>  }
>  
> +u64 inode_query_iversion(struct inode *inode);
> +
>  /**
>   * inode_eq_iversion_raw - check whether the raw i_version counter has changed
>   * @inode: inode to check
> -- 
> 2.39.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
