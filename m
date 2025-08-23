Return-Path: <linux-fsdevel+bounces-58867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E327EB3260C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 02:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2610A3AB702
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 00:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E08146D45;
	Sat, 23 Aug 2025 00:55:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B1175A5
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755910506; cv=none; b=cO7cP7zc507JVWRNkevCWWAEjQbKqPLYo38QHw0G/S562Ia08eENG1EBmsWx1Ym2VxWHYOHIrq+AZVxBXoWkOBqocBXn89JzDeukJBcJU5X4NFUrvGzSCE2J9AN0VoWFUummn+H7qjYw9S5/9uu7RjmBeWd4rHufd0cbcETTsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755910506; c=relaxed/simple;
	bh=dwQqBhkiv3gdPqNBg1N//OwTQuhOxMwSaRIXEgWrBK8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Shcfak+h+UULfhXuLq/nl3B8xdalQvtyqGKv+oudBfzeQBzBwr/v8aDX1OD17ozxNVuhyvlLNjrqzPIvknN2kI+7nXwoR2v6Tv4BBgYbn1Hm57Cf56QsH8YqoWHwCKXI0tzz1jpEG/HTqdjgpo0rIeAVB76PJhffpENiS5enMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e67a51f6b0so67260115ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 17:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755910504; x=1756515304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaiZLTdnzU20S2gEWsZVd/beFN16MGW5MuUPgJmjQ14=;
        b=tQzJSAfNvZsTmSxhrjjD4rPWGl0/yReKnkjPkczey88s4XwcmZtkMhHdl8CUrdgJ9C
         pncmZFCENNhMQSaUSSFYoW/b/bbrVsFG4eovxstjFXn0r0hq0eQM2BYQP47uirVQNjE3
         HvQE/h3Y8AqGkVBL5B9XlBtVotNiOQcy+EDKnJ3ZPTlGLtl/JhkO2imk1uiFa+Aa1F28
         Oci4G4+VcllQxibOfof4ApDXpCZCqvbs92TKG6eUTadx6All+SSc/tRLwSQrTR7tKrQF
         KmV+mPs46880Fx3DbRv6JVlbDq1ydWyg3Tuur4qeTOBQon9cuPZvneuI69WbvcBisgr9
         lfCw==
X-Forwarded-Encrypted: i=1; AJvYcCW70y1tE6thFv3ZRbPP8aDbMuyTz/XHgJGA07p6wTk9ybXI/la1H5SWugTR2A3XF54XldaTZaIbquxIAgRp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xqTYut35iFEoF+U4ia4TwhOf0+8iA/Xtbd/GmZNPRDaqpp+f
	+slJgNhlpJQM76ZL4wUWXhL7eEIDX6l+Z2ynUmz997ScUhbrPNWLV65NMsMyjpg4iuxSjW0xMio
	K2f8gwSXPmeyN4obO1QMlH/B+aAi6hQOi+EPRLV+WFVQvq5cTJashoSMyXY0=
X-Google-Smtp-Source: AGHT+IEulvgYYxLUbIAT2ZGCEo6uzPF5ZYh9bP6wBfxwiNL273lg5Mb1AdYubrIf9hK30VZ4neqQ7PTu1ZAat4XQR+oIsw6NpEF4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144f:b0:3e3:ef79:5a8c with SMTP id
 e9e14a558f8ab-3e921a5c9b6mr78062675ab.14.1755910504422; Fri, 22 Aug 2025
 17:55:04 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:55:04 -0700
In-Reply-To: <CAJnrk1bSD+HfwLqbFv8gsRsPt0kRsr8JZcEXdqBWuKh2Qnz_yA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a91168.a00a0220.33401d.02f0.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: slab-out-of-bounds Write in fuse_dev_do_write
From: syzbot <syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/fuse/dev.c
patch: **** unexpected end of file in patch



Tested on:

commit:         cf6fc5ee Merge tag 's390-6.17-3' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7511150b112b9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=2d215d165f9354b9c4ea
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=116eaa34580000


