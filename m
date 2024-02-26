Return-Path: <linux-fsdevel+bounces-12789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B208673C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F069A28D56F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8371EEEA;
	Mon, 26 Feb 2024 11:46:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35F1CF92
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947965; cv=none; b=rX0N5vEBzlQ2abcTbBPQUVrpd1L6lOLV18vp/F3uQOr0K6m+QYDTy/WIlct5erA5j6riZKdMqmXxZFqqA6qr6eFnobGmR54e0xN4N2yX9k21ba3C/19icH+9PmY+NtKQ76hJoq1AisNk1gmSQzpt9pr1szq8pdDWwOdarJ5VDYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947965; c=relaxed/simple;
	bh=S1DH6N129w+vMq5/UljzKNmTTX+FRMOyP1Xrb7w06Bs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JhC7C/fQXsoe4Ts0zUurCSfDLkldn2MrTmqxqvcA/fD65OuoWHK2YPem0EU3spauZvWaaNpOnj//W7ce2TEl/y7Nya9+MozIUd/WmztAmtbInbFC5XAwNKIDoW37NX0VAAP74sBQ1zPdRMekTKvtRjHcNgYnt4kZM+TZMRZaZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3657ef5f01eso39601755ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 03:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947963; x=1709552763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Co4mHqcajZ+TaVXtj1uAZr7j1bhwGXeKEUyHjDEeql4=;
        b=YKESBzfhvl1hRYA6qFyPJHtNOQbyP0i7DANvfsUJsNlC/ZpnsefDfra/yE77uRQvqE
         394tAahCj38ALl902kf0qnCXf4mVf6F3lMhttCFeWJ9fOXW2BkgS/B8d0ZU96Xwz2EO7
         0iA9xl2EPq6DeKNI9S1qpAvxJLKlvH9zHTYlegHkES16kU/OJ9KFfb+tg/97wkPJ09u2
         5Xx2MkQZCt++ISnjV/66J4epwOA7/qqPccwgnyrXNj9U9zTTzLpDFW1Ec/CR/HD3Yi9V
         rQF9GUqnYzUd8Io+HfYHvvxTmtPHhT2QvTfdsWA975WhhsGISl9qcVx5MYvkGKVHGgeW
         TFHw==
X-Forwarded-Encrypted: i=1; AJvYcCXkZf/KQ2LKnQkFHsFWcYorHXZ15ccSBKQRwARpD6Zi0peWsLqMAUQLJ4C/TF/qyGgRFdGziwSeW00jhHe11NMskTHJJ2rQUil+RBrXUQ==
X-Gm-Message-State: AOJu0YxmtXYoL4eJB/k24XazIeMJ6ekNsyBR/0s6NXxys879xQq65Ohp
	nQ0sNkqEEBgwffU0SycMwq5SAxNo80rVq1uaWmr4Z2P/1XjGd9oUs/NANbCLvqu6/fXNRbxZZON
	T097MkON0+tce0xfi1qy+wfZypPjz8TlxSyPgvppKqmatmpOz4DKTpx8=
X-Google-Smtp-Source: AGHT+IHIVqTZZ7YCL3IN8GhgKNZ48yzHqYO4fermQmaHfAwR6BgfFyKH6DsdKtx8xrqBPkzE+Y2WHuiAXDPL2Aoeo4nERWuFkxCB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3885:b0:365:2f9d:5efc with SMTP id
 cn5-20020a056e02388500b003652f9d5efcmr328599ilb.6.1708947962903; Mon, 26 Feb
 2024 03:46:02 -0800 (PST)
Date: Mon, 26 Feb 2024 03:46:02 -0800
In-Reply-To: <20240226105506.1398-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044c2da06124774f7@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
From: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, boqun.feng@gmail.com, 
	hdanton@sina.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 716f4aaa7b48: failed to run ["git" "fetch" "--force" "--tags" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "716f4aaa7b48"]: exit status 128
fatal: couldn't find remote ref 716f4aaa7b48



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 716f4aaa7b48
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172e5f4a180000


