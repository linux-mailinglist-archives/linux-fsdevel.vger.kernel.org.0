Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2C351188
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhDAJJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 05:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhDAJJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:09:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E746C0613E6
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 02:09:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id v10so965043pfn.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3E3WfnmsRcCOXraj/CRRvpeiE4ZMxFvi1kpPttSBTBA=;
        b=puPf+QorSmvJ1a/xime3aehCman5i+p9Lm7CKq+fv0mD/WjUCeqzkHhdlT6TfXNLxQ
         UTQaHRFebT+gfT8MGV3i2WjUHDZLTw9TI4dUFEQLdaYxKql7K3LJuhWd0RMy44GlRBkt
         U/ZxYrd7DuQUvV9n/NJ44kR10AuYxjkWP6wOQtjEWtqDzdaDpI8316E7G5INo3sS64J8
         ayn6udEIArfT6Dv867fv08JMzCGXhdWB13T0lN7GzBoUuLJi+6ZPsxmQ5NGsfJcrfuSd
         kBRE84DzeHRvYxqvaEzwL+zqm+EZXqFmnTN7V1S0C0dikMFsuRyYX9evG1FTNEemrnUO
         /nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3E3WfnmsRcCOXraj/CRRvpeiE4ZMxFvi1kpPttSBTBA=;
        b=fd8rTE+/im5o4X4cj905514dBmpMi8GuqFrs3xXqN1SRGzNEyEzbkwV4wGvEOPXmkm
         NVGFAIjfHMbEX9CvkzVKND1RzgX2IB63oTVECBgFd7CRBYDJmF+UqUyRS1s4WyYLFZR+
         ycv2Wk1Wsq6ORqgMD8594UlsenwrAkO23XTYxUuVXUc7rD3K27VtnfnY3Lka4hB7pFf6
         slwgFL/TRBMZZuK0RnAQBnO3LFmCRF586fT6Bjxpbdca3wzCZyCnIwTFbdgs8Xv0Q2m7
         QIG0+KXeoiBJeEkwgrno1LPANMcu+N4eAGaIG0PQz0fnpKS5fJ0WszATUKz0DcThjvhO
         z3ug==
X-Gm-Message-State: AOAM530gTbhV6vqCPK84F6bWJlZCV98i7QoUAxlB7hSqpPvng+qIFRJ9
        40Feo0U6eKXb0He20UcA0v0x
X-Google-Smtp-Source: ABdhPJz66+Gm1zWC1Zd92jqOvzeWFOnIeQysdpnWAYf11POOjdzKuJBDPIP8yDBlp2RQKwQFJgXUJA==
X-Received: by 2002:a05:6a00:cc8:b029:217:4606:5952 with SMTP id b8-20020a056a000cc8b029021746065952mr6748921pfv.50.1617268185082;
        Thu, 01 Apr 2021 02:09:45 -0700 (PDT)
Received: from localhost ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id a26sm4910686pff.149.2021.04.01.02.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:09:44 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     christian.brauner@ubuntu.com, hch@infradead.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, hridya@google.com,
        surenb@google.com, viro@zeniv.linux.org.uk, sargun@sargun.me,
        keescook@chromium.org, jasowang@redhat.com
Cc:     devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Export receive_fd() to modules and do some cleanups
Date:   Thu,  1 Apr 2021 17:09:30 +0800
Message-Id: <20210401090932.121-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series starts from Christian's comments on the series[1].
We'd like to export receive_fd() which can not only be used by
our module in the series[1] but also allow further cleanups
like patch 2 does.

Now this series is based on Christoph's patch[2].

[1] https://lore.kernel.org/linux-fsdevel/20210331080519.172-1-xieyongji@bytedance.com/
[2] https://lore.kernel.org/linux-fsdevel/20210325082209.1067987-2-hch@lst.de

Xie Yongji (2):
  file: Export receive_fd() to modules
  binder: Use receive_fd() to receive file from another process

 drivers/android/binder.c | 4 ++--
 fs/file.c                | 6 ++++++
 include/linux/file.h     | 7 +++----
 3 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.11.0

