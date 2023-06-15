Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC26B7322D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 00:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjFOWg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 18:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjFOWg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:36:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843AB213B
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 15:36:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666729f9093so222723b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 15:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686868616; x=1689460616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwQyuxAyTt1/oKouBdq99atB/qMOTmn/K879yY2V9E4=;
        b=noOsBr/CspwkQvpbrzj5KCSEhNzXrCsPg93TsJTZhVUEuAdjuyboueTWbZuUA0LZjl
         NZ8gTkUmwUdVIku8+KBhZiWOqfwBfPBvu4P5/Xo5R/7fkmnDG2vrm8qFrrDGsmWmmlfL
         VpLqLpIeF3j8FeIsIL6Mi3pKInxZ4/qcnTcuZ3HBAY/aTOF6hPgq+NRHnCABJ5IR7T+z
         BNK2fiKkSt/zcZ54eDPIwmb44thkxzK2vxHImPJSz+GSIsKGEjnG/3mOhpDVXQJH8Jyl
         Bpe7Ud3QyS2GYoeoOkt7Aiuzu2A1dfGCiBL+XpwnzI+iLZFcDLov/ZPOBUvRGNtsyLEk
         p7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686868616; x=1689460616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwQyuxAyTt1/oKouBdq99atB/qMOTmn/K879yY2V9E4=;
        b=GVjW+TytlsXLSXztS35nJZoD5UfBpxqKdqtcgwbSRkHVI32wNNTv7oQOIiV8cJue3e
         hdAaGXFaU7S0HW1MiAG7oZUZ80lTNfZoK9yMqczcx2tgmDkz5BephjjZr/8WjRmaAT2l
         pdW0mswAoT4Ozu9iH84A9DhbKVoJVfrtaX0NdLGwzgRxleTvRuZLqwe3VV4Bs82zzq/3
         zeoH+MNt1GIrlZzqGx6l3pN2sKQ7DMBs2ZeJTMERWB3KvJ9wnRS8fmsmC3HWe0Z2bg4r
         HHlJjD5ezUsM1RUWn7tMgnAkk8aYW3xEf9AUIHTGS0q3drn2LZHVOO2r8hCeYdUdZj7g
         ImSg==
X-Gm-Message-State: AC+VfDxOYSEZ/Qhrxm7V4pcEehyvtzHemjagm8TLQGs+JgZcRlrNGUoE
        xkd1ryqYGptL3njUwuFqpJa/qA==
X-Google-Smtp-Source: ACHHUZ75FXegV6BX2ho2UEFB4ciuweSYC7c5ETB/vEOPK3fmuFv6m+s+m/QOIFceiTM1FeQBqdwqyQ==
X-Received: by 2002:a17:902:d903:b0:1b0:6031:4480 with SMTP id c3-20020a170902d90300b001b060314480mr321313plz.39.1686868615966;
        Thu, 15 Jun 2023 15:36:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902b49400b001a980a23804sm14555755plr.4.2023.06.15.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 15:36:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9vaH-00CF1W-0L;
        Fri, 16 Jun 2023 08:36:53 +1000
Date:   Fri, 16 Jun 2023 08:36:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Protect reconfiguration of sb read-write from racing
 writes
Message-ID: <ZIuShQWnWEWscTWr@dread.disaster.area>
References: <20230615113848.8439-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615113848.8439-1-jack@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:38:48PM +0200, Jan Kara wrote:
> The reconfigure / remount code takes a lot of effort to protect
> filesystem's reconfiguration code from racing writes on remounting
> read-only. However during remounting read-only filesystem to read-write
> mode userspace writes can start immediately once we clear SB_RDONLY
> flag. This is inconvenient for example for ext4 because we need to do
> some writes to the filesystem (such as preparation of quota files)
> before we can take userspace writes so we are clearing SB_RDONLY flag
> before we are fully ready to accept userpace writes and syzbot has found
> a way to exploit this [1]. Also as far as I'm reading the code
> the filesystem remount code was protected from racing writes in the
> legacy mount path by the mount's MNT_READONLY flag so this is relatively
> new problem. It is actually fairly easy to protect remount read-write
> from racing writes using sb->s_readonly_remount flag so let's just do
> that instead of having to workaround these races in the filesystem code.
> 
> [1] https://lore.kernel.org/all/00000000000006a0df05f6667499@google.com/T/
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/super.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 34afe411cf2b..6cd64961aa07 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -903,6 +903,7 @@ int reconfigure_super(struct fs_context *fc)
>  	struct super_block *sb = fc->root->d_sb;
>  	int retval;
>  	bool remount_ro = false;
> +	bool remount_rw = false;
>  	bool force = fc->sb_flags & SB_FORCE;
>  
>  	if (fc->sb_flags_mask & ~MS_RMT_MASK)
> @@ -920,7 +921,7 @@ int reconfigure_super(struct fs_context *fc)
>  		    bdev_read_only(sb->s_bdev))
>  			return -EACCES;
>  #endif
> -
> +		remount_rw = !(fc->sb_flags & SB_RDONLY) && sb_rdonly(sb);
>  		remount_ro = (fc->sb_flags & SB_RDONLY) && !sb_rdonly(sb);
>  	}
>  
> @@ -950,6 +951,14 @@ int reconfigure_super(struct fs_context *fc)
>  			if (retval)
>  				return retval;
>  		}
> +	} else if (remount_rw) {
> +		/*
> +		 * We set s_readonly_remount here to protect filesystem's
> +		 * reconfigure code from writes from userspace until
> +		 * reconfigure finishes.
> +		 */
> +		sb->s_readonly_remount = 1;
> +		smp_wmb();

What does the magic random memory barrier do? What is it ordering,
and what is it paired with?

This sort of thing is much better done with small helpers that
encapsulate the necessary memory barriers:

sb_set_readonly_remount()
sb_clear_readonly_remount()

alongside the helper that provides the read-side check and memory
barrier the write barrier is associated with.

I don't often ask for code to be cleaned up before a bug fix can be
added, but I think this is one of the important cases where it does
actually matter - we should never add undocumented memory barriers
in the code like this...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
