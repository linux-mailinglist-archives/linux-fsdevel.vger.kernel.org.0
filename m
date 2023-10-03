Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A61B7B6022
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 06:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbjJCE4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 00:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJCE4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:56:37 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13528DD
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 21:56:34 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ae4cefe17dso808244b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 21:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696308993; x=1696913793;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfrUWOBmU6zzAiZBESX6DIbmzW9eMSUX6mzf04Ler6k=;
        b=rSJeQjzL4cpXkjEMBj76svmpvJCH8wtobdCv4GjpvMnpdyCjKyNov0cx6QlGCoRQ0b
         h5jvmWMgW5V22ERk6nXeg1+KKwRcJPmp+22IH2VbUrFMUqVrkkJo9CCa36f/azqBqGOl
         qSLYnNVGgxJx5D130PaNSDqE/8a+fnPFj9nDl14mer/sq+bH5NCn2w57NJ6YR1YOT6MY
         PxfGHrPQeGAwhvTF+e9pb1OAsitxWtlmJInExoiNxjpIG/xqFEBI5hhomLiEIF3nRkqm
         Ev2jMGex2P3tbrZd6JVUqjEy/EfyRTSGhrrtPh1nsjSIiYs7VZr8JDy3x8Ngkw7lYNeD
         +P+Q==
X-Gm-Message-State: AOJu0Yw8rInLr0a+OXXrE6jATAPHtwSu3WcSKHf3BTSQkjfS84LVXAJz
        OugYPjj3/kTTnJVPDLHZCwSUjyHjpMwoR4KdB1qVxkGaT4sh
X-Google-Smtp-Source: AGHT+IEbktwgravybWHUhcjDg2HPO0fZM9+laAEhvFerNy1UOSXTCbPCj1YqCLbR/KpGxOSSpO2R8d6JaZU/dh4DnHuTyvkCO+Z9
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2219:b0:3ac:ab4f:ef3 with SMTP id
 bd25-20020a056808221900b003acab4f0ef3mr7223567oib.6.1696308993424; Mon, 02
 Oct 2023 21:56:33 -0700 (PDT)
Date:   Mon, 02 Oct 2023 21:56:33 -0700
In-Reply-To: <00000000000056dad80606c447e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb84850606c8b688@google.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_encode_real_fh
From:   syzbot <syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 16aac5ad1fa94894b798dd522c5c3a6a0628d7f0
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Sun Apr 23 16:02:04 2023 +0000

    ovl: support encoding non-decodable file handles

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11972062680000
start commit:   8a749fd1a872 Linux 6.6-rc4
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13972062680000
console output: https://syzkaller.appspot.com/x/log.txt?x=15972062680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57da1ac039c4c78a
dashboard link: https://syzkaller.appspot.com/bug?extid=2208f82282740c1c8915
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14877eb2680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b701f6680000

Reported-by: syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com
Fixes: 16aac5ad1fa9 ("ovl: support encoding non-decodable file handles")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
