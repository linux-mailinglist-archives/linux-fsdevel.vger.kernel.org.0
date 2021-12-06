Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658F346A0AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 17:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389452AbhLFQJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 11:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358775AbhLFQHw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:07:52 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C964C0412B3;
        Mon,  6 Dec 2021 07:46:13 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d10so32547284ybe.3;
        Mon, 06 Dec 2021 07:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=e8VnTAo8sedImm7G/oZjQu3Dt8xy1R0MoEv9ZFn+tRY=;
        b=BiEORb0u6SefPleMWVNRNKin5r+NQDOp2Jj1YJIrfMehWNAVB4n93yfjZ2VFanivz/
         Zt7595IBBcOJPWgWvhqroa10oPjtMBXdWG0q/iTvxc37B1UJvTbCUcizk/7KvP4VC+LU
         2jId1860Bwf9WLPIYNHHRIjLIPcKlL65uxIF12CQpqXtD/KTz/Y1Dqz9Jmd2eWFanMpz
         3S/3VJOKC08btygpIfiuyl/c+ScEMTzyn3CgLAfTEqaFxKwn0qB/B6oaxeJ8IgBYEBp5
         qhBxHJasuqgSBFbUkG9yvMafxW/ZVHa5N0pXLt5j8xTzELHSAYVrk+rTid04yWSWzg7W
         7OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=e8VnTAo8sedImm7G/oZjQu3Dt8xy1R0MoEv9ZFn+tRY=;
        b=SGONwnulRRetyollIeWlOtcLNMB6LARREQdJZt3NgtFR3J7b99ErwzX1sSCgUpOfjE
         oeFal2uukJSEZo8/vPcazF7V5siUT/tsaIAj80brNUP9xKvtgwe+wCEf1W8ZF5SAnonz
         Mwxll4ouMDNWv+JuML2JBfNdodKTw3n8s20AiEMXxxmeICbTAmbMqrBbfo5uXa7ESqtP
         a1e2iYC9hXxhLm6Z7u0SF2lbhrh8IUYjqLPwal4CS3G5m+d2C9ISor8iETRAxMDpKCTd
         8lBoS2lMFqWcrdpkIeZcCt3iSaJMB44pC/SRWHKIjmhVyVOoSpAIF21uaO8IHq4Xmb0U
         ocGA==
X-Gm-Message-State: AOAM531j9vw8UpKbcu19k5ogHIft2ZCTtAUyF12sXOLSSmLUqnrSmZO7
        tU6/6ty4ClwdRgFu49f4VzIJjY3bSc+/TTx7mNzT/+/dmvI=
X-Google-Smtp-Source: ABdhPJwQN/3dc9TySPRoFSxcye+mzkRwb1a3ngc3AmV6qb8qiRLgsYlDsInR0hkKGhpnztNNJLDv5lokhXo25FZuiu4=
X-Received: by 2002:a25:fc5:: with SMTP id 188mr43696974ybp.608.1638805572204;
 Mon, 06 Dec 2021 07:46:12 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 6 Dec 2021 16:46:01 +0100
Message-ID: <CAKXUXMz1P8xCW+fjaiu0rvgJYmwHocMmtp+19u-+CQkLi=X2cw@mail.gmail.com>
Subject: Unused local variable load_addr in load_elf_binary()
To:     Akira Kawata <akirakawata1@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Akira-san,

With commit 0c9333606e30 ("fs/binfmt_elf: Fix AT_PHDR for unusual ELF
files"), you have changed load_elf_binary() in ./fs/binfmt_elf.c in a
way such that the local variable load_addr in load_elf_binary() is not
used anymore.

I had a quick look at the code and I think the following refactoring
would be good:

1. Remove the definition of load_addr and its unneeded computation of load_addr

2. Rename load_addr_set to first (or a similar name) to represent that
this variable is not linked to the non-existing load_addr, but states
that it captures the first iteration of the loop. Note that first has
the inverse meaning of load_addr_set.

The issue was reported by make clang-analyzer:

./fs/binfmt_elf.c:1167:5: warning: Value stored to 'load_addr' is
never read [clang-analyzer-deadcode.DeadStores]
                                load_addr += load_bias;
                                ^            ~~~~~~~~~


Best regards,

Lukas
