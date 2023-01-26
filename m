Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C693C67D13B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 17:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjAZQXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 11:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjAZQXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:23:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE72E268C
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 08:22:45 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so6493390ejc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 08:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OegseSfZc2E/Vjf004Pntcqx9XmNYjqnRjnm6tfb+hw=;
        b=KYsQbnF64/qZg9nKYrPkWJ9RnaYaT/z4enbUzlUTELmbxVj+UFqytC5aaj3mVn4zi4
         FTdKaROGIK0H4O/ESKB8uKE+uuveStDGzmmYkoULJkNLAQQG6WvGXh179jR/dh+eD3O3
         +YBEbKhCwkyapeyNPJxmawZQPFiNr3osqdziU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OegseSfZc2E/Vjf004Pntcqx9XmNYjqnRjnm6tfb+hw=;
        b=CfQuy3sxSBN7OgZl24rDBnBwS+ePHuff76YaAzC+0zusYwOHNNAdyA3504cQRVOf96
         CWCBCs5RrH1BMOYEQmbogFddugXUuVx9SCwb5/ykUGvrX6NVe758zyu/5P25Gszqz91o
         DH0T+nxoI5FG9uvV/nxOBem5k6D+B4vTdpnWzOgvtgw8bYWdqL0x2nzLE+usZQ+Qc+Gy
         0WigncxYnDzCRtRh9Rq3hXa4WpxGR967M+ykZ+kTOO8DZKnVzHtC1SNT+7tlcbYXXXnU
         Mji8n//8UlEmKATADSXvo7qZILsGnil2SAiG/NEo1fR4C4TCqsYq4S2cb7hcocB8/gJZ
         Jp+w==
X-Gm-Message-State: AFqh2koi+6VRj9XKXTzoXUNo3gDmRUZNbOXJ441GCshoy/aLu/Qg3LrX
        TQ6WAJ0n0iZnsXzxuqcSo29l8gqlET+ePfCRkKwcRg==
X-Google-Smtp-Source: AMrXdXtObG2B+DIyC8+08IGgbpYTpvnzI73DsPCqUKBitPqdsnfP0uMmtRo8RUKnv2PevlB1f7GK2oVl1/f4vYewWSA=
X-Received: by 2002:a17:906:ae5b:b0:870:8c0:d74e with SMTP id
 lf27-20020a170906ae5b00b0087008c0d74emr3876444ejb.110.1674750164594; Thu, 26
 Jan 2023 08:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20230126102318.177838-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230126102318.177838-1-aleksandr.mikhalitsyn@canonical.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 26 Jan 2023 17:22:33 +0100
Message-ID: <CAJfpeguErv8Umn+GLfhz6F6fMvKF5=6s6PbaGEFAtXWQMpY80g@mail.gmail.com>
Subject: Re: [PATCH] fuse: add inode/permission checks to fileattr_get/fileattr_set
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     mszeredi@redhat.com,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 26 Jan 2023 at 11:23, Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> It looks like these checks were accidentally lost during the
> conversion to fileattr API.
>
> Fixes: 72227eac177d ("fuse: convert to fileattr")
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Applied, thanks.

Miklos
