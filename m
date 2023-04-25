Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA7D6EE1E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 14:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjDYMar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 08:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjDYMap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:30:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832D7133
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 05:30:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2FB901FDA5;
        Tue, 25 Apr 2023 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682425843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/eMe0Yi26O4GgnxAzwKKj8+VaObX0RFaPTN5QrSbSM=;
        b=pbfmxOo4TAaQIk6drgeO52YWU2cdDpUoo+17MLTrMfHTVRaV1R1936FvwkqERu5mPCxFnw
        3ZY3RmfALMvpMHtpibbcW5UJHQ1+UWtcBeV1BxjRAtrdJwcxpZ82frDoXp3sTY+iCTPoTk
        FmOWws5EYVs5Jxbi95Vd7gIBmDaSRXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682425843;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/eMe0Yi26O4GgnxAzwKKj8+VaObX0RFaPTN5QrSbSM=;
        b=wxsbKQyZTzxh3hh91vMNeCPuyGYKzDzVKT5wqgpR0ca+Q3wWh/783LNPz9jdTkg7lsFTp0
        0KCywCWZqyXFOBBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 140BA138E3;
        Tue, 25 Apr 2023 12:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gt/gBPPHR2Q6cAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 25 Apr 2023 12:30:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8B799A0729; Tue, 25 Apr 2023 14:30:42 +0200 (CEST)
Date:   Tue, 25 Apr 2023 14:30:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     cem@kernel.org
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH V3 6/6] Add default quota limit mount options
Message-ID: <20230425123042.ja6oab6yhtzqnwyl@quack3>
References: <20230420080359.2551150-7-cem@kernel.org>
 <20230425115725.2913656-1-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425115725.2913656-1-cem@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-04-23 13:57:25, cem@kernel.org wrote:
> From: Lukas Czerner <lczerner@redhat.com>
> 
> Allow system administrator to set default global quota limits at tmpfs
> mount time.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
...
> @@ -224,6 +233,29 @@ static int shmem_acquire_dquot(struct dquot *dquot)
>  	return ret;
>  }
>  
> +static bool shmem_is_empty_dquot(struct dquot *dquot)
> +{
> +	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
> +	qsize_t bhardlimit;
> +	qsize_t ihardlimit;
> +
> +	if (dquot->dq_id.type == USRQUOTA) {
> +		bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
> +		ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;
> +	} else if (dquot->dq_id.type == GRPQUOTA) {
> +		bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
> +		ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;

There should be grpquota in the above two lines. Otherwise the patch looks
good to me.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
