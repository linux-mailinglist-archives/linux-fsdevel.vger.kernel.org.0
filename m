Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D585911EA67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 19:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfLMSgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 13:36:35 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39347 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfLMSgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:36:35 -0500
Received: by mail-il1-f194.google.com with SMTP id n1so236793ilm.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 10:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LN/80NF8cbWQM7vxxDct+WUJsuevWURUaIBSKYZhVqw=;
        b=GrkZ6c7LM0dvTaNJu/Tqj710himBg7AR5tzpKYfLIe7r/08eIMtz/Yq+91BKvAwHiP
         oimE+1OCay0GGYB3vvR20v5qmgBBPGGOqfUJiqYLIPDXsmcfRVcK/LdL2DBA2PD0cq3N
         3iKiBYaFPwqVJG4IYSVGf3/Pi7h3SFVOopQ0ixUun/sLqF3g2sv1fYkBiT2KEHv2SYoW
         SUB7oeAowd/hcTBy6xLiGbjnDDaRvQHbJKwHPB+g3dPfUvE/tr3HX9NFjmUbLWvx4Jez
         x1xYvM2eewBeuNF2WrYnK/D9GxK3GK5jF3xn2uj+sBZTfKhOwby3AKhW83f6KpMZyYAK
         gAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LN/80NF8cbWQM7vxxDct+WUJsuevWURUaIBSKYZhVqw=;
        b=HgdR8ULyjdRsv1+znbIvgXAf5kdrxJJuDtBbPi1YIBtCWcTw6Uodzm7KUmNjQtvIxn
         jRSezPkNuM4TFlbhf8Qvng1pWaS8mzJsPR2ThYBZs/IdrqtR06Q4X8A6E6SCEmqcka5A
         o3qeRHsXVEYpQ6+1W2s2CTma5KDV3nJvd2WSMO2lsTKSx/z9gpyBw2J9fXxGnaBFJ8CG
         as+ChRsHaHI7XpV+q7ErvYQDKnD6cRG3SYdHB889C0PtAwXqw/AL2YleQ7pu3qlfxR8j
         qURkuokSKw++W8lZU312jySTyHPthZq0tAuYbzUdPH0KXseogeXSZO8KkHKIkflVjJcb
         8d2Q==
X-Gm-Message-State: APjAAAW27txBNi1wkK4tQ/OaOPRCZHeAelxBrJwhfem2q+gFwn8I+yex
        herrQ90kZH6pnm/ryuIAcfyJnUQ3+POM1g==
X-Google-Smtp-Source: APXvYqx2zd95UAJhUHElWLxNIObtDQ/MIqLzjIYN5RmtwDLDaIII7mESEruxe8lQjg6BVFWGOvNkjw==
X-Received: by 2002:a92:2544:: with SMTP id l65mr672625ill.304.1576262194930;
        Fri, 13 Dec 2019 10:36:34 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w24sm2932031ilk.4.2019.12.13.10.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 10:36:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCHSET 0/10] io_uring items for 5.6
Date:   Fri, 13 Dec 2019 11:36:22 -0700
Message-Id: <20191213183632.19441-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mixed bag of stuff here, highlights:

- Support for fallocate(2)
- Support for openat(2)
- Support for close(2)
- Much faster file updates/registration
- A few cleanups

Against the io_uring-5.5 branch that I shipped off to Linus yesterday
and can also be found in my for-5.6/io_uring branch.

 drivers/android/binder.c      |   6 +-
 fs/file.c                     |   2 +-
 fs/internal.h                 |   1 +
 fs/io-wq.c                    |   8 +-
 fs/io-wq.h                    |   1 +
 fs/io_uring.c                 | 704 ++++++++++++++++++++++++++--------
 fs/namei.c                    |   2 +
 fs/open.c                     |   2 +-
 include/linux/namei.h         |   1 +
 include/uapi/linux/io_uring.h |   5 +
 10 files changed, 573 insertions(+), 159 deletions(-)

-- 
Jens Axboe


