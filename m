Return-Path: <linux-fsdevel+bounces-76550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMjVEPOPhWkODgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:53:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E54EFAC84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5617A3034642
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 06:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E97F2FB09A;
	Fri,  6 Feb 2026 06:53:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6C0313555
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770360782; cv=none; b=ZntrzB1b6dY5gNOTywGGp69Xtq9ICyrIP/Utr6YVg8F3AQvxLnuSEAFuO2pM3avmY7JlMkqaI51obpHj4aZOGprt7UQ4uTxy7LNXyMxjB63jtAer3MIwiz/CAXvObRQUBnlVtZvD5t7faKmOdpZNxFbN45uo+XdkJZuixxmAnL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770360782; c=relaxed/simple;
	bh=w83NeI8K2B7LnbTZqqYhBmS7HBp+lSRhSR753kSaPMs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dX16djL/2kb3j96soxvWk8AVm6Y7lyYjZwFaXX+QA/gmtxY6TN0ZjWVxHCnyQG8c8PceYx+iUXAOLKWJeChqj45ioV6y1ygA17zIVu43fW9WOZf5V1qKYrGv5pgpqyPwasOZ1hUNAbFJ2SWZR7cOI6xmramLWbsOinoN5402kaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-66ad005c9dfso8623938eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 22:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770360781; x=1770965581;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVaUQvK9UjjsYgRWlbbVp5yS+mORyLWj2BGFNbDjMdY=;
        b=jap2lDC7y6xrjyc608iHly+Cty4TeaWTWq8YPPBfymX7c6B1S8EiU/Bldn5iGordvX
         gkAJw61Lh8bACQd4Z1kX59tthSPVv8j6sftE6rjstu9Sf3FTaP5ZdfK1XSg741cmt5aT
         GVNouu206emzgHz+E5xoBC4tF/wKkV5SDTXwiogB6P8lVHjUt56RTuYLglinWzuqqrSd
         GVXLCVxEyCSuU1EIBdxTYkMCV7IJheD/V5WvjzDOvUHeLFwwCqeK9wR9iYLWt6solnmg
         2mUsICSAZz4UysKI/zQpJEsOjceobfm8NlhE6OHEhvTciIdk2nisBhJfME8V0gRcjVwz
         dqaw==
X-Gm-Message-State: AOJu0YwNCkmhh9R5wMT5wV44FrhUndUWcKoAubonCoycrRymTR/AYlQ+
	cChlwUPA6ghZLl0y9wRunKD3Fg11421k/RJdqQYtGlN1LsggVryTd85REkEpcFHChVV80Fj0Zp+
	NzhO9Yd5vkmTQgoipoK6Ibz+JfTCTCsUqlIhWJ5dmLIw3dSIF5Gd2poteUzs=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:198e:b0:661:1d0c:a5c0 with SMTP id
 006d021491bc7-66d0c667216mr1092470eaf.69.1770360781577; Thu, 05 Feb 2026
 22:53:01 -0800 (PST)
Date: Thu, 05 Feb 2026 22:53:01 -0800
In-Reply-To: <20260206060017.1208322-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69858fcd.050a0220.3b3015.0032.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KMSAN: uninit-value in fuse_fileattr_get
From: syzbot <syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9682a42d8ec8b05c];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76550-lists,linux-fsdevel=lfdr.de,7c31755f2cea07838b0c];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,szeredi.hu,googlegroups.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 1E54EFAC84
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com
Tested-by: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com

Tested on:

commit:         b7ff7151 Merge tag 'hwmon-for-v6.19-final' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fe878a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9682a42d8ec8b05c
dashboard link: https://syzkaller.appspot.com/bug?extid=7c31755f2cea07838b0c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14978a52580000

Note: testing is done by a robot and is best-effort only.

