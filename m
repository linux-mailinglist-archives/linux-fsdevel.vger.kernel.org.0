Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D02710C025
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfK0WYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 17:24:12 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:37814 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0WYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:24:12 -0500
Received: by mail-ed1-f41.google.com with SMTP id cy15so13439967edb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2019 14:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JsbfBtGAoe4wBuLGy+HYABZsSnGs/choumA/aUYLMN4=;
        b=I4PZpuhoQ/e/Sa0LlFix87Mp9zRFlH9jjkTlgbknnBAU9b9gg4C4Pz67aVJxxDlNjT
         Di+l7ApZhj2zm5AbzO3yeBN3fOXU25xyn+/07GEtI7VpjOSNF4gH9X/A6ANNoLlLIvvL
         L7Dlrpc9Q7/Jx4K23ipn/Ow+g8lX+6cUbS23eldSe3VGFs+dzG21Gr1dkRl9sIQ9k3xS
         rHZn0okzF7fCB/yl6kM8LmD/rwS7+0kK+uX6WSwJIPf6++0FIQVqHR3llPBPG277/1HH
         1UxbeMx3U0qJm5v7n90Lqwj3Cbgh79dKjaRlagVJIPJcjT8Hsd0N+xiF+r5E4bJqYSav
         4afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JsbfBtGAoe4wBuLGy+HYABZsSnGs/choumA/aUYLMN4=;
        b=P9chPdcsLprETzyPvHA6T7FVo5qIB3ggFX5fTue88v18JsSDX3FtHGjktYCMyLOklJ
         UTh962rul1X7h/dd1avTGvQZC/GSREyzfPElRl9MnKojbb/NWssC7M9Pr30HcMLSjV46
         KEQJvNE8060MUJD/Q/fv6o+EsiPdA8ryW+cUjMDThxu0zTFspGKkJ3LBoHSOtNDQGQjg
         Oi5DMQYIBbotS4oaGz+NCSwREOD0sbw/OXX7md30Ejb2fTmRRh9xaWMxhMvuycVa1a7R
         wVtttphuFJeHBjX43Q21MagQp6BnzO2b5NUveuWrABgbiOPQVfxVHHq4jT8qTm7KSV2s
         W8KA==
X-Gm-Message-State: APjAAAVCaY0gXA0eqQZJwX7wR4G4MELzXw5J3ee/hKoneogIRU4mGHPu
        9TToD0S+JuuBdg6bUZksYZT19uFd+9bZh3ryuIToJw3k
X-Google-Smtp-Source: APXvYqw/yccIz+MLWvr7YWPYP7oVIOkns1HJhdGu5YX4CwnuMJLWm0AGqqj6Xx40YGjoYCL+RnB89zhkxhKznxSmCrA=
X-Received: by 2002:a17:906:da04:: with SMTP id fi4mr32176347ejb.24.1574893450582;
 Wed, 27 Nov 2019 14:24:10 -0800 (PST)
MIME-Version: 1.0
From:   Meng Xu <mengxu.gatech@gmail.com>
Date:   Wed, 27 Nov 2019 17:23:59 -0500
Message-ID: <CAAwBoOLO31qYBnUfOn30uHiKZgZbnP97XC3ij5tcrb2Ve4FK7A@mail.gmail.com>
Subject: Possible data race on file->f_ra.ra_pages between generic_fadvise()
 and force_page_cache_readahead()
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi VFS developers,

There might exists cases where file->f_ra.ra_pages may race in
generic_fadvise() and force_page_cache_readahead().

Following is the execution trace

[Setup]
create("file_bar", 511) = 3;

[Thread 1]
fadvise64(3, 9055, 975, 2);
ksys_fadvise64_64
  vfs_fadvise
    generic_fadvise
      [WRITE] file->f_ra.ra_pages = bdi->ra_pages;

[Thread 2]
fadvise64(3, 9374, 3618, 3);
ksys_fadvise64_64
  vfs_fadvise
    generic_fadvise
      force_page_cache_readahead
        [READ] max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);

I could confirm dynamically that the order between [READ] and [WRITE]
is not deterministic (i.e., either may go first). However, they do not
lead to any crash or panics so I guess this might not be a serious
issue.

But just in case there may be unintended consequences, I am posting
this issue here for more visibility. Feel free to comment and discuss.

Best Regards,
Meng
