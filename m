Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3083549E2AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 13:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbiA0MmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 07:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiA0MmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:42:00 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C313CC06175A;
        Thu, 27 Jan 2022 04:41:51 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so2194784pgc.1;
        Thu, 27 Jan 2022 04:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sFhJiM7HwOuP8O4kpasf3dWkNLfvyKenAhUzdABLmMI=;
        b=gsMsZrgwSxiKuTphc5UnQInL+nNmbam3p9r4LbD9JvJm3qvJuaHtUk9HDzrB8kJFtt
         aBvo8CgAn0Q2QYzxQg4Ymb3vTlFeh5gG89VSq6RerdlFQFHsEjhxxf2ZcwtT9m0RZP/h
         l4sHn8hB5sIjgLK+OMi7OhaqSrxyLFE9IXX/2Sh7iIBjXUXAQKrxQdOZWg1GhfrCi2ZJ
         k7YmBn/MQdorb+8yovtSEXNU+Til+Urj4YFJ0dGdSvdK9XptwUTNExEsA+LyhUxDAOAk
         fyq4cwhcNmxjl6Z4QkD/x67Z/HwI6OCHrKYyuoLN8giUlCyObBZDZylKtuYytbW9R0Gq
         ykPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sFhJiM7HwOuP8O4kpasf3dWkNLfvyKenAhUzdABLmMI=;
        b=MS7hYpjphxjh+NoVwi428MIGcqlBEvymr58ydIiBA9GD53LuAiWnu0J6eA52ARyN8q
         w8BsaJUaH0HxBgHegVbYzN7A3Qra2pyUs/6xYgzjU7gsSdRixrgVDq9q4Whjv94r3hdr
         2HdoT1spT+Axz1fpBCu9ehw2vzoVYhPwz2JURf0Jlyu8sRaCi35E4Y1ft2uZkH1zxmm2
         2vHFltwxfWX8dS5G5Gdlujmz54a8R6XDVyyDaijD1bcm2X/N+JOWiPe4wVESSLBhQhaT
         O81IffHjNtM5f0+pR/BMvHWsZiR++SAVE93zTRRY53VhrMZUhzNTHBGdUr3qHJ6i0WVv
         8zLg==
X-Gm-Message-State: AOAM5322oMmYFPch5KYNgk49AhlwIz0cWVhkMTRgRF3FfXPmK0TB5k9h
        wEyEukfEMJQhdjG8/GW1FuhC3M4QOnF8kTRJ
X-Google-Smtp-Source: ABdhPJxErKkZYelaHCmxvEul0+xNWIVcb61iYt+pbRZpJQOviy9N1fIRNsDmulX4Kot2IVVxFEXQEw==
X-Received: by 2002:a63:2707:: with SMTP id n7mr2653955pgn.244.1643287311308;
        Thu, 27 Jan 2022 04:41:51 -0800 (PST)
Received: from localhost.localdomain ([2400:2410:93a3:bc00:d205:ec9:b1c6:b9ee])
        by smtp.gmail.com with ESMTPSA id m38sm19071298pgl.64.2022.01.27.04.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:41:50 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     akirakawata1@gmail.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Date:   Thu, 27 Jan 2022 21:40:14 +0900
Message-Id: <20220127124014.338760-1-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches fix a bug in AT_PHDR calculation. 

We cannot calculate AT_PHDR as the sum of load_addr and exec->e_phoff.
This is because exec->e_phoff is the offset of PHDRs in the file and the
address of PHDRs in the memory may differ from it. These patches fix the
bug by calculating the address of program headers from PT_LOADs
directly.

Changes in v5
- Reflecting on comments from Kees, add a comment to the first commit.

Changes in v4
- Reflecting on comments from Lukas, add a refactoring commit.

Changes in v3:
- Fix a reported bug from kernel test robot.

Changes in v2:
- Remove unused load_addr from create_elf_tables.
- Improve the commit message.

Akira Kawata (2):
  fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
  fs/binfmt_elf: Refactor load_elf_binary function

 fs/binfmt_elf.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)


base-commit: 0eb96e2c58c03e79fc2ee833ba88bf9226986564
-- 
2.25.1

