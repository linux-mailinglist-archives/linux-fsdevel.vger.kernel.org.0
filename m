Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C09E1D91F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgESIVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 04:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgESIVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 04:21:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80233C05BD09
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 01:21:16 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z5so11052010ejb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ccvp0UKA18YUUwbPrCJB74eAv5CbqESEGZXqss0korg=;
        b=BFj23ItLM6qHv7UFGIw4Z1tHDlsRy0cE17vc8ryxdCY/TBV3EeSAzz2ARf17Z+2At1
         UjMn6m4tGShREGUTMqco/W3LTIKTRO0BvxZKzJxP3TOy2qxYf/ojdFB/O2eVNeCHkrIe
         XHjr9Z5fTPz/wtjbT/EHgGPHqmjTwag8yEcGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ccvp0UKA18YUUwbPrCJB74eAv5CbqESEGZXqss0korg=;
        b=b2dgsN1Xb0n48sK8Xfb8qsmcij5E5SUK+qnztixgAteCWyGSIYrDoYuJWSE16Ea/Gu
         Wd8D38k2Q4JYUFeA4CJoRy8bBjRn6rJDVwkgH06Jn0be5iLmiqD2n+wLO05KzIYe8JfQ
         p6beBYM7HqcvtJIKqsBj3OQlkoeF/J+DP8lAEJuoEUBqBRQexJLJ+nn41bTwt+6On41X
         C+6acKbijRfb21rpdo2gsYxzoS1G6MUFnqa7qNSZ2EzBeOZwXflqw5JzhZEXI04QIL49
         oIs6mRh3oGeC3pC9btZzUfnUEd5ylyhXdJsK0Epj8wcNzXoCtcyDy0UwdBlV+4zgHSy/
         UhaA==
X-Gm-Message-State: AOAM5321PmJoz6vn0KnqSvip0KDVxu9sqsO817Y7MOEs0QGfMm/krtE1
        UVwI99xvfll/LfPmeXsJVryzddypBEZYuP1NXkr7/w==
X-Google-Smtp-Source: ABdhPJxk6mvgGGPc6gMxqKBM2HwfSbIRkvpM0M4MWM0/H4pPLUHTRwKgzq9GqfYRDFAgyGefJw/gtu/j4UXcR9w8mjA=
X-Received: by 2002:a17:906:f9d7:: with SMTP id lj23mr18927763ejb.218.1589876475234;
 Tue, 19 May 2020 01:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200515072047.31454-1-cgxu519@mykernel.net> <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
 <CAOQ4uxjT8DouPmf1mk1x24X8FcN5peYAqwdr362P4gcW+x15dw@mail.gmail.com>
 <CAJfpegtpi1SVJRbQb8zM0t66WnrjKsPEGEN3qZKRzrZePP06dA@mail.gmail.com> <05e92557-055c-0dea-4fe4-0194606b6c77@mykernel.net>
In-Reply-To: <05e92557-055c-0dea-4fe4-0194606b6c77@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 19 May 2020 10:21:03 +0200
Message-ID: <CAJfpegtyZw=6zqWQWm-fN0KpGEp9stcfvnbA7eh6E-7XHxaG=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Amir Goldstein <amir73il@gmail.com>, Ian Kent <raven@themaw.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 7:02 AM cgxu <cgxu519@mykernel.net> wrote:

> If we don't consider that only drop negative dentry of our lookup,
> it is possible to do like below, isn't it?

Yes, the code looks good, though I'd consider using d_lock on dentry
instead if i_lock on parent, something like this:

if (d_is_negative(dentry) && dentry->d_lockref.count == 1) {
    spin_lock(&dentry->d_lock);
    /* Recheck condition under lock */
    if (d_is_negative(dentry) && dentry->d_lockref.count == 1)
        __d_drop(dentry)
    spin_unlock(&dentry->d_lock);
}

But as Amir noted, we do need to take into account the case where
lower layers are shared by multiple overlays, in which case dropping
the negative dentries could result in a performance regression.
Have you looked at that case, and the effect of this patch on negative
dentry lookup performance?

Upper layer negative dentries don't have this issue, since they are
never shared, so I think it would be safe to drop them
unconditionally.

Thanks,
Miklos
