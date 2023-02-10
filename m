Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDBF6922A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 16:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjBJPw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 10:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjBJPwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:52:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287A85FB44
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 07:52:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id c26so12221343ejz.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 07:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ROduZYJpSejdajCsBZSHrHuAACG1d4aq3VU3Cfv3Yt4=;
        b=qAM8LzdtIzHzZx9Kf1mmuf82NNGWVm/JOZKSidHNH/flRfQFR6mcHEVPmS+xWBBlng
         xasUroz0oZpe/l3/em7/BN9N6XRzOxO2hnrVQu6cxuSaA9K8aD3TrmDOekcOuYxYbZBP
         3dYQPagXm7Qp8CpTytNoRFPG9+YbB5EwO42RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROduZYJpSejdajCsBZSHrHuAACG1d4aq3VU3Cfv3Yt4=;
        b=e2KNjkZLNgx0xEunoS5smFymNdH47GMW2uY0k4tG+o775Y4nfH0JPjt4Si+jxHakjO
         cqKl7gdQQx9nG3eKOy9lUjc4E1z1p+//UOiA584AZJIDQ2vpLBXkk708uJjjuq4OPITQ
         gwMcdcLOZgEnsGR1Il1DfxIalYp9SOhee3gT0LPsnVO9WfKXAVmocLKJHh2aYSSJk5CH
         ZjFyxJ7OO1rFtq6NACRTyYg916fNKnZfGoKSGL0lv7ftKZkw7s8U9fRCG8Ds4litXi0T
         4df89Ecy7KSuL/avXr7rzQRSw5aUJ8hCMWCsQ6zFBBHvPy5WFzgMi9omUzCwsW/O26hZ
         0iGA==
X-Gm-Message-State: AO0yUKXk5Ur1L8kssYpMSlPTSK5WVMmnGcVPo5MTHskrsDhS0QdnRX0m
        dGkWwrXuTn6D7FTn7BTGdvf5P0ma4E6ukQgfHarkzg==
X-Google-Smtp-Source: AK7set9DRrfJ8emvNMJ4bkS2cGPib1PAntVERZKX/H6AbXR1QQgyUoIWPbU2nZm7VGO/zeuCODpjgQVksVs8Lq6XoUc=
X-Received: by 2002:a17:906:718d:b0:8ab:4931:ca26 with SMTP id
 h13-20020a170906718d00b008ab4931ca26mr1302015ejk.5.1676044342787; Fri, 10 Feb
 2023 07:52:22 -0800 (PST)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 10 Feb 2023 16:52:12 +0100
Message-ID: <CAJfpegu6xqH3U1icRcY1SeyVh0h-CirXJ-oaCXUsLCZGQgExUQ@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] fuse passthrough solutions and status
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alessio Balsini <balsini@android.com>,
        Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Several fuse based filesystems pass file data from an underlying
filesystem without modification.  The added value can come from
changed directory structure, changed metadata or the ability to
intercept I/O only in special cases.  This pattern is very common, so
optimizing it could be very worthwhile.

I'd like to discuss proposed solutions to enabling data passthrough.
There are several prototypes:

 - fuse2[1] (myself, very old)
 - fuse-passthrough[2] (Alessio Balsini, more recent)
 - fuse-bpf[3] (Daniel Rosenberg, new)

The scope of fuse-bpf is much wider, but it does offer conditional
passthrough behavior as well.

One of the questions is how to reference underlying files.  Passing
open file descriptors directly in the fuse messages could be
dangerous[4].  Setting up the mapping from an open file descriptor to
the kernel using an ioctl() instead should be safe.

Other open issues:

 - what shall be the lifetime of the mapping?

 - does the mapped open file need to be visible to userspace?
Remember, this is a kernel module, so there's no process involved
where you could look at /proc/PID/fd.  Adding a kernel thread for each
fuse instance that installs these mapped fds as actual file descriptor
might be the solution.

Thanks,
Miklos


[1] https://lore.kernel.org/all/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com/

[2] https://lore.kernel.org/all/20210125153057.3623715-1-balsini@android.com/

[3] https://lore.kernel.org/all/20221122021536.1629178-1-drosen@google.com/

[4] https://lore.kernel.org/all/CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com/
