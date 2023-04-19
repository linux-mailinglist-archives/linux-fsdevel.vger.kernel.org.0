Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6636E7ACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 15:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjDSNaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjDSNaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:30:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D4469A;
        Wed, 19 Apr 2023 06:30:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 727C121999;
        Wed, 19 Apr 2023 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681911044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=usEQwowq+Yw1GH44xcAd8U8e4o6dI8rqDVqY0wujHJs=;
        b=p7h5hn0CdDGRorcYtBpMf1tRASfvpQC74+rfxqq3nZck/K5GsfVIFjkoxfj90MmCx14mf4
        M6beANvBRw5aqM2xpdmxHWF/MRgM1TxAoCE4Uz87UIWvt5QE914hQzFmoGSJYp7+HL7AZi
        unwk7wEIpyBz/cHnVjiAuOT6Uz2uVgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681911044;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=usEQwowq+Yw1GH44xcAd8U8e4o6dI8rqDVqY0wujHJs=;
        b=TOFbccIwqIU3OQ/e56ZS9H5Qmf9Kl1AFvNFWHsr/qTadIhrFQlgv5D7tKU+LyWkDBCOX4y
        S5Zs9y7DVHD3UCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B2081390E;
        Wed, 19 Apr 2023 13:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GgU1FgTtP2S/LAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 19 Apr 2023 13:30:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 81B8AA0722; Wed, 19 Apr 2023 15:30:43 +0200 (CEST)
Date:   Wed, 19 Apr 2023 15:30:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH 2/2] fanotify: report mntid info record with
 FAN_UNMOUNT events
Message-ID: <20230419133043.zintid3euvpwd5br@quack3>
References: <20230414182903.1852019-1-amir73il@gmail.com>
 <20230414182903.1852019-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414182903.1852019-3-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 14-04-23 21:29:03, Amir Goldstein wrote:
> Report mntid in an info record of type FAN_EVENT_INFO_TYPE_MNTID
> with FAN_UNMOUNT event in addition to the fid info record.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

This patch looks good to me (besides the things you've already noticed).
Just one nit below.

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 0b3de6218c56..db3b79b8e901 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -120,7 +120,9 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
>  #define FANOTIFY_EVENT_ALIGN 4
>  #define FANOTIFY_FID_INFO_HDR_LEN \
>  	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
> -#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> +#define FANOTIFY_MNTID_INFO_LEN \
> +	sizeof(struct fanotify_event_info_mntid)
> +#define FANOTIFY_PIDFD_INFO_LEN \

I agree with changing FANOTIFY_PIDFD_INFO_HDR_LEN to
FANOTIFY_PIDFD_INFO_LEN but as a separate patch please.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
