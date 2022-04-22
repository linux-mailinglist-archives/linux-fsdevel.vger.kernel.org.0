Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE6250B8A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 15:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447860AbiDVNju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 09:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347141AbiDVNjs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:39:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE7A57B0C
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 06:36:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g20so10477575edw.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvv4hk9RzyBg7Q3khkRUNS2a3fxWbQtrRbdQWki5nuw=;
        b=YU/gn07obeAH6SN1xpMdeM828TRnVhpVRBgY4DXLSGWkmynL5isGsCiCtsSRGBs9YF
         otlY2Xe7lW4nvhQ3ErUk35Izr3zcGx7W4CTdJoVSJc/bS/8RkIF3LD7A5hXnsC4fMo4p
         i+2+6rFDmv0o3XPrvuNXfHTVXZ1DghakIzFXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvv4hk9RzyBg7Q3khkRUNS2a3fxWbQtrRbdQWki5nuw=;
        b=kh0y5d7/zA/wF8FOxqx7dpmvtNTz/s8dunCRbRkN3CXjYdvuIJPTlWSyvnGlOZLaMU
         TXtjM/gCEcZUmMYpdEvgTn1Amauwo/Roblp5neXaMh47d/PLwybkV90YGslhDKUOE33M
         zSizlaRQsThOSScGkELB5E0co6JbtBkHCII5jdwRrfeHrjeQAXVA0YAO8ARweq67Z98n
         f3a5OAjbgHl/5WgXYZu+0pwi/qvadPwaLhzcE2MGTHcl15t2EdqSni+Ir3H/ooJWiznr
         Jem2KxcRSDE/8KZGPIe6Ur3FuT5SbKQIwx1x/ajwEL2o3l0IadzANMiNEiuKXlTuUHud
         7log==
X-Gm-Message-State: AOAM531I3NezkApc/u4e2NgPqDOdK8R2wwq7YVe6201RZnGCYfqHHe+c
        DGNd3yuGYx/H4+nBlebEkPTDa0iT8XdZq2rVm2ScjA==
X-Google-Smtp-Source: ABdhPJxik4aJmAihaidwgMRT992ybdWvGduMIqCnU9evAl+Zy19IXwCxlCifjr8ZrFbFAY2KQp0jE7mIdKHp+CTqGNw=
X-Received: by 2002:a05:6402:270e:b0:424:55a:d8a3 with SMTP id
 y14-20020a056402270e00b00424055ad8a3mr4840354edd.221.1650634613307; Fri, 22
 Apr 2022 06:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 22 Apr 2022 15:36:41 +0200
Message-ID: <CAJfpegsLCQwxUSjbEZiU_JHQHFAgJ3Z8NHGG9C5jM7gLM5vr=w@mail.gmail.com>
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2 Apr 2022 at 12:32, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>
> Move dmap free worker kicker inside the critical region, so that extra
> spinlock lock/unlock could be avoided.
>
> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Thanks, applied.

Miklos
