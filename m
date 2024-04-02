Return-Path: <linux-fsdevel+bounces-15926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E459895D86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED211C21CAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5302715DBA2;
	Tue,  2 Apr 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rajTLTK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661714AD2A
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089532; cv=none; b=UyWPCseU2bqjWuTA//qWhr/luAFM8iK6wBnrkBZ20YoJYUICubH5xiTuWSoL8BLOy/iGdCiTffJcd1qQ3nt6uKNp/3O8fGeLbPxtiD09/fK+61NyLGI5w7KCpUxvUJgyu5kDV9YgLGUTIY7870H3hDWGwcVxuukePM208Wr3TZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089532; c=relaxed/simple;
	bh=SFYOW08PqpPzwfxB7hZzx34O7i0fjEPQxzRH+d1frpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjMUgYQp66tfOQBWMJqnBAXh/DCMqe5t5vVDarG8JbTG/gkAHo8bxy+2BnuD/clH2uDgBwHhU9gZsMVBrYkm5+IM7tpyj5EPm8NdA4GNvRH3HA24mchaTt8QdnJKDkn+yOUFE7G6raBGhe44XMmQkQlQL0kQOM6EQAOP8EVfAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rajTLTK7; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso111919739f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712089529; x=1712694329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dBH876vAyKlWi1e2URAo959a0NCBuQah4G/duvZWoLs=;
        b=rajTLTK7azCbVxtKACPZqVnekoh0J9ambIIcnVvHESH38en1zKvSJlwPZYgVwaU8EI
         vsyb1fevE8r5m5u+fm2cr7S+q6Q/ttJFyTayY59OoFyTs/IB+hoNw1Ltdj78GttYQs0Z
         vI2ur8CsAPFoxQ/Bqfhyem3mRmOFbsdrQSl+8dERQslV8XpMHgVtmcRhy658Pbv1iRGt
         c9lJb+Ry4GoM2nSEgI4bQBp87Ljnya1m3Kxwn2AS56OKqC6YSrfhQopwdWvtMcggDn/g
         5n110D87p1SNSylX9pxWHHo33qnYVnF9WFLj7mc12Zg9ZjHE+xpa5PgBrr8WQiGiebsL
         K1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712089529; x=1712694329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBH876vAyKlWi1e2URAo959a0NCBuQah4G/duvZWoLs=;
        b=rQva9G4htXARVMFtxJO7V4AOAGQ+0RtD3yF1/We+1LlbockrdVlwzrZtNOutAb10fO
         NSeOG9avlOxfJBWXUhdfKdhvEDYRNly2hykNkxUmLaBsgSmBWevONHL8WnQVAY1jE52g
         4NqgaZP4M/eVzmxyehb/HcJUkx/2vUpQYuRn5hvAaQuPceE+f8hpsZyLY3ibZ6SP/YhX
         FiztuZmKRc2FIVpVBT55Cw5MdTMhokbBqi0M9pT9e0Nt2I9vEDt9cTXqwOqbEXUdC2wk
         1fE+YQkd7Aj4nDs0geJM0BtZDkLdNNvESFsc8whFb4T2iOaQIKiZq4wVy7nAQ+aKynai
         H4RA==
X-Gm-Message-State: AOJu0YzSrBC49PPFxDQPalmNnH6fuJEnZqeuydk2frYo+Cpb/F7T3KP1
	VYi925LBKwQzNiQ5VyL3Bg8GtBJeyzIXf+CjFu4F2Vk0uL0+QEnUH7F3HMwmvHsvatjFYhENAKX
	l
X-Google-Smtp-Source: AGHT+IGt8zx3yfoLHWJoD/9BicLeLb9BGtnXdE3dsIhE1rH1dRottnU4h8A2EJ7PIpY1aSbDRfOG7w==
X-Received: by 2002:a05:6602:3422:b0:7d0:5b47:8f57 with SMTP id n34-20020a056602342200b007d05b478f57mr16468113ioz.1.1712089528818;
        Tue, 02 Apr 2024 13:25:28 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u9-20020a02cbc9000000b0047ec029412fsm3445956jaq.12.2024.04.02.13.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:25:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET 0/3] Convert fs drivers to ->read_iter()
Date: Tue,  2 Apr 2024 14:18:20 -0600
Message-ID: <20240402202524.1514963-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

There are still a few users of fops->read() in the core parts of the
fs stack. Which is a shame, since it'd be nice to get rid of the
non-iterator parts of down the line, and reclaim that part of the
file_operations struct.

Outside of moving in that direction as a cleanup, using ->read_iter()
enables us to mark them with FMODE_NOWAIT. This is important for users
like io_uring, where per-IO nonblocking hints make a difference in how
efficiently IO can be done.

Those two things are my main motivation for starting this work, with
hopefully more to come down the line.

All patches have been booted and tested, and the corresponding test
cases been run. The timerfd one was sent separately previously, figured
I'd do a few more and make a smaller series out of it.

-- 
Jens Axboe


