Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908EC10C2AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 04:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfK1DD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 22:03:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43731 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfK1DD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 22:03:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so6499197edb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2019 19:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MA5gajHF1GyLnbdtQ1P4c4Q7951U6L+/3dn2e5BFp1o=;
        b=IeO5i5e7szJPcYtgGW7+1A6P+WnOIo2f6gw826oqAoX7Ar4OPcKCVnHrrBvB05Qsc0
         +F0cA+LkUay4AWilXnYPm0P0oyImOooFylFODrZltkMrwvjeyP0IKjujjUXMdQKCjwpz
         sQ6e2X5JxqJXc+fPyIRy7sZiP6knTrV0uB/qxBsXoU9W/7Qi2vUWFaTZ6A6I7ptS2/Jz
         Vh28ENfUnXZHA7LIC+ytQ0pRg57a6SdxcpUg5Ux2X3K4XpHqGKevBqZKZ2/zuQK5zp/q
         8kcYQIw26x2YuF6QUyTh9wQqxYTRkkNrewCO7TKTnIgJBgkiXjNjbausGSB81J8KMbnK
         4K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MA5gajHF1GyLnbdtQ1P4c4Q7951U6L+/3dn2e5BFp1o=;
        b=DFiqRQcvOIh8WrYDfh/pspalwDGrsU2/PEW0RPfHFK85vvNkoH20VuICfeCYyXYF78
         FoV0zDNDP3MkfQwDXJQFw4KEE/PMZqGaISuj8jNxTjJjEEdc46IBvFkUnwliUavPBfmZ
         /ajltLB+AY5Ng1/vIsE+lRty+ouZ4bTan9o1df5iXBJqK44bJRFtD2Pp+CpoSeyNfAAd
         KVwfUbiWDz1Fezs+lwqIK54dbRtdz96bNAz3REcHOLkk0CEKVKugndckkMWa3QF9Jl7k
         4aHdLHFW0fnZ0BBwwWsGOzG9idjXVU4G7kdZjUpDOp8AQ83f01QctsPgEeH5EF10wJXM
         lkKA==
X-Gm-Message-State: APjAAAWUMC5BhzGCzo5s5opZkxNw5+UUrXbNbvAKD2lbTXIICsM+DCNq
        uacazOBGlL4lEsV9JRlMrjB84+YUHZcaUVNnmNX/3EC0
X-Google-Smtp-Source: APXvYqzfpDiQZgV4pDx9NCT3hORrUZEbWzdqwR/wHhumgEG5Ye1nHKgV2ikSieevnAO6EgaFos9yE4QfFO20z9zodLg=
X-Received: by 2002:a05:6402:b2d:: with SMTP id bo13mr34654055edb.125.1574909817590;
 Wed, 27 Nov 2019 18:56:57 -0800 (PST)
MIME-Version: 1.0
From:   Meng Xu <mengxu.gatech@gmail.com>
Date:   Wed, 27 Nov 2019 21:56:46 -0500
Message-ID: <CAAwBoOLikLrR4bCGcOj0BQzKxf90C-OUpXk4Hi-0jJf-mL3HpA@mail.gmail.com>
Subject: Potential data race on the file->f_pos field between getdents and sendfile
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi VFS developers,

I am posting here a potential data race on the file->f_pos field
between getdents and sendfile. Following is the trace:

[Setup]
mkdir("foo", 511) = 0;
open("foo", 65536, 511) = 3;
dup2(3, 199) = 199;

create("bar", 511) = 4;
dup2(4, 198) = 198;

[Thread 1]
getdents(199, [some buffer], 3874);

__do_sys_getdents
  iterate_dir
    [WRITE] file->f_pos = ctx->pos;

[Thread 2]
sendfile(198, 199, NULL, 2163);

__do_sys_sendfile64
  do_sendfile
    [READ] pos = in.file->f_pos;

This may be a false data race, i.e., the behavior could be allowed by
POSIX as user might want to sendfile to a dirfd while the dirfd is
being iterated (although there is no obvious reason for doing so). I
am posting this here for more visibility and feel free to comment.

Best Regards,
Meng
