Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154BA5BB353
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 22:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIPUOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiIPUOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:14:05 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79FFBA162;
        Fri, 16 Sep 2022 13:14:04 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a14so8266434uat.13;
        Fri, 16 Sep 2022 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=L20SW832eC5U2q21l/Ay51d1N3TIrsvB3pYeReCImLo=;
        b=hW28qMWulwQV/AuxYVS715lnVfy+KVpnf67Ieat5CoJcDtUA2d6n4tZReMn8z0lcqU
         QIUL7TPVjAlz1wi942lGdT2xgvNmxMyJssU23U8PPCAiGsQ7YSpPKtyh+jnv8q7Lm5YT
         ryvgM22Mhhxid8Cj90lGJBNORKebezm4W6eiXf2BR9EtCJ+x0wPYTz/cUodZ3dmq+C60
         RmqscDvCusqWbdEMCSCjZZBK6UIVqU3+o++m9pEK9mwOy0rMMcxsTRWgoIW8lSC4t1wh
         larElLzdnYhCHqVMBlFt3F4WrLDD+qTcANBhjKtuZGsv5Jxm2nMIZrkBbm8foniLuOco
         r/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=L20SW832eC5U2q21l/Ay51d1N3TIrsvB3pYeReCImLo=;
        b=cQH7CG5RuRpyc+u8/Xcoi5D7/T3LLYTqqRNcqcdMPOQ10ujFekyuohOuw6Yk2vqjeV
         3MC8xv3dFp13opbIpsP41vMK9hR1VSr7ABYGBlrPrDRQw0yccUoWbD6yy2XISiW6v0f8
         m6qDm9jAWMXUYYl945afzbwZeYAYYFt67oN7QtkYmjC++dZOXhH4+yv/X/Clm7OZT/p+
         cGA5AzjJxfrBKaiu6tTYX0uB5UIGRvRIy6UyeJrYCNY8fUHIwBK8AdlSMG+peugGajDj
         C78ynzi8WXalt/6tzZVEcLHPsfkylyn5RLiC5cS3DyFvRGK5mnE0SUeFc5CxP40foy0t
         FNfA==
X-Gm-Message-State: ACrzQf1RHK0j8BAr8CVmY2dL6Ftt0Ff6hj2UPMgNMDQ6rv1tq+8jl/DC
        4VqpaP+SdC2NpVhUXbLP8R+1dWaTfvuQ0YE+844dXBJh
X-Google-Smtp-Source: AMsMyM6Ua2HAU1If14iZkSTbK3/6DsBySIw5nMlTroUrW+/9/9hd4vsPFEKosik4+LMbecf68Ugze55/xr1r3gCUw0A=
X-Received: by 2002:ab0:3f0c:0:b0:383:f357:9c02 with SMTP id
 bt12-20020ab03f0c000000b00383f3579c02mr2876371uab.19.1663359243306; Fri, 16
 Sep 2022 13:14:03 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 16 Sep 2022 15:13:52 -0500
Message-ID: <CAH2r5mve4HKpPOwFuE5+r26xJ7f--M5+wC=kY0km9-T2WGak2A@mail.gmail.com>
Subject: debugging rmmod failures
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Any suggestions on how to debug why rmmod fails with EBUSY?

I was trying to debug a problem where rmmod fails during an xfstest
run but couldn't find useful information on how to get ideas 'why'
rmmod is failing (in this case with EBUSY) and I could only find two
places where EBUSY would plausibly be returned but don't see the
pr_debug message in the log (e.g. "already dying") that I would expect
to get in those cases.

It also fails in this test scenario (which takes a while to reproduce
so isn't trivial to repro) with EBUSY when doing "rmmod --verbose
--force"  and the --verbose didn't display any additional info.

I also tried "trace-cmd record -e *module*" which showed it (one call)
returning 0xFFFFFFF0 but nothing useful that I could see.

Any ideas on how to debug *why* an rmmod fails?
-- 
Thanks,

Steve
