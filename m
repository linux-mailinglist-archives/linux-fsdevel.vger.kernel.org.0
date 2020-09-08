Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4A2611DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 15:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIHNN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgIHL0L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:26:11 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770E4C061573
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2020 04:26:10 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q67so8787020vsd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2020 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbwkhwLQx7+GhV9T4X9iG2wrMbFXrQhyeeBQAfsS22c=;
        b=OCx6sLWhB/bjVTTYCDuEoBWcNogPinb+elYrwkC5IZX4/eTuE9wwCM5CJxd79Vhkon
         KEnoPdDo6qbSQZ20cg/FVjnX/uiV3PE5flWOCD74O9jp3Fcmgv8zImJom/JS62ZZHtZN
         XmmtoKu51Jy6QeyhksLLr+K1dMadx4FbJAcoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbwkhwLQx7+GhV9T4X9iG2wrMbFXrQhyeeBQAfsS22c=;
        b=SVQ7cjxg6DWYPwYpbbu1R8R5zkYWUB2dugh0KZ1yPqdB5MCARoxvqjuvxCOBJAnA/C
         5g53JpcxkyILIznQYhlNjJTbUKuIVVI6sR2utAKno/mN8ixsN5Zlg5wPEnlbeYYgFHwx
         maLzLCbu+tbKryt6S8vbARMyrqIXSbEwwPIc+Rp0jG6yNx2z+AklL3yCUObvODc76eHt
         4OlkUp0BBn/T3aV6hep/CTakcw/r4GWE5MxyV//zw20eqri/V6OJfmemvfvAmatLmZXW
         L92asHMWAGKN3ZDRQb+TujG+9+AA2C4gsaciFPkliBLVa1djbLrG17/te2/xMsMWG3FW
         Pm+g==
X-Gm-Message-State: AOAM530+tFhhTXO+cUrqWNPh8OUmQSTx9a4Dw+rTSmMu7142xFxe16mA
        ob3pU2/PE4e3f6QSwUkR6nIPB14+yK9Z64uBmYSzxQ==
X-Google-Smtp-Source: ABdhPJxTfngNoQCIblDdEHyvRzh277qRfyPx6DDR9XF3LO9riGEiL+P5HWvoW3rvgQrzagF/ixhfFISuQK9ZB0LlyuU=
X-Received: by 2002:a67:e445:: with SMTP id n5mr14305319vsm.115.1599564369700;
 Tue, 08 Sep 2020 04:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <1599553026-11745-1-git-send-email-pragalla@qti.qualcomm.com>
In-Reply-To: <1599553026-11745-1-git-send-email-pragalla@qti.qualcomm.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 8 Sep 2020 13:25:58 +0200
Message-ID: <CAJfpegunet-5BOG74seeL3Gr=xCSStFznphDnuYPWEisbenPog@mail.gmail.com>
Subject: Re: [PATCH V4] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero
 ref count page
To:     Pradeep P V K <pragalla@qti.qualcomm.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        sayalil@codeaurora.org, Pradeep P V K <ppvk@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 8, 2020 at 10:17 AM Pradeep P V K <pragalla@qti.qualcomm.com> wrote:
>
> From: Pradeep P V K <ppvk@codeaurora.org>
>
> There is a potential race between fuse_abort_conn() and
> fuse_copy_page() as shown below, due to which VM_BUG_ON_PAGE
> crash is observed for accessing a free page.
>
> context#1:                      context#2:
> fuse_dev_do_read()              fuse_abort_conn()
> ->fuse_copy_args()               ->end_requests()

This shouldn't happen due to FR_LOCKED logic.   Are you seeing this on
an upstream kernel?  Which version?

Thanks,
Miklos
