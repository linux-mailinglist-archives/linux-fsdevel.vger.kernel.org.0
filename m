Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDB21A47A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDJOxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 10:53:04 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43194 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgDJOxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:53:04 -0400
Received: by mail-ua1-f66.google.com with SMTP id g24so689420uan.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2020 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=iOuSkiNnCdrm6WQOP5UTBzqHj5dlpQHZNX0c4sN5kGU=;
        b=ugGo4RpyxVPUyPNqgSF/orZjZYqvJ/WM7qjbUvTqYx4VfB3YRWlVrlLsK9MUsxVhNU
         zXEVMMc9s6SDJdQrcSLugVFHj7PUK/fBJkR0+vEAoaTQHcsVjZMRykR0jYKdwW2tFEU6
         jj4PZSgroXPRJ69kpyG57hQWRNEdDPzzDfcZqz76QJ3qWZGRKlsIg2B07XzYdUjE94T9
         diFK2jp9is7Lt5QSMoPePW3DctY5cJSQMfZ3kAlYVml4V9XpRTI21rAaZShvNhHUmRpC
         f6sWGJXFZ/fnsUKMRwtIoI32hDJJXLKMeQat1UqpbNKkCw7wuBTHczK5DACUmVW97c/Q
         SZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iOuSkiNnCdrm6WQOP5UTBzqHj5dlpQHZNX0c4sN5kGU=;
        b=bp+EKrOpzhZkAIriWaj0Zfg38uFBaBlc1E1qnwaKgppk0iuI8OWGHj/Y894VY2dD4I
         2DafMm2Px7X6cWqf0yFhsgCQEVAG5dVI6RgimxVyVkYd0d7xUvRL370m8zjYG10haek1
         JV7agZXT/0vGDKyeiooxujGIm8Et37XE1pryH0ktzvkOocXAAmHZkXbAkaHBTkB81j4F
         rS70L49c0rhlIH6v/3nMOg2cguNsvlbFQROQpmg68Kbjnqc+IPTA6oAO8QFVqvsOwICv
         jlgPuTNzKfqD2Mg9JoZk+FJ++Fxuh4520v0kN/BoOBOrPMDKRCZM0ZKopLVdmoZaosUG
         5+uA==
X-Gm-Message-State: AGi0Puap4zgT5wFSoA1a8fhgS3NRcliDmBBI8TWsABSxJ5vWc69ZUf0j
        DP8ceW5ZBZHbWNOevvI0uafyArXiTkVLlepYEngQmg==
X-Google-Smtp-Source: APiQypJZSlsqTv9Cy2lNEkMUUK0oSXXePKPxhBr26dnCs7fyCJq27LC83Guv/EBclbZ46zq+vQ3pkxXv6ohvxIxToSs=
X-Received: by 2002:ab0:6588:: with SMTP id v8mr3314969uam.35.1586530381502;
 Fri, 10 Apr 2020 07:53:01 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 10 Apr 2020 10:52:50 -0400
Message-ID: <CAOg9mSSeHarznzQOBr4GkdxMHqSTEEj786o8yG1nZ35C0FYSng@mail.gmail.com>
Subject: [GIT PULL] orangefs: a fix and two cleanups and a merge conflict
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, hubcapsc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 7111951b8d4973bda27ff663f2cf18b663d15b48:

  Linux 5.6 (2020-03-29 15:25:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.7-ofs1

for you to fetch changes up to aa317d3351dee7cb0b27db808af0cd2340dcbaef:

  orangefs: clarify build steps for test server in orangefs.txt
(2020-04-08 13:01:03 -0400)

----------------------------------------------------------------
orangefs: a fix and two cleanups and a merge conflict

Fix: Christoph Hellwig noticed that some logic I added to
     orangefs_file_read_iter introduced a race condition, so he
     sent a reversion patch. I had to modify his patch since
     reverting at this point broke Orangefs.

Cleanup 1: Christoph Hellwig noticed that we were doing some unnecessary
           work in orangefs_flush, so he sent in a patch that removed
           the un-needed code.

Cleanup 2: Al Viro told me he had trouble building Orangefs. Orangefs
           should be easy to build, even for Al :-). I looked back
           at the test server build notes in orangefs.txt, just in case
           that's where the trouble really is, and found a couple of
           typos and made a couple of clarifications.

Merge Conflict: Stephen Rothwell reported that my modifications to
                orangefs.txt caused a merge conflict with orangefs.rst
                in Linux Next. I wasn't sure what to do, so I asked,
                and Jonathan Corbet said not to worry about it and
                just to report it to Linus.

----------------------------------------------------------------
Mike Marshall (3):
      orangefs: get rid of knob code...
      orangefs: don't mess with I_DIRTY_TIMES in orangefs_flush
      orangefs: clarify build steps for test server in orangefs.txt

 Documentation/filesystems/orangefs.txt | 34 ++++++++++++++++-------------
 fs/orangefs/file.c                     | 34 +----------------------------
 fs/orangefs/inode.c                    | 39 ++++++----------------------------
 fs/orangefs/orangefs-kernel.h          |  4 ----
 4 files changed, 26 insertions(+), 85 deletions(-)
