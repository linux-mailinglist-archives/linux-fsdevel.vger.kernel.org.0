Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE06DF18D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDLKE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 06:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjDLKEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:04:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5657DAA
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 03:04:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E23922193C;
        Wed, 12 Apr 2023 10:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681293880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9hP3GMaKHdGssioYuhWSRo7DbghUDHqKiSPZCby+0q4=;
        b=ZxDnafhVm5A1aucDUQOgLo6ZwkePO9HTJBeNPHhDEHqQkVpyJJSy1FjyG9+prCq7d5QIwl
        xWMJI1LHj0vbfU7uKGHA+aYFBkEIzZsBUZxYky51HWYB89fNQEhjVBPmdVMnVvqG91IZbe
        hpRaEDn4AHXI+KUFetjmFyagLMO0b3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681293880;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9hP3GMaKHdGssioYuhWSRo7DbghUDHqKiSPZCby+0q4=;
        b=GUbcPYnkYERsoFCO4Ee54gkQAfma3CKtKzWAk1WVpR3/+w1gATnPm8mn959eLtt1QMSgMr
        Jw3V7WO6LWfV3mBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D52BC132C7;
        Wed, 12 Apr 2023 10:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WsUCNDiCNmRQDgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 12 Apr 2023 10:04:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4B1A4A0732; Wed, 12 Apr 2023 12:04:40 +0200 (CEST)
Date:   Wed, 12 Apr 2023 12:04:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Carlos Maiolino <cem@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 4/6] shmem: prepare shmem quota infrastructure
Message-ID: <20230412100440.pjgbqc6c44rq5ffj@quack3>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-5-cem@kernel.org>
 <4sn9HjMu80MnoBrnTf2T-G0QFQc9QOwiM7e6ahvv7dZ0N6lpoMY-NTul3DgbNZF08r69V6BuAQI1QcdSzdAFKQ==@protonmail.internalid>
 <20230404123442.kettrnpmumpzc2da@quack3>
 <20230404134836.blwy3mfhl3n2bfyj@andromeda>
 <20230412094432.p5x3sjolu7tbn5g7@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412094432.p5x3sjolu7tbn5g7@andromeda>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Carlos!

On Wed 12-04-23 11:44:32, Carlos Maiolino wrote:
> > > > +static int shmem_release_dquot(struct dquot *dquot)
> > > > +{
> > > > +	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> > > > +	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
> > > > +	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> > > > +	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
> > > > +	struct quota_id *entry = NULL;
> > > > +
> > > > +	mutex_lock(&dquot->dq_lock);
> > > > +	/* Check whether we are not racing with some other dqget() */
> > > > +	if (dquot_is_busy(dquot))
> > > > +		goto out_dqlock;
> > > > +
> > > > +	down_write(&dqopt->dqio_sem);
> > > > +	while (node) {
> > > > +		entry = rb_entry(node, struct quota_id, node);
> > > > +
> > > > +		if (id < entry->id)
> > > > +			node = node->rb_left;
> > > > +		else if (id > entry->id)
> > > > +			node = node->rb_right;
> > > > +		else
> > > > +			goto found;
> > > > +	}
> > > > +
> > > > +	up_write(&dqopt->dqio_sem);
> > > > +	mutex_unlock(&dquot->dq_lock);
> > > 
> > > We should report some kind of error here, shouldn't we? We do expect to
> > > have the quota_id allocated from shmem_acquire_dquot() and we will be
> > > possibly loosing set limits here.
> > > 
> 
> I've been looking into this today, and I'm not sure if there is any error we
> should be reporting here, as there isn't anything to really go wrong here. I was
> comparing it with other filesystems, and most of them uses dquot_release()
> return value, as a return value for .release_dquot. And on such cases, the error
> could be other than zero, if something failed while writing the dquot to disk.
> In the case here, we just write to the RB tree in memory, and it has already
> been allocated, so, I don't think there is any error we could be returning here.
> Does it sound right to you?

My point is that it should never happen that we don't find the entry in the
rbtree in shmem_release_dquot(). So we should rather WARN_ON_ONCE() and
bail or something like that, rather then silently return success. Not a big
deal but for initial debugging it might be useful.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
