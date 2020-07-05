Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18993214998
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 04:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGECG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 22:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgGECG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 22:06:59 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D258C061794;
        Sat,  4 Jul 2020 19:06:59 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n5so29256926otj.1;
        Sat, 04 Jul 2020 19:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0gnegzhHeVWl7TLl8qenganCsj1xNuxI3eSL3L+Lu8k=;
        b=sTeAvzjc2Evo9Tr56G73mdgWWBU8fxByKiw9+KQxDDuSIkNN8XCfNY/vxmc10XlZre
         41ZVPFMY8OeD9HRKwpuOZ2OhTvzUmzIx0ptDRM/a9QBQWPRO3s4cEqyW2emYBn8+CSx4
         yOWnsrg32E9iYgPgm9H8gGFk/Cfa+vJ/sFA/xlcsTqGkW0xuiRsNaU4HmpVNilJTscL4
         TptACgKgKvsk9MqHoR26UYqOR8bCfJ96TyiU+9jIBqTuCYfRRL2EBU5G144+2Aw0thYH
         WSKYaDn1vaTnq0RrJrzcB5VSdIT67BTIF0wJ/zuHYI8F6uUEveAwg2RV2Sjf4UgrZN3t
         yA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0gnegzhHeVWl7TLl8qenganCsj1xNuxI3eSL3L+Lu8k=;
        b=YXMijg1lFEWJPzgbHos2mT0SwgSUCGg8byxtqWvWTFkXA0mSJ7muuRQMOF+BvAfq30
         KJUJ/SvC+LWp+Vtni3tNSnpdsJpHsS6r5d39Rbf5GeiQZqg0c/TNcI81igPdolutNqcS
         9TLqhdM1jQGSWKzmoOSoKez3j5YkT+2c7R6Apr3hSD8RN78mqnhv/3PCFSF/xFHiC1z+
         oQLKdxysW2D14GPkfnWHwFwD5UX3IcHTWT7awpJBcYsi0rTwNMVUmio5tVHTm4ESQ+Mx
         66zXB2ORMiOGmA+9RIPm22y7wL1VTPEHi80zc0AQeUFnOuhAs26t63N8bRendOJJJNvb
         ICyQ==
X-Gm-Message-State: AOAM533UF6Y4Ml1Oyp1GWmoecg2Q9eYVtcoYYmqH9oAI/5bjKKYQlbri
        R+WvCOBnYpX30/2rwAPDjEKHmw8nIr/v16o8b5Y=
X-Google-Smtp-Source: ABdhPJwNaHqQEVCHDrNezDBmVrnbHXUiCmIc/UC+Xgs6AOyMNcsk0dUhDVAu8VroGEqRSVVumZbm3JzuMpIZrPc2CSc=
X-Received: by 2002:a9d:4d1a:: with SMTP id n26mr26918173otf.54.1593914818366;
 Sat, 04 Jul 2020 19:06:58 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Sun, 5 Jul 2020 04:06:22 +0200
Message-ID: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close faster
To:     gregkh@linuxfoundation.org
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        shuah@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello

At first, I thought that the proposed system call is capable of
reading *multiple* small files using a single system call - which
would help increase HDD/SSD queue utilization and increase IOPS (I/O
operations per second) - but that isn't the case and the proposed
system call can read just a single file.

Without the ability to read multiple small files using a single system
call, it is impossible to increase IOPS (unless an application is
using multiple reader threads or somehow instructs the kernel to
prefetch multiple files into memory).

While you are at it, why not also add a readfiles system call to read
multiple, presumably small, files? The initial unoptimized
implementation of readfiles syscall can simply call readfile
sequentially.

Sincerely
Jan (atomsymbol)
