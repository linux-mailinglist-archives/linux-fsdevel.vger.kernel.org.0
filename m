Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101BA764589
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 07:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjG0FeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 01:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjG0FeF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:34:05 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFD62D68
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 22:33:39 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9ef9b1c66so1098286a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 22:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436008; x=1691040808;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACCQJS1yNDOg9N72wtfvjjkCfEbgk/h272KX1jaBuI8=;
        b=K3IMj4F1bT5kZ+O9aumlPxYElhwLNBw5flJktBjT2gZ/TZaUyh1cKeI6YRlaTnFo+4
         gAzEEm4VgBbz+OBANEpChwO+RKQYxzd1IpmxqtDjPBmPvg5ot5LM4/wrkBz6OZ4WKrRW
         uINDaCKJrXFdjlFAodT1xzGDzJCnE1DM0YQbQwlPX/htKsfwbz0cKmI7aYhJiqHG8D3O
         Z1Haq92qIz2KL/hJk7UAga9hwK+Raf6evzTFDGnSLc/H/pDU0PFG+XoNvlxc9/iJPV5b
         i2ucsl5WX63GtY0rQPMcjgViRCmxKRAnNAP3kXTkC39Zh5RObn/tE/L+1bRNOrlzF85f
         xIBQ==
X-Gm-Message-State: ABy/qLaHXKUcAY8TeM8oo4v7CsBqEyHPgy7V1DkH3mpwBBJC83CyHvqm
        i+86sdW6fQWM1o21aNjK6TLFUnyjWKzXSurD+1v8xN/QKE/K
X-Google-Smtp-Source: APBJJlERGUD5LQ82IZmIMYfnXRXSirkzOqmaKhkhvfCMNRb7PUbXIrlMigrCCdB5aZywpNhcqkm81YBBEkCGhS8uEJq5ZEnxHL8q
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1043:b0:6ba:169f:f425 with SMTP id
 b3-20020a056830104300b006ba169ff425mr6494875otp.2.1690436008287; Wed, 26 Jul
 2023 22:33:28 -0700 (PDT)
Date:   Wed, 26 Jul 2023 22:33:28 -0700
In-Reply-To: <000000000000a0d7f305eecfcbb9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca24700601714dd2@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in path_openat
From:   syzbot <syzbot+be8872fcb764bf9fea73@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, bp@alien8.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, yazen.ghannam@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 00e4feb8c0476bbde3c8bf4a593e0f82ca9a4df6
Author: Yazen Ghannam <yazen.ghannam@amd.com>
Date:   Fri Jan 27 17:04:03 2023 +0000

    EDAC/amd64: Rename debug_display_dimm_sizes()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157a6f81a80000
start commit:   c1649ec55708 Merge tag 'nfsd-6.2-4' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=319a3509d25b0f85
dashboard link: https://syzkaller.appspot.com/bug?extid=be8872fcb764bf9fea73
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c604fe480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: EDAC/amd64: Rename debug_display_dimm_sizes()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
