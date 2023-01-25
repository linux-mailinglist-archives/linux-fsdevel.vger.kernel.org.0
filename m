Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E455C67B694
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 17:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbjAYQGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 11:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbjAYQGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:06:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598CC59B5D;
        Wed, 25 Jan 2023 08:06:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E95DD21A4C;
        Wed, 25 Jan 2023 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674662785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81rsLaNWgm7vU5nHefc2xCItrqcxjoWdidUKklnGA5o=;
        b=Sdb2wNDsqJzP4x2H5rFQuY0NZyn9LEHWMCAHd8kU86lEEHlOlOzBjOA5gNgK6BZngfdGkr
        Zal+FSzU4noMQhQ5neXLfNjJGH+V4VvR0UDy92F4mkzyQsG5k2Ke7bhsRkttDW419k/9kx
        O0gpFMZRLLexIh6KyJHqudO7qgGcUKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674662785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81rsLaNWgm7vU5nHefc2xCItrqcxjoWdidUKklnGA5o=;
        b=blwiKfgoVEoTTVqbFpVDk30VdU8P7XC0snTavzBSH94YTVy/kMrI3ex4ow44if10TThIX7
        aBx2+vZr6eWXEyAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4F941339E;
        Wed, 25 Jan 2023 16:06:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QNfzM4FT0WMnBAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 16:06:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 59055A06B4; Wed, 25 Jan 2023 17:06:25 +0100 (CET)
Date:   Wed, 25 Jan 2023 17:06:25 +0100
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
        linux-xfs@vger.kernel.org, Colin Walters <walters@verbum.org>
Subject: Re: [PATCH v8 RESEND 2/8] fs: clarify when the i_version counter
 must be updated
Message-ID: <20230125160625.zenzybjgie224jf6@quack3>
References: <20230124193025.185781-1-jlayton@kernel.org>
 <20230124193025.185781-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124193025.185781-3-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-01-23 14:30:19, Jeff Layton wrote:
> The i_version field in the kernel has had different semantics over
> the decades, but NFSv4 has certain expectations. Update the comments
> in iversion.h to describe when the i_version must change.
> 
> Cc: Colin Walters <walters@verbum.org>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. But one note below:

> diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> index 6755d8b4f20b..fced8115a5f4 100644
> --- a/include/linux/iversion.h
> +++ b/include/linux/iversion.h
> @@ -9,8 +9,25 @@
>   * ---------------------------
>   * The change attribute (i_version) is mandated by NFSv4 and is mostly for
>   * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
> - * appear different to observers if there was a change to the inode's data or
> - * metadata since it was last queried.
> + * appear larger to observers if there was an explicit change to the inode's
> + * data or metadata since it was last queried.
> + *
> + * An explicit change is one that would ordinarily result in a change to the
> + * inode status change time (aka ctime). i_version must appear to change, even
> + * if the ctime does not (since the whole point is to avoid missing updates due
> + * to timestamp granularity). If POSIX or other relevant spec mandates that the
> + * ctime must change due to an operation, then the i_version counter must be
> + * incremented as well.
> + *
> + * Making the i_version update completely atomic with the operation itself would
> + * be prohibitively expensive. Traditionally the kernel has updated the times on
> + * directories after an operation that changes its contents. For regular files,
> + * the ctime is usually updated before the data is copied into the cache for a
> + * write. This means that there is a window of time when an observer can
> + * associate a new timestamp with old file contents. Since the purpose of the
> + * i_version is to allow for better cache coherency, the i_version must always
> + * be updated after the results of the operation are visible. Updating it before
> + * and after a change is also permitted.

This sounds good but it is not the case for any of the current filesystems, is
it? Perhaps the documentation should mention this so that people are not
confused?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
