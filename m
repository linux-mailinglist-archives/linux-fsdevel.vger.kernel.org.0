Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD12772FB2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 12:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjFNKhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 06:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjFNKg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:36:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3C2B5;
        Wed, 14 Jun 2023 03:36:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB09322493;
        Wed, 14 Jun 2023 10:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686739014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFuunLuk/KGPgOZE70zqAYLnO7a/eDeyuBJEDejMyac=;
        b=RAyFpTYpW6tCEvx75rYKbFCiIUGWbm2HXHnx5MhUkbHEkfb5MkArgvn1tnoWFQuKMstQ2I
        PBSMWyyIyShG9i//UBHQMZDt6emgx+2ksCO97cwEKt4p1dpg4bnGV/3NagbYMtkLs3zThg
        HwNd3KbsTgYBHZ0X471sCm7frRqm6WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686739014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFuunLuk/KGPgOZE70zqAYLnO7a/eDeyuBJEDejMyac=;
        b=zqYS6atnPsqDHm9nC/oXo7/uQvjlA5j6TWQLxZPps1LAstmr2Ck8XzzguQXfkQ1CFJQBLB
        Ju5UxDbVwdsoW9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCCA01357F;
        Wed, 14 Jun 2023 10:36:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d0vdNUaYiWTCfQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Jun 2023 10:36:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 727D1A0755; Wed, 14 Jun 2023 12:36:54 +0200 (CEST)
Date:   Wed, 14 Jun 2023 12:36:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230614103654.ydiosiv6ptljwd7i@quack3>
References: <20230612161614.10302-1-jack@suse.cz>
 <ZIf6RrbeyZVXBRhm@infradead.org>
 <CACT4Y+ZsN3wemvGLVyNWj9zjykGwcHoy581w7GuAHGpAj1YLxg@mail.gmail.com>
 <ZIlphqM9cpruwU6m@infradead.org>
 <20230614-anstalt-gepfercht-affd490e6544@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614-anstalt-gepfercht-affd490e6544@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-06-23 10:18:16, Christian Brauner wrote:
> On Wed, Jun 14, 2023 at 12:17:26AM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 13, 2023 at 08:09:14AM +0200, Dmitry Vyukov wrote:
> > > I don't question there are use cases for the flag, but there are use
> > > cases for the config as well.
> > > 
> > > Some distros may want a guarantee that this does not happen as it
> > > compromises lockdown and kernel integrity (on par with unsigned module
> > > loading).
> > > For fuzzing systems it also may be hard to ensure fine-grained
> > > argument constraints, it's much easier and more reliable to prohibit
> > > it on config level.
> > 
> > I'm fine with a config option enforcing write blocking for any
> > BLK_OPEN_EXCL open.  Maybe the way to it is to:
> > 
> >  a) have an option to prevent any writes to exclusive openers, including
> >     a run-time version to enable it
> 
> I really would wish we don't make this runtime configurable. Build time
> and boot time yes but toggling it at runtime makes this already a lot
> less interesting.

I see your point from security POV. But if you are say a desktop (or even
server) user you may need to say resize your LVM or add partition to your
disk or install grub2 into boot sector of your partition. In all these
cases you need write access to a block device that is exclusively claimed
by someone else. Do you mandate reboot in permissive mode for all these
cases? Realistically that means such users just won't bother with the
feature and leave it disabled all the time. I'm OK with such outcome but I
wanted to point out this "no protection change after boot" policy noticably
restricts number of systems where this is applicable.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
