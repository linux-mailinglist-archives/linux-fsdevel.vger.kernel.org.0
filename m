Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21F97A8B04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjITSBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 14:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjITSBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:01:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE0A3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 11:00:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991c786369cso3161066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695232856; x=1695837656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x11cnA5i6BYv1UJiZcsle56884GMaZKBKvxZRyq2WDI=;
        b=VKR465u9CXmsEXo4ZRqDBUaU2yBeod36deI03WvyzkYMm6flakkoBOWFSc2pHMc/4n
         tLs/7s6MITBuDEdA28jHSkQIrdC0FdDnrlAihMb5FAVGMAJCyzQ6MnEC2LdRin0SAh/j
         xEG+rAghFqYUQpdX5RrcXsE8k/O8918GIO5sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695232856; x=1695837656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x11cnA5i6BYv1UJiZcsle56884GMaZKBKvxZRyq2WDI=;
        b=Kz2SbUameofPmFbVzt/SNY/M0oRLk6uCXysP2RqjrvTIQon8dlpYLZi6jWD/wz0Ce9
         irGqxmN3Pt0qyRgkwDTAFk1QAP8sC2syzxy8zA9TfoSFYF0nqRcpdamvfu9DbFHRlOXd
         9kS+O6yqulx0/SNLw0UAED3icxetSPPPPMH6N1t73oneBCNYZE3BHyykCI71wCANTDA5
         DmFYUBi8OF4G1uJzmLNgQQhJ+ZQ2kunf3Og5cYSULCRN1AjhvbdRyEk5YLp5VfzB8QcA
         f4RyVAzB75nbO6+0qVfiX8xyrMhiGuLBopdM5iE7VxF4jrkpkhApMjz5ULmr1HOZE59o
         Tj2w==
X-Gm-Message-State: AOJu0Yx8DJlTNfSuT0IFoMeB247FDvdaOPvAG4ElWAWWLbV1KDv1W/W8
        BXu7jOYXl1y01N2jh+nJXadr/6fER6Je+KhXkWkfWw==
X-Google-Smtp-Source: AGHT+IHj7iiACx6FDFseix7jP22QLHME2toKnEVwSQHm9HLD7qAnDya1L/5YBK7/NxT+tYYzMN20TQ==
X-Received: by 2002:a17:906:21b:b0:9ae:3ee3:dc5a with SMTP id 27-20020a170906021b00b009ae3ee3dc5amr2523954ejd.73.1695232856746;
        Wed, 20 Sep 2023 11:00:56 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id u26-20020a170906951a00b0099cce6f7d50sm9639386ejx.64.2023.09.20.11.00.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 11:00:55 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so8347099a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 11:00:55 -0700 (PDT)
X-Received: by 2002:a05:6402:719:b0:532:ac24:5c00 with SMTP id
 w25-20020a056402071900b00532ac245c00mr2453767edx.40.1695232855125; Wed, 20
 Sep 2023 11:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
 <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
 <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
 <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com>
 <2020b8dfd062afb41cd8b74f1a41e61de0684d3f.camel@kernel.org>
 <CAHk-=whACfXMFPP+dPdsJmuF0F6g+YHfUtOxiESM+wxvZ22-GA@mail.gmail.com>
 <20230919-kranz-entsagen-064754671396@brauner> <20230920-fixpunkt-besingen-128f43c16416@brauner>
In-Reply-To: <20230920-fixpunkt-besingen-128f43c16416@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Sep 2023 11:00:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5gYo-rYLUxyR_oBGgZ4hMy1EaOk5c2NE9C4RJ6WB_NQ@mail.gmail.com>
Message-ID: <CAHk-=wi5gYo-rYLUxyR_oBGgZ4hMy1EaOk5c2NE9C4RJ6WB_NQ@mail.gmail.com>
Subject: Re: [GIT PULL] timestamp fixes
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 20 Sept 2023 at 09:22, Christian Brauner <brauner@kernel.org> wrote:
>
> In the meantime we had a report that unconditionally enabling
> multi-grain timestamps causes a regression for some users workloads.

Ok.

> I'll be putting the reverts into -next now and I'll get you a pull
> request by the end of the week. In case you'd rather do it right now
> it's already here:

By the end of the week is fine, I'll wait for the proper pull request.

Thanks,

             Linus
