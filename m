Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B731722603
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjFEMgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjFEMg3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:36:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA71B6;
        Mon,  5 Jun 2023 05:36:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53E101F8B4;
        Mon,  5 Jun 2023 12:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685968565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDPQJSax2y1DgqRa020Su1AOhWpgOXbpRl/eNtbLm/U=;
        b=BnGESfhS5Uoh/nHZqR9YuTwAnw/vc25GK/VO71E5qsjPPVhRP1DwitnTOzn8izvfiQGj2X
        6v87plSWQLpyvmQ0xQzzhpnpGfd2PLGDpP2AXb5X7OZT2uOF1cSyhUGjf9APFalaL507LO
        6WGghS6QH0Ddt16lV0p+2wJLJrbkRGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685968565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDPQJSax2y1DgqRa020Su1AOhWpgOXbpRl/eNtbLm/U=;
        b=+JrFbW8MAz/F6iiHD4iP8Zs7ueFtOq7RjUNJH+W93QIWOpqAFEiKw8tAkvxL09Jii8gm+0
        9YOWKbTwsIir78DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 365F5139C8;
        Mon,  5 Jun 2023 12:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f48+DbXWfWRMFQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 05 Jun 2023 12:36:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A9A2FA0754; Mon,  5 Jun 2023 14:36:04 +0200 (CEST)
Date:   Mon, 5 Jun 2023 14:36:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.cz>, Jeff Mahoney <jeffm@suse.com>
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in flush_old_commits
Message-ID: <20230605123604.7juo5siuooy2dip2@quack3>
References: <000000000000be039005fc540ed7@google.com>
 <00000000000018faf905fc6d9056@google.com>
 <CAHC9VhTM0a7jnhxpCyonepcfWbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com>
 <813148798c14a49cbdf0f500fbbbab154929e6ed.camel@huaweicloud.com>
 <CAHC9VhRoj3muyD0+pTwpJvCdmzz25C8k8eufWcjc8ZE4e2AOew@mail.gmail.com>
 <58cebdd9318bd4435df6c0cf45318abd3db0fff8.camel@huaweicloud.com>
 <20230530112147.spvyjl7b4ss7re47@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230530112147.spvyjl7b4ss7re47@quack3>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 30-05-23 13:21:47, Jan Kara wrote:
> On Fri 26-05-23 11:45:57, Roberto Sassu wrote:
> > On Wed, 2023-05-24 at 17:57 -0400, Paul Moore wrote:
> > > On Wed, May 24, 2023 at 11:50 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Wed, 2023-05-24 at 11:11 -0400, Paul Moore wrote:
> > > > > On Wed, May 24, 2023 at 5:59 AM syzbot
> > > > > <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com> wrote:
> > > > > > syzbot has bisected this issue to:
> > > > > > 
> > > > > > commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> > > > > > Author: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > Date:   Fri Mar 31 12:32:18 2023 +0000
> > > > > > 
> > > > > >     reiserfs: Add security prefix to xattr name in reiserfs_security_write()
> > > > > > 
> > > > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c39639280000
> > > > > > start commit:   421ca22e3138 Merge tag 'nfs-for-6.4-2' of git://git.linux-..
> > > > > > git tree:       upstream
> > > > > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=13c39639280000
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15c39639280000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8067683055e3f5
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0a684c061589dcc30e51
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14312791280000
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12da8605280000
> > > > > > 
> > > > > > Reported-by: syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com
> > > > > > Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")
> > > > > > 
> > > > > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > > > > 
> > > > > Roberto, I think we need to resolve this somehow.  As I mentioned
> > > > > earlier, I don't believe this to be a fault in your patch, rather that
> > > > > patch simply triggered a situation that had not been present before,
> > > > > likely because the reiserfs code always failed when writing LSM
> > > > > xattrs.  Regardless, we still need to fix the deadlocks that sysbot
> > > > > has been reporting.
> > > > 
> > > > Hi Paul
> > > > 
> > > > ok, I will try.
> > > 
> > > Thanks Roberto.  If it gets to be too challenging, let us know and we
> > > can look into safely disabling the LSM xattrs for reiserfs, I'll be
> > > shocked if anyone is successfully using LSM xattrs on reiserfs.
> > 
> > Ok, at least I know what happens...
> > 
> > + Jan, Jeff
> > 
> > I'm focusing on this reproducer, which works 100% of the times:
> > 
> > https://syzkaller.appspot.com/text?tag=ReproSyz&x=163079f9280000
> 
> Well, the commit d82dcd9e21b ("reiserfs: Add security prefix to xattr name
> in reiserfs_security_write()") looks obviously broken to me. It does:
> 
> char xattr_name[XATTR_NAME_MAX + 1] = XATTR_SECURITY_PREFIX;
> 
> Which is not how we can initialize strings in C... ;)

I'm growing old or what but indeed string assignment in initializers in C
works fine. It is only the assignment in code that would be problematic.
I'm sorry for the noise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
