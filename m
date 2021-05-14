Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FC9381445
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 May 2021 01:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhENXer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 19:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhENXer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 19:34:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ECBC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 May 2021 16:33:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l4so903571ejc.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 May 2021 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1+NbqxnUts2cERrUKprfSG6COch8OgsrINoj1msojwQ=;
        b=SE78uhsaW5vmO2PQwNgDVDEFZaLmLd2hYDNZhtr9Nt/nw9Asyt0kF6wBIRcaCQE94q
         iFo9NmUEMIp1hQL34Xw1iwYmf+UkAl2N+08lUDF845tzB4wZaLM/OM2gen6ONHUtYSz7
         CpZ1xfTo2Jg4UJ9OutADhkb19GX/5HMflMJF05nLMyzn5UQuaGvwkMIMASnORPA3Rd/P
         FgZ1/x3PNkA7FZCp8OHCYRsQxDUyfrhsvaBWylUAX4Glxf2WL1OoaFEoTsTPAbce7R3Y
         l10IgmrP7DIItHPkINgy5dP9A30nU7qafs9JueEYbZP/3+8ZFpGxN6oO2AultOlrolea
         smUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1+NbqxnUts2cERrUKprfSG6COch8OgsrINoj1msojwQ=;
        b=MTCtrmlnTrfvbAGBVpn3CNZhcc/aUfGW/hKoE5dchdVv/DmH8910FVaF857u0lIxc7
         awXvvBnHwjv1ZsFhIn0Mcv2ybULxnFxxMOG3qNHAYsswbTa6PYhpQbrsEGyA7mhsgowR
         paeQi2EaevHf+X8ZqwKZeiLnU4NI0MLbDfAQxoX7ZpETnQPmB6jF9QVi8xm3aeCFpqQD
         oZVMG96FQkARTSDugZ7f8+GeqeLWEQZ0p2bDHyHUxo1neN81HXgWfC6Z2MPj6eVyYYCe
         n3xf6z4orSlgHwd2Rkv0eLsccUj2kCsbQUahUN/PanzN1aZnqfW/5X1XQQe5mbEe7b9C
         coIQ==
X-Gm-Message-State: AOAM5332456wC8jTRYNyQGFarNlWERUPwW4NjV4HHz3CCy4jv/9zDuC7
        wlc22LNiiX7rFR9I04AwHrwtvRC5yC7o/TK9Dm4mTPggBzagpg==
X-Google-Smtp-Source: ABdhPJyg/1HU0s2ONvtTgrt5iERBgGgkS6JytB18uzIi8C03bdvf44hVYzlIqOF4VsHI3+YtSAzrMa4Jr9LrNS0IJRg=
X-Received: by 2002:a17:906:33da:: with SMTP id w26mr51913539eja.472.1621035213402;
 Fri, 14 May 2021 16:33:33 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 May 2021 16:33:22 -0700
Message-ID: <CAPcyv4hDfxpYh1rvvqFCQ+eNk_XxZD3grUOYkHWbERfxky43xQ@mail.gmail.com>
Subject: [GIT PULL] dax fixes for v5.13-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fixes-5.13-rc2

...to receive a fix for a hang condition in the filesystem-dax core
when exercised by virtiofs. This bug has been there from the
beginning, but the condition has not triggered on other filesystems
since they hold a lock over invalidation events.

The changes have appeared in -next with no reported issues. The
patches were originally against v5.12 so you will see a minor conflict
with Willy's nr_exceptional changes. My proposed conflict resolution
appended below.

---

The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fixes-5.13-rc2

for you to fetch changes up to 237388320deffde7c2d65ed8fc9eef670dc979b3:

  dax: Wake up all waiters after invalidating dax entry (2021-05-07
15:55:44 -0700)

----------------------------------------------------------------
dax fixes for 5.13-rc2

- Fix a hang condition (missed wakeups with virtiofs when invalidating
  entries)

----------------------------------------------------------------
Vivek Goyal (3):
      dax: Add an enum for specifying dax wakup mode
      dax: Add a wakeup mode parameter to put_unlocked_entry()
      dax: Wake up all waiters after invalidating dax entry

 fs/dax.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --cc fs/dax.c
index 69216241392f,df5485b4bddf..62352cbcf0f4
--- a/fs/dax.c
+++ b/fs/dax.c
@@@ -524,8 -535,8 +535,8 @@@ retry

                dax_disassociate_entry(entry, mapping, false);
                xas_store(xas, NULL);   /* undo the PMD join */
-               dax_wake_entry(xas, entry, true);
+               dax_wake_entry(xas, entry, WAKE_ALL);
 -              mapping->nrexceptional--;
 +              mapping->nrpages -= PG_PMD_NR;
                entry = NULL;
                xas_set(xas, index);
        }
@@@ -661,10 -672,10 +672,10 @@@ static int __dax_invalidate_entry(struc
                goto out;
        dax_disassociate_entry(entry, mapping, trunc);
        xas_store(&xas, NULL);
 -      mapping->nrexceptional--;
 +      mapping->nrpages -= 1UL << dax_entry_order(entry);
        ret = 1;
  out:
-       put_unlocked_entry(&xas, entry);
+       put_unlocked_entry(&xas, entry, WAKE_ALL);
        xas_unlock_irq(&xas);
        return ret;
  }
