Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ADE6EAA67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjDUMeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 08:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjDUMeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C90E53
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 05:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E46A64FA3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 12:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC6CC433EF;
        Fri, 21 Apr 2023 12:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682080452;
        bh=dga946Vepdsucpib1+Glr81GFaUTdbLG8Bi6ScDe4AY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQqZg2GTAinua+owig+UtrJA/FKBo1ElJAOoFumWoQzBrbWlVtgHvvAn6ZGJdQuo7
         txafkmE068ErUUClnxY5s7FZaszkCvXhxxo/KkO6BxMMGdyDhh3pV0Is8K1RWFX5K8
         Qx38FQm9LdQIIfA3MB0dUo1B3cfBNkC838OHH5KNdBzGxecp53DekM7FBXXXPS391z
         CL/ekfrjIDu80aaEJz478cwbp27a9hb7ZKIGsbEK0OlBcP4nRf/JjgqqP3kl9FOBdA
         ZGwK6HuJqjcVmcj4IdAJtMzWA0r1fBtOBqx6jrvhduRmHb645kUwl+VVoTVYuhxCVe
         o211objNRUG8g==
Date:   Fri, 21 Apr 2023 14:34:07 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 6/6] Add default quota limit mount options
Message-ID: <20230421123407.yqkety2r7ijkchvf@andromeda>
References: <20230420080359.2551150-1-cem@kernel.org>
 <20230420080359.2551150-7-cem@kernel.org>
 <Zjm4wD22Q8NU2h4KOvWzcfoANWK18DShrsWE6MIUq-AMEA0cOzxvzyFZNiFM-rePmqKt1loq92zJaZBw1YJFwA==@protonmail.internalid>
 <20230420143954.asmpkta4tknyzcda@quack3>
 <20230421102042.re3mij2avpvyilek@andromeda>
 <RY7vIJyTAdlxd_KyQWlwUF4FvwfnDTOCxNr79kbMIS6AYg_pnVWcGiRar3CrV9a8m39Yv0-OOfPcQMoSVj8YeQ==@protonmail.internalid>
 <20230421104743.ieehvkcjw3vxy3qe@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421104743.ieehvkcjw3vxy3qe@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 12:47:43PM +0200, Jan Kara wrote:
> On Fri 21-04-23 12:20:42, Carlos Maiolino wrote:
> > On Thu, Apr 20, 2023 at 04:39:54PM +0200, Jan Kara wrote:
> > > On Thu 20-04-23 10:03:59, cem@kernel.org wrote:
> > > > @@ -3714,6 +3723,50 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
> > > >  		ctx->seen |= SHMEM_SEEN_QUOTA;
> > > >  		ctx->quota_types |= QTYPE_MASK_GRP;
> > > >  		break;
> > > > +	case Opt_usrquota_block_hardlimit:
> > > > +		size = memparse(param->string, &rest);
> > > > +		if (*rest || !size)
> > > > +			goto bad_value;
> > > > +		if (size > SHMEM_QUOTA_MAX_SPC_LIMIT)
> > > > +			return invalfc(fc,
> > > > +				       "User quota block hardlimit too large.");
> > > > +		ctx->qlimits.usrquota_bhardlimit = size;
> > > > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > > > +		ctx->quota_types |= QTYPE_MASK_USR;
> > >
> > > So if I get it right, the intention here is that if
> > > usrquota_block_hardlimit=value option is used, it automatically enables
> > > user quota accounting and enforcement. I guess it is logical but it is not
> > > documented and I'd prefer to require explicit usrquota mount option to
> > > enable accounting & enforcement - it is then e.g. easier to parse mount
> > > options (in userspace) for finding out whether enforcement is enabled or
> > > not.
> >
> > Hmmm, I think I see what you mean. I can make usrquota_block_hardlimit options
> > to not actually set the quota flag on quota_types, so this should be explicitly
> > set by usrquota/grpquota options. Does that work for you?
> 
> Yes, works for me!

Great!
> 
> > > Also I can imagine we would allow changing the default limits on
> > > remount but it isn't easy to enable quota accounting on remount etc.
> > >
> >
> > hmm, yes, maybe enabling default limits to be changed on remount isn't a big
> > deal, once the quota is already enabled, so everything is already in place.
> 
> Exactly. I don't say you have to do it now as I don't think that is super
> useful. But if there's a demand we can easily do it.

Sounds good :) If you don't mind, I'd postpone it, as I am planning to add
prjquotas to it later, I can add it to the same series, just to avoid adding
more review overhead to this one.


> 
> > > > diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> > > > index c0b531e2ef688..3cc53f2c35e2c 100644
> > > > --- a/mm/shmem_quota.c
> > > > +++ b/mm/shmem_quota.c
> > > > @@ -166,6 +166,7 @@ static int shmem_acquire_dquot(struct dquot *dquot)
> > > >  {
> > > >  	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> > > >  	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
> > > > +	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
> > > >  	struct rb_node *parent = NULL, *new_node = NULL;
> > > >  	struct quota_id *new_entry, *entry;
> > > >  	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> > > > @@ -195,6 +196,14 @@ static int shmem_acquire_dquot(struct dquot *dquot)
> > > >  	}
> > > >
> > > >  	new_entry->id = id;
> > > > +	if (dquot->dq_id.type == USRQUOTA) {
> > > > +		new_entry->bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
> > > > +		new_entry->ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;
> > > > +	} else if (dquot->dq_id.type == GRPQUOTA) {
> > > > +		new_entry->bhardlimit = sbinfo->qlimits.grpquota_bhardlimit;
> > > > +		new_entry->ihardlimit = sbinfo->qlimits.grpquota_ihardlimit;
> > > > +	}
> > > > +
> > > >  	new_node = &new_entry->node;
> > > >  	rb_link_node(new_node, parent, n);
> > > >  	rb_insert_color(new_node, (struct rb_root *)info->dqi_priv);
> > >
> > > Maybe in shmem_dquot_release() when usage is 0 and limits are at default
> > > limits, we can free the structure?
> >
> > hmmm, which struct are you talking about? quota_id? As we do for DQ_FAKE?
> 
> Yes.
> 
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Carlos Maiolino
