Return-Path: <linux-fsdevel+bounces-79700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEH8NDwyrGkemwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 15:12:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79B22C1C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 15:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 464573020852
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2AD2E2EEE;
	Sat,  7 Mar 2026 14:12:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F442E11C7
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892724; cv=none; b=Rr+A1sVUZkSHZBM9ai1aJKZgN0qBNiroEJGOj9OBE/II2PuB83xsAz9Y1CtKlZqUsg8IwLhaVbcNCyx6a1lAzZvTbpcpAEKiPh+y8MpLpPhOuf/+94JLvkAHmC2LYL8tvzGs2vc8mkG80L9JAVSL7JHEV/cVk8tMPMeKbP8ld/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892724; c=relaxed/simple;
	bh=WATbRmx/veztlxbajH6ebmO2CxzS4Ua6ZlttOzHkp04=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fhOAC3iukXzMuqvBPGtD97YChbkaeMD1Nt2/MRAvO/4u/IRjVYJ6pXzdVDCG2jAF/24ZkTwYtq7PSzEzgU+GVNoWQchzKkptDZHwDoz489S0hRlWpsQu59q3vv3jGW5BSckrl5wWPcxcDIKhvjNho1EwBxVpWMAhXRSr/f7odbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679c448d15cso129360878eaf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 06:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892722; x=1773497522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=il3sOCmcrVJs9HHc6eX/g7XL5qIrdkLnxgjrjyiZbpU=;
        b=I0CsCxMgzIzWpMi76RIO0uRPBsRyUwkruzpU995cN+L2CTE5mmUlRrM1KrsYz4d0HZ
         s9TVLb5U2ETjsoLtFnVobAdKqk3PGZ+gEVTLdIC7NHq3EA9LBNopHKWRmJnthseVj56c
         m/j0UOgpNGumlyRmHa1KVq5OzZvGGLShU9X3bzStd9oFAiu+u43ttR8QlqG5DtNqSYKd
         jCLifUXltnVK90kxyfAMKKRtPoero7NWA063nx6zG09mafktcekgRnPPS+HBwSzXA6hy
         bdSJMWvUIckHchujVTwPWv50fJPRLPcyvHYVcBDSp7YBmbv+roeuVEoe5X6f7zF2i1iu
         95cw==
X-Forwarded-Encrypted: i=1; AJvYcCUfdJ+n+ONcPrCXqa1tv8AqbDxFYakn7IXsig0AEkffS0ganruAE1d1RoluxxqAigtTOVtxE4TYTsDG1ndh@vger.kernel.org
X-Gm-Message-State: AOJu0YwibCwgSFcpDrPUTqtGVuw2cvS/6cAPj/a1V6Dx+1iph5ZhBasg
	1iEIIVQifkOypkRpAr7/KXbVyIjp7xE2DlYL3OykPm0Lyqgzp85TdB3q3zN7yxX4dvrU1NYI/mp
	8XKDRFYbdE/T7p71x2cr3ay9MX83aa4SDuujkOJgN3SMbl8cQF9vzUiHCDEU=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2283:b0:67b:a91f:8f07 with SMTP id
 006d021491bc7-67ba91f93e7mr456981eaf.29.1772892722158; Sat, 07 Mar 2026
 06:12:02 -0800 (PST)
Date: Sat, 07 Mar 2026 06:12:02 -0800
In-Reply-To: <683930.1772891469@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ac3232.050a0220.13f275.0056.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in netfs_limit_iter
From: syzbot <syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com>
To: dhowells@redhat.com, kartikey406@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7E79B22C1C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79700-lists,linux-fsdevel=lfdr.de,9c058f0d63475adc97fd];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,manguebit.org,googlegroups.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.859];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
Tested-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com

Tested on:

commit:         c107785c Merge tag 'modules-7.0-rc3.fixes' of git://gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1756db5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e
dashboard link: https://syzkaller.appspot.com/bug?extid=9c058f0d63475adc97fd
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15916b5a580000

Note: testing is done by a robot and is best-effort only.

