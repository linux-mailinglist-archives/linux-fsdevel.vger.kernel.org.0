Return-Path: <linux-fsdevel+bounces-16854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB1F8A3BCA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 10:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082811F222CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E09376E2;
	Sat, 13 Apr 2024 08:58:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DAB1CFA8
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712998687; cv=none; b=FrRZiKErwJrujIBmAZxIeKyu6n1h6ZbO9KAIBs1w8VkykbHegZnnaQl3aVmV+CS60qi0QXWvPZ/aNCQo5l7lTNRch3rZ2/lmdu1aCCU0f+wT3uisDWuT3ruK6eUl/P/Ouff5oPtaAfunG+gfz7aAeubjGy1K4wIkk/oE65lKIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712998687; c=relaxed/simple;
	bh=KIfnyfR7vYYdcwapDYh/BTV5MWSExVwJa52f6U/e9lw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s1okfaA55lZq618vlBvz54S6DQwLIAxgrsG4IPbK7GMWqg6Bkt5xWx2HDsbo38ZipM5yWuEZdu7X4dcjdPbzXlJJyg2MRpRoxGe7Cq3+uTIkMhA2l1jKb0CnXTN4xD2iKmUK0OL2MOPsSijI68qJP3M/Czpxv1XIT2WwJQ39iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc764c885bso207223939f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 01:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712998684; x=1713603484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeiumxD2W77agYk5SZK5cVx4YsslJs/nsVx2smQ5QmQ=;
        b=IfCSRvO+6svR7ujkrswaJDdljSqtifJm4Il4vyoIbU7nJjrMkMuVbLuqibyN55WXyg
         2NY9OaW6gjBj0JQGBzDBtjc6uygh96ohJb0WLn1a4X01dTaxm1Jj0W9ELh0IwjjuSRo1
         FiumpdEa1Y2luG41VsF4BAyLU7KXLLO0T96Bwbo1ZDUsocNweZZVA+xSDatSDWfsHZl9
         NihXS2LqQ2vfqIqotlZPhGReDxpng9hF6a7Szk4rbIljGgJLdVc+ABj1Rl9FmtJYQHjp
         5pfwdkeJ/jb7b8fXhrWOEJF92UqkMKcgs5jsEBWXNzZ/SyjEUf29beOZuVsj8yD1w34l
         Sw9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoYwKACTpFbXrxpMqrPTXf1RZSeAVacVjoGxJFsr+rh21mGW30bJhMRz4CSykTPZpOkZbQydKIRQbmrZ+d+mZ1+zC5gdNsJOSDWlZ9NA==
X-Gm-Message-State: AOJu0YyF/mgGIjaZR00A1nEJXjuSK5u/c+GzdeiMmfSsCCmNmIWS44Pa
	KmCnZ+lWfProUV4HLoOIZqtQIviluoCz1vcnOL1hApe3Ry5pYu2KJxl5LPoOUeKn9yUdbCxns02
	Kw3NR7hEcqZMNlkJFoafiUyzSD5LGVAh204K1Jp6KSjY0m+d+PNZMSJs=
X-Google-Smtp-Source: AGHT+IEoOIyYUcirD1veAnTrzTF2ffLJUxDOAtgseUuzBuijmXiPpCKUzqSSskYi7UJYvovHGUVtetdoO7alhYeiewgCeWppe8+V
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8528:b0:482:d9d4:b0a6 with SMTP id
 is40-20020a056638852800b00482d9d4b0a6mr109163jab.5.1712998684788; Sat, 13 Apr
 2024 01:58:04 -0700 (PDT)
Date: Sat, 13 Apr 2024 01:58:04 -0700
In-Reply-To: <CAOQ4uxhJi_YT=AZOaJGH6tt9kM7kUoAF1uzVqfGBXjvc8S78Ug@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b9bda0615f69622@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
From: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>
To: amir73il@gmail.com, hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com

Tested on:

commit:         9e589786 fsnotify: do not handle events on a shutting ..
git tree:       https://github.com/amir73il/linux fsnotify-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11cdb161180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9995779c8305f57e
dashboard link: https://syzkaller.appspot.com/bug?extid=5e3f9b2a67b45f16d4e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f52d33180000

Note: testing is done by a robot and is best-effort only.

