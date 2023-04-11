Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25E56DDB94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 15:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjDKND6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDKNDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:03:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6CD4C3A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 06:03:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C0D8219C4;
        Tue, 11 Apr 2023 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681218199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31Pc6Essa9yT1G1gaEpHoNq4CDQyULlkkDcBOL12Aa4=;
        b=3Cb6UsDgbhD10DnTCgm6+v7mqFpCDe9QQYDSYB1i/WOWYrIW5c/Bl64orBwuFgWeGujBLA
        9v+9Btv3rBxkLBAc4mWWfg5qeOGn/09x4dFI1j2s9QXZm7dtQoawqUT7oc0g+Y4PLa3+/a
        qUTGmBCbHhbi/5N7ZJ7llfRbpDQf6Ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681218199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31Pc6Essa9yT1G1gaEpHoNq4CDQyULlkkDcBOL12Aa4=;
        b=tQ/gsVMYtF5WMCtbbZfbhyR0EBjY41mUkkzvwXaiW16Bma+rguj3lZILdwOdGgU3V7eINa
        GfRZwvdiaBZ7N0CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BE9D13638;
        Tue, 11 Apr 2023 13:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8KHIBpdaNWRyJwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 11 Apr 2023 13:03:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8FB10A0732; Tue, 11 Apr 2023 15:03:18 +0200 (CEST)
Date:   Tue, 11 Apr 2023 15:03:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Carlos Maiolino <cem@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 5/6] shmem: quota support
Message-ID: <20230411130318.vp4yiywllys2xy7h@quack3>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-6-cem@kernel.org>
 <HeUy_Hsb2zCT7bosvDzr4zBwFgRu_HmprljMKVUH5O3vqwnUW5xvtvGDLP6ztcP94xBXvaFIO7m5kgN0ri1Tcw==@protonmail.internalid>
 <20230405114245.nnzorjm5nlr4l4g6@quack3>
 <20230411093726.ry3e6espmocvwq6f@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411093726.ry3e6espmocvwq6f@andromeda>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 11-04-23 11:37:26, Carlos Maiolino wrote:
> On Wed, Apr 05, 2023 at 01:42:45PM +0200, Jan Kara wrote:
> > > @@ -3763,6 +3878,9 @@ static void shmem_put_super(struct super_block *sb)
> > >  {
> > >  	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
> > >
> > > +#ifdef CONFIG_TMPFS_QUOTA
> > > +	shmem_disable_quotas(sb);
> > > +#endif
> > >  	free_percpu(sbinfo->ino_batch);
> > >  	percpu_counter_destroy(&sbinfo->used_blocks);
> > >  	mpol_put(sbinfo->mpol);
> > > @@ -3841,6 +3959,17 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
> > >  #endif
> > >  	uuid_gen(&sb->s_uuid);
> > >
> > > +#ifdef CONFIG_TMPFS_QUOTA
> > > +	if (ctx->seen & SHMEM_SEEN_QUOTA) {
> > > +		sb->dq_op = &shmem_quota_operations;
> > > +		sb->s_qcop = &dquot_quotactl_sysfile_ops;
> > > +		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
> > 
> > s_quota_types should rather be copied from ctx, shouldn't it? Or why is
> > s_quota_types inconsistent with ctx->quota_types?
> 
> I believe s_qupta_types here is a bitmask of supported quota types, while
> ctx->quota_types refers to the mount options being passed from the user.
> 
> So we should enable in sb->s_quota_types which quota types the filesystem
> supports, not which were enabled by the user.

Oh, right.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
