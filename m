Return-Path: <linux-fsdevel+bounces-44159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1284A63D65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 04:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDA116C828
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 03:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40C215045;
	Mon, 17 Mar 2025 03:42:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C7014D2A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182924; cv=none; b=ZDUrPi7FDTnVg0fAqyHBj6scUf8dOvGA1jSWFBsrt8qaYlzg44bUVw39WP/f6p7klMTfp85TCB3nrv1BI64lH8WZ46pY7MimzEG9/qCIdjQ2b3DA28TjXi9ADhhaDrIgsK8edTQuE4OO8Xz6Q5tNfFd7oXXnz2afeB7rSd+CWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182924; c=relaxed/simple;
	bh=4bKMRgR40SFIGPrQst350r/1BhxLhA5iWiEP4IH6Wf4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MQAsRuoVqd5BFEn3EtKexJxyoBl0lu8+elIruvHsKxJetPpbOIs6VWM1xfy4K03ZbWNMwsmnU3Le/IAjCEhPtk6BXwkPOox0P4GWxTmS6JMpC/YRsl5fUYwK5Ts8gw6zKmkHHQYC6YJxNmaXJ1UIQPgm7RS2kQtIXMv5AJyJDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3cf64584097so46647235ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Mar 2025 20:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742182922; x=1742787722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjiBm1c2DmGIm1FqaFSvnhp7T2ix8so/PQi/7DTSKoI=;
        b=bFUb0/a0jwBtIg6/ItiFtrOlq2AqyK810cN4wE168rsidwpSjrnUBYs6mhpSeh+sAD
         w4dd5hREJ/Oi+VwfsQO4CS1jTpQ5k0SfUycIhMKcYkFuRPR+TZAoPAbDm5eIkbNjbyJS
         LkN67jzTeft857TSuVQrkBwNJJnsaX8kOdhO6Fh4NBLbgfXjmDh4Z7mDeorYjUOJL/sO
         3kwxomP36V7WGusC0YhgAxjtUG8Is8dC4CYVlwAqpGxNEI+SNjDnNajBn+3osgPB8Ghg
         uUp4uF+avNhZhUdB5oHYLikyasEvPqvl56y0m7pa5HTTzY17wpWF45DBtfvMldbeT7Jr
         uDNw==
X-Forwarded-Encrypted: i=1; AJvYcCXLunpj2aOn0NrQhs+2eJo8MaBa0SmriphHipdsvs9suL3LeYxB3GShkItM6Lhkclp9E/SyiW3H7EfSX9PH@vger.kernel.org
X-Gm-Message-State: AOJu0YykjEDt3pskj8gTUUvI69w5dglGJrfiZZgElVUn95hEI0lHPzI6
	sv8Nw9rxzehEA7O/h9Q2Ik+rSZD7jsWcPON81D6iiEqtpDgSkEI5gQLsa19+Fs8xV1x+VYF7buS
	k/a3uQZ64fALW8cjYkITKs32BkocMEdZmna2K2UGjtABvLroBw+fFwFQ=
X-Google-Smtp-Source: AGHT+IGRJxEYTkN4nNIUivh4AbwbqwYWEBSzEdyGdF65wRPtPt7zza6HZ7IgQX6o8I+5Es6ikmt9MGchhETcY8dWjrVY+2jO/J0F
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378f:b0:3d3:dcb8:1bf1 with SMTP id
 e9e14a558f8ab-3d4839f440dmr135090345ab.3.1742182922001; Sun, 16 Mar 2025
 20:42:02 -0700 (PDT)
Date: Sun, 16 Mar 2025 20:42:01 -0700
In-Reply-To: <PUZPR04MB6316E1DB152B8065EB4615C781DF2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d79a09.050a0220.2ca2c6.000a.GAE@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in __blockdev_direct_IO (4)
From: syzbot <syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org, 
	yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com
Tested-by: syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com

Tested on:

commit:         4701f33a Linux 6.14-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15154068580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=620facf12ff15d10
dashboard link: https://syzkaller.appspot.com/bug?extid=f7d147e6db52b1e09dba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b9c474580000

Note: testing is done by a robot and is best-effort only.

