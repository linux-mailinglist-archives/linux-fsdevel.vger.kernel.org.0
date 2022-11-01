Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09E1615110
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 18:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiKARvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 13:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKARvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:51:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F1D1C43D;
        Tue,  1 Nov 2022 10:51:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 77152336C4;
        Tue,  1 Nov 2022 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667325105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Hu2igDpV58FWOpyGjErjvDHZCw49fVJ+gWTy+xKV5E=;
        b=y9wYpip6Of0LxO5D0ICCZcxW5C4TSGGzJYTFjb+bKg3sU2k05k4D+/01EPPXlczTaEBRmB
        fbmiQ/N6jqun7+cAPgU8IAkRAhiPgew7XKrAjURzfU3Lu1w2crWuvxtj9JjG7w5lOm5dNy
        t+qapKKxG0oDUt/1dtxQO3ahJmGqKG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667325105;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Hu2igDpV58FWOpyGjErjvDHZCw49fVJ+gWTy+xKV5E=;
        b=XhaNawLrRjMwML6jyojoDCga85WxaVolsa3sEPqf0UcePwfe2kmdA2uIEP5avYx0+Eb2P0
        Dmgclk6xu5T1aGCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 531561346F;
        Tue,  1 Nov 2022 17:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vH08FLFcYWMHIwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 01 Nov 2022 17:51:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3EC20A0700; Tue,  1 Nov 2022 18:51:44 +0100 (CET)
Date:   Tue, 1 Nov 2022 18:51:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 0/3] fsnotify: fix softlockups iterating over d_subdirs
Message-ID: <20221101175144.yu3l5qo5gfwfpatt@quack3>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Stephen!

On Thu 27-10-22 17:10:13, Stephen Brennan wrote:
> Here is v3 of the patch series. I've taken all of the feedback,
> thanks Amir, Christian, Hilf, et al. Differences are noted in each
> patch.
> 
> I caught an obvious and silly dentry reference leak: d_find_any_alias()
> returns a reference, which I never called dput() on. With that change, I
> no longer see the rpc_pipefs issue, but I do think I need more testing
> and thinking through the third patch. Al, I'd love your feedback on that
> one especially.
> 
> Thanks,
> Stephen
> 
> Stephen Brennan (3):
>   fsnotify: Use d_find_any_alias to get dentry associated with inode
>   fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
>   fsnotify: allow sleepable child flag update

Thanks for the patches Stephen and I'm sorry for replying somewhat late.
The first patch is a nobrainer. The other two patches ... complicate things
somewhat more complicated than I'd like. I guess I can live with them if we
don't find a better solution but I'd like to discuss a bit more about
alternatives.

So what would happen if we just clear DCACHE_FSNOTIFY_PARENT_WATCHED in
__fsnotify_parent() for the dentry which triggered the event and does not
have watched parent anymore and never bother with full children walk? I
suppose your contention problems will be gone, we'll just pay the price of
dget_parent() + fsnotify_inode_watches_children() for each child that
falsely triggers instead of for only one. Maybe that's not too bad? After
all any event upto this moment triggered this overhead as well...

Am I missing something? AFAIU this would allow us to avoid the games with
the new connector flag etc... We would probably still need to avoid
softlockups when setting the flag DCACHE_FSNOTIFY_PARENT_WATCHED but that
should be much simpler (we could use i_rwsem trick like you do).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
