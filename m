Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D118786CCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 12:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbjHXK3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 06:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240783AbjHXK2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:28:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A811991;
        Thu, 24 Aug 2023 03:28:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 107BB20FD8;
        Thu, 24 Aug 2023 10:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692872918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jedpz3oxE8a0uFpj7PYxqDrhCXPcolWbfz2tog52GEQ=;
        b=oXH3cgrhlrDy6G3jDRDca73fUlFE5JtvUP1uV9oL7Imy5Btp06Smi3EV4/jlGo2UA2SH4c
        a3W7KN1kBePgnzaGGq+OwH5ueAaYiPGBbvJafgcGn1wCY/HOIazVf2h6vhgT2jR3ODDHzZ
        7kBAfzoKMA0xBiQKJeV6bNAAnInpKdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692872918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jedpz3oxE8a0uFpj7PYxqDrhCXPcolWbfz2tog52GEQ=;
        b=StyB7aSEBEfxF6IwhN1KWSZFXCSM0zOdvXWRKq0RWW2o3NYfBfGLzbPO8sTJnens2A5ZxR
        WK8lnl+JK1Xa3gAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01A391336F;
        Thu, 24 Aug 2023 10:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pMZTANYw52QSNQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 24 Aug 2023 10:28:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8DE6AA0774; Thu, 24 Aug 2023 12:28:37 +0200 (CEST)
Date:   Thu, 24 Aug 2023 12:28:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 28/29] xfs: Convert to bdev_open_by_path()
Message-ID: <20230824102837.credhh3fsco6vf7p@quack3>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-28-jack@suse.cz>
 <ZOaEHrkx1xS9bgk9@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOaEHrkx1xS9bgk9@dread.disaster.area>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 24-08-23 08:11:42, Dave Chinner wrote:
> On Wed, Aug 23, 2023 at 12:48:39PM +0200, Jan Kara wrote:
> > Convert xfs to use bdev_open_by_path() and pass the handle around.
> ....
> 
> > @@ -426,15 +427,15 @@ xfs_shutdown_devices(
> >  	 * race, everyone loses.
> >  	 */
> >  	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
> > -		blkdev_issue_flush(mp->m_logdev_targp->bt_bdev);
> > -		invalidate_bdev(mp->m_logdev_targp->bt_bdev);
> > +		blkdev_issue_flush(mp->m_logdev_targp->bt_bdev_handle->bdev);
> > +		invalidate_bdev(mp->m_logdev_targp->bt_bdev_handle->bdev);
> >  	}
> >  	if (mp->m_rtdev_targp) {
> > -		blkdev_issue_flush(mp->m_rtdev_targp->bt_bdev);
> > -		invalidate_bdev(mp->m_rtdev_targp->bt_bdev);
> > +		blkdev_issue_flush(mp->m_rtdev_targp->bt_bdev_handle->bdev);
> > +		invalidate_bdev(mp->m_rtdev_targp->bt_bdev_handle->bdev);
> >  	}
> > -	blkdev_issue_flush(mp->m_ddev_targp->bt_bdev);
> > -	invalidate_bdev(mp->m_ddev_targp->bt_bdev);
> > +	blkdev_issue_flush(mp->m_ddev_targp->bt_bdev_handle->bdev);
> > +	invalidate_bdev(mp->m_ddev_targp->bt_bdev_handle->bdev);
> >  }
> 
> Why do these need to be converted to run through bt_bdev_handle?  If
> the buftarg is present and we've assigned targp->bt_bdev_handle
> during the call to xfs_alloc_buftarg(), then we've assigned
> targp->bt_bdev from the handle at the same time, yes?

Good point, these conversions are pointless now so I've removed them. They
are leftover from a previous version based on a kernel where xfs was
dropping bdev references in a different place. Thanks for noticing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
