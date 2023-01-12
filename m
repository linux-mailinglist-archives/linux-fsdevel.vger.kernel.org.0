Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A3A667214
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjALMZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 07:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjALMZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:25:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9254018E27
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 04:25:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8BDF3F9CF;
        Thu, 12 Jan 2023 12:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673526324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r72XN/10geinoldklZuXjEtjLUeoG/A9stUTTV5GsEo=;
        b=abcR6X3vYCwSbp7rSvAPrAGOr4I8/BeTH/+mTPXT8GZuvoridYEW0OKZVJ7eojuiUlUaxm
        9YG0dqeXHxvwoIelzRSTWjrfiVn9fLfrcHMEOPCmCQeBwzobbkYBBSeIRWb3F6ZvafMK/X
        XfJYoCmpfKWLP/mx2ShjI9IOxqc99HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673526324;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r72XN/10geinoldklZuXjEtjLUeoG/A9stUTTV5GsEo=;
        b=jobfLSg1+CX5tzuIN2hjOkyfw5Md8FMOgU/xsa9Gw45osHbPkn3u3WeZRBn2FgNKmHrTbK
        GVvIfb2VosBz8QBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C85F913585;
        Thu, 12 Jan 2023 12:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SS3fMDT8v2MiRQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 12 Jan 2023 12:25:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EDE0FA0744; Thu, 12 Jan 2023 13:25:23 +0100 (CET)
Date:   Thu, 12 Jan 2023 13:25:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Josef Bacik <josef@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/3] Shut down frozen filesystems on last unmount
Message-ID: <20230112122523.gyuletgmmwg667fn@quack3>
References: <20221129230736.3462830-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129230736.3462830-1-agruenba@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andreas!

On Wed 30-11-22 00:07:32, Andreas Gruenbacher wrote:
> currently, when a frozen filesystem is unmouted, it turns into a zombie
> rather than being shut down; it can only be shut down after remounting
> and thawing it.  That's silly for local filesystems, but it's worse for
> filesystems like gfs2 which freeze the filesystem on all nodes when
> fsfreeze is called on any of the nodes: there, the nodes that didn't
> initiate the freeze cannot shut down the filesystem at all.

I agree this situation is suboptimal ;)

> This is a non-working, first shot at allowing filesystems to shut down
> on the last unmount.  Could you please have a look to let me know if
> something like this makes sense?

So I had a look at the patches and I have to admit I'm not a huge fan of
this approach. For example if there's a utility doing disk image copy and
the filesystem gets unmounted, it could result in an inconsistent copy
AFAICT. Not for GFS2 as you argue but it seems a bit dangerous to provide
API that makes it easy to screw up. Also I dislike the fact that different
filesystem would behave differently wrt umount & freezing. Why cannot we
just block unmount when the filesystem is frozen like any other write
operation? I understand locking-wise it is a bit challenging because we
have to block in a place where we don't hold s_umount semaphore but
logically it would make sense to me. What do you think?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
