Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD7C7BA8C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 20:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjJESKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjJESJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:09:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56462D67
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 11:09:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b2cee55056so242469566b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696529364; x=1697134164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0qibAZ55nBMQUVO4W+tHwFw/+c6/o3btv7NH2vgvLPE=;
        b=R37iyHMqrbESsTzmZGCNQbKKSn8mKMUO8KF6Oig8mIRhpZ72OMTcJAibjJUFT+gSF9
         GZNph9zvR4j90jxgARVTpzKhaBgC0XNKcci7+O/XlNtRhrQFfppR1rmVddT3eekFTiuB
         HBMiQRqkuhO7yLnuvlFPdsv3zn+JwGrJ0rZr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696529364; x=1697134164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qibAZ55nBMQUVO4W+tHwFw/+c6/o3btv7NH2vgvLPE=;
        b=jKiYsI0dGt3VZPcx+arJDY0FASnQpZr39RpvKMerGZZQ6h1jUPOEgxbXezzd3CrzCl
         RMA4ptjegZrVz0db1ThVwxpOR9vh+NMKF3eOjfdDU+FU0mRrZ9UOw0BIqxteskJ6Omra
         oVEBkAjholhmHbTRlPYzKIPQoV6AUQqTcE7Hhxkyac9FxaeO1pHU04WDrDtX3NUqiATl
         jiU8o7doWLlk0STw3/LTqear1erEE7q701r0kP2FA4KLPcZmxPWULuh6pnmyhrB7aSOR
         rFpNsxkyFINj3mu4IV51qKQT8nbdqvkt49REV+Ma/SSdCdnUle76U2UrI0pcTSIhsaB8
         se0Q==
X-Gm-Message-State: AOJu0YziTrQ3ogst1n/F+m1oQjWNHIvyvjMhMcJKazWRyuN86kAkAj3b
        XuU/lznkToMBZppv26aGx6jZx+qQUwSn8fSOqtiOeg==
X-Google-Smtp-Source: AGHT+IHTILGuMDTtjdOwmLrVfoDLf5+16gEi3ofBjwOEIDxPHrA1VvsTtSAoe6m2fibXAtSMGD8fZQ==
X-Received: by 2002:a17:906:3e52:b0:9b2:955a:e375 with SMTP id t18-20020a1709063e5200b009b2955ae375mr5740281eji.23.1696529364702;
        Thu, 05 Oct 2023 11:09:24 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id dc4-20020a170906c7c400b0098e34446464sm1559864ejb.25.2023.10.05.11.09.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 11:09:23 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so2203955a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 11:09:23 -0700 (PDT)
X-Received: by 2002:aa7:dcd5:0:b0:524:547b:59eb with SMTP id
 w21-20020aa7dcd5000000b00524547b59ebmr4597113edu.15.1696529363376; Thu, 05
 Oct 2023 11:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231005-sakralbau-wappnen-f5c31755ed70@brauner>
In-Reply-To: <20231005-sakralbau-wappnen-f5c31755ed70@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Oct 2023 11:09:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjn9dzM=3c-Monj8dfohg=SCWo5DXAajnGyCD_1z2wekA@mail.gmail.com>
Message-ID: <CAHk-=wjn9dzM=3c-Monj8dfohg=SCWo5DXAajnGyCD_1z2wekA@mail.gmail.com>
Subject: Re: [PATCH] backing file: free directly
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 5 Oct 2023 at 10:08, Christian Brauner <brauner@kernel.org> wrote:
>
> I've put the following change on top of the rcu change. We really don't
> need any rcu delayed freeing for backing files unless I'm missing
> something. They should never ever appear in fdtables. So fd_install()
> should yell if anyone tries to do that. I'm still off this week but
> this bothered me.

Ack. Looks sane to me,

             Linus
