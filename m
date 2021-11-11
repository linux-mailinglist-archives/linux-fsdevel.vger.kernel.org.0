Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784C444DC72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 21:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhKKU1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 15:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhKKU1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 15:27:20 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F427C061766
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 12:24:31 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d10so18067558ybe.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 12:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Qvece8PZmbspgJR3Zxru9iTtFer0lwJEBdhfE9Fkq80=;
        b=lAGpr0DglWoA/pRbaAyDtj/5N/gKcrL5ru4TswKZshgjvfZGrz8fbJJ3UctcjZ5JKO
         JCRr9LtFEXIzBtREmNmdoKJVS2Kqiq3RNIlZ4nlgod3+9W+jV/kjBTm8T9GQmaPa/Ahy
         pvgvIHdwTO9PtHvao8BcfCxKpfwTUrucGJcIY90i8sK51acGp/zh/WrdwJrjFHwf7yrk
         bBumt+NATBr6ngha6Bcfsei3cWUoy7P2z8cd1QObz3cl63IKtO90ycLM/FZYJDYD9glM
         yIC4rCHv1K1Esh0emrcy2G6KE/TGANSmHyv8nJbdT1exLkqdmsY3HWvfPgzIPhEPwgl0
         XD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Qvece8PZmbspgJR3Zxru9iTtFer0lwJEBdhfE9Fkq80=;
        b=jTdtNAI0w73LOI8B+5mhkaMu/2MZeG+v5z+rEbnCywjUqr9dBHowU2nguEI0MC5fX8
         /ibjpWjAHIWuPz8uRtqrypZYXJsptBibl1GAc9wmDtg7XI91w7gMpxG1rSlE1Bom6+H2
         w9UaYgshZ0W07gh5IPsrw58J78/YrzN/d+c/kSAthwCN/kl4XR3c2ENR/3qJHBTc70Pr
         mBID6idcQub53rhNOm4W8miGeqAOmTxCeCu8Hdv3hDTnm9ZQazUIVNMnfKe0PZmwYptB
         TX4v5rerW4poIH+w5uN6gk8KdQ3PTNk/cgua838+aRzzGFKcB+mAXui8/kB0DUFWwC2O
         PvKw==
X-Gm-Message-State: AOAM532zw5XDJxTUhqHt/HW815UKu4xXhziJBlyvigRzGtbro3RW8Ssz
        1HZ9eVP+LEA4RBWQAlGJ0/IsqNnxasUNbKw4cNWbNgetPEEw/HtTLaE=
X-Google-Smtp-Source: ABdhPJyvapKveU7blL/sdUFkoFETid69sVADg86ag7QAeGCQowEZCr1BE404ZWmI5Xy0ziqPqKvJf1TwY7rOZ1m5bI4=
X-Received: by 2002:a05:6902:1021:: with SMTP id x1mr10782593ybt.391.1636662270654;
 Thu, 11 Nov 2021 12:24:30 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 11 Nov 2021 15:24:15 -0500
Message-ID: <CAJCQCtSh2WT3fijK4sYEdfYpp09ehA+SA75rLyiJ6guUtyWjyw@mail.gmail.com>
Subject: 5.15+, blocked tasks, folio_wait_bit_common
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Soon after logging in and launching some apps, I get a hang. Although
there's lots of btrfs stuff in the call traces, I think we're stuck in
writeback so everything else just piles up and it all hangs
indefinitely.

Happening since at least
5.16.0-0.rc0.20211109gitd2f38a3c6507.9.fc36.x86_64 and is still happening with
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64

Full dmesg including sysrq+w when the journal becomes unresponsive and
then a bunch of block tasks  > 120s roll in on their own.

https://bugzilla-attachments.redhat.com/attachment.cgi?id=1841283



-- 
Chris Murphy
