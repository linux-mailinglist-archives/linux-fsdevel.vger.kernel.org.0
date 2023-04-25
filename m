Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FF66EE2D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjDYNWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjDYNWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:22:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A269F2D52
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 06:22:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD82121941;
        Tue, 25 Apr 2023 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682428918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z9Ct6m1F90AsrgQQ6lr+xNgx5dYzgpTa/d+gY39u8l4=;
        b=hwKQuGvyhUjffrLWjzFWKZ+d0mJ4kw7oq/SRNjMV2mzwg8BFQ6+VDPbm3lB3IHlK0CWnuC
        263rA6NvyBeEa+UhR7g7iRtrFgbcDoh2+9xn6xNriFOVv3EkzTp+rznVKTjjnjxZwuGYKs
        Y7WrtMCd3QdqX2EXO6E0oNWuLOw0918=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682428918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z9Ct6m1F90AsrgQQ6lr+xNgx5dYzgpTa/d+gY39u8l4=;
        b=odSorB+Jgw90gPNFVz2kvE5DqxEaKnBuabuW4NRuj+CCE1569SewCW2lrrneJF34LI8hmo
        qB4+HJx8yhCuArDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEE4713466;
        Tue, 25 Apr 2023 13:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Iq+mKvbTR2QVEwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 25 Apr 2023 13:21:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 523D4A0729; Tue, 25 Apr 2023 15:21:54 +0200 (CEST)
Date:   Tue, 25 Apr 2023 15:21:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Carlos Maiolino <cem@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH V3 6/6] Add default quota limit mount options
Message-ID: <20230425132154.nxaxyyhwupelmma5@quack3>
References: <20230420080359.2551150-7-cem@kernel.org>
 <20230425115725.2913656-1-cem@kernel.org>
 <TKImHxraRSMubDtoPH1UEQ_fhD7pIJaiCnH3Am2xGlnJsjVV3h1sAxBQuF_M17myRFCD5e1n8bMFL_4ro5w_uw==@protonmail.internalid>
 <20230425123042.ja6oab6yhtzqnwyl@quack3>
 <20230425125610.xjbkxlozfvio2ihh@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425125610.xjbkxlozfvio2ihh@andromeda>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-04-23 14:56:10, Carlos Maiolino wrote:
> On Tue, Apr 25, 2023 at 02:30:42PM +0200, Jan Kara wrote:
> > On Tue 25-04-23 13:57:25, cem@kernel.org wrote:
> > > From: Lukas Czerner <lczerner@redhat.com>
> > >
> > > Allow system administrator to set default global quota limits at tmpfs
> > > mount time.
> > >
> > > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ...
> > > @@ -224,6 +233,29 @@ static int shmem_acquire_dquot(struct dquot *dquot)
> > >  	return ret;
> > >  }
> > >
> > > +static bool shmem_is_empty_dquot(struct dquot *dquot)
> > > +{
> > > +	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
> > > +	qsize_t bhardlimit;
> > > +	qsize_t ihardlimit;
> > > +
> > > +	if (dquot->dq_id.type == USRQUOTA) {
> > > +		bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
> > > +		ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;
> > > +	} else if (dquot->dq_id.type == GRPQUOTA) {
> > > +		bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
> > > +		ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;
> > 
> > There should be grpquota in the above two lines. Otherwise the patch looks
> > good to me.
> 
> Uff, sorry, copy/paste mistake. Can I add your RwB once I fix it? Or do you want
> me to send a V4?

Yes, once fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
