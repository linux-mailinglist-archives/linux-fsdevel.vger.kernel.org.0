Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB72B259E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKMUfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 15:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMUfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:35:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D9DC0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 12:35:52 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z21so15887095lfe.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 12:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NckPtgXfN6MS9MFfgiNpJS/JgzuVpE4Dg5TdNsKgarI=;
        b=s/XG/nTa6i9hMd64JgLKI9ZnaxJoKzw9A8E7r2fcjEWxtlGB+CPxpZo3Lhl4XGN60+
         XQkFa2u7C0JqS4x8Tzwk/4EGO+IzHvejoCutt5gcoNziOY66Q++Yz8D8WkDvXeHH+5ZS
         XyMFySQG+LjLp+Q0UzG3HrJ5lnWpW95hL4BecAYOyF54OuerSqZqUgbXf9DnMUgSXRQF
         75rTvqNGpOA+lsmWSBNTtGMFgW58dLEnjhqsXVpXlFQv6G2c+RNmM7noYekaA6hR+gnJ
         yVPzUBQFDs5lCf0buEZ5k7fSc6zewMoQ+qa4Krpl5To2rYDmDyWTX821VX1gQ+GXSYKH
         2Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NckPtgXfN6MS9MFfgiNpJS/JgzuVpE4Dg5TdNsKgarI=;
        b=JfNIh1Ii3hjWmzYpicf2vv5rfsciFCb3Vnc4+EkRQkyOhaeWbGieLKsgKfEfSJf/zC
         DeQA/aLcaKVqlMfrv/UE1qrTm/RHONeIU7F8dA4F08oziyxmwF+Bgb47rxDM4MaQ76bY
         pM1ql1KDr7//ZVv5TKjt/eI/XX3OU68thMTmIBqRsEk1CEkrwYB/GD5nDa5nZdfsfTqp
         PZtm2XM7iCvqL9/Gk6VBosuVcaw2boYpvt3yyGwazfjs8KU1fB2Ya8o0+7+UiJLIELMh
         nEGXZ3wgTdy3AJ1KWaiQ4QVeKjECPCR2LI/j1CkCU81rTS3IBjFi0/5p0eOGZhChfjdu
         a2xg==
X-Gm-Message-State: AOAM533f+OYTyX8CMnXdxU56i3V/LT8JU+k/FlS+pQjkHI1B+NNsx7S2
        737u800XgAP36MjehRPTx2zNGeJkRvstfh9f7jJmLpNyqAM=
X-Google-Smtp-Source: ABdhPJy1hPZWV78BKrUdqhFIgdQ/PJdiYSM1pxfUsbsVNghwssM2LIGc8nRY5d6CpzZkmgjs8NVc80YapKPBnclrXD4=
X-Received: by 2002:ac2:5185:: with SMTP id u5mr1432545lfi.433.1605299750309;
 Fri, 13 Nov 2020 12:35:50 -0800 (PST)
MIME-Version: 1.0
From:   Igor Zhbanov <izh1979@gmail.com>
Date:   Fri, 13 Nov 2020 23:35:45 +0300
Message-ID: <CAEUiM9PxZSCuBPSuwkcWxZ2Q-=WFfMU461u2WUnXCw8UBN6x6w@mail.gmail.com>
Subject: Proposal for the new mount options: no_symlink and no_new_symlink
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I want to implement 2 new mount options: "no_symlink" and "no_new_symlink".
The "nosymlink" option will act like "nodev", i.e. it will ignore all created
symbolic links.

And the option "no_new_symlink" is for more relaxed configuration. It will
allow to follow already existing symbolic links but forbid to create new.
It could be useful to remount filesystem after system upgrade with this option.

The idea behind these options is that a user controlled symbolic link could
affect poorly designed applications or system services that are using fixed
paths to read/write their data. Such a place could be: /tmp (or similar)
directory, unknown USB drive with ext4 or user home.

I.e. it would be possible to mount external storage with hardened
"-o nosuid,nodev,no_symlink" to be sure that it contain only regular files.

What do you think about this?
The patch-set is simple. But I would like to know your opinion first.

Thank you.
