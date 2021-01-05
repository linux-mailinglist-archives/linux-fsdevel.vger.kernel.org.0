Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2922E2EB29E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 19:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbhAES3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 13:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbhAES3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:29:54 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D4C061793
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jan 2021 10:29:13 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i18so292869ioa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Jan 2021 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+TyQkEMafuxHeItsQmIw3IkEc+mWTDN39fb3kbBoCAQ=;
        b=SUnf7RuciFcT7xoD/lKhNL+PDI/zrsFawvjUbXJAVrZn0I7SGaLzrfDZAzVB92/71m
         9T/bmyhAiNxUrRbDsA5t0Iz50Dma067juh75ksoMK313gwGRyxbn1F/hPp9RQvQYmOyd
         gYPuLsVF5s0Z6YeiW4ICYvfIyn6vcCslod9h1ZfZ8s++Qz0CFPT0QO5kGwbLGCaCGg7x
         wCRrn8r+NJkUL4ZOujT2KsDRmfyYNy8e4t0LdVrrZgsv2iqhXkl5KorpXviYaROBRrh9
         shkuYqNyY05HBiqf8Ozn4Qrka8/fcaOyD+9z38U6W6dOL7mMgoMiRSf6b8dVcF8yV1xt
         u6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+TyQkEMafuxHeItsQmIw3IkEc+mWTDN39fb3kbBoCAQ=;
        b=E0TM/6UzNrSVjcIgV9rfgTmT8DTjOh9FGKtDQlzg5C0EDuDbGQxNgu9cespsjQWIZu
         Xvz3c5SKESpYJeWV5RahCXAP2pL1zYCVN2ppbef7MAIqJWg1NfvUz/Fx5aq2y/I/72TJ
         3xlJ1fFyARo2YGf/jLoiVt/Hp0c0fHwhO4qlu6qxgayLqE02Rp9TVZLDli1T4TWhO74s
         mU+ZSo+fC/k/z1S7DW8wTQTecf2Tk+WGe4WnoJ+CZqG/rCHySXNqQdIhixg7Xa7KMCtj
         2iX503Wo34SEl5w39ZDZqTecBjEAcL8w4R1slfBd+sJqRUoxfADa5xCxDkuySS1h33hB
         r+EQ==
X-Gm-Message-State: AOAM530vFHw0Jzdl0KzFlRfTuD9q6skbwi6KaSip80Jo6AGIznk4g8cI
        zFx98+fV6GfjQi+L+kAQ3ebniA==
X-Google-Smtp-Source: ABdhPJzYusZ33kX0BXHdXB9ebF0uo+0mpGyGAAOfZD4Tg5IPe4ZCx+Nhm43vG5uXAXrLq9SUTx16+Q==
X-Received: by 2002:a02:9691:: with SMTP id w17mr812141jai.9.1609871352998;
        Tue, 05 Jan 2021 10:29:12 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k76sm61777ilk.36.2021.01.05.10.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 10:29:12 -0800 (PST)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fs: process fput task_work with TWA_SIGNAL
Message-ID: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
Date:   Tue, 5 Jan 2021 11:29:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Song reported a boot regression in a kvm image with 5.11-rc, and bisected
it down to the below patch. Debugging this issue, turns out that the boot
stalled when a task is waiting on a pipe being released. As we no longer
run task_work from get_signal() unless it's queued with TWA_SIGNAL, the
task goes idle without running the task_work. This prevents ->release()
from being called on the pipe, which another boot task is waiting on.

Use TWA_SIGNAL for the file fput work to ensure it's run before the task
goes idle.

Fixes: 98b89b649fce ("signal: kill JOBCTL_TASK_WORK")
Reported-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

The other alternative here is obviously to re-instate the:

if (unlikely(current->task_works))
	task_work_run();

in get_signal() that we had before this change. Might be safer in case
there are other cases that need to ensure the work is run in a timely
fashion, though I do think it's cleaner to long term to correctly mark
task_work with the needed notification type. Comments welcome...

diff --git a/fs/file_table.c b/fs/file_table.c
index 45437f8e1003..7c76b611c95b 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -338,7 +338,13 @@ void fput_many(struct file *file, unsigned int refs)
 
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
 			init_task_work(&file->f_u.fu_rcuhead, ____fput);
-			if (!task_work_add(task, &file->f_u.fu_rcuhead, TWA_RESUME))
+			/*
+			 * We could be dependent on the fput task_work running,
+			 * eg for pipes where someone is waiting on release
+			 * being called. Use TWA_SIGNAL to ensure it's run
+			 * before the task goes idle.
+			 */
+			if (!task_work_add(task, &file->f_u.fu_rcuhead, TWA_SIGNAL))
 				return;
 			/*
 			 * After this task has run exit_task_work(),

-- 
Jens Axboe

