Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90B33AC13C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 05:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhFRDUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 23:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhFRDUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 23:20:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3FBC061767
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 20:18:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g20so13498149ejt.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 20:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLggwlEz9KvaqTsvD1N67bjXjYEPfw0xJN+eofsbIEg=;
        b=LeS2JjPwBohnWSN3UMBVdfjycTPlOisHQcuIJVwOlO9eR1p8p0xWOrm91+3FZl6C97
         G1rwNnlyYPzxy4McN2Y037p0crdsF8/zAOMC2sXR+QxnLekiwdb2BA+MMd4JepSPJy4j
         CtB3r+X1EkC31clb9Iw+5PQUXoOjC9nRmepkaZcWiAgX1oufedkU7HIKEpZokMf2qH7H
         RoEZKXdE3J0HnWEGuz8BKlTKHms1uoIqXENdI0+x5J0wBZHBJ74G78bGhvGT5wvq2Etw
         VAuHVTYtD4nanHpASudOb+OmfBfxWJlFH8e/oxrCBqWm+l60T8FlLlDOj+Nq6rDyxqaA
         a1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLggwlEz9KvaqTsvD1N67bjXjYEPfw0xJN+eofsbIEg=;
        b=XgE1lLx2NQ5OkBHsox+pFyi9VVpyi/2fmQJzFg2XllRmx0VPvURRz9pCebo60+e7YN
         t/twrA9ATYzIXzwYitTKyna4nfoCHIoqinol2vdnVApxDmWjVcvoBSep0skM3WQE20Hz
         CKaxsZSb+sFR7GBTWlyz5zsydxVmoXjR/RN5WbFpctocaQLgYbMiGCXZbSZ9NXp77rDP
         b7fI3sYp0cYCf5eEaoHbZXu+KHJzFYdasXxTRky5+A5MydIkw5vhrGd7V1aGfYtiymr4
         Rgb6+JdT0w7xjOvAt1kLAg/CrkKf3F+uOSJxVCC22xF1mhnUDtUFhHCgIM4Euk8Xdnpu
         YEFg==
X-Gm-Message-State: AOAM532C1NYiesJlTJ37qi3PsfREYsK7y4VOAEtXLWAx4jl3JEVVrpl8
        /wuT9BzfRKrtQjf/SkG8ryniT3clbBylanByJYzr
X-Google-Smtp-Source: ABdhPJzN+mYgtC0eBkhZhzGJhLQjFCbBuFlJghEgoQO/wcTYdvnFAIXrjFWrVDier3cOEKa4xAydvckxOEAYsT5C+1Y=
X-Received: by 2002:a17:907:a8f:: with SMTP id by15mr8609968ejc.91.1623986316521;
 Thu, 17 Jun 2021 20:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <ee75bde9a17f418984186caa70abd33b@huawei.com> <20210616132227.999256-1-roberto.sassu@huawei.com>
 <6e1c9807-d7e8-7c26-e0ee-975afa4b9515@linux.ibm.com> <9cb676de40714d0288f85292c1f1a430@huawei.com>
 <d822efcc0bb05178057ab2f52293575124cde1fc.camel@linux.ibm.com>
In-Reply-To: <d822efcc0bb05178057ab2f52293575124cde1fc.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Jun 2021 23:18:25 -0400
Message-ID: <CAHC9VhTv6Zn8gYaB6cG4wPzy_Ty0XjOM-QL4cZ525RnhFY4bTQ@mail.gmail.com>
Subject: Re: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:28 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Thu, 2021-06-17 at 07:09 +0000, Roberto Sassu wrote:

...

> > An alternative would be to do the EVM verification twice if the
> > first time didn't succeed (with vfs_getxattr_alloc() and with the
> > new function that behaves like vfs_getxattr()).
>
> Unfortunately, I don't see an alternative.

... and while unfortunate, the impact should be non-existant if you
are using the right tools to label files or ensuring that you are
formatting labels properly if doing it by hand.

Handling a corner case is good, but I wouldn't add a lot of code
complexity trying to optimize it.

-- 
paul moore
www.paul-moore.com
