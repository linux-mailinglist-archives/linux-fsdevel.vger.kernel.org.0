Return-Path: <linux-fsdevel+bounces-21102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB28FE5B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 13:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3ED0287FF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2619013F014;
	Thu,  6 Jun 2024 11:45:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F0195973
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674304; cv=none; b=SZeE5zNA8S25gzluXb3VCCCaVhgbpDQ+ik66lXI0kboReoBFwz7CT93w3d+baMP74LRLUJsMWmNpuYbnZPLgYt11lYjhgq+k52DWREwcTnXuWeMuDuOnmlev5nJvj5NTgFB/o/C2DglmDqY6sx4YS10P+4N0kZCtCwamEkW/tIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674304; c=relaxed/simple;
	bh=NSnqkr/gfjY1p48t+iFaGKw6DOOdST7s2h6VaDJRfVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O9pE5m4na+UIUiXD6JEZ+79zt1acshupAvwzlHRmljY+fgr9NJnfhRDQY7nRxYaS/y4Rt0D86k3kFchmk7N7zhDy6UERySVi/EPTXBdXMTTw1VpLntaz4pXlLwLlYd4XP5NYXuFex5YrFJgafdIlV4zvyuD3EyNALNtdEtn8ICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374933240bbso8066555ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 04:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717674302; x=1718279102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+u7BjMvOtjUoqQAFOQc26Gn/n/2VEOVuCJ6OTmdBu4=;
        b=TSakClVm/qKGkXtc4qG4g3AQ6nh5iuRJ7y4lZfr2iS6EbIZBChB/+xaeNvpovBIpWv
         Q9vzbhkAYWeqOd3zrpUSE643RmK50rhGonOS3zAD6eqZxd90D/HORBZJBpI663DnzOpV
         O44LG21uAtoi+KtvX4iegufsMzCHKXDWmczLbDxq5w1Qq35q6vnGWYs6gJv5ghWU4pkR
         uMu/+AhUkT2Ju+ncR0BoYCsMM4Smw5/MxFnuOfKsuYeLUn0sTXDKkIBprWFz7t4CfNQ5
         Cvr9PuTEQIgrR5MhTzlGWI2o8AuFGlzBqhTqamJRAP2tRRiDeCHjdg+Z4agz89uoLJ0r
         H5QQ==
X-Gm-Message-State: AOJu0YyGP3/7jJrO1tFK06XzKRaOrb4bqJFE1KLXHOwhzrG1Awutj8GK
	0DlZbLslxtQvwgvKacK2uUPlwrLeKeV3ezX1doRsm70M0HxNEqQWC6LYY40ldmJpF2gOT8yJzUE
	mts9id3BfTXlOjnQBLOwTo3MJ/lVq2Aya7rpDogOD77WmSUeTi4CIqvE=
X-Google-Smtp-Source: AGHT+IEvVTLQWUUVW4dX+tdko3DC2U0Lom5rowVnSiDS6z0cgoL1la8PQ1WzXbE7DP2uJQtxcIh6qg6wbHciCneAEo3j5dq++qnX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:6406:0:b0:374:c152:3d45 with SMTP id
 e9e14a558f8ab-374c1523fc8mr182895ab.6.1717674302623; Thu, 06 Jun 2024
 04:45:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 04:45:02 -0700
In-Reply-To: <CAJfpegutqoJxR303yk_8pkvGidEztteGhTpk2uhf-oC4AXdZRA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5ec61061a373662@google.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_request_end
From: syzbot <syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com

Tested on:

commit:         24601487 fuse: clear FR_SENT when re-adding requests i..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15256e16980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=da4ed53f6a834e1bf57f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

