Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACF2345724
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 06:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCWFVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 01:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCWFVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 01:21:47 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C244C061574;
        Mon, 22 Mar 2021 22:21:47 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id d10so10264476ils.5;
        Mon, 22 Mar 2021 22:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUPGwHyfCFhrEpg/kWavchzpPaEqNThbAknTwO+GXwE=;
        b=Q30cijKjBPZcUumK9c6JEf6v1L6cssfeK21CQTE2vmnkQad4uFeUit/Wy4kl22qC9A
         4BXesXSR9Xl6aadVzaEVUWD1qzhAQd969S5eNvRMC4awroXzbQsQLMmZHKfZAl2my2Cv
         mqd9ilS5f0+/lcoUhWwZ+/O6KuSRPmqF8FJO0gRvpB3x4V/sHzLRj17qB2k/aNETXCmX
         u5w0i4UYYTYLQHGIpcSB3zXF9xGSzSWnKqeJ5laMuuLAXWp3UOZHYpLaBQ/Z/wdMdBro
         ZEW2Poyw3fcNJxCMi9iG3XawWDJR+Jk/a2i1Mhrkzi/Aox3hSTgcI6sw2mMC99NvBruS
         iNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUPGwHyfCFhrEpg/kWavchzpPaEqNThbAknTwO+GXwE=;
        b=PrbGfJ5G2fH+T5C9bR6YuAHvL0BtzXORliBdUC3f7PKcR4DQzQKeVYgV5z13UxykPK
         hala9w/GxeY4rBLF/yYNnN4acmc1F1WZiU+4o1dJYaZc6sy8vzLTje9q45uN4JT9mq59
         CtIDXB67m3mkS8yNgOfIVU5uumnp0kscCboa1D37gchPYN2sR+2ukG68mK1SIGt0NQRN
         Op3Z0ZiR2nwmbCKG3iYs9j+62AS2Wb9+TQuQkq9i9pc0Jd5N9G+TT+lpLCUyH6TZkujz
         eIWGtxic3hcP9q2I+vTGjwhIQeI7Ci13PlOdF5481j7uFXj9h7KR9ClJSVhPCRTfUWjW
         DPbQ==
X-Gm-Message-State: AOAM530XcZPACA/xjpZLFvDrtF/jBRVuXkfgSJvMPU+Q7Qs1XyWbTV8/
        GRITbwuJRrpFlUf11koEjVbJ81zrD8GFwYq+g9E=
X-Google-Smtp-Source: ABdhPJzHA0qDITha2g0lDdOXurKnM8m7i01zKX3wBlGzeIpmXZ9KCi7mK+ftSET1YYSGgmn3737v0qJ6tCNmfYa8kV8=
X-Received: by 2002:a92:2c08:: with SMTP id t8mr3284834ile.72.1616476906587;
 Mon, 22 Mar 2021 22:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210322144916.137245-1-mszeredi@redhat.com> <20210322144916.137245-2-mszeredi@redhat.com>
 <20210322223338.GD22094@magnolia>
In-Reply-To: <20210322223338.GD22094@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 23 Mar 2021 07:21:35 +0200
Message-ID: <CAOQ4uxjuKWGYbsg8KdF4dncOmcSrL_Mhj5_E2B5JSP58aMsQ-g@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] vfs: add miscattr ops
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +``miscattr_get``
>
> I wish this wasn't named "misc" because miscellaneous is vague.
>
> fileattr_get, perhaps?
>
> (FWIW I'm not /that/ passionate about starting a naming bikeshed, feel
> free to ignore.)
>

Eventual bikeshedding is hard to avoid in this case...

I don't feel strongly against "misc", but I do think the flags and
ioctl are already
known as "fsx" so it would be more friendly to go with that.

If you don't like "fsxflags" because it's not only flags and you think
"fsxattr" is too
close to "xattr" (FWIW I don't think it is going to be a source of
confusion), we
can simply go with get_fsx(), similar to get_acl(). It doesn't matter
what name we
use as long as everyone is clear on what it is.

"struct fsx" is not any more or any less clear than "struct statx" and
while "fsx"
it is a pretty arbitrary name, it is not much less arbitrary than "miscattr".

Thanks,
Amir.
