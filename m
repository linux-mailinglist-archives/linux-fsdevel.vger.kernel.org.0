Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C106A6C8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 13:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCAMpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 07:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCAMpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:45:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288DE3B3C7;
        Wed,  1 Mar 2023 04:45:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D5AC01FE14;
        Wed,  1 Mar 2023 12:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677674706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8u/TFj2VjsuomX+EL4UF0htWY0lZS8tv6pZM1Zu/bL0=;
        b=begXH1dQ7zKqSl1FXj1j8wl3l+1XvuMEeo1yZDAUm0fQirlxq1PEHHJUHcyV+P8fw43UKZ
        XiNLG14WQErfJMauPwloKEBTrXx1gjnrWIMeGmORAYbuZBk3jppduz+R3pr/RYLp79c4Fk
        dIWLm2ds1qqhJ+4mSJVzcSeGhoYu6F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677674706;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8u/TFj2VjsuomX+EL4UF0htWY0lZS8tv6pZM1Zu/bL0=;
        b=QvU83tMMBI0GVx9uQQTeJUixJtzBYVKcMHTg5xcP2bpM+jc389D+lXsSBbvLuAfHBOHTr2
        4OWAbna32NQsI3AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3A2613A63;
        Wed,  1 Mar 2023 12:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WFO/L9JI/2PKegAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 12:45:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1D0D0A06E5; Wed,  1 Mar 2023 13:45:06 +0100 (CET)
Date:   Wed, 1 Mar 2023 13:45:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Palash Oswal <oswalpalash@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: KASAN: use-after-free Read in inode_cgwb_move_to_attached
Message-ID: <20230301124506.4a7tuvlptyzkbpm3@quack3>
References: <CAGyP=7fWFjioc7ok0SZ7kBNh6_MAk1keL4BKPvUNdmpGjnsZOA@mail.gmail.com>
 <20230228124556.riiwwskbrh7lxogt@quack3>
 <CAGyP=7f5mtWWhXF58-HaEmq=3Pba1EU83KKxwVXCe8tv9cARZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGyP=7f5mtWWhXF58-HaEmq=3Pba1EU83KKxwVXCe8tv9cARZQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 28-02-23 22:33:32, Palash Oswal wrote:
> On Tue, Feb 28, 2023 at 4:45 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 21-02-23 21:09:23, Palash Oswal wrote:
> > > Hello,
> > > I found the following issue using syzkaller on:
> > > HEAD commit : e60276b8c11ab4a8be23807bc67b04
> > > 8cfb937dfa (v6.0.8)
> > > git tree: stable
> > >
> > > C Reproducer : https://gist.github.com/oswalpalash/bed0eba75def3cdd34a285428e9bcdc4
> > > Kernel .config :
> > > https://gist.github.com/oswalpalash/0962c70d774e5ec736a047bba917cecb
> > >
> > > Console log :
> > >
> > > ==================================================================
> > > BUG: KASAN: use-after-free in __list_del_entry_valid+0xf2/0x110
> > > Read of size 8 at addr ffff8880273c4358 by task syz-executor.1/6475
> >
> > OK, so FAT inode was on writeback list (through inode->i_io_list) when
> > being freed. This should be fixed by commit 4e3c51f4e805 ("fs: do not
> > update freeing inode i_io_list"). Can you check please?
> >
> >                                                                 Honza
> >
> 
> I have verified that the commit fixes the bug. Tested against v6.0.11
> on the stable tree.

Thanks for testing!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
