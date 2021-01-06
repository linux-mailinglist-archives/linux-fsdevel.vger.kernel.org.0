Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794162EB827
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 03:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbhAFCja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 21:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbhAFCj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 21:39:29 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1157CC06134B
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jan 2021 18:38:14 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o19so3384420lfo.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Jan 2021 18:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ury5f7F0ygdu/yondQUGmbZ3cq88GMLsTjmzvozFvjc=;
        b=JJTa/Tc+QXB7WTaTy03wXcVsiHCJ38bI/5PQU88HQ7YN4KMpPo+5MqlwDqB9HQdU4s
         +ffbgkc58Jd0iZCuDKXDzIQGz508oG5upwZRERod2tiZ1JDwovF24A9bNyAkovIsB0DF
         vQ5dhm6M/QrRyW2sUvMRUA8fA580S8vKFJifkqsq+biFxy1WYEC9GR3S8uLl402UtDGC
         8+BMzLyqfGhxhyK18nkdQE2lGKcyTUxz20aGSs7EYR3LJx/Bh70Xel7XpEPeO1o75+dR
         tTMfb8mBfsjMHKptKJQv9ke1SSeQz2hTBc6aWrgTgKDd6Gucj4N6AKERsmxMfoBBgG5f
         D3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ury5f7F0ygdu/yondQUGmbZ3cq88GMLsTjmzvozFvjc=;
        b=fxqa+pGBqGYq17gAKhavXbxlcLoO+xzAJRmjYrPIxxnJAdvcoihx4tj5LdWOqzGn3H
         R87hGM6NJGkf8Jl7ARVY1sxFyVmq1agVkS4qAKSCVZpd1pGYthIc6PavpRIRM0Idnbn0
         yxGgBxuJLxiaA8MCSFJf5nVavJIF+CJGCNroqgQrZkFh28y5YSi1l+/R0KYEjfPH3a5D
         AyKHLl2TqenCddfRxOdBJS5FVaaryEivd8I2akHwcX1m554d15p9U//5sGFb3xt2IICd
         VyQRJqFuzcJZMWwwdvDkTopn2BfnPP+VWE5XFVwRw1BvkicEkD/xHvr2qmxTWd/7GU3O
         TDYw==
X-Gm-Message-State: AOAM530MfNGnHa7Tw93Gwep+4+MN61J0Wmu/Yj1UiNK7IEdEEhSrZEaa
        fjsrVwM/Q5Is24gsEu8rk7Rw1UihH7TRaNlfgD0=
X-Google-Smtp-Source: ABdhPJyhW9COAv+OxGK2kh2IIX00msmTRyXR26oD1Hjec8jnar2dkN9PRalz7nXQlp7ElJNqMzgTW0hTwXUYrMrWpTo=
X-Received: by 2002:ac2:599e:: with SMTP id w30mr918546lfn.552.1609900692588;
 Tue, 05 Jan 2021 18:38:12 -0800 (PST)
MIME-Version: 1.0
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
 <CAC2o3DJqK0ECrRnO0oArgHV=_S7o35UzfP4DSSXZLJmtLbvrKg@mail.gmail.com> <04675888088a088146e3ca00ca53099c95fbbad7.camel@themaw.net>
In-Reply-To: <04675888088a088146e3ca00ca53099c95fbbad7.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Wed, 6 Jan 2021 10:38:00 +0800
Message-ID: <CAC2o3D+qsH3suFk4ZX9jbSOy3WbMHdb9j6dWUhWuvt1RdLOODA@mail.gmail.com>
Subject: Re: [PATCH 0/6] kernfs: proposed locking and concurrency improvement
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ian,

I am rethinking this problem. Can we simply use a global lock?

 In your original patch 5, you have a global mutex attr_mutex to
protect attr, if we change it to a rwsem, is it enough to protect both
inode and attr while having the concurrent read ability?

like this patch I submitted. ( clearly, I missed __kernfs_iattrs part,
but just about that idea )
https://lore.kernel.org/lkml/20201207084333.179132-1-foxhlchen@gmail.com/



thanks,
fox
