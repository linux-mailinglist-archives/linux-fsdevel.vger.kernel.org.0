Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E18C20C15A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgF0NFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 09:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgF0NFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:05:39 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E50C03E979;
        Sat, 27 Jun 2020 06:05:39 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id k7so5555043vso.2;
        Sat, 27 Jun 2020 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VjC16p+GoxuoIWlJhKz+IIz8N8uNdW4gDeTUzcPL0Ak=;
        b=YlSSOZGztdfK1neu9Enh1MfW1rZK34OjqNV/UyuGx9JADOSaYo457pjorKAqAkdEPZ
         LiYHv1LJN2Q2QpWUvpKyT7d4jKZRpl0XXqUNDxb2og5keR8d+fGEhEb4Zrs+m7BCbFoo
         /WJZaTA3unBWFUmcgdcLeQVWhx5GU1iVfgajNbwxLCj0pMU7aMQu2+9IwUv6ZCdi71bz
         SZPi/+fWmepH9u/3614U6tEQZPss1PZIamzSLqyDK/wPS9tkWM+vj6SkHpULpqd/uPj4
         9sUT0ZUXOHza+gFsb8e2pH0HsrT++p2YBURDa+nSX83azojww2hUYRA1J9rzdJrr3aJx
         MNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VjC16p+GoxuoIWlJhKz+IIz8N8uNdW4gDeTUzcPL0Ak=;
        b=gTEGWw3odHK69HeSvljLQCi8/gJyw/QQONTm/MUYq7e9d/Oxd5K+6r4GJFCPIscG+3
         u5pOON8FXSlpl9tePj4CzwbMEzEo5D/8WHo/2KZYSbx1edBdshr5HtNQxpM4AYUKgceg
         J5YKxNEWCvlkvmkSudGlZypDeGMFh2wED67duD18al7Ev+J3MXZKeTtM+dH8PnRTw5CC
         QX8K4rxFzNjdBFvD84H4npYdneK+mHoD2GoxhEuzwsXDU6NXMUPURyHznklyDQrdIHoR
         JMEuDTy+uc+T3nBhjiEQspDTuF4Q10vVEi7RAYVftBgbbN54aIh3DJdNQceP/6uAYWhi
         2y1Q==
X-Gm-Message-State: AOAM532i14gk+Z+TkHLMNet4TVK/uCyI4uQYCX+MiY8l7CfhcPqzhtfX
        27QZHtdiWDq2tkjdYk1HLbFw7avsKvMtZinSTSI=
X-Google-Smtp-Source: ABdhPJyseDDlbK9yS7yhoqK/FiQxELToQw+pvf/n2Lnfy7aDvshahJX5DvPZvf9cAQhNojTceDvj1Wc6OP1abvpil7Q=
X-Received: by 2002:a67:ea84:: with SMTP id f4mr5694066vso.113.1593263138880;
 Sat, 27 Jun 2020 06:05:38 -0700 (PDT)
MIME-Version: 1.0
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Sat, 27 Jun 2020 22:05:28 +0900
Message-ID: <CAD14+f1mAW-tVM6c1vbA_7ZgbtKzLRsBaceVBZ6PzZGsFzGPKg@mail.gmail.com>
Subject: exfat: request to implement FITRIM ioctl for fstrim
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, witallwang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi.

It has come to my attention that while exfat supports live trim via
the discard mount option, it does not implement FITRIM ioctl for
fstrim(8).

As exfat finally became the R/W cross-platform file-system solution
and many flash storages defaulting to exfat, I'd love to see fstrim
support added to exfat too.

Wentao Wang added FITRIM ioctl for vfat about 2 years ago. I hope that
can be a useful reference:
Commit f663b5b38fffeb31841f8bfaf0ef87a445b0ffee ("fat: add FITRIM
ioctl for FAT file system").

Thanks.
