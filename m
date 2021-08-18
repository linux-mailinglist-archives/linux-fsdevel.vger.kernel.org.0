Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF333F0759
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 17:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbhHRPER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbhHRPEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:04:14 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71005C0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 08:03:39 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id ay4so1122163uab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6OCLZQBwVcpLwcY/DKCJmIdalTErEPwaknULWqkTgYU=;
        b=XFzYhjc12V3mkhM5uroFJxJTQx2njr5xJq4zJ0RaA83UeTJZTMx7hxBZFCPybq/C7s
         eCClrNbsgsgbxrW9WBrUg/y/n8AUyzHDgjnxdpFtPrtIu9b2WP0aOryWMumLrOjaKFVL
         pXkg/VmXgIvbmuyfEFvedk07te9ttq7YgUUR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OCLZQBwVcpLwcY/DKCJmIdalTErEPwaknULWqkTgYU=;
        b=V4ZybkxQHKejfrNlVOoqlYF1U1ARlnE1m5tZMa2iEDyllKN4ZKz+coCMGafkfxsMXz
         RrKm44dqBzBKN7asyogPjK2i+iLWh/F7oPYhY4pcK3h01YK8skAcN235ePkzOoLSSovb
         e/X4eoFVaGxtlPPsapbMNtIxYVsul78qvkY1MZm0UeyVBm4N2Zy9ymEatnHg5g+rlfww
         ljWm7xhjsORRAB8wOmJFTVfXKRz9g00Qg/vS7FH0TN7Y18yz+EIMip5Is6d7iqjaSXer
         Ah+LUrziYynDQOa9NGlT6NhISemHONmsbYK22WVttiYwi7D9YkVJTbwPrX5wshDbbZDj
         oBsQ==
X-Gm-Message-State: AOAM532mbXzsDGbuZbj83iwV9AOHe7n8J4PXyTbGv2eMHKqx2GpSF+s2
        nCRAbW7LdJegcgdYEW+xE1IwEThUqUCCHf9K2BncbA==
X-Google-Smtp-Source: ABdhPJyDTknAMeyHz6aoQlgvyjbpcWmvkXnm1pMSL/rA6R5TLhjnybHbvy47eIc1Q6xlHDljffCdNY/dyRXZ5BoDizo=
X-Received: by 2002:ab0:36ae:: with SMTP id v14mr6764417uat.8.1629299018623;
 Wed, 18 Aug 2021 08:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210818133400.830078-1-mszeredi@redhat.com> <YR0YiSP3DliPCPWF@zeniv-ca.linux.org.uk>
In-Reply-To: <YR0YiSP3DliPCPWF@zeniv-ca.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 18 Aug 2021 17:03:27 +0200
Message-ID: <CAJfpegsSQv5im4KRN3EfryyNy6aq9eRPPgL_K-1Knj+qtXiaQg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] allow overlayfs to do RCU lookups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Aug 2021 at 16:27, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Aug 18, 2021 at 03:33:58PM +0200, Miklos Szeredi wrote:
> > I'd really like to fix this in some form, but not getting any response
> > [1][2][3].
> >
> > Al, Linus, can you please comment?
> >
> > I'm happy to take this through the overlayfs tree, just need an ACK for the
> > VFS API change.
>
> Looks reasonable enough; I'm not too happy about yet another place LOOKUP_...
> details get tangled into, though.  Do we want it to be more than just a
> bool rcu?

I'd be fine with that change.   Calling with false/true is less
descriptive than calling with 0/LOOKUP_RCU but I guess we can leave
the actual calls to use the latter?

Thanks,
Miklos
