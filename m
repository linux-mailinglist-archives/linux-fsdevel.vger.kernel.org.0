Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10D8778382
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 00:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjHJWOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 18:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjHJWOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:14:39 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE89E273C
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 15:14:38 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bc84c4f043so19675625ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 15:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691705678; x=1692310478;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+iSfVQKiy94ihvevaPz7mdBT1Zd/e8n0em7o/WIjuQ0=;
        b=l9m2/TwsjBUewASC0iFwONzO6Bi0yYFjwt86vOQt9DYoO9DTV3HKjrYGOX+qmjCqad
         HOnWTtzL6GhAxsMIEZplabiqXTPt9F7tYtMc0kEVtCddERz7CrPQtdX1lRvPdPNA87aY
         BHtfuNf1ol7MRfU6vVb2sfObMQBPqp6lSle/OwUZI4H2VuNyHWLR74VBfTyv+Swe0E0U
         07xnkHQh5CQPwkoSH5cf+U9F7spGZgNqOK8HIVVY4Qvbx0N+HctLXvGWk6EB4p3wa+AO
         4nShiSg9na9ZmSOJcL5MS3Nz4zhJHUmxZEz8bAJVfljkoSBjcSZ8Hrp7iOlaIxnfsFrT
         sFQg==
X-Gm-Message-State: AOJu0Yy0I+bXNCGnQL4u603IHHQLjZZZLBYWwrMm3DgCST8Uh4LUI1wx
        CMbY/Q5sWfmC9smDaeIf8CcL4nv1G+y2JIR8i4RaXC9C6U6t
X-Google-Smtp-Source: AGHT+IHTzTABqpJVuLtnELQWEcoBDNkcI7acDmY68LAjTTfOxK2QXJmkSMtIbz4lbKeoczQf+GCJ8xGSG+P8VQnPmUL+jm88OSVl
MIME-Version: 1.0
X-Received: by 2002:a17:902:e748:b0:1bd:9c78:8042 with SMTP id
 p8-20020a170902e74800b001bd9c788042mr13632plf.11.1691705678229; Thu, 10 Aug
 2023 15:14:38 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:14:38 -0700
In-Reply-To: <00000000000040e14205ffbf333f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003f591060298ecc6@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in wnd_add_free_ext (2)
From:   syzbot <syzbot+5b2f934f08ab03d473ff@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this issue to:

commit 3880f2b816a7e4ca889b7e8a42e6c62c5706ed36
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Oct 25 15:31:28 2021 +0000

    fs/ntfs3: Fix fiemap + fix shrink file size (to remove preallocated space)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=168fd89ba80000
start commit:   f6a691685962 Merge tag '6.5-rc4-smb3-client-fix' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=158fd89ba80000
console output: https://syzkaller.appspot.com/x/log.txt?x=118fd89ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=5b2f934f08ab03d473ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f56679a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118b8eeda80000

Reported-by: syzbot+5b2f934f08ab03d473ff@syzkaller.appspotmail.com
Fixes: 3880f2b816a7 ("fs/ntfs3: Fix fiemap + fix shrink file size (to remove preallocated space)")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
