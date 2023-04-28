Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B596F18E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 15:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbjD1NJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 09:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346153AbjD1NJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:09:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AC2268E;
        Fri, 28 Apr 2023 06:09:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 83835200A3;
        Fri, 28 Apr 2023 13:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682687362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JWfxAcfk/xVe6NFhNb6c7XGdn22Dp0roG4qf31nBwCA=;
        b=xmn9HCmoZfh4/VC1asnLv3Xy9BXzI5lda9aeKwUxeZNjxGCaJ/gRRxZEt8dD6AaIXsE8bi
        4OqBThhKXperIxTCcs8JuF/LtyuuqOhHBNgd5KnR2cjWD6TFr33DWFBjVaB+fkPXFWcEmx
        LfCjWWuZt+ueIV68Y964o9fj4fqEhJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682687362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JWfxAcfk/xVe6NFhNb6c7XGdn22Dp0roG4qf31nBwCA=;
        b=7bVqPaLqtIgJb804rnmb3quZr++WOREcf7UFUizDZEO6tVHDlRJcur4c7nmZK3aUV91/iP
        25F5Y8neblKRAFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76097138FA;
        Fri, 28 Apr 2023 13:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QbDHHILFS2SREgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 28 Apr 2023 13:09:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B611FA0729; Fri, 28 Apr 2023 15:09:21 +0200 (CEST)
Date:   Fri, 28 Apr 2023 15:09:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] writeback: fix call of incorrect macro
Message-ID: <20230428130921.dgtldfqqsmpke47l@quack3>
References: <20230119104443.3002-1-korotkov.maxim.s@gmail.com>
 <20230126135258.zpvyfxc2ffhzzsnx@quack3>
 <df995d93-4b31-fa61-a7ae-db33fd058412@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df995d93-4b31-fa61-a7ae-db33fd058412@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

Jens, can you please pickup this patch? It has fallen through the cracks.
Usually you tend to be picking up cgroup writeback stuff. Thanks!

								Honza

On Wed 12-04-23 17:31:03, Maxim Korotkov wrote:
> Hi,
> Will this patch be applied or rejected?
> best regards, Max
> 
> On 26.01.2023 16:52, Jan Kara wrote:
> > On Thu 19-01-23 13:44:43, Maxim Korotkov wrote:
> > >   the variable 'history' is of type u16, it may be an error
> > >   that the hweight32 macro was used for it
> > >   I guess macro hweight16 should be used
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > 
> > > Fixes: 2a81490811d0 ("writeback: implement foreign cgroup inode detection")
> > > Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
> > 
> > Looks good to me, although it is mostly a theoretical issue - I don't see
> > how hweight32 could do any harm here. Anyway, feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > 								Honza
> > 
> > > ---
> > >   fs/fs-writeback.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > > index 6fba5a52127b..fc16123b2405 100644
> > > --- a/fs/fs-writeback.c
> > > +++ b/fs/fs-writeback.c
> > > @@ -829,7 +829,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
> > >   		 * is okay.  The main goal is avoiding keeping an inode on
> > >   		 * the wrong wb for an extended period of time.
> > >   		 */
> > > -		if (hweight32(history) > WB_FRN_HIST_THR_SLOTS)
> > > +		if (hweight16(history) > WB_FRN_HIST_THR_SLOTS)
> > >   			inode_switch_wbs(inode, max_id);
> > >   	}
> > > -- 
> > > 2.37.2
> > > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
