Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06C05538F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 19:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiFURd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbiFURdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:33:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6942CC9D
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 10:33:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eo8so20393525edb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPe4+RCnBHVMZruHFQAx708KnNfkN6WftaGLH5zFBxY=;
        b=J/Yin+Uj4dOB+/0w9E2pKJETBFwg5PZNwy55uX6UUbzoJnNB99usJc9n51umx7VYFj
         5fWSEXGY7kRlB4+a6bjlzbQBKRp1Hxm77SvVL+SuvhB2mojigYh17ilBjI5SQAwi0qAj
         rACuenr2CqnfwQGUqgIYxcecBckT1Mf1r4vh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPe4+RCnBHVMZruHFQAx708KnNfkN6WftaGLH5zFBxY=;
        b=3l2LcKWXLP64a/Tniqc5Y6arbFo1coS6wg4MJrQI7ISHqZywkdWrrTMAFpSP4qxjt6
         z7f04QRCiry6vi/tL8Jk3Axsbpwly3T4EQ9PZziQvYu5ta0Se2bjnIWS9Kc/GOEqeVV3
         YJhoR9uwV/ePrCpg5+JLkFwc+7JoP+E6h8y9s/xA9XpFr5julHnZmxXHPhYFgFMiBXPu
         x6IkEGFMETt9ZtAd0401BMmFlV6i0oMSRM94SBlkkl2F/fD5Q5r5sCy5W9izXE7rnEuc
         qVGc3jF4d9NI2DarOfRbrueRLm0D9KRE5OFnhwLlXKSEOcROLSRf/hJiSe+4zrxIRENu
         rg2A==
X-Gm-Message-State: AJIora/WhyNnjIIYg7JekVPG2eE1jMXNNU38PBdsYhnVfZeCFfQG+KVU
        N7By2UVhNtpj56KeOf9nZDfZA4lD+/KCBeeQ
X-Google-Smtp-Source: AGRyM1uAbo+reb1OpQRN1mTI+afaSOfP/rYq7+R2agoSHKJfSuU7oJPkJg/9rhXaI8pH2UdCtXJW7g==
X-Received: by 2002:a05:6402:516b:b0:435:8f7b:b6f7 with SMTP id d11-20020a056402516b00b004358f7bb6f7mr8550034ede.291.1655832802593;
        Tue, 21 Jun 2022 10:33:22 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090630c600b006fef51aa566sm8130022ejb.2.2022.06.21.10.33.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 10:33:21 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id g4so19896751wrh.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 10:33:21 -0700 (PDT)
X-Received: by 2002:a5d:6da3:0:b0:219:bcdd:97cd with SMTP id
 u3-20020a5d6da3000000b00219bcdd97cdmr29119384wrs.274.1655832801122; Tue, 21
 Jun 2022 10:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220621141454.2914719-1-brauner@kernel.org> <20220621141454.2914719-9-brauner@kernel.org>
In-Reply-To: <20220621141454.2914719-9-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jun 2022 12:33:04 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgSWHmLQtRr0v60utSEtbNk5PO8rkxJhhy2TkmvZoR7nw@mail.gmail.com>
Message-ID: <CAHk-=wgSWHmLQtRr0v60utSEtbNk5PO8rkxJhhy2TkmvZoR7nw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] attr: port attribute changes to new types
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Tue, Jun 21, 2022 at 9:15 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The other nice effect is that filesystems like overlayfs don't need to
> care about idmappings explicitly anymore and can simply set up struct
> iattr accordingly directly.

Btw, do we have any actual tests for this situation?

            Linus
