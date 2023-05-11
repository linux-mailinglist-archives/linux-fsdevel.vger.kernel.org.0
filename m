Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDA36FEB9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 08:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbjEKGPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 02:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbjEKGP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 02:15:29 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE4B421A
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 23:15:27 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-331663d8509so122246295ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 23:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683785726; x=1686377726;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLAHlnW18J3ayWajoJkbp6lkX65Y1Y64Dsrkn5HyXys=;
        b=KN587vdr/jJN9inVg3VZIs3Bv8fp9fsrom/StrI09Z2r3OlKCIQoVLVY5TzIeN4p5M
         IJ2DRlKv94A5NeTV1Q5/2WoU75+NWnIc47HbNdJBUwf4lw4PfAXFYS677D2+1AZNx1jO
         BbgqHxkJ4wB+cqJlIpVdc4EqqGCHOxHqx6eI+URru9TV8es0znbZjbDrlW5nvHji4K+d
         FqybQTI62z/lSlr+sfue57Do7x1fSH2CGSZkJL6fAaRXjy/Hz8XHsrLoXBkuiYteT4s6
         MkhlyRNEMftOwagabe16UDYH0TisISVhiAZq8wAoh4p6buWNH/CFwN8ranngTTdqmtp6
         H1Cw==
X-Gm-Message-State: AC+VfDwejA9HfP7iwmGChLJ1qzO85p7zD01vSwie+seSAyaQ5Zqmkebe
        MWM80PbVbMn1vnVPARU9cYuE25t0WhzDTkw+7M5ZvvrUBpZ5
X-Google-Smtp-Source: ACHHUZ6yvxzia8K5bqOIRLxJYZeu6ltxVUJ+CKrR6EbTo4IyZ9g273GGCZ7A663uAMysUgMSPPasigEBgavPCpj4W/XwVrtzz+X+
MIME-Version: 1.0
X-Received: by 2002:a92:c9c6:0:b0:335:fef6:6b84 with SMTP id
 k6-20020a92c9c6000000b00335fef66b84mr345927ilq.1.1683785726767; Wed, 10 May
 2023 23:15:26 -0700 (PDT)
Date:   Wed, 10 May 2023 23:15:26 -0700
In-Reply-To: <0000000000009b5b5705fb5dfda0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f3bf005fb64ea0a@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in __ext4fs_dirhash
From:   syzbot <syzbot+344aaa8697ebd232bfc8@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 08dd966cfd2bef467acd1835ae10c32356037bc3
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sat May 6 15:59:13 2023 +0000

    ext4: improve error handling from ext4_dirhash()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15ecb2fa280000
start commit:   578215f3e21c Add linux-next specific files for 20230510
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17ecb2fa280000
console output: https://syzkaller.appspot.com/x/log.txt?x=13ecb2fa280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb5a64fc61c29c5f
dashboard link: https://syzkaller.appspot.com/bug?extid=344aaa8697ebd232bfc8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b80e32280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113f582a280000

Reported-by: syzbot+344aaa8697ebd232bfc8@syzkaller.appspotmail.com
Fixes: 08dd966cfd2b ("ext4: improve error handling from ext4_dirhash()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
