Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D68522CD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 09:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbiEKHIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 03:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242553AbiEKHID (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 03:08:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B33AA0D08
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 00:07:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y21so1423316edo.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 00:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yp55JvrZnoapZhhPg9nglUGsDWim50kPROdVVnou5Nw=;
        b=Tbvi5ltsARlvIdW+yMDCQBzBIclvAZymsXsV9F1mkVq/BGVV8KVRlVGR6iMnl9HDR+
         3AKJz2+/ZQxFAD9NoQksKZ+KbajOTvsmF7dhsfCekiiBg+WWkAZFgG6ZoFT+rfNm9BMv
         jQrOD8jcc8q0YMiBHGx8DDTqA6mFaBTeMhQLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yp55JvrZnoapZhhPg9nglUGsDWim50kPROdVVnou5Nw=;
        b=w5nhu+yvlBT02WPeUzkAjMS1kE1FcdrStL8TUkiBMvIu0Wl8+9xUDx72qwW1wNE5I7
         1AqC4YMPDPo92lpsC3LqahOG0bh+u7mUs2eW8ezO5p6bOQuc9SO2jsztvasI+fE1h1dU
         N58ET+Uj1gvDNKnX9PHO7JuEgHvuugx8yb3z/sl6KA4u0DqZckmrzRKBgvayrM1HaWrO
         QTcdK0pDkmakxpGuYLs5BbaQhqrWkO6wVfzFUrwqxqgXg8T6tOwl4M8lo9lgFMEbt0xw
         WFsfIwLz8bkYr17jS9wGb07Y/sMQSbIKMlmxAmMnPqBSfCYaW7xXVdSM84coSbKxg0es
         YnSA==
X-Gm-Message-State: AOAM531hwoHuxnZRVSDvQ+/nWU0+ienDjjFrcpuM519QJUC94h2K6hPn
        N6YqAPPyP+nKKAhM9KcZNqqfmZ6ch3VlaF8XwL2hPw==
X-Google-Smtp-Source: ABdhPJxes41Q7Oqs4oy9VMmXMdOFiEdoAK5Ep3Ngad2GkTjCm6BDzEGO5c+BibRshNVGl0pSqC5e8tq6q6OWavesbug=
X-Received: by 2002:a05:6402:42c4:b0:426:a7a8:348f with SMTP id
 i4-20020a05640242c400b00426a7a8348fmr27535912edc.341.1652252874751; Wed, 11
 May 2022 00:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org>
In-Reply-To: <20220511013057.245827-1-dlunev@chromium.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 May 2022 09:07:43 +0200
Message-ID: <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 May 2022 at 03:31, Daniil Lunev <dlunev@chromium.org> wrote:
>
> Force unmount of fuse severes the connection between FUSE driver and its
> userspace counterpart.

Why is forced umount being used in the first place?

Thanks,
Miklos
