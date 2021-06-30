Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38CF3B8270
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhF3Mxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 08:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhF3Mxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:53:53 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E0AC061756;
        Wed, 30 Jun 2021 05:51:23 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id g22so3014999iom.1;
        Wed, 30 Jun 2021 05:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Z1Sr0ZZ3Eaq33xdrYwzRNUibLuxnwUA0miK9swTaYI=;
        b=cJwlQR0PDO16mUnge992zKP+NwR6BBGtWFmFC9sJW7wkgtUHU9isQIg74HVWOqx2FA
         1+oO596YYhUJRvGn/tvHFEah1egYALLUM6emh91+SiBZL4fk7JB1mmxCQ5WO4Or4posA
         gYuFpmZkm5kzlswRgM5CxOxVAXWXAWYHgXsrjQhzu60Ixp/NAbO0dLma9NXcjWjIZKmc
         7l6CI12Y7yMA4igg/XxP6wqAxSVHsdAc7OQ58TxNF4UHA7JA5X61pYDUUJ2JDN+DCoYw
         yc9ofwvKGsN0LuKrbdrw4F1mdw5X+qor/GhoxLk5ZN5gMt1HiI/2JIsyooMJTBmVRGvY
         QxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Z1Sr0ZZ3Eaq33xdrYwzRNUibLuxnwUA0miK9swTaYI=;
        b=T/AiKUUT2fUfyKF/KoAX8J5TUlEX+RYiILJWHcIDx1JDCjr2W67BDt6zTWWHkrl0A4
         sCtslvXn5xqt9182/l+LMkQmT7k9dwPopHD1yisE/u4Vn5SB7SW9mH7FpvQoIfKLHTOw
         9lgLp/bCj/uVIKB49WrO9zy+RB2ajOP+ad7SE2mfKbXzSJAfxBsXpMyb7t/wdsq1178H
         zWIqo3wj2DC4VuSphRGWtztmAPkN6O/NiujN/Z4twxH0HwxAjCj+eJDXaFyRmbUv/GfT
         vpP55h7vvbduJ+vuvREY2TBgC4sBZuj7kKRTnPYA25pakhc93yMbaFbFYnGUlWnuN/xR
         PUwA==
X-Gm-Message-State: AOAM532JSYoG9TYdXaRpUQozrk6JBVTKedPypiWAihV2aavmZ++icFz7
        4ha5otzbrUvpvADPSDm8HSWrKnzyLtxJnH5/950=
X-Google-Smtp-Source: ABdhPJzVZkc+LfDp6m557XKzYHLSlNrC3wMCjCrF2Kio441WtDXxumEaJN/tR6q0H0NUP/LaWjOguV37sQwlQ0T1XiM=
X-Received: by 2002:a02:9109:: with SMTP id a9mr8752667jag.93.1625057483032;
 Wed, 30 Jun 2021 05:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-8-krisman@collabora.com>
 <202106300707.Xg0LaEwy-lkp@intel.com> <CAOQ4uxgRbpzo-AvvBxLQ5ARdFuX53RG+JpPOG8CDoEM2MdsWQQ@mail.gmail.com>
 <20210630084555.GH1983@kadam> <CAOQ4uxiCYBL2-FVMbn2RWcQnueueVoAd5sBtte+twLoU9eyFgA@mail.gmail.com>
 <20210630104904.GS2040@kadam>
In-Reply-To: <20210630104904.GS2040@kadam>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 15:51:11 +0300
Message-ID: <CAOQ4uxg063mwwdLnM7vooJSB38HvPF5jkSck6MunEL+K4oHArA@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 1:49 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> I think my bug report was not clear...  :/  The code looks like this:
>
>         sb = inode->i_sb;
>
>         if (inode) ...
>
> The NULL check cannot be false because if "inode" is NULL we would have
> already crashed when we dereference it on the line before.
>
> In this case, based on last years discussion, the "inode" pointer can't
> be NULL.  The debate is only whether the unnecessary NULL checks help
> readability or hurt readability.
>

Right. Sorry, I forgot.

Anyway, patch 11/15 of the same series changes this code to:

 sb = event_info->sb ?: inode->i_sb;

So inode can and will be NULL coming from the caller of
fsnotify_sb_error(sb, NULL).

I think that should make smach happy?
You can try to run it after patch 11/15 of this series.

Thanks,
Amir.
