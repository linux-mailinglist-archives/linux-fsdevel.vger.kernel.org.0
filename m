Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4858D79D5D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 18:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjILQKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 12:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjILQJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:09:44 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559A71721
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 09:09:40 -0700 (PDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-573c84224easo7684955a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 09:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534980; x=1695139780;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AARlkl615ZUGGLFRfA9oVBXF7htkT9kJFgokf8340Ec=;
        b=aywDidKMuuRlLmkf+U9m4UH+Cbc8GM4WggdMGdZ8ZZqJhQRQuQpEXGKiYgx5E1qNn0
         5mcZjBiW2cJ+GRSeHrNouJulQSc/V92GJOzlBpexFj+7AHrcgqjIpkh2HQLkFoM+uwQp
         50ojnvHjtJj6nUKuxh/oNV0bVqDgB/ltvt/y5gUxZagXJ5krLsNdYE7+kCvNubJ98pqN
         neZWZlrfQ52ZD5sBDaH1RVMCoqbEw9Du8E9BoZUR6RCmdEuNDhlHfVhicJIoVjrrHVEh
         4zCSwNxAkK6LA8Up3lBFwUOCgEZC5SF1RF+y2gt6htdPuOZboLAduuUNR+bNdeFz/Ata
         U4Nw==
X-Gm-Message-State: AOJu0YwVh8cOWxALptGn13nlVWyrNTSdANLwvL7PCUZ8c/tUAs2dxC2p
        BnVNvHpJNIHHg9XTufFErcu18H5mjUBBSqb0z6+QwRXMvSgi
X-Google-Smtp-Source: AGHT+IGmbnURw9iUYORzpx4zYzKhO+uYCyE7mL3DVcRhUXuaET8MI50eU927MgZ+N8oEvTnRJI6eHK1KQne2J49J5nuKknxf1Mkr
MIME-Version: 1.0
X-Received: by 2002:a63:3409:0:b0:563:e937:5e87 with SMTP id
 b9-20020a633409000000b00563e9375e87mr2908645pga.5.1694534979875; Tue, 12 Sep
 2023 09:09:39 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:09:39 -0700
In-Reply-To: <00000000000019e05005ef9c1481@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088fbf106052bab18@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: stack-out-of-bounds Read in xfs_buf_delwri_submit_buffers
From:   syzbot <syzbot+d2cdeba65d32ed1d2c4d@syzkaller.appspotmail.com>
To:     chandan.babu@oracle.com, davem@davemloft.net, djwong@kernel.org,
        hdanton@sina.com, jiri@nvidia.com, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d772781964415c63759572b917e21c4f7ec08d9f
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Jan 6 06:33:54 2023 +0000

    devlink: bump the instance index directly when iterating

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15554ba4680000
start commit:   3ecc37918c80 Merge tag 'media/v6.1-4' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=d2cdeba65d32ed1d2c4d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170a950b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1625948f880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: devlink: bump the instance index directly when iterating

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
