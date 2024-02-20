Return-Path: <linux-fsdevel+bounces-12171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B7485C35F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 19:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA98D1C21718
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 18:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB9877F2F;
	Tue, 20 Feb 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY07BMqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEED6D1A8;
	Tue, 20 Feb 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452572; cv=none; b=WlHg7CXg4hdbpnEMEITLpYd7ZTsv9WA3ttlVZafixKD2D10I5CF6GsoLpMVJKUXdicRRo7JdHGwQ1RKpufaXQdrKX1BNG9tdG1JuqaPaJai2jpmmN3NcPDVkzO/KLezAVqkozVU+rNnRsNC6zweq5oKIu+JkHvGTWZrVZCPvo8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452572; c=relaxed/simple;
	bh=tPWeZ1qRuWVXE/rrq7qVGTOTw/AlwbHnoQ41Kwp3AQE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RMulBLczziaPUHa+uayyW+04fukT9wd/JNpx+CiXH8BDb0f5jN2vX/mCBZvJcux6NzV3cgDwQTcxrzYU6H6F3IMlQKx4w+zLkYq9FkQy3uK5zNf7ffADPPQYEfc5v7zy1WBPzNapaUqloYix7AbXo8RfTYdqkVsLfItErJvRpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY07BMqD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d1080cba75so55243391fa.0;
        Tue, 20 Feb 2024 10:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708452569; x=1709057369; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lCA+rpRvWHa0gdI+SBPsLlnk7CtGNTdjDq+Gt1oJr7w=;
        b=ZY07BMqDLFO8p2ZIdHVwYZBp3JA6lqphWZJmkgJVFpOdqeO9zhRBT6hYWVbSZc4f62
         ZMuxbsRZ2/0Vdl6aDfIjMsFdJMwPSxgK93VEpBiiTLO6CgaUo5iK3tgmLk/CCqEdMoyw
         X2Qdv8xg0jiuEKdEWQSwDal07e9Q6V5EQ3EGZ9OgY512pRmtSQSk56nD7bz3NP5j/6Nh
         CQxBsSLLh3wuUk4wR7dX3TfrHL62r90nUpLipNb+Q8K+AtaH9+srnDMkaIp6O8uO6S85
         a6ciQ0Bf7J5OznEDG4zH55V/yjJ5POhEX/iwPz0ogx0vkn/zS9x54UB0xxStC19WADcv
         lqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452569; x=1709057369;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCA+rpRvWHa0gdI+SBPsLlnk7CtGNTdjDq+Gt1oJr7w=;
        b=StfnhY5MF8KgTNK0IwLQovCNjecNYmAFJ7Tsb9HowT1C061+sM6us93lGfKCBpvLM3
         6dXlERVf94+SudfhC3+HBXTn6ls5rbq/Qs/gJhsKPIm6LSS+56rgV3aaAXT7Kc0FoSmp
         NJFSI3q5EAO5l+u+tIarwkIQxVViGdChCXAhBHH15GWzsHXA2ABCQrmiBsEPUK9V4Fai
         c3cUKrYfKQGadXtUS9e9BejWH2N8j2GputL97WgbxBiEtWCCDLivK2L/J8CbZsga4BFI
         kOi3QmV1K/T1oWH0qj3LBEtQ6CD3CYqDmYWMmNPRzppavs+XJjwnBLWrul4zJCOKNGfv
         R1QA==
X-Forwarded-Encrypted: i=1; AJvYcCVB4qXS6DhjDKyUweR3/vn58kbEE+V+S085zPzDxae3d2lckDe+M6vuzU2Ecz8BsOdeqMxkdWfK6uHtSv517O8VEUqSTnZONJAiVEDRh3fXzxe+i+HUhu0d0DL5ECANbmTs7sT1eUtaXNw=
X-Gm-Message-State: AOJu0YwVXSmt4uOpNL8jKsn7kHa+RVDlmrSjfce+jsIYzTBuOQaJHMAO
	NPBgiAVkLJbpUdqoWBIi/ZzdJC0W/5nbkzma0DfH24IsuNhA1kDOcUiOEd/biOgWF1H4cnw/bxa
	0bHMn9qahT9+ulbxyDUpU/28eWl7T59hydEHKSg==
X-Google-Smtp-Source: AGHT+IE7JnacY/Ay9AFFtmTzAWUNFIS1+xe46vcWjFQAe7NhUiGg/wK0RixRDKsonXhJD0viq/sSraHjVkcZkVK2wtU=
X-Received: by 2002:a05:651c:609:b0:2d2:2b74:4bdd with SMTP id
 k9-20020a05651c060900b002d22b744bddmr2337816lje.8.1708452568397; Tue, 20 Feb
 2024 10:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 20 Feb 2024 12:09:17 -0600
Message-ID: <CAH2r5ms2Hn1cmYEmmbGXTpCo2DY8FY8mfMewcvzEe2S-vjV0pQ@mail.gmail.com>
Subject: folio oops
To: David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

FYI - I hit this oops in xfstests (around generic/048) today.  This is
with 6.8-rc5

Any thoughts?

125545.834971] task:xfs_io          state:D stack:0     pid:1697299
tgid:1697299 ppid:1692194 flags:0x00004002
[125545.834987] Call Trace:
[125545.834992]  <TASK>
[125545.835002]  __schedule+0x2cb/0x760
[125545.835022]  schedule+0x33/0x110
[125545.835031]  io_schedule+0x46/0x80
[125545.835039]  folio_wait_bit_common+0x136/0x330
[125545.835052]  ? __pfx_wake_page_function+0x10/0x10
[125545.835069]  folio_wait_bit+0x18/0x30
[125545.835076]  folio_wait_writeback+0x2b/0xa0
[125545.835087]  __filemap_fdatawait_range+0x93/0x110
[125545.835104]  filemap_write_and_wait_range+0x94/0xc0
[125545.835120]  cifs_flush+0x9a/0x140 [cifs]
[125545.835315]  filp_flush+0x35/0x90
[125545.835329]  filp_close+0x14/0x30
[125545.835341]  put_files_struct+0x85/0xf0
[125545.835354]  exit_files+0x47/0x60
[125545.835365]  do_exit+0x295/0x530
[125545.835377]  ? wake_up_state+0x10/0x20
[125545.835391]  do_group_exit+0x35/0x90
[125545.835403]  __x64_sys_exit_group+0x18/0x20
[125545.835414]  do_syscall_64+0x74/0x140
[125545.835424]  ? handle_mm_fault+0xad/0x380
[125545.835437]  ? do_user_addr_fault+0x338/0x6b0
[125545.835446]  ? irqentry_exit_to_user_mode+0x6b/0x1a0
[125545.835458]  ? irqentry_exit+0x43/0x50
[125545.835467]  ? exc_page_fault+0x94/0x1b0
[125545.835478]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[125545.835490] RIP: 0033:0x7f9b67eea36d
[125545.835549] RSP: 002b:00007ffde6442cd8 EFLAGS: 00000202 ORIG_RAX:
00000000000000e7
[125545.835560] RAX: ffffffffffffffda RBX: 00007f9b68000188 RCX:
00007f9b67eea36d
[125545.835566] RDX: 00000000000000e7 RSI: ffffffffffffff28 RDI:
0000000000000000
[125545.835572] RBP: 0000000000000001 R08: 0000000000000000 R09:
0000000000000000
[125545.835576] R10: 00005b88e60ec720 R11: 0000000000000202 R12:
0000000000000000
[125545.835582] R13: 0000000000000000 R14: 00007f9b67ffe860 R15:
00007f9b680001a0
[125545.835597]  </TASK>


-- 
Thanks,

Steve

