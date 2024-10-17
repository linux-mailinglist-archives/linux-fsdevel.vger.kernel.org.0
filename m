Return-Path: <linux-fsdevel+bounces-32166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5C99A199F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 06:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49A82876C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 04:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B59C14D43D;
	Thu, 17 Oct 2024 04:18:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316D20ED
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729138688; cv=none; b=SlTS+F7nF9EKvrn6afyckdGy1zF9K8t08zFyU52NT/+uXrTj7FJzHnUWcPBz6LqEQ7k8nU4MBqaVuhUZhIR2je+IK3JHf580MILCHBOX4KuPE5R178WYU5RSAcuEVY8eeY7XoILjbFWUDkfI0RHgyLuCDArzPqqOEpJnufx/WHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729138688; c=relaxed/simple;
	bh=1OU3n6Oq4M7nhUUx2iIxEh0l7ukW95iagzuvOHRgB+A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OLd4rVS2LktzNPguHrMz/4JHBYUIEhxhm9yKpHTwLs4H6CC43IoYXUsI2UcNEYU3SLQ2VXYDiioFbphruKHFQ+DXcTKC89uIRyd5tFcZ2bpGN67p7sErqZ+scAyGZ9vlGNYkS38UYCTQVCuXIWJMWypUHNFCCODi8ljKg+K2xHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8354dae2e52so46411439f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 21:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729138683; x=1729743483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jY61h8LqdmtDNf/l3f6Fa7vLNIRrdlFHFmkic/5tLgU=;
        b=oDXiSHkYy+fPBf6s/6i4D29LTSMzB523TRNsg3L2ckB8INwijfiFJ4TgrmDuodXY0H
         KCCp79TyI3vMs2Rx2Cv+lh6YruazuSCwuO3gssviJR00l7CdZ4ibmLZzcgSSkYsxuZMR
         fcm436+0NCfXruMGThmdkJ5hNzzdURlQCLjBYlyi8HzD+EunoKKKjZzdThC05Tmct7+x
         bLNmNDgQSc6q87m1M4nC1TPGutgkqC/qiRQoqEdQe1WP0YGZgPH7R3jEMJIjldI48RZ8
         weIknUo8qW31MJF2OQerEAtulp/aoIhTk3Qun9FzXrNgXGNkYlYvbucGZ+EqGOCHFQNa
         104g==
X-Forwarded-Encrypted: i=1; AJvYcCUrwwv0eQ9y7vSUTCmPgNoACl0ojtiMbHKWxPFYGtT27QMonIOnmqRJN1omxQbcQF97/Ek8mF5LVK0Kwcnt@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0LhfGFsFvv9BFRs14juOAvmAJnLvwWh+gmqoqaFNq8RVh0+p
	t7LIdl5ZM9IZgs0RKzSmvGIJGVZkpd0myMMupLfWVAukcgzao9n7Q/5CJr5Xw0b5WE7xz79GyzZ
	Oc+xeNHrLXLUtE4N7PcTiwShkOgR9J0clODkdOuQxBuFmuftAY/kIz/U=
X-Google-Smtp-Source: AGHT+IHecXCjdNhKl7trxeGNO/H1tW6w8QYfFSoocTY3Dx0XEd9VtaLK94WhYDh/oL4TAV/MRqJ5eZL6zMp1j2JWD9vUrLE/dJdZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d06:b0:803:5e55:ecb2 with SMTP id
 ca18e2360f4ac-8378f64c49dmr2521392539f.0.1729138682825; Wed, 16 Oct 2024
 21:18:02 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:18:02 -0700
In-Reply-To: <PUZPR04MB6316311A4447A7FCDF5A796E81472@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67108ffa.050a0220.d5849.0020.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com
Tested-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com

Tested on:

commit:         c964ced7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ce345f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ca345f980000

Note: testing is done by a robot and is best-effort only.

