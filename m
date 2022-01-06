Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C3D486DBB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 00:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbiAFXZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 18:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245509AbiAFXZ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:25:56 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099C3C061245;
        Thu,  6 Jan 2022 15:25:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id pj2so2510534pjb.2;
        Thu, 06 Jan 2022 15:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPyFOe45ca4grfTtJIiNrD4ZWJeCIBx7fl55dgxsoT8=;
        b=kaBTxInPfAb1uuRnogBDPNiH7MN8xpW58nvhnGy7fVozCLm1J1+k0RUa/CnC45a3Lp
         Ae1bLZ5WLp/vQ+sL1/RRe08Vi+pcrUtbNulEKyAwUwRmeKAbNXQaOiwqpYrhad6r5Bcz
         yslPrKm8E/n1Lj7P1DRnhHpl3Cqh5jxcN0f2iGQ7GthCLv/Arx+4T2ROkpWStDt5ClxJ
         K7sO2/1WKgM3BFlYMiusi05PyaxMhB99dmZi7cgCiAu142G1F3Ij3dadAb+hLp7HRbTt
         /1NQEHimzrR+6RjUCnTAFSLapr10gucJ2qxlLvB0VLDEa6N9Y4CKGHssDuArA880MMdk
         mP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPyFOe45ca4grfTtJIiNrD4ZWJeCIBx7fl55dgxsoT8=;
        b=15S0ii6d8InjZ8UBvXKaXmVGy99mJgZPlK1N9RwEmPFzhSu7nPRH4zwbWPKUVN+hDN
         b3vhbNS+CmPDPADxrwpoFtvWVdc4gmZUwvSxm9oJ/2Cz5UlUvTPS0tkqhj3MH7/pHh1z
         5s2keOP6NRMJfSiCFAuqtKJhSlNbtZmcp34G/qitRa88AWFP7k6wyFC0+f4hdkVAPy5y
         YEjor7xJUKwlcr54OsAXmBRZzIf2ekpa2cvkd5xqui9OVla5tZy+ZxjlTtFFltqvF487
         qtmaY5kPlDSlOoouy17l8h801ot3PGeF/mNnj68MNPIM6WpGsAxfyXlRVT20GpCzyd6i
         7SMQ==
X-Gm-Message-State: AOAM531cbvBNCxsPl24NT0tNFObpdgxG57PhsMGHLTxvsN3iqrvzVM3S
        zRi/pzkOKhDui0Oxi9VnIpY=
X-Google-Smtp-Source: ABdhPJw1vax3EHEwXVs5U4kUCft3UW5PyhYNTx4YI4FlBquuopL7Fh0iUFyxixFLYkRnIs4MYoq9WA==
X-Received: by 2002:a17:902:7603:b0:149:1ce6:c28c with SMTP id k3-20020a170902760300b001491ce6c28cmr61160866pll.164.1641511555562;
        Thu, 06 Jan 2022 15:25:55 -0800 (PST)
Received: from goshun.usen.ad.jp (113x33x71x97.ap113.ftth.ucom.ne.jp. [113.33.71.97])
        by smtp.gmail.com with ESMTPSA id r13sm2937078pga.29.2022.01.06.15.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:25:55 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     akirakawata1@gmail.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 RESEND 0/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Date:   Fri,  7 Jan 2022 08:25:11 +0900
Message-Id: <20220106232513.143014-1-akirakawata1@gmail.com>
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
 
 Sorry for my latency.
 
 Changes in v4
 - Reflecting comments from Lukas, add a refactoring commit.
 
 Changes in v3:
 - Fix a reported bug from kernel test robot.
 
 Changes in v2:
 - Remove unused load_addr from create_elf_tables.
 - Improve the commit message. *** SUBJECT HERE ***

Akira Kawata (2):
  fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
  fs/binfmt_elf: Refactor load_elf_binary function

 fs/binfmt_elf.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)


base-commit: 4eee8d0b64ecc3231040fa68ba750317ffca5c52
-- 
2.25.1

