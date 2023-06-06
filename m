Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0869724556
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbjFFOKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 10:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbjFFOKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:10:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BED2E73;
        Tue,  6 Jun 2023 07:10:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 36367219C8;
        Tue,  6 Jun 2023 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686060611;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DnDPXhI3NugAUYZBm9igpPNqRsW/0UkHxLFDHiY2qPM=;
        b=SLJCEfKR4RsFxYJJacuSTrkx3tRmHsVqMMxqGc7hbFxXN0EQztQ7YZPL0OkMrYT5746tis
        UmY1poW2CjDoLehv4spCNVnaxULlIMUkQ0Mwbb7BJshjbl6u1O1WUZXzZxmHizLL82qwbF
        sPcjymrm23RgQ0tCy518DbfH4EWKC/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686060611;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DnDPXhI3NugAUYZBm9igpPNqRsW/0UkHxLFDHiY2qPM=;
        b=qXJrzo6/9NXQ3dA4jDQQ35sgK1KXkMgB1CbJ1wR8IPkPXmMDh6qRwjAuzaURqtPMmITs4n
        SdWROySz5NE1PXCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEA1A13519;
        Tue,  6 Jun 2023 14:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rcOQNUI+f2TocwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Jun 2023 14:10:10 +0000
Date:   Tue, 6 Jun 2023 16:03:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+afdee14f9fd3d20448e7@syzkaller.appspotmail.com>
Cc:     chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiaoshoukui@gmail.com,
        xiaoshoukui@ruijie.com.cn
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_ioctl_add_dev
Message-ID: <20230606140355.GG25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000002eb8105f51cfa96@google.com>
 <00000000000073fb7305fd730525@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000073fb7305fd730525@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 02:55:38AM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit ac868bc9d136cde6e3eb5de77019a63d57a540ff
> Author: xiaoshoukui <xiaoshoukui@gmail.com>
> Date:   Thu Apr 13 09:55:07 2023 +0000
> 
>     btrfs: fix assertion of exclop condition when starting balance
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bdc3a3280000
> start commit:   04a357b1f6f0 Merge tag 'mips_6.3_1' of git://git.kernel.or..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
> dashboard link: https://syzkaller.appspot.com/bug?extid=afdee14f9fd3d20448e7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f043b0c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d2ea9cc80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: fix assertion of exclop condition when starting balance
