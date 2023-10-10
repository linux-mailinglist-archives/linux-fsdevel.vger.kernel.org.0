Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC477BFBA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 14:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjJJMmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjJJMl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:41:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B45CA9;
        Tue, 10 Oct 2023 05:41:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8EDE1F6E6;
        Tue, 10 Oct 2023 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696941716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0pwsG/zAmRt+eyqpV9jl1kWUP1l3z7gh21JzbEhzESM=;
        b=EiJYiiH7GA1WrbbPpRe/c1AX8Xc3zUvTf6bk3OY7frH5aDbjVg29W1uT3MogT+DWfC+kuq
        aim6Dw+eS+gOXUGkhnTNCAwVcamXOYyVRHRzfFBZnbPrGmqG9Ot+Uz3kNnq83cMoQaBZQl
        OR3KEgqCb8sGYI7/7sd8ggWBJ4QX6cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696941716;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0pwsG/zAmRt+eyqpV9jl1kWUP1l3z7gh21JzbEhzESM=;
        b=S74DSRTmOUtRdAHL6gyawrdtccvqW5Xpiw7FcgjwKAFSA4I+g0dZwDMwPzTN87nX8S4WBW
        ZvvO6xo+J9LZygBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE6EE1348E;
        Tue, 10 Oct 2023 12:41:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ophZMpRGJWVCVAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 10 Oct 2023 12:41:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 61C41A061C; Tue, 10 Oct 2023 14:41:56 +0200 (CEST)
Date:   Tue, 10 Oct 2023 14:41:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, reiserfs-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com
Subject: Re: [PATCH 4/4] reiserfs: fix journal device opening
Message-ID: <20231010124156.fqy2ysppc7ickeed@quack3>
References: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
 <20231009-vfs-fixes-reiserfs-v1-4-723a2f1132ce@kernel.org>
 <20231009-sachfragen-kurativ-cb5af158d8ab@brauner>
 <20231009163353.jh7ptcnyl3wd7xbd@quack3>
 <CAHrFyr6sjz+MM4vAzwHKwasuQi=_dhGM+3JAJkp8A0Hu4gDtbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrFyr6sjz+MM4vAzwHKwasuQi=_dhGM+3JAJkp8A0Hu4gDtbg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 10-10-23 11:43:59, Christian Brauner wrote:
> On Mon, Oct 9, 2023, 18:34 Jan Kara <jack@suse.cz> wrote:
> 
> > On Mon 09-10-23 18:16:45, Christian Brauner wrote:
> > > On Mon, Oct 09, 2023 at 02:33:41PM +0200, Christian Brauner wrote:
> > > > We can't open devices with s_umount held without risking deadlocks.
> > > > So drop s_umount and reacquire it when opening the journal device.
> > > >
> > > > Reported-by: syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > >
> > > Groan, I added a dumb bug in here.
> >
> > Which one? I went through the patch again but I still don't see it...
> >
> 
> (Sorry, from phone.)
> 
> I'm dropping s_umount across a lot of work
> instead of just over device opening which is really the wrong way of doing
> this.
> I should just drop it over journal_dev_init().

So I was kind of suspecting that but I couldn't figure out how it would
exactly matter when SB_BORN still is not set...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
