Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B2779FC6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjING7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 02:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjING67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:58:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3CFCD8;
        Wed, 13 Sep 2023 23:58:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DF4F1F74A;
        Thu, 14 Sep 2023 06:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694674734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7q48jtCBMGEZ5OKO+Z/fS2sy4IWYeVg+HSunn4WKPQ=;
        b=sGXajjx8Ei20o1HBZchoVJsXyBKgREy5z1/sPz6FnkqZp3HtFm0XJXC+adjreHN4i/Aaty
        cX7yp0J0ltH7OkVnkwqaI4jLwm2hr4YVoUOkAfMaRuYL2wzhxxSAVAOiiXDAAneWtVSbAB
        CQzX7ksz+6UX32bTGIsCDmg0Y7CwauQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694674734;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7q48jtCBMGEZ5OKO+Z/fS2sy4IWYeVg+HSunn4WKPQ=;
        b=W/z5EcJSOhmW6iwyyWIGwsd4x6jOgHTYp7vQhPBs9PktK4ckHALyl1/sxYNZPzA08gxekA
        Ot36dJsEX8reXFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F8A7139DB;
        Thu, 14 Sep 2023 06:58:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4f+kBy6vAmVLegAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 14 Sep 2023 06:58:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A6B70A07C2; Thu, 14 Sep 2023 08:58:53 +0200 (CEST)
Date:   Thu, 14 Sep 2023 08:58:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     =?utf-8?B?6YOt57qv5rW3?= <guochunhai@vivo.com>
Cc:     Jan Kara <jack@suse.cz>, "chao@kernel.org" <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGZzLXdyaXRlYmFjazogd3JpdGVi?=
 =?utf-8?Q?ack=5Fsb=5Finodes?= =?utf-8?Q?=3A?= Do not increase 'total_wrote'
 when nothing is written
Message-ID: <20230914065853.qmvkymchyamx43k5@quack3>
References: <20230913131501.478516-1-guochunhai@vivo.com>
 <20230913151651.gzmyjvqwan3euhwi@quack3>
 <TY2PR06MB3342ED6EB614563BCC4FD23FBEF7A@TY2PR06MB3342.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY2PR06MB3342ED6EB614563BCC4FD23FBEF7A@TY2PR06MB3342.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-09-23 04:12:31, 郭纯海 wrote:
> > On Wed 13-09-23 07:15:01, Chunhai Guo wrote:
> > > From the dump info, there are only two pages as shown below. One is
> > > updated and another is under writeback. Maybe f2fs counts the
> > > writeback page as a dirty one, so get_dirty_pages() got one. As you
> > > said, maybe this is unreasonable.
> > >
> > > Jaegeuk & Chao, what do you think of this?
> > >
> > >
> > > crash_32> files -p 0xE5A44678
> > >  INODE    NRPAGES
> > > e5a44678        2
> > >
> > >   PAGE    PHYSICAL   MAPPING    INDEX CNT FLAGS
> > > e8d0e338  641de000  e5a44810         0  5 a095
> > locked,waiters,uptodate,lru,private,writeback
> > > e8ad59a0  54528000  e5a44810         1  2 2036
> > referenced,uptodate,lru,active,private
> > 
> > Indeed, incrementing pages_skipped when there's no dirty page is a bit odd.
> > That being said we could also harden requeue_inode() - in particular we could do
> > there:
> > 
> >         if (wbc->pages_skipped) {
> >                 /*
> >                  * Writeback is not making progress due to locked buffers.
> >                  * Skip this inode for now. Although having skipped pages
> >                  * is odd for clean inodes, it can happen for some
> >                  * filesystems so handle that gracefully.
> >                  */
> >                 if (inode->i_state & I_DIRTY_ALL)
> >                         redirty_tail_locked(inode, wb);
> >                 else
> >                         inode_cgwb_move_to_attached(inode, wb);
> >         }
> > 
> > Does this fix your problem as well?
> > 
> >                                                                 Honza
> 
> Thank you for your reply. Did you forget the 'return' statement? Since I encountered this issue on the 4.19 kernel and there is not inode_cgwb_move_to_attached() yet, I replaced it with inode_io_list_del_locked(). So, below is the test patch I am applying. Please have a check. By the way, the test will take some time. I will provide feedback when it is finished. Thanks.

Yeah, I forgot about the return.

> 	if (wbc->pages_skipped) {
> 		/*
> 		 * writeback is not making progress due to locked
> 		 * buffers. Skip this inode for now.
> 		 */
> -		redirty_tail_locked(inode, wb);
> +		if (inode->i_state & I_DIRTY_ALL)
> +			redirty_tail_locked(inode, wb);
> +		else
> +			inode_io_list_del_locked(inode, wb);
>  		return;
>  	}

Looks good. Thanks for testing!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
