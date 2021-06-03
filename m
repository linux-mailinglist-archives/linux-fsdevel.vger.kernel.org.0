Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73B5399E25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFCJx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 05:53:27 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:51962 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCJx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:53:26 -0400
Received: by mail-yb1-f201.google.com with SMTP id d6-20020a2568060000b0290535b52251cfso6991726ybc.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WodA4cwW8evDahl78i//uxClrYSQx00er8Xt0Jxhbsg=;
        b=Ygw51n8wfm9lFZI3xex/mXBhfGsFka65cBbbx7b7+2vgBJoUY9GqxJIMPumNpKmwar
         JPSYeqjLVCudYagM9pzYAr/DIyUDfSi0I/FRTAnE0+v1qsbkc3WeqThX/OuEDlTvrXNb
         zbfdmipGFsubXExWhZ8kpX+CBcwTA1unFVoB+rN2HJ9TD+VDqMyqmhK7gZr0jsklQzJF
         TFE3HA320u2bqyxCCPVbmB0CpCpk6uEz/3zXyUzA7pEFaIhKNloAN/cIHy8c23Z9qAn4
         bRViw2ck+o0aJXumDz0Z9p1VJzESEfLTSR7GquUMH756oFy7zugzbQ2J68fv6sx8eaNc
         y+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WodA4cwW8evDahl78i//uxClrYSQx00er8Xt0Jxhbsg=;
        b=aRLbaYYmY0z6CpPZJNEwMW2AI6eZ9bLJWNrAJVTYaTCz/oGt13diRdgoNpJP2fBNvQ
         7SujVNqo/uYYLHdi0UJ7mQUAt7Gq45swoDKb5bFugIXtbklyK6m6YV64CrO63aefifFm
         3G4xN5V7JzMrtLznmx0fzgvF8G1XuGkK17W2shVSHyp6iAfZnteVRfLvJiHqI8o+AYQk
         vyzsAnxMeuifL6eyY6q29jXA6DsQYKgxGlvNLuXwTVIiTubv+KKHPqVCVQEZle9cE9R4
         TYPWqT/1lxR4QJxXYbKpvc75HtLlvpci/T2Ats+0kuyjQNNL6DrYQqCVo+xnDt8xTfAd
         tJ9g==
X-Gm-Message-State: AOAM5339mp5VBc6eXaXxur+NRMY9Fi9yi152ZtTPJxUjFQDuGo33eJC4
        sFmAD2cbVJeeWd1Xy78v3IQ9nqxZB8o=
X-Google-Smtp-Source: ABdhPJynmwoj0mblrAdNot1lXDwB1wQmT9NFiOhQkn9P5Mn/HixT+3+tCZIHQCVLgAxmlYiVHkU6IcBz00I=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a5b:489:: with SMTP id n9mr52932311ybp.45.1622713842127;
 Thu, 03 Jun 2021 02:50:42 -0700 (PDT)
Date:   Thu,  3 Jun 2021 09:50:36 +0000
Message-Id: <20210603095038.314949-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 0/2] Fix up casefolding sysfs entries for F2FS
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These correct displaying support for casefolding only when that capability
is present, and advertise if encryption and casefolding are supported
together. Casefolding requires CONFIG_UNICODE, and casefolding with
encryption wasn't supported until commit 7ad08a58bf67
("f2fs: Handle casefolding with Encryption")

Changes for v2: Added comments to double #endif's, added Fixes and Cc tags

Daniel Rosenberg (2):
  f2fs: Show casefolding support only when supported
  f2fs: Advertise encrypted casefolding in sysfs

 fs/f2fs/sysfs.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

