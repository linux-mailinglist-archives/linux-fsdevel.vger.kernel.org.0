Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A999B45F59E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 21:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbhKZUEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 15:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhKZUCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:02:06 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64583C0619EB
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Nov 2021 11:44:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w1so43065105edc.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Nov 2021 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=T2WjcJMogJUqwl7auwMJR6uAomfwfWvBoMmZ62DhD5s=;
        b=HtcaQXsaNEzfzLJkKGbxnOEKWSL8ViT8fA+EwlSZ1jyD9lC9dTU93MeZ6Pd1AU75SK
         WvNIqyR7rZZP1OtjQsKwMMKs0oW3rQjvTu4ugkFC+6R1IQtOdywvS4ARx6rPrt94Yann
         /lcJfzzagrRSqQ+La502zhgxPLDI6A1PBhrZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=T2WjcJMogJUqwl7auwMJR6uAomfwfWvBoMmZ62DhD5s=;
        b=CutlvbW/KO0U68lyyure3VKHiczicEpmSMUMRaOuLecdzR7LPtCeQDrq3D4mrOt0c0
         NsbTJky1wKEPCfoEbhQ64nqw258M4j2qhAC9FeuoOCbYmUWJ7bkNCaB6auUSMe1Uqccb
         rxqpj7FMzKenkfuhf2G5dzJvWaNoss70LqFmiwkL8N1mrDAA7OAFVtYpykARswTFydeo
         gMstHc+EfuFbA7rsuE2Uo9mSIUB0dxIUJKPnh9++E+mB51D/RDv9lu9Drn5WhYF5m/UZ
         ApB/SKuNDMVjysEdTjQJZNd8rjnke29wBuNZaDUrEeeWqP778+L98/X57TWmwNb0nOmI
         KEbw==
X-Gm-Message-State: AOAM533WvIK6EFeVyzK/5MbCGjhXj3yPtdUhgj8gcJ9l6pcQoLQlxoxF
        UzU+fTeKmqObrC6ZR2qVJqM+0bbSClSBpQ==
X-Google-Smtp-Source: ABdhPJyRGOCQd4lVfadvwALi/7ZG7nxnUMUhAM3e1UTEwNd/2IVfVaQp1SQh3AOJ9cVnVUAt9Hcghw==
X-Received: by 2002:a05:6402:1a42:: with SMTP id bf2mr50827763edb.64.1637955895925;
        Fri, 26 Nov 2021 11:44:55 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.broadband.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id nb4sm3674514ejc.21.2021.11.26.11.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 11:44:55 -0800 (PST)
Date:   Fri, 26 Nov 2021 20:44:53 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.16-rc3
Message-ID: <YaE5NdAaxf0vuEew@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.16-rc3

Fix a regression caused by a bugfix in the previous release.  The symptom
is a VM_BUG_ON triggered from splice to the fuse device.  Unfortunately the
original bugfix was already backported to a number of stable releases, so
this fix-fix will need to be backported as well.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (1):
      fuse: release pipe buf after last use

---
 fs/fuse/dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
