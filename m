Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1822407F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgHJO7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 10:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHJO67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:58:59 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01CDC061756;
        Mon, 10 Aug 2020 07:58:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so5024974pls.2;
        Mon, 10 Aug 2020 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3EOXOOWYYlAj99G6WV2By0kWl8SEe77hw4rKVyQwu0k=;
        b=jSa433kL6JihAjzQB2FOaVyp+FMxCEVWBQ6/BOiywhrd3vANIBjSxgF2SUz3ypRjxA
         mDMRPSEPY3SB6ePtMUgBmIBhojD2LNaRH/ZBoUNpDgZ0IVzoJpvYYbC54yvQutNIsYo8
         Vn+oNNp+cmzYEyRbML8I0jGD7bry7/jM48QFfvXlL/0oM+t7lpiamVNewmAEKcT15kZh
         geWKthbuDMVElHXDFzXXNXMUnrmTnimWaB+2tv89sg361HXEw4e7nnuLiIWDzsnClwRC
         TUMd2f2TCX0nNbVdUbdQRtpxN9T6EncjWaZosRo4lN2a4eCB3Xh9qPh0deEoWahfOy7T
         JR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3EOXOOWYYlAj99G6WV2By0kWl8SEe77hw4rKVyQwu0k=;
        b=bGbhXnfiT9Rt2Ey/BgOrmVWaVXgNr5eZbW5gd0TeHIfvMXbqvfemabtAuuXAHH9Mzq
         pea64+1Xsp8NSHRLY7pO+R4zaVdpBO9v+Uip0F8Z5mUJ241ZNl4Umg5xoG5z0ZZ6AbCj
         iW6P/OGjixu3T5vM6Bmce/5gwsA8AXmWXBwGkNgI/0EuLon8X0k+Aalo61Vzc65D1O9F
         YusXZniZGOkOMFyIW49o0+HeLcrrGWYTJassRzuSAcRUhjDuLog5Qk6U4ljaG0iK2Skz
         k63y1uUj6ENQ2RtgQWgOnUfeUThEUDbq9DRzxTKUMS+aBYkUYKuPw1q5hjn3BTIljvKW
         2y6w==
X-Gm-Message-State: AOAM531FRZpxQaonYvA8jd00Vh3b1BWfiwnj9BfEocw5apByba+z5aUB
        TCTYG/M0iXUGlymr9sK2FteLAP39v/A=
X-Google-Smtp-Source: ABdhPJxCbs4JlT5SLgTjn/gn7TmQM2XGF2gJa9n1eCk5hEQdNQtxFDZYx4GB+O3XbN3A8gOfHpnX/A==
X-Received: by 2002:a17:90a:ff85:: with SMTP id hf5mr26790162pjb.79.1597071538285;
        Mon, 10 Aug 2020 07:58:58 -0700 (PDT)
Received: from localhost.localdomain ([124.170.227.101])
        by smtp.gmail.com with ESMTPSA id o192sm25631162pfg.81.2020.08.10.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:58:57 -0700 (PDT)
From:   Eugene Lubarsky <elubarsky.linux@gmail.com>
To:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        avagin@gmail.com, dsahern@gmail.com
Subject: [RFC PATCH 0/5] Introduce /proc/all/ to gather stats from all processes
Date:   Tue, 11 Aug 2020 00:58:47 +1000
Message-Id: <20200810145852.9330-1-elubarsky.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an idea for substantially reducing the number of syscalls needed
by monitoring tools whilst mostly re-using the existing API.

The proposed files in this proof-of-concept patch set are:

* /proc/all/stat
      A stat line for each process in the existing format.

* /proc/all/statm
      statm lines but starting with a PID column.

* /proc/all/status
      status info for all processes in the existing format.

* /proc/all/io
      The existing /proc/pid/io data but formatted as a single line for
      each process, similarly to stat/statm, with a PID column added.

* /proc/all/statx
      Gathers info from stat, statm and io; the purpose is actually
      not so much to reduce syscalls but to help userspace be more
      efficient by not having to store data in e.g. hashtables in order
      to gather it from separate /proc/all/ files.

      The format proposed here starts with the unchanged stat line
      and begins the other info with a few characters, repeating for
      each process:

      ...
      25 (cat) R 1 1 0 0 -1 4194304 185 0 16 0 2 0 0 0 20 ...
      m 662 188 167 5 0 112 0
      io 4292 0 12 0 0 0 0
      ...


There has been a proposal with some overlapping goals: /proc/task-diag
(https://github.com/avagin/linux-task-diag), but I'm not sure about
its current status.



Best Wishes,

Eugene


Eugene Lubarsky (5):
  fs/proc: Introduce /proc/all/stat
  fs/proc: Introduce /proc/all/statm
  fs/proc: Introduce /proc/all/status
  fs/proc: Introduce /proc/all/io
  fs/proc: Introduce /proc/all/statx

 fs/proc/base.c     | 215 +++++++++++++++++++++++++++++++++++++++++++--
 fs/proc/internal.h |   1 +
 fs/proc/root.c     |   1 +
 3 files changed, 210 insertions(+), 7 deletions(-)

-- 
2.25.1

