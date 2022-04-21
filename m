Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4879950A455
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 17:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390172AbiDUPjF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390111AbiDUPjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:39:04 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD4146B33
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 08:36:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y21so120073edo.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ECbaUjNPWxDfrNA66rDo4tFmjf5CBuTQXWJkkCb+ok=;
        b=SfShqGESysEsb1o79ybRTJnvLlJjwXLqgstljw5zylpZMPFfOieAC5If1G3lDKMScz
         n4ovY4iJ415W1/L2fDLVvkhCm2ezL0Lc7m9OD2RYf0oMsSYJFz83XNGhSm5P7+9Al97U
         0geidEomgSvn7SGgZZljiBYDKXV287br+6TPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ECbaUjNPWxDfrNA66rDo4tFmjf5CBuTQXWJkkCb+ok=;
        b=EjV/gy9Z4gqm40xJLJpvfx3JW6B8f4E3T9A5I7AcS/oSaVr995P4k3nNJHCdyU+l0J
         dYhkaJ4rGLY5q2PjFv7hmcwMEmwbUNuJnqsK8XjByLkC3Ois4pCb+X1AseOqMF9MsPfd
         lBR7RK3rg7gANQkN46qFGdquKVEYIv3Lc6FmAtHWHIlM7xulPLEVywyF5g3V0dMpzhbb
         zMoYfAkNru3Q7XMcP4YsCDwn9c/oMiYN3kcFlwrtvYtV88KydiKDQllH5wZUlPcR5MQY
         5EVkwJz2+ziMRIJBuxH2Y4eZjQV/vHtyCF+DCyeRUuUcbiGEysgYui27tAdQTHBo6B93
         22pw==
X-Gm-Message-State: AOAM530uKskA845yAiS2sJor70dNPBJn72Z7bVq1LulCOicJXjntZ98l
        /SsBBCc1dtXHllh6EDrchy/AfTNcl3JZ760fo71jaA==
X-Google-Smtp-Source: ABdhPJzgOxzZ231dlpYxwZ9wcbXxVOCcEy5LK+jwGR9n22b1eXTLejQ46hbanXJSnkhixtOWDrTyV2IA5k6IlghQmQk=
X-Received: by 2002:a05:6402:42cb:b0:421:c735:1fd3 with SMTP id
 i11-20020a05640242cb00b00421c7351fd3mr83971edc.341.1650555373332; Thu, 21 Apr
 2022 08:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <165002363635.1457422.5930635235733982079.stgit@localhost>
In-Reply-To: <165002363635.1457422.5930635235733982079.stgit@localhost>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Apr 2022 17:36:02 +0200
Message-ID: <CAJfpegs=_bzBrmPSv_V3yQWaW7NR_f9CviuUTwfbcx9Wzudoxg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT flag
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 Apr 2022 at 13:54, Bernd Schubert <bschubert@ddn.com> wrote:
>
> This is just a safety precaution to avoid checking flags
> on memory that was initialized on the user space side.
> libfuse zeroes struct fuse_init_out outarg, but this is not
> guranteed to be done in all implementations. Better is to
> act on flags and to only apply flags2 when FUSE_INIT_EXT
> is set.
>
> There is a risk with this change, though - it might break existing
> user space libraries, which are already using flags2 without
> setting FUSE_INIT_EXT.
>
> The corresponding libfuse patch is here
> https://github.com/libfuse/libfuse/pull/662
>
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Agreed, this is a good change.  Applied.

Just one comment: please consider adding  "Fixes:" and "Cc:
<stable@....>" tags next time.   I added them now.

Thanks,
Miklos
