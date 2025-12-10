Return-Path: <linux-fsdevel+bounces-71075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3792CB3EA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 21:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFB99301102E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 20:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659903254B4;
	Wed, 10 Dec 2025 20:06:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCCF221FCF
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765397167; cv=none; b=MZSLzWaGAe7eWh+caYxLq/EFZ7P7wNseHfn+UksFVRUc9Q4k9k6C6QhLxVc0Tl+i6erQINJHKuHmY+a/Q18WouDOPvtS+Zkx3JtcEhdhz5R6z/EC870rddbFObvPMXRY6BGtSt7WN4jl5j4XaHZxFlCs9QvrcAU0yRRij3x20YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765397167; c=relaxed/simple;
	bh=o/N9hNYDFGaPPiccpt1MWu5r6nedgV25JSOFHlJwRBE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gjeUfmG8ckfkzTPvIcC9r/7u7zOD9TgbqAd6ia6fh6i85+j7OuuHPaeYh4SvJee4gtCG60Ry2JcstZPEmqnbyTmgPK3OV8GK9vapw1RtxzyWJ+ySdtcmlHVfbAIyfhlTMo0kjMlTbjWb+2srPqteyqFNdQ6Ujn8cwmC/038r8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c6d4a76d9cso457247a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 12:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765397163; x=1766001963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdpoFQRlR9CsknvUV9HU8+SF/nRNvJP5Go3OaipCpTY=;
        b=wiT98iGsnUi7KvqOb63XeVRuRalzqXRyPVclKul/MYXZyQCbPwmgqNLDC9PmciWKQh
         DZMt8PYp9gkEGQYZbxwf+BA1z13+gI1YdGeuX7eecB3Sv0Tr79zxMPYkBUz/qU+djDtq
         hzuEwq2nmXCuIpiS8v0Xlz9+ce2Ap5anrC00zdDsuBvHXTcOiUlP5Fnn9zOYFGpU2n+f
         kw+iWJCwRpZCffPXJJX/5t5ZrXFGWU6kC3eRn5WhzTaaraHGSAl+LAF5UoQ7zBGqnp70
         LaMzdRK+lIl2goQwotbPC4Ed2O0UyS6KLEs6mib6HUbcHDMF5kjC7Dxkgz2o23xNFQJz
         aKCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx6T4+a3+A5eczRUVlsZ5pwgceBqm/KDX+KN8iLd72M02FA+VcE+I/dMafUoW9jTF8q4RZFPvd61M1P1dA@vger.kernel.org
X-Gm-Message-State: AOJu0YygOPo3Bka0Cae9UOzDkvVJB9QUOHJo0M6Xxw3aFlEmi/qWM7eK
	FAJGPjL3UDiKDnzXrJiCtvI52IWCi8JaEDHDrfRJLXSQx7XG/mbhn29RummuaHlD1vpNLSMfvb8
	eZTaHPaR1GhPQ4JPf3mZ2cNNK9Z2zJwkJYNiksvwHGX7TVCftaLQdSKDhd7Q=
X-Google-Smtp-Source: AGHT+IH2drRLJviEjM9rn0/o/Ucd3/rXK4gn13nxFWO1Yth2qfGPOfT9g4jca/MwVBRdNkdfRv7PnZGaG7JkJGUqUpGB5UWyUmkz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e842:0:b0:659:9a49:8fcb with SMTP id
 006d021491bc7-65b2acf8273mr2227515eaf.68.1765397163648; Wed, 10 Dec 2025
 12:06:03 -0800 (PST)
Date: Wed, 10 Dec 2025 12:06:03 -0800
In-Reply-To: <ff7k3zlpiueyyykotdpfcaoxn2tukceoqcbmfdwjfolndy4sen@3f5r362sg67g>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6939d2ab.050a0220.4004e.01e7.GAE@google.com>
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
From: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	mjguzik@gmail.com, ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com
Tested-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com

Tested on:

commit:         0048fbb4 Merge tag 'locking-futex-2025-12-10' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15607992580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de48dccdf203ea90
dashboard link: https://syzkaller.appspot.com/bug?extid=d222f4b7129379c3d5bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14261a1a580000

Note: testing is done by a robot and is best-effort only.

