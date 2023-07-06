Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0312A74A246
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGFQgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 12:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGFQgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:36:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2291D1FC6;
        Thu,  6 Jul 2023 09:35:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BFAA21F85D;
        Thu,  6 Jul 2023 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688661356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PsVUq4b3rii/qzBSnj09xlS3Zu3xM5oAxCymz1PLAcI=;
        b=qQw2gPX/jTIYhsu1jUAA2RIbY+AVlAS7JCA0EXgPq6wCCeh2AHG126pv/LGKv5qqOnenGT
        YZMJhFW3sLdj2COMAwL9/Exm5KHwPxYbDOdLuQRpBPhfnCVN42JfFJJdU0sxDEgtx6Lj4H
        I4GawAUizK3WZ6sRa+6BudaqarEECnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688661356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PsVUq4b3rii/qzBSnj09xlS3Zu3xM5oAxCymz1PLAcI=;
        b=IyOmFAh/c3+KYD2WbcdOzi+DsugS7TrcFc/QQ1ClRai8e7FVCq0W6JcOTzhJDjzVSRsTVp
        DQLYZu4vcTJZisCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1643138FC;
        Thu,  6 Jul 2023 16:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xINHK2ztpmQ7NwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 16:35:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 48A27A0707; Thu,  6 Jul 2023 18:35:56 +0200 (CEST)
Date:   Thu, 6 Jul 2023 18:35:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 02/32] block: Use file->f_flags for determining exclusive
 opens in file_to_blk_mode()
Message-ID: <20230706163556.7ygts5dhfhgj53zl@quack3>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-2-jack@suse.cz>
 <ZKbfO5eFJ9hVueb/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKbfO5eFJ9hVueb/@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-07-23 08:35:23, Christoph Hellwig wrote:
> On Tue, Jul 04, 2023 at 02:21:29PM +0200, Jan Kara wrote:
> > Use file->f_flags instead of file->private_data for determining whether
> > we should set BLK_OPEN_EXCL flag. This allows us to remove somewhat
> > awkward setting of file->private_data before calling file_to_blk_mode()
> > and it also makes following conversion to blkdev_get_handle_by_dev()
> > simpler.
> 
> While this looks a lot nicer, I don't think it actually works given that
> do_dentry_open clears out O_EXCL, and thus it won't be set when
> calling into blkdev_ioctl.

Aha, good point! So I need to workaround this a bit differently. I think
the best would be to have file_to_blk_mode() for blkdev_open() only and
make the other places (which already have bdev_handle available from
struct file) use bdev_handle->mode. But I have to come up with a sane
transition to that state :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
