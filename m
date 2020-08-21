Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10224D65F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 15:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgHUNpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 09:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgHUNoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:44:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEEFC0617BB
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id di22so1438206edb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThqvJPVAt1k40pAXNs/4MJKb4e62gPXaTQ23UtAvrFU=;
        b=zoXS+GZHOSUhxBOaFtvSm0cRAQyQWOAk0zO78DhJxL4g7QbXnVliajOCWf6dc1d1bl
         x+oK2pRZ/VTVTZuSbWnFciazhGq+8ZgoNE04pdkiSIsozjkfWSmIgLn7/vZ5IOu3GjYf
         db7LJWCE36bApiJXHmhknJ0IKOhI5o4jT/EUK9uYZfCKfn5nmOwwFd70zjXtmakG91tl
         /p8dsffnqTwZAotrhotLd2mV6Yr/4twEKwTMaoXh03IlnvYl485e2qtoMkVlPXUNtXAb
         T9XvR9RWx3UVLTltIvce1tIopRFMtkpfC8vdo4gfEamXcHnv86IhgOqxQrpXry+aXaF3
         mMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThqvJPVAt1k40pAXNs/4MJKb4e62gPXaTQ23UtAvrFU=;
        b=RznfPZdEMY/QenGTTL1gnySDRvVL0i4vv4dQuyXgFtXBmublUnOTKxC72kVTBA3kw/
         AJvxs2jiVq6TERyk4eH1vM/Zc/553gRDFFGTlAITSM8Ao5l+KcKZbLUG6SmK0ry7s1Ws
         8epeWeeN5F9ypqRk3VG+unAdckLkjB1lI64+mQIHrD40ERbEMOvYxNJiMjErIJJHHGt9
         wGDIaU5gNBekK4CE/KweXlSMjmLt73y0kRRGd5EIY/jv9XAzn6Vl80PbIbTnudbN/IZ6
         4/S5saXIE46Mypbid4X0okvJu7S2wAx7EznyobwwsYZXt9UuHwX8hvdXpx8qUfpCwFk6
         fnWA==
X-Gm-Message-State: AOAM533TMvSHi8U08buOsrACkw7sNJaEShItqz8LHZ68U/8+BtpQVjNt
        mwFOvWuAZ7VWYshmYbP2GhxIsBVqyd0kBINc4qoD
X-Google-Smtp-Source: ABdhPJzfXGGBBlnrtjP+kIEMmpJM+BHFPNrRyhFTTHkds09zaAYZz0htWNuYUb0v7KEh1R7P4qnO6LqobkBFlB+IVFc=
X-Received: by 2002:a50:d809:: with SMTP id o9mr2799575edj.12.1598017437083;
 Fri, 21 Aug 2020 06:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com> <20200819195935.1720168-3-dburgener@linux.microsoft.com>
In-Reply-To: <20200819195935.1720168-3-dburgener@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 09:43:46 -0400
Message-ID: <CAHC9VhRR732OE7rkQ+QQe4J-z9ygfS=GD+U_5=9Pj2CykuAr1w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] selinux: Refactor selinuxfs directory populating functions
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
> Make sel_make_bools and sel_make_classes take the specific elements of
> selinux_fs_info that they need rather than the entire struct.
>
> This will allow a future patch to pass temporary elements that are not in
> the selinux_fs_info struct to these functions so that the original elements
> can be preserved until we are ready to perform the switch over.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> ---
>  security/selinux/selinuxfs.c | 45 ++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 20 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
