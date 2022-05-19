Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6AB52C859
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 02:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiESAHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 20:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiESAH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 20:07:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D2175A3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 17:07:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fd25so5037709edb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYzl0vkutTLS0hzlFyrBMzDRdY+ph8j1AYEXBHgldcg=;
        b=KwKF8C+a3lYh7TKvVdu1n8gevRU2AzOmIvfDcMSy+DEdFmcWxwGeh1VxE3LilvEONC
         qKpj+AgORGrTVnZZiQkvAlh1SKWihwN9cKUyi295BuJtRpF3FRCTEtQ9y7GyxQTgqSMr
         VF4oqiBd6OtNQIjXTjPxogigoRT/miEr7g5Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYzl0vkutTLS0hzlFyrBMzDRdY+ph8j1AYEXBHgldcg=;
        b=3VcgGc1hHepDQlqdfOiCrlkLRBblGmQJqXGZJrc06WJdvd503DS+mbeeaSNMR4mAC2
         UwNExskGIEivNUmJtjISAe8961yoxp61TslvFjscmZvS1Dn1NbD/0Guw6bgM6t7p1oYe
         FfjheuTNUoG3YUMY33SN458AZ6MrqMurDnkKpkqG7ckahWXNLqNWiFJiwcuWJcnjQCuM
         TqtDQWmS3tU2Ikn8+MtbHsveRqzwYyLYi7ZCJ181YQiDbTHBj4WDkBp3W05Ja09WJwqn
         57Ldl7TOmACNAbTyE7RTbHqkDQdfA/sLtCfK6jpoeCY1stMAgY43mgYI7OICp9DMrrpy
         nJjg==
X-Gm-Message-State: AOAM530+OK0ycqCKrW7uph/mt3sxnoiz1GbdqwX45p/XGtis2CdN/QAB
        I2wE9kLsI7kyqCkND4yMXPVVuxpvCilhJw==
X-Google-Smtp-Source: ABdhPJyBIy5UwKVQwNA9IXr18NoXapOn9zyaGK8bbJE/du5yUqri2YTd6gL9LDTHg+pVMBjdytKdPA==
X-Received: by 2002:a05:6402:2945:b0:41d:aad:c824 with SMTP id ed5-20020a056402294500b0041d0aadc824mr2466065edb.364.1652918847467;
        Wed, 18 May 2022 17:07:27 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id g6-20020a056402114600b0042617ba6396sm2008531edw.32.2022.05.18.17.07.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 17:07:25 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id u27so4031702wru.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 17:07:25 -0700 (PDT)
X-Received: by 2002:a05:6000:2c2:b0:20c:7329:7c10 with SMTP id
 o2-20020a05600002c200b0020c73297c10mr1658727wry.193.1652918845040; Wed, 18
 May 2022 17:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <YoUiHhz1NsTbN5Vo@zeniv-ca.linux.org.uk>
In-Reply-To: <YoUiHhz1NsTbN5Vo@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 May 2022 14:07:09 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj4eF-HZc+uuVcD4EjLW_QN7_8OZ5gtAC9_6qY1-ZK4rg@mail.gmail.com>
Message-ID: <CAHk-=wj4eF-HZc+uuVcD4EjLW_QN7_8OZ5gtAC9_6qY1-ZK4rg@mail.gmail.com>
Subject: Re: [git pull] a couple of fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 6:43 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         vhost race fix + percpu_ref_init-caused cgroup double-free fix
> (the latter had manifested as buggered struct mount refcounting -
> those are also using percpu data structures, but anything that does
> percpu allocations could be hit)

Pulled.

I do note that you are one of the remaining people not using signed
tags. Not the only one, but _almost_. I've cajoled almost everybody
else to use them...

               Linus
