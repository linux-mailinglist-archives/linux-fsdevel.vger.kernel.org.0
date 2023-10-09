Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579D17BE675
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377218AbjJIQeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 12:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377228AbjJIQeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:34:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253ACB0;
        Mon,  9 Oct 2023 09:34:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A78D41F749;
        Mon,  9 Oct 2023 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696869239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dU9LM9aHBBqla57kFGIYFdLq6SSPhLiP4O9pk8Isu0Y=;
        b=kom7+S4bqA6OUl0guyXeDNw+lPXADEc3RvAKoXH7zyKsZdm+4gWqyuY7S/lOEznHbUN9Ph
        mzVep/CSCw+3PM074cb0A2CYdFfVip7aKJNGtUl0HFYHCYArLrlQcZaJNutjgiEMU5Srpr
        8K4wmHDbHW0RxHtg5dIe91g9Q9licV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696869239;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dU9LM9aHBBqla57kFGIYFdLq6SSPhLiP4O9pk8Isu0Y=;
        b=AbOzVvdvP48EGXJQMO/p4lERWhdZsR4wPNlER31nTj14Qnt3BwXvXVFRMUaiSgR8qwMC1D
        j5aI22RSELYgENCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 997BA13905;
        Mon,  9 Oct 2023 16:33:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iINmJXcrJGWXUwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Oct 2023 16:33:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DBCFEA04CB; Mon,  9 Oct 2023 18:33:53 +0200 (CEST)
Date:   Mon, 9 Oct 2023 18:33:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com
Subject: Re: [PATCH 4/4] reiserfs: fix journal device opening
Message-ID: <20231009163353.jh7ptcnyl3wd7xbd@quack3>
References: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
 <20231009-vfs-fixes-reiserfs-v1-4-723a2f1132ce@kernel.org>
 <20231009-sachfragen-kurativ-cb5af158d8ab@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-sachfragen-kurativ-cb5af158d8ab@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-10-23 18:16:45, Christian Brauner wrote:
> On Mon, Oct 09, 2023 at 02:33:41PM +0200, Christian Brauner wrote:
> > We can't open devices with s_umount held without risking deadlocks.
> > So drop s_umount and reacquire it when opening the journal device.
> > 
> > Reported-by: syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> 
> Groan, I added a dumb bug in here.

Which one? I went through the patch again but I still don't see it...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
