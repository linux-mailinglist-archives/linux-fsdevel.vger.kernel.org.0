Return-Path: <linux-fsdevel+bounces-68416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB89AC5B0AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 04:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C5A6350CE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 03:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B761A83F9;
	Fri, 14 Nov 2025 03:00:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F124679F
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763089207; cv=none; b=PKO4/OB1esny/ROegu94hbBCUy3Ibkgp4huV1fMB+fZWAT9XxBN5207UnuD86dqhpgXXx+DTNPjfh94fC9EXt1Vb42rNhKgLntela0fF571LcOSHsxrmyK/va8JaSCB40SRrZFBh+wL60jcAgH0zKFupm8vkly4jGDDz3PKaamc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763089207; c=relaxed/simple;
	bh=BGWo9OPwPsMaQBf755FuxsZA3PMeBK5opX3Vp+9DhBo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CPagHbZZBAZcV3SATqiF0npWvWAlvo8Vtp0yP76oZlV+7NCgXAh0+xZ4GrIbPWWniVH6D+y0DiAG5B90fV3fp5lhapzPa13rAgBr6AzDFi4q0dddMaDSSFhcqe/X+J+kYBPynXbTyXbWF+EGS+DCcv/WYO0gHvijEE+4AYSMhSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9487df8723aso470200639f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 19:00:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763089205; x=1763694005;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36M7EPZWiVtPyWxC1X81YJti4CQ0C0dLY8kItaGWYDs=;
        b=qcELQm+a4UshDro2l/r/TK5DQZ22Hgtd/9MyaJKkeYfi2MX53EBreI0IiLfEhhpziX
         V+gccOYgUncHGG9Ye7EAn+KFnBAUb4VImBUvQkHyUVgajZ0xZuAN4iads3ZXSzbypoFz
         MqBgnCgnj9NVBQsr/GDePZ16y/aby/SdqUKpuHyqMiyOcZflM6MY/UAbJrFXZwycE20y
         uKOgQRbVupR1eygxyWRMwgK3Cd53SnP4Ve5lMD5D2IGI6ubwm+0yvL5i+ExwudLt8QyQ
         XsDIx69gO+zuxepL/0ZzCV0lwfAFHHxxXZw7YTayn5Br8pkFgSYZHd8G0kj15ukz/J8j
         bYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTY1BMBaYEV79IDw2voPYP6oVc1kMJeP/6XUir8U8A8ctlrD1jZLeh7oz9xZnkt6hcAhBqLIjbPZARDGxd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ONpUH/CGE7RAK7y6qAxKjn3epC9esTzfSJTt71JNjfs+aAOb
	E3eaJTtFiVqQepZnHi9nkS8nMMBaU/93r1e2nTYQiQjm0PJ4ufCMIRyJOu2rfbU4eQPpBKYrU6K
	GQXj/JjfVK32q/YTmc3t+xwxhJtKKQWo9rOmR0w7SBnpx4+i1EvRhohXKlBY=
X-Google-Smtp-Source: AGHT+IFVozJECMXI6cbJwOmdjzfH+rZ4wsEYOPV/ekXDAckPJLnMmOGP529xsmH9GdSmicJiYjOyyrEaOBHIZeCpLciwDfLPyEjZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd83:0:b0:433:78b8:943a with SMTP id
 e9e14a558f8ab-4348c867eeemr36442835ab.10.1763089205146; Thu, 13 Nov 2025
 19:00:05 -0800 (PST)
Date: Thu, 13 Nov 2025 19:00:05 -0800
In-Reply-To: <20251114031838.3582-1-mehdi.benhadjkhelifa@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69169b35.a70a0220.3124cb.0040.GAE@google.com>
Subject: Re: [syzbot] [hfs?] memory leak in hfs_init_fs_context
From: syzbot <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mehdi.benhadjkhelifa@gmail.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com

Tested on:

commit:         6da43bbe Merge tag 'vfio-v6.18-rc6' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cab532580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c3eb42580000

Note: testing is done by a robot and is best-effort only.

