Return-Path: <linux-fsdevel+bounces-809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D94E7D093C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 09:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2BB1F23AA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61843D2E4;
	Fri, 20 Oct 2023 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB741D260
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 07:10:40 +0000 (UTC)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49E21AE
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 00:10:38 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ccf7049ed4so718134a34.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 00:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697785838; x=1698390638;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWL0rNLl5jF/ivasCRcew47fQzuvd0OIJz60/b6FZdY=;
        b=U+8+7x17X7zzF1rVD0vBxzG7lerHmQBcjIaVn8JJmkRNqjwHucMULiF51Pj+e1Pj99
         7oNBmtWcGkgbW5e6YhJGg+zcPYycOyp4Ctcc213bnPMAmm4em8d6WJ5P5lJ8s17cp3Mp
         MdVdtxgBXN6fHY2sf9qgxw8B9mtEhGN3QndMQ3WeKs6vs91IvRd3Rqc9rHm25m96TFSH
         FEvWXpIm3/IcJx6ApW2X+Q6EBsHZoIisXZ7JNj7RpQSmcbvZTp1e+m7EiKJPCMHCuUPj
         pYw/jpRe8G5lrXKfsYwyGSdiNXyldjT7ZHwFEAi+Kdofzk8r6gjok5OJNPGAn10Z6kyb
         82nQ==
X-Gm-Message-State: AOJu0YxGG3alWBkza4HBdvyIXIVh73+U6jyo9t38xT522NJ0/FR+ugzS
	jpw0tiouxxW/bJLCuLAvGgXD2z0Jl/ICJrzGqGO5GkLFJm5Y
X-Google-Smtp-Source: AGHT+IGTxmGob7Dc/DPgC3p4zZRvObLuhFsv4iCL/svsCC2b2UrLxyCog5rpqjctEWdGkRbOPSHHWA/IV8941w7lnpeNC3TMVIqS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c18c:b0:1e1:3367:1429 with SMTP id
 h12-20020a056870c18c00b001e133671429mr503641oad.10.1697785838117; Fri, 20 Oct
 2023 00:10:38 -0700 (PDT)
Date: Fri, 20 Oct 2023 00:10:38 -0700
In-Reply-To: <0000000000000c44b0060760bd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c92c0d06082091ee@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING: suspicious RCU usage in gfs2_permission
From: syzbot <syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com>
To: agruenba@redhat.com, cluster-devel@redhat.com, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	postmaster@duagon.onmicrosoft.com, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0abd1557e21c617bd13fc18f7725fc6363c05913
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Oct 2 02:33:44 2023 +0000

    gfs2: fix an oops in gfs2_permission

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b21c33680000
start commit:   2dac75696c6d Add linux-next specific files for 20231018
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b21c33680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b21c33680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
dashboard link: https://syzkaller.appspot.com/bug?extid=3e5130844b0c0e2b4948
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c8d09680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a07475680000

Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com
Fixes: 0abd1557e21c ("gfs2: fix an oops in gfs2_permission")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

