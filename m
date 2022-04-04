Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51B34F154C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348219AbiDDM5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiDDM5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:57:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F78C32993;
        Mon,  4 Apr 2022 05:55:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5D3321F383;
        Mon,  4 Apr 2022 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649076944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U3rOkje7vch6OHbrYJ0OvYxnuQPxmcNpHEJB0u8Qkeo=;
        b=jLQaNRdG16A4I7HlMjmhmGbqipWfw8HoPbj0sYe1zdA9gQzepbZjMvsXK+7FmWvZbiu0QM
        YkRsyF7Ka+ITBycmCNvjX2XwfXM1QOScSGvfPwLXMQ7kbeojDaXlobPbhkaH09VJgIkpHB
        X2SoBvm0OcyVOdywseln8APbAnX33lI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649076944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U3rOkje7vch6OHbrYJ0OvYxnuQPxmcNpHEJB0u8Qkeo=;
        b=/7j7eqSsuy1ByoK8OQCMIYmGxnK5Ari3ADITvwr5gVHr0e1ZTLuOlNo6P8+o2qIpBbS5cj
        4Ox1x3RhfBXigQAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0948DA3BA7;
        Mon,  4 Apr 2022 12:55:44 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0A42BA0615; Mon,  4 Apr 2022 14:55:41 +0200 (CEST)
Date:   Mon, 4 Apr 2022 14:55:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Pavel Machek <pavel@ucw.cz>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220404125541.tvcf3dwyfvxsnurz@quack3.lan>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
 <20220402105454.GA16346@amd>
 <20220404085535.g2qr4s7itfunlrqb@quack3.lan>
 <20220404100732.GB1476@duo.ucw.cz>
 <20220404101802.GB8279@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404101802.GB8279@1wt.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 04-04-22 12:18:02, Willy Tarreau wrote:
> Hi Pavel,
> 
> On Mon, Apr 04, 2022 at 12:07:32PM +0200, Pavel Machek wrote:
> > > Well, if someone uses Reiserfs they better either migrate to some other
> > > filesystem or start maintaining it. It is as simple as that because
> > > currently there's nobody willing to invest resources in it for quite a few
> > > years and so it is just a question of time before it starts eating people's
> > > data (probably it already does in some cornercases, as an example there are
> > > quite some syzbot reports for it)...
> > 
> > Yes people should migrate away from Reiserfs. I guess someone should
> > break the news to Arch Linux ARM people.
> > 
> > But I believe userbase is bigger than you think and it will not be
> > possible to remove reiserfs anytime soon.
> 
> I was about to say the opposite until I noticed that one of my main
> dev machine has its kernel git dir on it because it's an old FS from
> a previous instance of this machine before an upgrade and it turns out
> that this FS still had lots of available space to store git trees :-/

:)

> So maybe you're right and there are still a bit more than expected out
> there. However I really think that most users who still have one are in
> the same situation as I am, they're not aware of it. So aside big fat
> warnings at mount time (possibly with an extra delay), there's nothing
> that will make that situation change.
> 
> At the very least disabling it by default in Kconfig and in distros
> should be effective. I really don't think that there are still users
> who regularly update their system and who have it on their rootfs, but
> still having data on it, yes, possibly. The earlier they're warned,
> the better.

Yes, we start with a warning now. Say a year before we really do remove it,
my plan is to refuse to mount it unless you pass a "I really know what I'm
doing" mount option so that we make sure people who possibly missed a
warning until that moment are aware of the deprecation and still have an
easy path and some time to migrate.

Regarding distros, I know that SUSE (and likely RH) do not offer reiserfs
in their installers for quite some time, it is unsupported for the
enterprise offerings (so most if not all paying customers have migrated
away from it). The notice was in LWN, Slashdot, and perhaps other news
sites so perhaps other distro maintainers do notice sooner rather than
later. I can specifically try to reach to Arch Linux given Pavel's notice
to give them some early warning.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
