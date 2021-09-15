Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80240CA15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhIOQbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 12:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhIOQbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:31:01 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A435C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 09:29:42 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w1so3590724ilv.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UxuAkQ4ZtEcbC+XH0J5oJ2exv4p4EDf6m4KsjfHsOSo=;
        b=d4BsZUAHcQWlZRxgHrvDbCkMmPZAsdoZEzZwBDP59rutjmrLeTwIz9qARf8OewK3Wp
         UxlKzMP6tmWPE0mCM9Q4F2zGQyT2i3Ev6sXkU5QOHBREW0B5VCJ4qpMo3+Q5WqNKov0L
         CE0ELiE7emZ/v6aKI7PcDb047fIHhoXlqb/zXSmoYs5ed0735klf8/Yc2lg2/3dLtwMn
         yUJQ3h54j8Ii13o7kAo3eI8veZkHtNpGANTM3p/MeZWdLyXRbu35e/+4GJQUC2lCqvlp
         bL+G8ppx7fKbrlkHl+uqCiCwBv1WXNiGD0BiT88oBrDhF1dGw65qIo4qALhcdC/J3HeS
         lAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UxuAkQ4ZtEcbC+XH0J5oJ2exv4p4EDf6m4KsjfHsOSo=;
        b=6ik9Wvp6UCPKghqLdPN9OdhcGdpboWsSUCYcUWgtfISghGj1Yc5HgKuvG2VOraSr9P
         BSSX3cpPqmtRjJg4jnDVcPyeAXC/1x2gRC2cZSsI1j58RC4kTPnQ/JUTPFxIAELTStgg
         hdgUq3KdbSxo4sl+2ssTfaLl0D3JgK04ZPqJtSRHNnCU7kw89mEBis2RJfEyYCSaj1dy
         NxsZOlkJxfD8bdn2cLsX11D/PS2+dJrgjMmqDaKlF0gWEUa907Rzxry+ZAq+rSCwIH3D
         y4vp3PRPr4wxG1qL7ZWQZWSX9yh4KZBU/nI8miHcuGpRhg/aA+novH3wAq7eFl09WPW7
         tEPg==
X-Gm-Message-State: AOAM5313uMgxuuUqr+L7Y0TsS0CTmNKVnVrZjrxntGb/nD9xxsmGp3oI
        6aoPA/w/1Ud7F3vOJUhQIxmZOA==
X-Google-Smtp-Source: ABdhPJzUsCoNUfzqz1dDtv0AlqnIYxxmDSmXZINr6v8l7jYvuEsMjmwaot8J1UrnGWEzrIFvxKmPsQ==
X-Received: by 2002:a92:7114:: with SMTP id m20mr687074ilc.114.1631723381941;
        Wed, 15 Sep 2021 09:29:41 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t15sm227160ioi.7.2021.09.15.09.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:29:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Subject: [PATCHSET v3 0/3] Add ability to save/restore iov_iter state
Date:   Wed, 15 Sep 2021 10:29:34 -0600
Message-Id: <20210915162937.777002-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Linus didn't particularly love the iov_iter->truncated addition and how
it was used, and it was hard to disagree with that. Instead of relying
on tracking ->truncated, add a few pieces of state so we can safely
handle partial or errored read/write attempts (that we want to retry).

Then we can get rid of the iov_iter addition, and at the same time
handle cases that weren't handled correctly before.

I've run this through vectored read/write with io_uring on the commonly
problematic cases (dm and low depth SCSI device) which trigger these
conditions often, and it seems to pass muster. I've also hacked in
faked randomly short reads and that helped find on issue with double
accounting. But it did validate the state handling otherwise.

For a discussion on this topic, see the thread here:

https://lore.kernel.org/linux-fsdevel/CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com/

You can find these patches here:

https://git.kernel.dk/cgit/linux-block/log/?h=iov_iter.3

Changes since v2:
- Add comments on io_read() on the flow
- Fix issue with rw->bytes_done being incremented too early and hence
  double accounting if we enter that bottom do {} while loop in io_read()
- Restore iter at the bottom of do {} while loop in io_read()

Changes since v1:
- Drop 'did_bytes' from iov_iter_restore(). Only two cases in io_uring
  used it, and one of them had to be changed with v2. Better to just
  make the subsequent iov_iter_advance() explicit at that point.
- Cleanup and sanitize the io_uring side, and ensure it's sane around
  worker retries. No more digging into iov_iter_state from io_uring, we
  use it just for save/restore purposes.

-- 
Jens Axboe


