Return-Path: <linux-fsdevel+bounces-50716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 645FFACECBC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 11:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1AA3AB5B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDEF20C005;
	Thu,  5 Jun 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HFDtQNSX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B7566A
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115400; cv=none; b=UHTNKchlmeUnjwop+IrKgqcBDCOQCfTcPIfRU5+ce9djIP5U+Mj3EyiMi6hdDDjH9ZVV3HUqvMwzCrMa5QnzXzrKJOYYXgV0xpB+ki0MUaSpHMdgCxe8f+xXl9Djd9I6z7CqSRBGfh+wnpQrnBjdlqiJTZcinB1haK21PJ5QJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115400; c=relaxed/simple;
	bh=LdksxAdZMV0O2bMPUPb50S3RXaDjNvXNL/6IF6EW5ZA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JDFP0nawywknqqM9kHigrXHky6agEpL7xK7QQ0IBoszE8Tht+jmlrqCFqHAUCySM52Q1OFGPqPDWZ1M0EFxac1QiR02v7vgWuLHgyOW7bZviJOYlefZvhgZQ2eRZJgpWLvFYbSAoJ1q+QVtyRtn7Oz02kahmNS9s50Y6nMPur0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HFDtQNSX; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313154270bbso874378a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 02:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749115397; x=1749720197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LdksxAdZMV0O2bMPUPb50S3RXaDjNvXNL/6IF6EW5ZA=;
        b=HFDtQNSXcFe1/G5B/4iz6vshHU2flbZFf6/jPmrMWJ00VfR/AHVaw/6xYmZwicB4v/
         dtGzNCPU1ruEZGXt60oMq0YfyDXYldB7QryC4sTXhZxwNAHSjpS87q5BpBp8NT1Q0Py0
         84jZ8tBUXM9XuxX+rO+bVBcofYmttcHwhJB5GY8ZyisE5n3tgZLwAmBznNtAcgF2GQS9
         9d79sMk2NSwCUXJb1Vcfw88nCaRSYfeCq+5KviBYDC8xpwY2M30w4QX/XKvhfsOpZ4EG
         S3oVoB/dcXAzYc9HedklolyU70FRgUGMgWj938ePUJRTXs9syr3R8lFOqEVZotMq+yWC
         mefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749115397; x=1749720197;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LdksxAdZMV0O2bMPUPb50S3RXaDjNvXNL/6IF6EW5ZA=;
        b=llfZ4qzPowL25JzMCOMeTxYbejobVe1YPZhsfBxYl9bVJnU53vQ0bo2LwPhrIA8Hyj
         vVdCbnKqnq0j1NpS4dFSaRixDgZDxo6aH+ZqcvL/Q/jddvH3VM07J5D4Ia/bhSeS0BkD
         wL/ybn7gfuXEU599Z2zPssNGQzen2VDT2NGQ3YrBsQHwm47OsqIjgRCf1TSthAOd4bHf
         2dzPEjdbsGlTjFqX2sOowshiIDhn11vIDHI4f6adyNBsxEljKM6LWMfVRpxYPbH4fhWC
         jt7b0iNjFBw9Ob6tZFRh3S+A4uIn4qd6uRfWd7FsU3MrgqBmKLzrPFwWq44Es12ALuCe
         i7kQ==
X-Gm-Message-State: AOJu0YwPRjuZw+nE9bMFLwhJhHswuFjDb/kizVHaGAvGZPDa8ZSRdHSY
	XzIv/xRxSeXxaGWr0HY0QwAoLErl8Wpk4xdq1UC9ilrNBzELQOLT6Y4j/6szRGp+PB3iqrIWepT
	CIwWwXACXVCnA5FiUVrSwe/wwvwcLnXbLFUrzsOtNkAJlVDlPM1Mns7NT/w1fwg==
X-Gm-Gg: ASbGncvj6pnu7+gSu7xpHyyVFMZrX9acXnj1S70lvahZ2t9fZlNFh9ip9T6wo95vyyi
	kso7GROS3+kYyjmwtXveg+1bEoOGuqGFTPTba2p9kvpDzQjYvF3vSySGGcn8r+c3CP6aSu5W/uM
	IFoKx/kXyFP7Dxb7F5XIw1JLaV8DUYBNl1MyLzJyxJeZixfl6yxhPEt7DGFXiKFcIVkMUfviY=
X-Google-Smtp-Source: AGHT+IGVI0ATGNBPKqzzbUtxgAaCmg/+KvieS7j0nIOPKunQlg4vA7+YnldXGX1bdV5UYNsRTuzij1F4j9PlPaxW68A=
X-Received: by 2002:a17:90b:268b:b0:311:ab20:159a with SMTP id
 98e67ed59e1d1-3130cd7e191mr8996384a91.29.1749115396864; Thu, 05 Jun 2025
 02:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Prince Kumar <princer@google.com>
Date: Thu, 5 Jun 2025 14:53:05 +0530
X-Gm-Features: AX0GCFuuTN1tVf64U9LvN3lBaOZzbo8kwOjxP-gxsPZG2fyhTvlMnY1kxLbPDEc
Message-ID: <CAEW=TRpJ89GmQym_RHSxyQ=x97btBBaJBT7hOtbQFKyk4jkzDQ@mail.gmail.com>
Subject: Getting Unexpected Lookup entries calls after Readdirplus
To: linux-fsdevel@vger.kernel.org
Cc: Aditi Mittal <aditime@google.com>, Ashmeen Kaur <ashmeen@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello Team,

I'm implementing Readdirplus support in GCSFuse
(https://github.com/googlecloudplatform/gcsfuse) and have observed
behavior that seems to contradict my understanding of its purpose.

When Readdirplus returns ChildInodeEntry, I expect the kernel to use
this information and avoid subsequent lookup calls for those entries.
However, I'm seeing lookup calls persist for these entries unless an
entry_timeout is explicitly set.

One similar open issue on the libfuse github repo:
https://github.com/libfuse/libfuse/issues/235, which is closed but
seems un-resolved.

1. Could you confirm if this is the expected behavior, or a kernel side issue?
2. Also, is there a way other than setting entry_timeout, to suppress
these lookup entries calls after the Readdirplus call?

Regards,
Prince Kumar.

