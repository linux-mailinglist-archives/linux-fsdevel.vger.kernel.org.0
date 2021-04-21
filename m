Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB1367437
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 22:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245636AbhDUUjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 16:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbhDUUjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 16:39:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C0C06138B
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 13:38:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r12so65441565ejr.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=md3o4p7n3hM5uE+5WCGNtClm3RdZoyFagq0E7NLsAic=;
        b=jluoif0LUeWyHw6yXRzDm293OaeL1Gvzfs7lwWkF0kZ9iIB1xqqXcZBZzzI/nHk04R
         RJ5g0rXOaZVzvBmrxkjLX1UL2uAcE44TgBlZMGHdPQ6nibpmb/ZZgNzdIwqQWeaE4jwe
         X7GwFGRmJn4teKMZEas+gWWYQ6GPcmOqBAE1TKE0ELsYa+UL1L3STWfI7955RsmXxtZX
         iN3VPpRYPPbQVHaaquw/NaB2MZk+e1rO98iDD8P0RBMTASUUMSwY0li2YrNwYWvfizuR
         kW4otWYEy08FXf46qc1KQr9JcddGNgHgqd88tjlw3lYZDryYu2WR5b576MwjjpTbBKrI
         +Arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=md3o4p7n3hM5uE+5WCGNtClm3RdZoyFagq0E7NLsAic=;
        b=FFpOLtU/70eq2YqBpVu9nHxv5rgI6UVbm0g/HdQNwTlD4/hSa+k5v3uWZefGNYPlGy
         u/U2PrZ0Sg+jpx+Fvq8zr5BGtywNOSMPwJm/RRi3rUBefyOalexcg42MjM9HStKI6+LO
         v55tkpQ4Wuuecs+iITxZma+tBtLHuborxQUFh0lOFrbruBmb24hahPWC1K+mzHjmNRqa
         4/0KhAu8Q1c0l/QUt0mAteqP6e4qxtn4ZILy8E+D5+6bkEgpSu06381NzztqvYST/YIk
         hdNtGV1xtWgvdESr7OaSiHMOCjZzgw9J7fpsocIOc7aOw31EF4w7YuxStkKo5/+Ael2m
         OWeA==
X-Gm-Message-State: AOAM531Bv48umU875JHEkpOkK2OfpJwRQvGPlFtrqDiHMGgB5Ezord3a
        DRQKtj4RJVrraucEf95UQuQRAXLSf8/FaPJT7k8QLWgLaA==
X-Google-Smtp-Source: ABdhPJyFe9bNzV6/bc99zAfaqrVO1DebH0rgqEH8+mOVAiJ8K6bc6MFkmZrpd827WzqVo1ofdZuRb3cNGC3u1dwSFpY=
X-Received: by 2002:a17:906:f1cb:: with SMTP id gx11mr35468706ejb.106.1619037511266;
 Wed, 21 Apr 2021 13:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com>
In-Reply-To: <20210421171446.785507-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Apr 2021 16:38:20 -0400
Message-ID: <CAHC9VhTFPHO7YtTxSZNcEZwoy4R3RXVu-4RrAHRtv8BVEw-zGA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] selinux,anon_inodes: Use a separate SELinux class
 for each type of anon inode
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lokesh Gidra <lokeshgidra@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This series aims to correct a design flaw in the original anon_inode
> SELinux support that would make it hard to write policies for anonymous
> inodes once more types of them are supported (currently only userfaultfd
> inodes are). A more detailed rationale is provided in the second patch.
>
> The first patch extends the anon_inode_getfd_secure() function to accept
> an additional numeric identifier that represents the type of the
> anonymous inode being created, which is passed to the LSMs via
> security_inode_init_security_anon().
>
> The second patch then introduces a new SELinux policy capability that
> allow policies to opt-in to have a separate class used for each type of
> anon inode. That means that the "old way" will still

... will what? :)

I think it would be a very good idea if you could provide some
concrete examples of actual policy problems encountered using the
current approach.  I haven't looked at these patches very seriously
yet, but my initial reaction is not "oh yes, we definitely need this".

> I wish I had realized the practical consequences earlier, while the
> patches were still under review, but it only started to sink in after
> the authors themselves later raised the issue in an off-list
> conversation. Even then, I still hoped it wouldn't be that bad, but the
> more I thought about how to apply this in an actual policy, the more I
> realized how much pain it would be to work with the current design, so
> I decided to propose these changes.
>
> I hope this will be an acceptable solution.
>
> A selinux-testsuite patch that adapts the userfaultfd test to work also
> with the new policy capability enabled will follow.
>
> Ondrej Mosnacek (2):
>   LSM,anon_inodes: explicitly distinguish anon inode types
>   selinux: add capability to map anon inode types to separate classes
>
>  fs/anon_inodes.c                           | 42 +++++++++++++---------
>  fs/userfaultfd.c                           |  6 ++--
>  include/linux/anon_inodes.h                |  4 ++-
>  include/linux/lsm_hook_defs.h              |  3 +-
>  include/linux/security.h                   | 19 ++++++++++
>  security/security.c                        |  3 +-
>  security/selinux/hooks.c                   | 28 ++++++++++++++-
>  security/selinux/include/classmap.h        |  2 ++
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  3 +-
>  security/selinux/include/security.h        |  7 ++++
>  11 files changed, 95 insertions(+), 23 deletions(-)
>
> --
> 2.30.2

-- 
paul moore
www.paul-moore.com
