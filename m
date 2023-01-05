Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5665E9E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 12:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjAELaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 06:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjAELaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:30:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E92034;
        Thu,  5 Jan 2023 03:30:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 461BD234B1;
        Thu,  5 Jan 2023 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672918207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CsvjmsAHNTyHKSfmDtz6pIN4kNlQ9as0u9oFPmUqhRg=;
        b=JiYh+Xu6osQ/NDoxUyINRU+wYbDFFYeNrFDGdadKhaXgsOLDRX0S0SoEo9Fcux5XQZoXXp
        TLHScjTz/YdH1l06U+wkfB7CLLj9+hxh1NitrjP2VCBby557hePrtVcvgwnlnAhZsVkvYO
        Wp91UabVImea4ag//C1fP9A5Jx/R9dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672918207;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CsvjmsAHNTyHKSfmDtz6pIN4kNlQ9as0u9oFPmUqhRg=;
        b=oRbhGkSddDMc/XMDnwtt7DJ1hgx81ftFg1Fa7OdHHDsARUcJDuHLj5L4TcV6aGH7mCcdCj
        H/37vdeaz1AYPlCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3409013338;
        Thu,  5 Jan 2023 11:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LSClDL+0tmMxMQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 05 Jan 2023 11:30:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9D115A0742; Thu,  5 Jan 2023 12:30:05 +0100 (CET)
Date:   Thu, 5 Jan 2023 12:30:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rcu 20/27] fs/notify: Remove "select SRCU"
Message-ID: <20230105113005.qmwz4bcxffy265ps@quack3>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-20-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105003813.1770367-20-paulmck@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-01-23 16:38:06, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: <linux-fsdevel@vger.kernel.org>

Sure. You can add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/notify/Kconfig b/fs/notify/Kconfig
> index c020d26ba223e..c6c72c90fd253 100644
> --- a/fs/notify/Kconfig
> +++ b/fs/notify/Kconfig
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config FSNOTIFY
>  	def_bool n
> -	select SRCU
>  
>  source "fs/notify/dnotify/Kconfig"
>  source "fs/notify/inotify/Kconfig"
> -- 
> 2.31.1.189.g2e36527f23
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
