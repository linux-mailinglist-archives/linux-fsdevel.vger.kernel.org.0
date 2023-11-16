Return-Path: <linux-fsdevel+bounces-2950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890527EDDFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 10:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B931F23FD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F9428E3E;
	Thu, 16 Nov 2023 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96C0196
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 01:51:10 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5abf640f19aso750417a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 01:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128269; x=1700733069;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiNHOjfzTCRSZhLxgg5CyThWc28KBQzyvt0Gk1pd2sA=;
        b=belkGussbSR1TGBTOJTLr5+5tq47sEwqaLUG57n097xgWC3W73d6jVm9GjhIXlMeul
         Mh8PFbsuZMpkWMkqSHExQC/2ckzgmGlxWziJwTtJN2xtKfwDC7JBzc+mCL52z9Eb1W58
         nApGzpSF24YWo2ArtPo8gMFfUUQCTOhgN2Id4vq9ePGmFXJY6H9dARKKzzneY19D86B+
         wvrqnvqG7W9BU2D1y7UCq70e2WY7X34OqO2aGkGUyhIhW2/2Bn2D50rA/mEFCurlIu83
         GFj5p00kArnhwUO7eogrgtZ3+eI8nrVCQ1g5WxP4NCCicoeNyiog+zbRY8SP1BNGLduL
         yydg==
X-Gm-Message-State: AOJu0Yx9JSaK3iE6T3EhZirLPucUQgnuqcVldF5E/EYjMQY8Lt4t+a2R
	612Wze9AzBDndBuv8T4+F+4sBrXguXtH6YpSrLBwAYuwyP1N
X-Google-Smtp-Source: AGHT+IGFkiPFsgApk8aUnzxiA3nQo2YGU1aJ7rbgvlaLBurc6k5+bkMItSzH20RLWujRkf0/mfiX8H+dDfidMqvoyI7pX9pP4ert
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:dd4a:0:b0:5c1:589d:b3e5 with SMTP id
 g10-20020a63dd4a000000b005c1589db3e5mr253325pgj.2.1700128269720; Thu, 16 Nov
 2023 01:51:09 -0800 (PST)
Date: Thu, 16 Nov 2023 01:51:09 -0800
In-Reply-To: <000000000000ae5995060a125650@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096e7d5060a41f594@google.com>
Subject: Re: [syzbot] [autofs?] general protection fault in autofs_fill_super
From: syzbot <syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com>
To: autofs@vger.kernel.org, billodo@redhat.com, bodonnel@redhat.com, 
	brauner@kernel.org, eadavis@qq.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, raven@themaw.net, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

syzbot has bisected this issue to:

commit e6ec453bd0f03a60a80f00f95ae2eaa260faa3c2
Author: Ian Kent <raven@themaw.net>
Date:   Fri Sep 22 04:12:14 2023 +0000

    autofs: convert autofs to use the new mount api

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d04220e80000
start commit:   4bbdb725a36b Merge tag 'iommu-updates-v6.7' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d04220e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d04220e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=662f87a8ef490f45fa64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14384a7b680000

Reported-by: syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
Fixes: e6ec453bd0f0 ("autofs: convert autofs to use the new mount api")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

