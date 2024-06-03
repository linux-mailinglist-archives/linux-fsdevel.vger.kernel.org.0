Return-Path: <linux-fsdevel+bounces-20780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBD98D7ACA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7B71C216CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 04:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377028382;
	Mon,  3 Jun 2024 04:34:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55181224FB
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717389245; cv=none; b=dagJJGp4Wjli3jkHVtwie7lw3uqt9FPnVAqQ2ayliYpTR7sGdXuFGKO4zOfkN1LO8ql+RbiSy34w2IRI4gEpTrurvi0MZ18YjmcRH2JKcC1LnpwZPw9o1+12QhmGXr+e3QKl/Q86crE6MIG7I9G+gRWjEL8QhHR3gfRg3MZtjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717389245; c=relaxed/simple;
	bh=XvC0SiEJbpVH/uBYqdcftKNyxVAMGHgOIGcomLlhPmk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lskcn/68uoaVVuX45wZ69W+KIJzq1NB4GMQPXEgzIq1wECBm/wOgZ+r97pZLTBCtt+gDwl16+1Q+Dkfgy+lCJoglwv5Xpda9QG4otKSrCNRbb2BzcUup4LFNvZGUMt+tZ+aLQuhKTteKXfjdKESJczSQdBE/9uJuK0wqrFxQTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e8e5d55441so529989139f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jun 2024 21:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717389243; x=1717994043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4vNl9aSBub11HSYUiO1Qffb2KM2Qlkf21jiN6qmFeg=;
        b=QY4tgF3UybokPN0sE7/dm+LzUUUsR6EbupUDMcJKED0iVWdcf+bCAfcywQUkhXnU/9
         m+WYs327E6Jm+ZfrbHy7dS2FYTuWZ3BLYs/2fS7TH5OKY4z2Bs0q81xRFOfI9rITS8nI
         5bZYAXGX0LK1FN25i9pj+6/mg62BqkFlLG3GGDZuRzy5CA4IVBxIHykrkBCwTWNI6N/V
         CyZPClIGxVMRPRzNo1lkmHsRVFlWV2zkp6wbmcRV5de1Z1w5UoYLaSVDEoH1l2LtFUsY
         Eo0orD5YkwNICpfm/pyQa93b/IrL8120wuGQ7WqNBaWJpOwfGvlojsU/IbyABzNKzjfW
         P3KA==
X-Forwarded-Encrypted: i=1; AJvYcCWZX+LNYFZLosbzMvr76It0n28Du8elUXIJKeocfutTvm9Tf4+DgZFrBBO84nSv4ma77k81bafHireguDUiFy1pW1DFr+u1Ukm9JXHdOw==
X-Gm-Message-State: AOJu0YznNJkyqWYG9XJdGlfX4jYHpVumoq0nn4A4uSq+P0WrCU1Qf3hN
	YuZ6Iwoash/CHjizMnNwLNM/AGdrxCaVb8IL9G2etYbiq7lv45RtnQwEZRC8Djwn7BWMq4nrlwO
	9JtpYnSyQSwowBq4K6QMc6kAjxo17ZBXDMWYUEIPKfglh5IacR5qZzxc=
X-Google-Smtp-Source: AGHT+IFJF86xiMzFFPnya5J2F0WVQeTFP2xpVeNQH9BTe2iwAatl+IEZdZVB7KJ5SbCBJJnRnglxEPi/YP+bSmu0HwYFkIC8opkc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:603:b0:488:5e26:ffb5 with SMTP id
 8926c6da1cb9f-4b541a80d6dmr100445173.2.1717389243514; Sun, 02 Jun 2024
 21:34:03 -0700 (PDT)
Date: Sun, 02 Jun 2024 21:34:03 -0700
In-Reply-To: <20240603042116.GL1629371@ZenIV>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd11c70619f4d7f7@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in vfs_rmdir (2)
From: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

scripts/extract-cert.c:46:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/extract-cert.c:59:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/sign-file.c:89:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]


Tested on:

commit:         1c163f4c Linux 5.0
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 v5.0
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=42986aeeddfd7ed93c8b
compiler:       Debian clang version 15.0.6

Note: no patches were applied.

