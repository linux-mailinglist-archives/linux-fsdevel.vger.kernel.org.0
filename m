Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E037A78DBC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbjH3Shi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbjH3Ji7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:38:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4C5137
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 02:38:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 715AD1F45F;
        Wed, 30 Aug 2023 09:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693388332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PIxQhlRFdNZswSMGee257L+GnW4woe/Nn9nub9+MKzw=;
        b=u3purBzD1lDBwNHBxD0L10YRsGqgTiDXKMf+uNIDtSbfzg2f1dExaGu0302JVjHEc6yn72
        gujaXasqwXCPLVMHXB6S9XbH8A6kHK6N+TEtJluiWcJqVQFdRNGhCGa99Px8/l4pE8i9+t
        lRtWvsBXvx4Kxa+rxjMkxVMbaBCfGAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693388332;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PIxQhlRFdNZswSMGee257L+GnW4woe/Nn9nub9+MKzw=;
        b=YRZdTIazvSq/KWONWEgag0o18Mp7C9iPMcHhhBOBJSSd34qqxaRCaRje2aLGNBArcZ1Ifb
        LGpGuD/TRBxzCqBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 606FB1353E;
        Wed, 30 Aug 2023 09:38:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +y+AFywO72QNJAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Aug 2023 09:38:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E8292A0774; Wed, 30 Aug 2023 11:38:51 +0200 (CEST)
Date:   Wed, 30 Aug 2023 11:38:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: export sget_dev()
Message-ID: <20230830093851.uwdgpt645niysuji@quack3>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
 <20230829-vfs-super-mtd-v1-1-fecb572e5df3@kernel.org>
 <20230830061409.GB17785@lst.de>
 <20230830-befanden-geahndet-2f084125d861@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-befanden-geahndet-2f084125d861@brauner>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-08-23 10:05:57, Christian Brauner wrote:
> On Wed, Aug 30, 2023 at 08:14:09AM +0200, Christoph Hellwig wrote:
> > > +struct super_block *sget_dev(struct fs_context *fc, dev_t dev)
> > 
> > A kerneldoc comment would probably be useful here.
> 
> Added the following in-treep:
> 
> diff --git a/fs/super.c b/fs/super.c
> index 158e093f23c9..19fa906b118a 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1388,6 +1388,26 @@ static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
>                 s->s_dev == *(dev_t *)fc->sget_key;
>  }
> 
> +/**
> + * sget_dev - Find or create a superblock by device number
> + * @fc:        Filesystem context.
> + * @dev: device number
      ^^^^^^ inconsistent indenting.

> + *
> + * Find or create a superblock using the provided device number that
> + * will be stored in fc->sget_key.
> + *
> + * If an extant superblock is matched, then that will be returned with
> + * an elevated reference count that the caller must transfer or discard.
> + *
> + * If no match is made, a new superblock will be allocated and basic
> + * initialisation will be performed (s_type, s_fs_info and s_id will be
> + * set and the set() callback will be invoked), the superblock will be
      ^^ I guess no point in talking about set() callback when sget_dev()
has no callback specified. Rather you could mention s_dev as one of
initialized fields.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
