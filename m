Return-Path: <linux-fsdevel+bounces-63267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65845BB33C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1CC7B4E67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496EA2FFFBF;
	Thu,  2 Oct 2025 08:33:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CDC3128D5
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393985; cv=none; b=dQv9eSAR48JortVYOPDs4eSlkAt1Fs3YHMlIXuWeKHE7hb70z/J6X7lNZv+B72gau8ZYMeeJO+NgpagrJdhUEzgPIJD4S5eJJWB0Zo/u39XJNU9ZUf65qtmDQNNluXCKFI6sYsQ9mtg2STpriJ2b7eeJwiMr0vXxU45WHFcwJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393985; c=relaxed/simple;
	bh=GwdG0LgXcPpFF0iNYWG53721cpsBmDZEt4fFYYhZpYY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gmjyvZUkTeiwBxzX7HayMIInPHZmbwRAWAh5gnrrR3EyFRJY7QhICMkGEIMyDDF9DurY3NKD/weu0mms13dGt7sJQ5EWq3ON4iVGzQQR64l6p8PNxjVXpo2WLYXEfTl7oApFvskbbXqdB7f7inbDsIOAMkvHWhiE1sgTktR2EBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-92c122eb2bdso55425939f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 01:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393983; x=1759998783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaax1dXQz4N3uHy3soJijtPdYU/9vfx4hJFhMaL0iYY=;
        b=opJuw+zUl6SlaHJ6UKW9kZceRzsLnbW9ps8cr7B/0ifYlEesMOZ8KaTSNCs1NBqhH/
         6TdQ+9Gn6HV0YMEqod78lUk4M+5o2mtubZwfknRCHgKTjat9NXzTirfsS6JCLifEHK7q
         HOze0cNB4TbLMSmtf/l0SYrr2QBBpQjA/whajNdYLDV6jPH0FCUMS0e4M0gf/s2v2vde
         +WcLsIVhHPgS34/6dSpEpFNYUkhL98O0yztjH+3rtX+0mED92/rIIowr5qCUWA/DATfS
         OW83USkmf+veqyX4E0mlysR4aVPhEg0BZblDfrSoFWKltIeNepPDGe0cvzLS0XsqJ2ib
         xodQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9hubiq0ko0mOxFjFRmLT1+Mf7oVqGq7KCTy0X5GeKP2R0CE+KnuvNdpl0raTKGZqteK3TzIv8o9V3EZVe@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVb+95mJwskJkWhKJLIdRXoOE3C6oJHa0m2FVC5HG2n4VBscd
	ilzkNGudFvXSGkqOljlSamhHvJFWRbJC2ffnMvMPcGwunFCNJWAc3YEXX5Cj+gtTbL6v9VwIfnn
	jY4S5wOQTWB00BHr40qUkIebgirWVeit8AVDfdPVTBirXvk/R57Yvpi+dMYI=
X-Google-Smtp-Source: AGHT+IEkhH6g5PNdLjla1yW96SNW/PdjBCNRzmgw37q+kKCorUgATLSaIuUBTLsTETpJgcgz+FGbVv5W0BEAJN77xuutsfNT/gOT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4284:b0:8ef:c5c:ab5b with SMTP id
 ca18e2360f4ac-93a6b70a4b2mr220604339f.7.1759393983613; Thu, 02 Oct 2025
 01:33:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 01:33:03 -0700
In-Reply-To: <siwzfsrwodz2zfxqmub4yrfcadmnygdoc7a5imvtr3eicgzlsn@2ipfsri5p7ui>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de38bf.050a0220.25d7ab.0781.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in copy_mnt_ns
From: syzbot <syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/Honza: failed to run ["git" "fetch" "--force" "f569e972c8e9057ee9c286220c83a480ebf30cc5" "Honza"]: exit status 128
fatal: couldn't find remote ref Honza



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git Honza
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
dashboard link: https://syzkaller.appspot.com/bug?extid=e0f8855a87443d6a2413
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1411285b980000


