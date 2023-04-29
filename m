Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8F76F270F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 00:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjD2Wyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 18:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjD2Wyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 18:54:31 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CD01A2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 15:54:29 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-32acaf9eb6dso17268905ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 15:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682808869; x=1685400869;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIRWs04g8ZoJm6CieeH8gXHcikugX3NlQwgnDthdPx4=;
        b=BGtuYApvSevhora8+1f9/jA8YZmmTxJODHcghUqtZHe/hp26M498xhBi9RpJfl+VRI
         Q3dpZs3Psyt+nVY+Z97iApIJ4XnPCXzOUA6fsKdQfLHzij0H9/x1o9SXCj3HuRKXsJ3Q
         V8pugGa4vq29XayPhuZLEp9grNr/ZOlGph7Vxah7/N+yvSgf9yhAA81KpiPry9kicsPm
         g5K8bHI3KMNKRNOGg2wXmaks6x92TbtSgtlc5L2FKViE2uT7rD8Vz3CQATRfG0lTZDGl
         ImKk12JUQ8g6nl7btbN0hQM69idhL7k6fQwAquOwzlTOCXnebBw94TDA+8s2QKCaqfcA
         qZJw==
X-Gm-Message-State: AC+VfDz6XMzzy8L+kpsQNywjl00kPW6sP74fsdrEIREZU1m03J4mXEQP
        SR0BiXLNVtGULlHhoTIH/tescbYs/+xymDUpqAMaR+RvSZb7
X-Google-Smtp-Source: ACHHUZ6q6tCAObTqNYFe4Z3JPgMW55/a5SUlKQk4uTbKCrGAa2NrKDNpA9gPZsRW4lxFJkTX4gtvpVthncvAeVqUeKrgA4Q8lHgM
MIME-Version: 1.0
X-Received: by 2002:a92:c9cb:0:b0:32f:8970:2a66 with SMTP id
 k11-20020a92c9cb000000b0032f89702a66mr1248583ilq.4.1682808868929; Sat, 29 Apr
 2023 15:54:28 -0700 (PDT)
Date:   Sat, 29 Apr 2023 15:54:28 -0700
In-Reply-To: <000000000000e5ee7305f0f975e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db8c6605fa8178df@google.com>
Subject: Re: [syzbot] [net?] WARNING in print_bfs_bug (2)
From:   syzbot <syzbot+630f83b42d801d922b8b@syzkaller.appspotmail.com>
To:     broonie@kernel.org, davem@davemloft.net, edumazet@google.com,
        groeck@chromium.org, jiri@resnulli.us, kuba@kernel.org,
        linmq006@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        tzungbi@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 0a034d93ee929a9ea89f3fa5f1d8492435b9ee6e
Author: Miaoqian Lin <linmq006@gmail.com>
Date:   Fri Jun 3 13:10:43 2022 +0000

    ASoC: cros_ec_codec: Fix refcount leak in cros_ec_codec_platform_probe

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d40608280000
start commit:   042334a8d424 atlantic:hw_atl2:hw_atl2_utils_fw: Remove unn..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10340608280000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d40608280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7205cdba522fe4bc
dashboard link: https://syzkaller.appspot.com/bug?extid=630f83b42d801d922b8b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147328f8280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1665151c280000

Reported-by: syzbot+630f83b42d801d922b8b@syzkaller.appspotmail.com
Fixes: 0a034d93ee92 ("ASoC: cros_ec_codec: Fix refcount leak in cros_ec_codec_platform_probe")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
