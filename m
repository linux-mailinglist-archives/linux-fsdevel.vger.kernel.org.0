Return-Path: <linux-fsdevel+bounces-27069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8DC95E511
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 22:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95AE7B20F94
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 20:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A26A8D2;
	Sun, 25 Aug 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWQX7wKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06C801;
	Sun, 25 Aug 2024 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724617138; cv=none; b=NpydjDQOBRc+A9wEtzThri9mGDyxao0s8jJI3SbGHEl/ZIBnAaMYJmxOKMNIZ/ZYbfsXNBx1v7vJG8c4omou2pbaLvBJypoqxj7sJXGgk6HoUVbcpads8nyPDwDaCy8HpSCtzaeveuLf8k5BkEj6M+09ZcKu3hr/aqcBtsS3df4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724617138; c=relaxed/simple;
	bh=pQvsKRIzaaFuutRjgT2m6bCC+cy9chyHQSgPUu6BMeE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jzhafjyEmrylC92IeILcUraCN2khWSISEyrNXBWGhXDGE4B27Ro1LW6uPcFeGtWHZUluvIg206glP9Rufme2FEjDAQ3UTV60jNbThnib7ewk7qh+fydcsA0iL9zg9wsMxyE+0sgTG/rp/INwfu4LCeP5bHnVdhtyNzGFU53qIGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWQX7wKu; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-533496017f8so4901729e87.0;
        Sun, 25 Aug 2024 13:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724617135; x=1725221935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4P7XXm9eSrgZ/kl6du4jTDJpa0x1cOivnQTsm8g2HSM=;
        b=bWQX7wKu9peW05SMNYyjEyW9oooDwmYXQXy1o1u5Jk5PZuvGh8kWttJ4aolaUId59B
         FHkWFavLKCJFnJzaZjpYSWbudeBRs3ijA8qoxdjGidscMdLZqORdW62NC4znAQek+RuG
         j57IO/YpPG5ShwER6i/7ToLe9wIf/zaiVTYVlk6e31ugCu49AKRgR4sXfIJmLjU33pm/
         a1QV/aT+UtP0rZwh9M5x8uTezPHuqwlO4fYnjrwFKjnfdNEKW1lr0FvKEpxexFhK7dhx
         Lx7Ijtqo/hEcurM2wmNb6x7SncA0KXsxxOiu19NNC4iGSDNmvaHHSuCmgiG3l2UOkyqk
         ZB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724617135; x=1725221935;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4P7XXm9eSrgZ/kl6du4jTDJpa0x1cOivnQTsm8g2HSM=;
        b=RZNKY58fKnhBkss7vth9D0iChtHB4CwnldfN8s+VG+jQNp841IO7uIBOcX11Zghv1r
         D+4yaeVyHOroUIbarpesQxXsto35Nfmgbr59mo9rUalhOGZZcfcVhMJrqRpnkEAmfOXf
         h1y6tiPGoAg0zZLF+ACHsLk+hRK5WQBljpaT6Ru37OkY5XCY8mLNST5UcqZHIf9Hyxzr
         68DbunHAnv/e9KfRHT4JqpcTzH8iYC1+nmexHO57xgdC71TizkKwKmU6fxdpz1rVUDbQ
         52hCSm/Hk4lXanSHu7UF6rTJ0sRNIyDk/TtDRBBDq3b4S2046t63pKiFvipWNLE44z4B
         Xojw==
X-Gm-Message-State: AOJu0Yy3oIV/B1+ffLjFXfZ3mF1tFbfQpbeaa6r/hndORKgaQOas2cmO
	QDEaDQ9ksvVBJnON0WGXZgMawxlyuWu0NB2UuONSsP6oW5ugIQ8CIYzgdPt3iHv1hZwvOn+YClf
	Lc1JUw6fTCchVdjXqvypG9Rnd4ey2fUpg
X-Google-Smtp-Source: AGHT+IFccCq9i2PBJDvVPN83Iaf58GPmFBLNgdMRedz6h3BxVSGQf4X8gQprHFB2bvMlUCxVVQjNEQ0piO2hTYDaaj0=
X-Received: by 2002:a05:6512:1248:b0:533:460c:e42f with SMTP id
 2adb3069b0e04-5343882d110mr5793542e87.4.1724617134486; Sun, 25 Aug 2024
 13:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sun, 25 Aug 2024 15:18:43 -0500
Message-ID: <CAH2r5msDdpEruQXAtDXimonHKF7CVwO8bnghwXwrUX6K3xkFcg@mail.gmail.com>
Subject: Hang in generic/113 starting in 6.11-rc3 or rc4
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, David Howells <dhowells@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

I noticed a hung fstest (process hung in a syscall before it gets down
to the fs) running generic/113 on mounts to Samba (the mount still
works, but the test hangs) starting after 6.11-rc2 kernel (it fails on
6.11-rc4 but works on rc2).   It is unlikely to be cifs.ko related
since it still fails with 6.11-rc2 version of cifs.ko where kernel/VFS
is rc4 but works if kernel/VFS is rc2 (ie fails even with older
cifs.ko source built and run on 6.11-rc4 kernel) so is probably
related to a VFS or netfs change.

It also doesn't appear to be hung inside cifs.ko, but in the VFS layer:

# cat /proc/fs/cifs/DebugData  | grep "Active VFS Requests"
Active VFS Requests: 0

it works on 6.11-rc2 but fails (hangs) on 6.11-rc4 in my tests to
Samba localhost running generic/113


# cat /proc/fs/cifs/open_files
# Version:1
# Format:
# <tree id> <ses id> <persistent fid> <flags> <count> <pid> <uid> <filename>
0x4a8de66a 0x2cf91d3e 0x24d0faab 0xc002 1 5678 0 aiostress.5454.3.12
0x4a8de66a 0x2cf91d3e 0x36a30cae 0xc002 1 5678 0 aiostress.5454.3.14

# cat /proc/5678/stack
[<0>] futex_wait_queue+0x66/0xa0
[<0>] __futex_wait+0x15b/0x1d0
[<0>] futex_wait+0x73/0x130
[<0>] do_futex+0x105/0x260
[<0>] __x64_sys_futex+0x128/0x200
[<0>] x64_sys_call+0x224c/0x22b0
[<0>] do_syscall_64+0x7e/0x170
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

I also didn't see anything obvious suspicious using trace-cmd tracing
all cifs.ko tracepoints, but is there a trick to try to narrow down
the hung syscall (and where) a little more easily?

Any ideas?

-- 
Thanks,

Steve

