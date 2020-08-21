Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BFC24D64A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgHUNni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 09:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgHUNnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:43:33 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A59C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:31 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o23so2356519ejr.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwPYAaAyjgcgcGgiOAPq785/sNM+j+6uNMAeEOCCIYQ=;
        b=C2OOoRUPg5JdyGi7R5v6jL/8I86rGRKKmib3ykTZ0jPM0l/xCiP70gNgQ8B4g5hHQv
         ZFzl2WMy1xx/1z6vsSe8+7aqo2+QIg4gzsHK8sYUsUL+cGrp3U1eXJKXa37HkA4maezX
         j0E49FnfY0OH1MBnWAPtpyJcFN4V7/Db3nLRO07/8qxfyU2fySzHPgYhm9fAxxUVA/lM
         /sExE5yM4HxU04sB6tro+bFD3+YgcsCT2E5nS3gXC5eafDZwCXtQsGAV9jCGIRvL83Wv
         PE/SNyEJrs5HzxVh7NoSNIp0067uwpbq3tLIsX5v5drqTXc3OSXg07nZl6jS1akSqkw7
         OVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwPYAaAyjgcgcGgiOAPq785/sNM+j+6uNMAeEOCCIYQ=;
        b=HQ9kTAD7d12qGnSsPlPUzdzvg95CRqoSQkhexuHI+H1yJq+dTggVs6l1DIhbFPCldc
         oDAv+/KymL1FdbyNHfq93JuO2kun9wA9kZ6SSveGT6jI1AAJqwZKU4gGSDBgYcXPdEWU
         1ssnMNe61IvsPSTctjvoAvmHrTvcNfHBtqlcAqm2w4SCWe0YEgaQOpzm+j0XwiXSVdmJ
         x7wbfy7WxdnxOPW05mYAlPGGjrcECZLIwnOxWy47Tb3ix3i4wAkCtGLu6312+ahAyfr2
         fCbEwczlAD3Yy6V1T6cAyuU6JOlK9wx8dT+i1jarQn48ZoEYDnHXPomDmlo2XwMFmwA6
         FHZA==
X-Gm-Message-State: AOAM533YlJWCzfocys5Z/7at0V9adlpzB/SthvAACstWFaiuScArKVOf
        AIvgGQq+6C75DIsEQBRjoU4+E+OOXSnmYaL1Wqnt
X-Google-Smtp-Source: ABdhPJx/JW++1YCyrYu7jShC9KtWQ5VmMfCwSPJyKTJ5baRc9q/Nu4UyhcADgnYRthpWL2h2Cv6KRIuFOvH/lc/C7mI=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr2924861ejb.91.1598017408415;
 Fri, 21 Aug 2020 06:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com> <20200819195935.1720168-2-dburgener@linux.microsoft.com>
In-Reply-To: <20200819195935.1720168-2-dburgener@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 09:43:16 -0400
Message-ID: <CAHC9VhTi1F9XgZvOkRgx7zTXLQx8mN8oEBLKdDfTKRntiRx0Fg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] selinux: Create function for selinuxfs directory cleanup
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 3:59 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> Separating the cleanup from the creation will simplify two things in
> future patches in this series.  First, the creation can be made generic,
> to create directories not tied to the selinux_fs_info structure.  Second,
> we will ultimately want to reorder creation and deletion so that the
> deletions aren't performed until the new directory structures have already
> been moved into place.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> ---
>  security/selinux/selinuxfs.c | 39 +++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 14 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
