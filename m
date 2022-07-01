Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F965633AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiGAMr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 08:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbiGAMr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:47:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33FE33A3F;
        Fri,  1 Jul 2022 05:47:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 75C2B1FF71;
        Fri,  1 Jul 2022 12:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656679675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0pUM2xdQzcIIXOyIh2sG4C5+QmWunBrYb7tIsGA4f8=;
        b=gNErYllWnEH4fZcEIECKcMItNGUTi2ykcgk7562oF0h5Yw/6y0ngObC337XxO9PAB+awjn
        DlORazre0wT82YkB5aVkqD2mSIFk6lJ1FMi4dovGPBk8UdzIjkw2EhcQPLnEvC0RxBUr2G
        6n64a7CmQHBFeHRlvx6HSPjCLKUCp9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656679675;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0pUM2xdQzcIIXOyIh2sG4C5+QmWunBrYb7tIsGA4f8=;
        b=XoUjLgEZSODfc7wVC2kg8pbkfNtxxkFCjxcnAMErTeP7wWn0KrMB/6LUwss8Xt96q8n4Uv
        lMdelhgbzKcaYZDg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 59ED42C141;
        Fri,  1 Jul 2022 12:47:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 66366A063E; Fri,  1 Jul 2022 14:47:51 +0200 (CEST)
Date:   Fri, 1 Jul 2022 14:47:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/3] fanotify: prepare for setting event flags in
 ignore mask
Message-ID: <20220701124751.fccem5ce47prgmrh@quack3.lan>
References: <20220629144210.2983229-1-amir73il@gmail.com>
 <20220629144210.2983229-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629144210.2983229-2-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 29-06-22 17:42:08, Amir Goldstein wrote:
> @@ -529,6 +529,7 @@ struct fsnotify_mark {
>  	/* fanotify mark flags */
>  #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
>  #define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
> +#define FSNOTIFY_MARK_FLAG_IGNORE_FLAGS		0x0400
>  	unsigned int flags;		/* flags [mark->lock] */
>  };

The whole series looks good to me so I'll test it and queue it up. Just I
find the name FSNOTIFY_MARK_FLAG_IGNORE_FLAGS somewhat confusing because I
had to think whether it means "mark should ignore flags" or whether it
means "ignore mark has flags". So I'll rename this flag to
FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS on commit.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
