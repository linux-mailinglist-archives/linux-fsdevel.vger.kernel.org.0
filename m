Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E167A7BC997
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 20:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjJGSrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 14:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJGSrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:47:31 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0671993
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Oct 2023 11:47:30 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-57b67c11f48so4191795eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Oct 2023 11:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696704449; x=1697309249;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSRQ8RwQuSP9B1eQWdhsCbagB5eHTgwqSyVUIKNXPzs=;
        b=cu55qtqmRbppcVBeuwTE5A8RUZs5i43CBqaPgxfhMF5GUEuijskPU6O+ZKWUxpcz0X
         PAniQ9kj/+tR24kW/c+qBqKI61N69VhKQLU8o9tdncHF4qD71+b0kW6WoCev2LpKdZB0
         8dUc2zXDCQxUKD4TC4HosO32+r8UtYL388V8e/lw+D1NexOKRMzoYns+zO/3oMqcK07g
         7/mQy8klFT5WzFV16enarUX3tYKc0sidA1BUFp9XHNYSg9ApUW8DcQAEz2kmILnYMMW8
         /49/KsXrIukNvnQfYWF5gA9FHytwEif1liCgoG2d5CqQux99tXGXHu3h/7fhzwIh7swt
         g89A==
X-Gm-Message-State: AOJu0YxnrJYDPB8b9+Vo2lcdez1uLwnA5EvrbSGZrX0b7XJeOxUkOPyO
        6TGopOX6InZ5xWQeLjn9DkBtkyFjqeu94mjE1R5jBCNLOkZi
X-Google-Smtp-Source: AGHT+IEx2EwcPHofqub4lXJasDwOlKl9757idsGDqcwwmj6GOMD4/awENtx2yU7O4k0qCX3txvrblVBgUXRKbZTqOl9TUrQagkzO
MIME-Version: 1.0
X-Received: by 2002:a05:6871:6a8f:b0:1e1:46c:9ae2 with SMTP id
 zf15-20020a0568716a8f00b001e1046c9ae2mr4598420oab.2.1696704449417; Sat, 07
 Oct 2023 11:47:29 -0700 (PDT)
Date:   Sat, 07 Oct 2023 11:47:29 -0700
In-Reply-To: <00000000000073500205eac39838@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff17f2060724c971@google.com>
Subject: Re: [syzbot] [exfat?] possible deadlock in exfat_get_block
From:   syzbot <syzbot+247e66a2c3ea756332c7@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
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

syzbot suspects this issue was fixed by commit:

commit ff84772fd45d486e4fc78c82e2f70ce5333543e6
Author: Sungjong Seo <sj1557.seo@samsung.com>
Date:   Fri Jul 14 08:43:54 2023 +0000

    exfat: release s_lock before calling dir_emit()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f6bef1680000
start commit:   5d0c230f1de8 Linux 6.5-rc4
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=27a4e50cc5856a15
dashboard link: https://syzkaller.appspot.com/bug?extid=247e66a2c3ea756332c7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12532d91a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105aae2ea80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: release s_lock before calling dir_emit()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
