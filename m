Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D6576E66D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 13:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjHCLLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 07:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjHCLLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:11:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2993C30
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 04:10:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9CB2421996;
        Thu,  3 Aug 2023 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691061022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yc3a5LoywkaUHdHoAsQOA2AQsLjX/79Lk7JxX0gqMLs=;
        b=SdnES3XuNN6dv6ok7TpNqKxuHQUtWX6gK53giin3O5yQTUMF7lavYBS6eL+4Z1eg2O/r6p
        NYVpI4KN8IR/BdGW903uJE5a0ie4dJ0Gdo8yP0lhVZtAjBeLcLcfYD9iGB4qOmQX3qpBvb
        uMpTA6a62HNgbQfNpK6WXKG7mXexpUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691061022;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yc3a5LoywkaUHdHoAsQOA2AQsLjX/79Lk7JxX0gqMLs=;
        b=f4jXc1bM6SgUKS+I+X8a1As3HFFjRprAmWqgzRR4HrwLmq4hBJbra5cTE5k9xsC8qZtX//
        DcZItJOrXbn/YfAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EE32134B0;
        Thu,  3 Aug 2023 11:10:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CS7QIh6Ly2QnKQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 11:10:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EB744A076B; Thu,  3 Aug 2023 13:10:21 +0200 (CEST)
Date:   Thu, 3 Aug 2023 13:10:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Carlos Maiolino <cem@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org
Subject: Re: [bug report] shmem: quota support
Message-ID: <20230803111021.ge3asfgvc3nl4uml@quack3>
References: <kU3N4tqbYA3gHO6AXf5TbwIkfbkKFI9NaCK_39Uj4qC6YJKXa_j98uqXcegkmzc8Nxj8L3rD_UWv_x6y0RGv1Q==@protonmail.internalid>
 <ffd7ca34-7f2a-44ee-b05d-b54d920ce076@moroto.mountain>
 <20230802142225.of27saigrzotlmza@andromeda>
 <1858133-56ab-fafb-7230-a7b0b66694ed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1858133-56ab-fafb-7230-a7b0b66694ed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-08-23 17:00:49, Hugh Dickins wrote:
> On Wed, 2 Aug 2023, Carlos Maiolino wrote:
> > On Wed, Aug 02, 2023 at 09:53:54AM +0300, Dan Carpenter wrote:
> > > Hello Carlos Maiolino,
> > > 
> > > The patch 9a9f8f590f6d: "shmem: quota support" from Jul 25, 2023
> > > (linux-next), leads to the following Smatch static checker warning:
> > > 
> > > 	fs/quota/dquot.c:1271 flush_warnings()
> > > 	warn: sleeping in atomic context
> > > 
> > 
> > Thanks for the report Dan!
> > 
> > > fs/quota/dquot.c
> > >     1261 static void flush_warnings(struct dquot_warn *warn)
> > >     1262 {
> > >     1263         int i;
> > >     1264
> > >     1265         for (i = 0; i < MAXQUOTAS; i++) {
> > >     1266                 if (warn[i].w_type == QUOTA_NL_NOWARN)
> > >     1267                         continue;
> > >     1268 #ifdef CONFIG_PRINT_QUOTA_WARNING
> > >     1269                 print_warning(&warn[i]);
> > >     1270 #endif
> > > --> 1271                 quota_send_warning(warn[i].w_dq_id,
> > >     1272                                    warn[i].w_sb->s_dev, warn[i].w_type);
> > > 
> > > The quota_send_warning() function does GFP_NOFS allocations, which don't
> > > touch the fs but can still sleep.  GFP_ATOMIC or GFP_NOWAIT don't sleep.
> > > 
> > 
> > Hmm, tbh I think the simplest way to fix it is indeed change GFP_NOFS to
> > GFP_NOWAIT when calling genlmsg_new(), quota_send_warnings() already abstain to
> > pass any error back to its caller, I don't think moving it from GFP_NOFS ->
> > GFP_NOWAIT will have much impact here as the amount of memory required for it is
> > not that big and wouldn't fail unless free memory is really short. I might be
> > wrong though.
> > 
> > If not that, another option would be to swap tmpfs spinlocks for mutexes, but I
> > would rather avoid that.
> > 
> > CC'ing other folks for more suggestions.
> 
> This is certainly a problem, for both dquot_alloc and dquot_free paths.
> Thank you, Dan, for catching it.
> 
> GFP_NOWAIT is an invitation to flakiness: I don't think it's right to
> regress existing quota users by changing GFP_NOFS to GFP_NOWAIT in all
> cases there; but it does seem a sensible stopgap for the new experimental
> user tmpfs.

So passing gfp argument to quota_send_warning() and propagating the
blocking info through __dquot_alloc_space() and __dquot_free_space() flags
would be OK for me *but* if CONFIG_PRINT_QUOTA_WARNING is set (which is
deprecated but still exists), we end up calling tty_write_message() out of
flush_warnings() and that can definitely block.

So if we are looking for unintrusive stopgap solution, maybe tmpfs can just
tell quota code to not issue warnings at all by using
__dquot_alloc_space() without DQUOT_SPACE_WARN flag and add support for
this flag to __dquot_free_space()? The feature is not used too much AFAIK
anyway. And once we move dquot calls into places where they can sleep, we
can reenable the warning support.

> I think the thing to do, for now, is to add a flag (DQUOT_SPACE_WARN_NOWAIT?)
> which gets passed down to the __dquot_alloc and __dquot_free for tmpfs,
> and those choose GFP_NOFS or GFP_NOWAIT accordingly, and pass that gfp_t
> on down to flush_warnings() to quota_send_warning() to genlmsg_new() and
> genlmsg_multicast().  Carlos, if you agree, please try that.
> 
> I have no experience with netlink whatsoever: I hope that will be enough
> to stop it from blocking.

Yes, if you pass non-blocking gfp mode to netlink code, it takes care not
to block when allocating and sending the message.
 
> I did toy with the idea of passing back the dquot_warn, and letting the
> caller do the flush_warnings() at a more suitable moment; and that might
> work out, but I suspect that the rearrangement involved would be better
> directed to just rearranging where mm/shmem.c makes it dquot_alloc and
> dquot_free calls.

Yeah, frankly I think this is the best fix. AFAIU the problem is only with
shmem_recalc_inode() getting called under info->lock which looks managable
as far as I'm looking at the call sites and relatively easy wrt quotas as
freeing of quota space cannot fail. At least all shmem_inode_acct_blocks()
calls seem to be in places where they can sleep.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
