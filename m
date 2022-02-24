Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F74B4C2392
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 06:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiBXFat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 00:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBXFat (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:30:49 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADAD22EDF2;
        Wed, 23 Feb 2022 21:30:20 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u20so2017545lff.2;
        Wed, 23 Feb 2022 21:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ssbTILFe2u43gFml3/5OETrelKmGcJxKqHN6FlLabWo=;
        b=SIjxS4N0yIePoISFjFKUFxVDjaveHK9Y+Q+jNGLW6OIX9byTGcx9Cu1VmqCPM2Ps7T
         yX3I/Pwk2Au59eJkLSlCDmYKEfEeKe7QOx/niDMTLXAe5JDtj06VC8teeseMDeDUgIz/
         DxwdodRptKOZMTeh90zv2E7bIs/xwcJQ+h+lLq0XEdDPHYZeEzQgkZGscbwonR1pTOWR
         R93mguwWuVCD6EqkmD1LLFlWHpNCrwLA9ZnrR6E304aPgBMf2Od02wuLXG3T1bfSB+Op
         lo8dG9OuO1ZLAeXAnWRN/lKPboj0H0Pb63Vxi6cF+R3f3STq0JmWHpGZU90yy2t9pbR9
         rIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ssbTILFe2u43gFml3/5OETrelKmGcJxKqHN6FlLabWo=;
        b=d+aKIad1sHXhDXIo8S0oXx4cl3m/JQs/sgKWP/QCIuVSIlS0n+wplWdUxfFOXA0pk9
         k9CBGTE6Zh0O6I4+N0SpG7bTBeSspzLFS2Gm42zpG/Y/rFJdkbuxyX0vxYdK7fdfub1v
         WiyLDWz4vV8bEsgJXa/+bZrxCb3v6zk/X0IrYV7MLFips09s4kI1Lbov3215zblUfT52
         2p6DvL63cjKqpq+9nStakYhPXSNmSkQBrxb3x8AlYfuaChw891FYEZpMQsghH9bSi1fg
         QCczd4hp5Axln8a7NlDaT424lXz7lgbZW01T8UrHSyMlP254Z1qzoK4wl0nk13AL5bV1
         xOpw==
X-Gm-Message-State: AOAM532TJ0Jcm3ZC6c6LA6VgHAPQCLN8Koh9U32s9XzGmF5EoXwl9+l2
        OfN8QJV5Cj9F+lpbHa2/ta0PmZok+/zaUbnF1dKOYrnvXwc=
X-Google-Smtp-Source: ABdhPJwIy0Ji5zP1BBlRg4CD/cIVUb39yK2WuQ6mQEy9VidIcSlv+KBlFCEmEw+2ck3fajrpAUO4zpWxyuTu99Ap/yM=
X-Received: by 2002:a05:6512:c09:b0:438:df07:a97e with SMTP id
 z9-20020a0565120c0900b00438df07a97emr769819lfu.667.1645680618344; Wed, 23 Feb
 2022 21:30:18 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 23 Feb 2022 23:30:07 -0600
Message-ID: <CAH2r5mv7Z7XmyWgp5K8ZshA1OiMBTNGU-v8FdmwwkZaNNe=4wA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] making O_TMPFILE more atomic
To:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently creating tmpfiles on Linux can be problematic because the
tmpfile is not created and opened at the same time  (vfs_tmpfile calls
into the fs, then later vfs_open is called to open the tmpfile).   For
some filesystems it would be more natural to create and open the
tmpfile as one operation (because the action of creating the file on
some filesystems returns an open handle, so closing it then reopening
it would cause the tmpfile to be deleted).

I would like to discuss whether the function do_tmpfile (which creates
and then opens the tmpfile) could have an option for a filesystem to
do this as one operation which would allow it to be more atomic and
allow it to work on a wider variety of filesystems.

-- 
Thanks,

Steve
