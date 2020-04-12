Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4144A1A5DF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 12:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgDLKGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Apr 2020 06:06:04 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:37862 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgDLKGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Apr 2020 06:06:04 -0400
Received: by mail-io1-f45.google.com with SMTP id n20so6509021ioa.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Apr 2020 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Itwlm7oPySATR9b82rci+Y4Outg32bQKgDwCWb93UQg=;
        b=nmeLxVBfy+c6MdY7WhHk/72VDFwJ+Yp8aD5H33UDPL2e4jCu+GNPk/fK7fBsF7Zzjn
         G0Hi4l0TZlgLdonuhiRMQ+yKx7SCRVdvyUdTGmzlgRSGCykiqhBVP7AYmEMI0Dwb/mub
         zXXjvJI06IWBxjsOd+Q8xxge3RnmLbOjyfKPSAEGccXShqLztLnlfzSEKfEYVQwxY+Td
         R0OjAQPuEP+uUwan63aXOIt4dVqkOogCWB5N4iIuDIJ9j/dMpNTveY2Dwzh5lOqK4Ym0
         cdJgprK9WEYsrINwE8fHEQvA9IiO+8LG94UrugQgOLHb/xjWg4j3UDhf/SWBLCUAF7Az
         lmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Itwlm7oPySATR9b82rci+Y4Outg32bQKgDwCWb93UQg=;
        b=XLsHrhg/yc+OzxDYzEmpjprK1ZvBet13Nv2tQvd2tKFjN3NQ5NsfGsrwzX+H4V7Ewj
         TenmsLWoILD7p+hJ2Pq3dKO65JjCf0oOgAwap772gNJ7MzcSzjcBm3XftIbgAQLjkw9j
         ilKi0OLH7b5124KLj3c7DN9pOQNaivno604Y8es6KLcU27kP8Kn7UvVvrGefZJfgNQt6
         PrmjrY+DYJCp2O1ScujIt8zaHiyA9IeS0k5W8gqfQg5mVK6TFYXgvE2m6heHAhr8+Nid
         e8EsRsr4s3fdIU37VRA079wBGSoMpsnNWNZx/YY4bE/z8ew77IOT9NL0ghXWYwqlZSpp
         bMdw==
X-Gm-Message-State: AGi0PuYUza8SsRkFMR/3VaVzOhm4ERLYeSqqpSXMbk/N53J8Aq3JdEL4
        NOI6AusP7bAxNJ24xgqnQNH1CEpJ1j4ehuRjGfe9tpOP4SMd0A==
X-Google-Smtp-Source: APiQypLJuNL/PN/OuQs0otMizOL9nSjEPKkR1jsPCb+ElBNanSf2bU6O9CiZeeePcfWjvNbz+vZ1m40svdtAkGPai7U=
X-Received: by 2002:a6b:4f13:: with SMTP id d19mr11828970iob.153.1586685962059;
 Sun, 12 Apr 2020 03:06:02 -0700 (PDT)
MIME-Version: 1.0
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Sun, 12 Apr 2020 06:05:26 -0400
Message-ID: <CABV8kRw_jGxPqWc68Bj-uP_hSrKO0MmShOmtuzGQA2W3WHyCrg@mail.gmail.com>
Subject: Same mountpoint restriction in FICLONE ioctls
To:     linux-fsdevel@vger.kernel.org
Cc:     amir73il@gmail.com, mszeredi@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I was curious about the reasoning behind the
same-mountpoint restriction in the FICLONE
ioctl. I saw that in commit

[913b86e92] vfs: allow vfs_clone_file_range() across mount points

this check was moved from the vfs layer into
the ioctl itself, so it appears to be a policy restriction
rather than a technical limitation. I understand why
hardlinks are disallowed across mount point boundaries,
but it seems like that rationale would not apply to clones,
since modifying the clone would not affect the original
file. Is there some other reason that the ioctl enforces
this restriction?

Removing this restrictions would have some performance
advantages for us, but I figured there must be a good reason
why it's there that I just don't know about, so I figured I'd ask.

Thank you in advance for your insights,
Keno
