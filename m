Return-Path: <linux-fsdevel+bounces-72067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6657CDCA11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 16:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A48C300C5E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32F340A51;
	Wed, 24 Dec 2025 15:07:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81397212566
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766588825; cv=none; b=UwR3RmvY2a+xh0lWtFlZNEAhEQf3gnutpeUCvyXe9xczk7o8ALFSkVdX0D+BNim8DrdMsrkR2QmjhPAn5PPmPeEYxnQpO8pz28+XNQ/eUBgRrWjgNk0qyhT00ZqpJi1Os/AMeccAlMosScpUtfBvvJ0+v8xjCY/5ZieVB4D8rjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766588825; c=relaxed/simple;
	bh=Hf+2I7pWdDSKiMdf5GKTtKVx2c5a8qSqVgZJTcGK4Qo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GIsorCApeYkwazpSJdnO586+iXcS/dlJg+YxvogvxQGvU3v/1zvKRwo8SXb99kuGWTU1ujWiNdql6A5y9ubsp+/bSkgzJcwad/uDegSpWLssSVU9qE1FB/dcKROzKa43Js2UhNKj4UbCQ1nfQTgFjZPF4o7LYyiHCHL7FTACaIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65747d01bb0so9600743eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 07:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766588822; x=1767193622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGEebkuJuIJnxoSbDFwOV//9p90hs4SM8XrLhdxyQ9Y=;
        b=jw7Zh3UnKMZ6iXYIIti88TEtfOzDBKD9xmn1VthfM1DwBn1DiNYcDoEEVccv0emh9e
         sA3gp8hc4UgHSWaV7g+sefVuKcY8ZX0pk0UJNdYvioerzhuu4Qc43SobLGmcijewF4Hn
         3WPTg55P+8xrBTnqYwTjAEpIGF3dMOKrSrXdA4foL0EHWoIrRQb1ngPjUx0XzQasY9ik
         Dtw0gRf1krRseftiZECfi1U9o3Jqtf8NxRX68FwAiSm+Amuvv54oYDCy621y5Y+xIpOC
         YKMlUDqoD/ycQlOvxcjPPJ0jLV3CjPQf07lC0VLOEArZF61mQ8YFwi8LnJ8hTVB6eu8Q
         qIig==
X-Forwarded-Encrypted: i=1; AJvYcCUH5Uobi2x/dE5z77DAyLtevFMCdmHLURD3NZ2UPeLmowALuqTzN4A6WymAB4wkVOP7ljGfLgh/dumyGI3/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5OJR+0k0LTRMYEQ4cKI9JOefbXqtF8CKvq22Uw5Rt/hUsg9b
	e6giWQ2nvnmfo0tFA228VBIqZyb31mRXIDw+zljoYRc6MLO1gL8fUICH0/m464WrF0KKHNancp2
	1H49ZBBaXxiI3sY/AtvwXVbI4ki4zZPh8dJT7RSMw2XAdBJxf3gmvWWnz4Zk=
X-Google-Smtp-Source: AGHT+IELDyu5WssNs4ccQsrLICH7J90xI0qUly/KgqTtQolyEWQ8LpQAL6MVRydvk9ULcnvYUPBIqyCzYF/L07NusW1YFeL5az8X
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3010:b0:659:9a49:8e87 with SMTP id
 006d021491bc7-65d0e9f7c48mr4815313eaf.11.1766588822437; Wed, 24 Dec 2025
 07:07:02 -0800 (PST)
Date: Wed, 24 Dec 2025 07:07:02 -0800
In-Reply-To: <20251224143748.45491-1-activprithvi@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694c0196.050a0220.35954c.001e.GAE@google.com>
Subject: Re: [syzbot] [fs?] memory leak in getname_flags
From: syzbot <syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com>
To: activprithvi@gmail.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
Tested-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com

Tested on:

commit:         b9275466 Merge tag 'dma-mapping-6.19-2025-12-22' of gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=170e209a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d60836e327fd6756
dashboard link: https://syzkaller.appspot.com/bug?extid=00e61c43eb5e4740438f
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e790fc580000

Note: testing is done by a robot and is best-effort only.

