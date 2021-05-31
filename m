Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A35B39656F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 18:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhEaQgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 12:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhEaQeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 12:34:04 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B004C050274
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 08:00:06 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a8so12177344ioa.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IB9OkdVPGdjxp5kroxkbnSR30Pq7n280ZF7aa3Q26ag=;
        b=A8Oq/3ZqXNHV2xFkoc4rlQa108lTlpoPQynn9P0tr2fH1gtz00otM0QQBtMPPCPMBM
         CFWpit3B6p8cojkIj3UDUt70oVePCMgaGlz3Bo+GLafsFotSKluOYFiFUeAa5cOZNDYy
         GTopOU1o2Lii8wePrW062TGMNMm+g9WMCQ25X2ATAVB4I8gGfHMS6R7sVH9VL0m88bJ8
         8lL7aw6wXUQ0sZAsKb+1Ka5YgY5DbIxlndoH1HIkcDtfsEn/OYQIyPWh2An3sI/Qv9XM
         7YqRTIInJa5lwXNk1rmOE/z4tzPXW1pp+JOJThj0v2RzQIIWl8Q8d+5rbP4ZZgFVbvLL
         mLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IB9OkdVPGdjxp5kroxkbnSR30Pq7n280ZF7aa3Q26ag=;
        b=qEdU7Drtl7GCrY8CqA4ir9MKB4SNYvxH9pt5jPK9+kiwpT+xrgaLIWbvv+TZbfhIu2
         XnCw4zRnkxpg9KpnFDmhDxm6dsTmINtA/XuQ6UgcVq9C3GLwjIkXYE8GAe07pKtkafUs
         YbABi1TCy/qyHpv4mADKiNqeQSuc88zMaAJeXdWnmyFdc7AFW9KRNtk35vaeTTpUbdh/
         kNb7g1DmjxPFfs/BU0k3yY7mFu6w4UDBBG9I1Jiml59LP1sX885h+w+VlVvc9DawXYCT
         bLAW/yqMeStk2xpjPN0AN8CbftGhj7JtEseIggOAhiEf52Pv5ZGAytCCR4+oBxaQwRNZ
         JZ3g==
X-Gm-Message-State: AOAM533SEZUJ1LFsLGyGFKnjVaOcTePk+pRKEnfPMGxNmVtVJjcIIb/f
        75aoRKVEzvXrkiFdjwZ+wp2JxWbC+3/RdFJqmZcGXvXOFQpvDA==
X-Google-Smtp-Source: ABdhPJzvWFndH1Okzio+LJRMen0390TDjpzg+p7J5rc5BGMhT+eoDQTXcJ3MdllwcUgJy2Kb0btGo6p9O+qejYQYVJ4=
X-Received: by 2002:a6b:4105:: with SMTP id n5mr17087507ioa.148.1622473205494;
 Mon, 31 May 2021 08:00:05 -0700 (PDT)
MIME-Version: 1.0
From:   tianyu zhou <tyjoe.linux@gmail.com>
Date:   Mon, 31 May 2021 22:59:54 +0800
Message-ID: <CAM6ytZrBUMB6xpP_srni8VParnNiuFPZZ2H-WsWUJEZH_vSk1w@mail.gmail.com>
Subject: Missing check for CAP_SYS_ADMIN in do_reconfigure_mnt()
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, function do_remount() in fs/namespace.c checks the CAP_SYS_ADMIN
before it calls set_mount_attributes().

--------------------
// fs/namespace.c
static int do_remount(struct path *path, int ms_flags, int sb_flags,
              int mnt_flags, void *data)
{
        ....
        if (ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
            err = reconfigure_super(fc);
            if (!err) {
                lock_mount_hash();
                set_mount_attributes(mnt, mnt_flags);       // <===
protected function
                unlock_mount_hash();
            }
        ...
}
--------------------

However, in another caller of set_mount_attributes(),
do_reconfigure_mnt(), I have not found any check for CAP_SYS_ADMIN.
So, is there a missing check bug inside do_reconfigure_mnt() ? (which
makes it possible for normal user to reach set_mount_attributes())

Thanks!

Best regards,
Tianyu
