Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D84710BE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 14:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbjEYMT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 08:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjEYMT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 08:19:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04B7A9;
        Thu, 25 May 2023 05:19:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DFE11FE56;
        Thu, 25 May 2023 12:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685017164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nY73Ob7i9/yszN4HxG34KoA67z+MTS83xA9FlnqxOvk=;
        b=1VUxox0NDiJaPMB2SjrAkEBNzxU3Qk/uwOorE1RBIN9XCysvFJiV//9Q+i6uaI3DPufqYD
        zUnOqRRd85+c32qiYXm5F6UHzSykAAxCv3jAv1MX9J7dKjhhwmFRcETc6xJpiXlp56CpvD
        Lo0L4MMCrwh4Ob18X74fg4r5Oe5oH5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685017164;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nY73Ob7i9/yszN4HxG34KoA67z+MTS83xA9FlnqxOvk=;
        b=zupC0LSZ4V0QDdBF3Eoluoogja4JzNZ9eQbfmfXh+x7Bh4GCLDR6FOlRfCrZwVVSLEVHFP
        SjGTVeXzpXVPuUDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D738134B2;
        Thu, 25 May 2023 12:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id asXNFkxSb2TTMAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 12:19:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CD528A075C; Thu, 25 May 2023 14:19:23 +0200 (CEST)
Date:   Thu, 25 May 2023 14:19:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] fs: add frozen sb state helpers
Message-ID: <20230525121923.ckj7hkaqonuyq447@quack3>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508011717.4034511-3-mcgrof@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 07-05-23 18:17:13, Luis Chamberlain wrote:
> Provide helpers so that we can check a superblock frozen state.
> This will make subsequent changes easier to read. This makes
> no functional changes.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Just noticed one nit...

> diff --git a/fs/super.c b/fs/super.c
> index 0e9d48846684..46c6475fc765 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -905,7 +905,7 @@ int reconfigure_super(struct fs_context *fc)
>  
>  	if (fc->sb_flags_mask & ~MS_RMT_MASK)
>  		return -EINVAL;
> -	if (sb->s_writers.frozen != SB_UNFROZEN)
> +	if (!(sb_is_unfrozen(sb)))
             ^ unneeded parenthesis here

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
