Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5DF4070E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhIJS0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhIJS0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:26:53 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5467DC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 11:25:42 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q3so3506518iot.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Vg/TxJx63a6Prh8d9/6qNscaebIESeGpR+mOWO6b+k=;
        b=0ZN5l7orVRtwjzzB+pmEYI5kgoJZ7L99LqxCzkXrNqh6xI5XOuWyHvDrws/fa4awJz
         MUqxIwfAH2INCzV6t3EAlgvJ9cyFD9bTNbtsdFwDlRgKIulI4TcansNR5Sq0YZbWdoJR
         Bj8QoS6q9BcItcjZFkF4c5U20GNRujXXgssl457TUHotb+NXi4raxVXfqUB3ieNHEgfZ
         6HDacflIDY2lCvGkVFOhnpLo24uJR1c7S36CsjNHly5Nzy+TaG8XPv4hMaSrJMU/+kqH
         ih2o6M9yu71V3UP9UUqrOLUDkjbQLRZHPQSNINuItIT8+KqIo/+8NTODEG2ZrZi6nbyE
         oUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Vg/TxJx63a6Prh8d9/6qNscaebIESeGpR+mOWO6b+k=;
        b=b9HJfmiplyZlzJsnaYw6RQ94rrEnuYFmAH92nIm0Q0J0Dp5w1/uShHP8pmlfgzSVj6
         x0uRORJTC4GnuCw7IHiPOsc3YqJhHcBmEyFGetEQ6aCR8UoNzCgQrVc/zBrpdfMgGvY5
         P+29DRCuir5jadM8Hj4Jw4pwXqj4/G3YMZS2t0pMyFtzXFipoXaZJkNFSUwPqvHErZn1
         ApLN1uf3+d5ru/nu3DuYnHl+1iJZF3OuEK+Mjxk/idUJT6njC4x0QU8hceUlz1/V23bI
         v96VXaPxWLTOpWBkPAQGXNcuaptwexpqPOUzLAfAlK2sNVBqyq0EHTHDe/YMM5In+nwH
         9TNA==
X-Gm-Message-State: AOAM530N/jRKflahozdQ84P1N7WW1l2oEjRVrqr4Ra1N46AdfdLx0MIq
        xxRmcgpDCegeE23b+JMT4NW+AXP8o7SH89CnET0=
X-Google-Smtp-Source: ABdhPJxVHW7Q5mx1xrhGM4a6BQn7Vb8+mSP0KRnQLSfr+uhoGu2/u+bFXw+qqcMqtXuheY8+PsQlLA==
X-Received: by 2002:a6b:c3ce:: with SMTP id t197mr8107952iof.159.1631298341644;
        Fri, 10 Sep 2021 11:25:41 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c20sm2575149ili.42.2021.09.10.11.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:25:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Subject: [PATCHSET 0/3] Add ability to save/restore iov_iter state
Date:   Fri, 10 Sep 2021 12:25:33 -0600
Message-Id: <20210910182536.685100-1-axboe@kernel.dk>
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
conditions often, and it seems to pass muster.

For a discussion on this topic, see the thread here:

https://lore.kernel.org/linux-fsdevel/CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com/

You can find these patches here:

https://git.kernel.dk/cgit/linux-block/log/?h=iov_iter

-- 
Jens Axboe


