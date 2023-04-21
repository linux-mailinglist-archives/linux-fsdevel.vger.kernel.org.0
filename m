Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA5E6EA891
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 12:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjDUKrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 06:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjDUKrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:47:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FACAF16
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 03:47:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 03B051FDDC;
        Fri, 21 Apr 2023 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682074064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4pkvpqYpTTTdKct/ljbjhP6YZDlGJ88YB/YoGZSHrjc=;
        b=EIevZDxKnimoOkGUE8AIspOXO/Fio2rzzBm5JoSLeAdYQspUlWpOsmY2GcO+z4BlERJ0wU
        IZH29iyzI4Wn3Uz0bdGmuVTLcnwNCWZ5P66HinNVCAj8PoBnHmo0ddtJk9jnk/7VpnZjnP
        QeXvTuBIsz/GaIqjWnqaFAg5elnsUeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682074064;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4pkvpqYpTTTdKct/ljbjhP6YZDlGJ88YB/YoGZSHrjc=;
        b=vk9eI6VEAY7psJx40HGRRAAxyZUofgDsBSb8dLYs0I3SDMoQleT/OqTrMJZdIpxbEWleD9
        47Xc7HabF+mvqdAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDEF11390E;
        Fri, 21 Apr 2023 10:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QsgmNs9pQmRRewAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 21 Apr 2023 10:47:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 74811A0729; Fri, 21 Apr 2023 12:47:43 +0200 (CEST)
Date:   Fri, 21 Apr 2023 12:47:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Carlos Maiolino <cem@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 6/6] Add default quota limit mount options
Message-ID: <20230421104743.ieehvkcjw3vxy3qe@quack3>
References: <20230420080359.2551150-1-cem@kernel.org>
 <20230420080359.2551150-7-cem@kernel.org>
 <Zjm4wD22Q8NU2h4KOvWzcfoANWK18DShrsWE6MIUq-AMEA0cOzxvzyFZNiFM-rePmqKt1loq92zJaZBw1YJFwA==@protonmail.internalid>
 <20230420143954.asmpkta4tknyzcda@quack3>
 <20230421102042.re3mij2avpvyilek@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421102042.re3mij2avpvyilek@andromeda>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 21-04-23 12:20:42, Carlos Maiolino wrote:
> On Thu, Apr 20, 2023 at 04:39:54PM +0200, Jan Kara wrote:
> > On Thu 20-04-23 10:03:59, cem@kernel.org wrote:
> > > @@ -3714,6 +3723,50 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
> > >  		ctx->seen |= SHMEM_SEEN_QUOTA;
> > >  		ctx->quota_types |= QTYPE_MASK_GRP;
> > >  		break;
> > > +	case Opt_usrquota_block_hardlimit:
> > > +		size = memparse(param->string, &rest);
> > > +		if (*rest || !size)
> > > +			goto bad_value;
> > > +		if (size > SHMEM_QUOTA_MAX_SPC_LIMIT)
> > > +			return invalfc(fc,
> > > +				       "User quota block hardlimit too large.");
> > > +		ctx->qlimits.usrquota_bhardlimit = size;
> > > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > > +		ctx->quota_types |= QTYPE_MASK_USR;
> > 
> > So if I get it right, the intention here is that if
> > usrquota_block_hardlimit=value option is used, it automatically enables
> > user quota accounting and enforcement. I guess it is logical but it is not
> > documented and I'd prefer to require explicit usrquota mount option to
> > enable accounting & enforcement - it is then e.g. easier to parse mount
> > options (in userspace) for finding out whether enforcement is enabled or
> > not.
> 
> Hmmm, I think I see what you mean. I can make usrquota_block_hardlimit options
> to not actually set the quota flag on quota_types, so this should be explicitly
> set by usrquota/grpquota options. Does that work for you?

Yes, works for me!

> > Also I can imagine we would allow changing the default limits on
> > remount but it isn't easy to enable quota accounting on remount etc.
> > 
> 
> hmm, yes, maybe enabling default limits to be changed on remount isn't a big
> deal, once the quota is already enabled, so everything is already in place.

Exactly. I don't say you have to do it now as I don't think that is super
useful. But if there's a demand we can easily do it.

> > > diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> > > index c0b531e2ef688..3cc53f2c35e2c 100644
> > > --- a/mm/shmem_quota.c
> > > +++ b/mm/shmem_quota.c
> > > @@ -166,6 +166,7 @@ static int shmem_acquire_dquot(struct dquot *dquot)
> > >  {
> > >  	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> > >  	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
> > > +	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
> > >  	struct rb_node *parent = NULL, *new_node = NULL;
> > >  	struct quota_id *new_entry, *entry;
> > >  	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> > > @@ -195,6 +196,14 @@ static int shmem_acquire_dquot(struct dquot *dquot)
> > >  	}
> > >
> > >  	new_entry->id = id;
> > > +	if (dquot->dq_id.type == USRQUOTA) {
> > > +		new_entry->bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
> > > +		new_entry->ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;
> > > +	} else if (dquot->dq_id.type == GRPQUOTA) {
> > > +		new_entry->bhardlimit = sbinfo->qlimits.grpquota_bhardlimit;
> > > +		new_entry->ihardlimit = sbinfo->qlimits.grpquota_ihardlimit;
> > > +	}
> > > +
> > >  	new_node = &new_entry->node;
> > >  	rb_link_node(new_node, parent, n);
> > >  	rb_insert_color(new_node, (struct rb_root *)info->dqi_priv);
> > 
> > Maybe in shmem_dquot_release() when usage is 0 and limits are at default
> > limits, we can free the structure?
> 
> hmmm, which struct are you talking about? quota_id? As we do for DQ_FAKE?

Yes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
