Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6D226F882
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 10:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIRIkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 04:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgIRIkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:40:43 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D5AC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2020 01:40:42 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id e41so1604384uad.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2020 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwlUQkGfUvPCwlHhD4WuRXZet1Q6IjYVRW9aDOj5UKM=;
        b=ARKtKE6lE5a03DrnZTKqf78mVzHs84uTofWc1TE5e/iFtdns0FVSKo/0ZtdKubq8X9
         II2vXBN0q1BBCeySgngcs9zrMRSXcr2pbfo5usjQY9HLyY8Z7EWYndXqt3bedZkRup59
         /6nWUSi37REMTm5x4i+GhfqJhZywuSXqpRFXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwlUQkGfUvPCwlHhD4WuRXZet1Q6IjYVRW9aDOj5UKM=;
        b=HBkRZoaHMeaeA86Do0k/Mgctsj1PdBlChir8qxFa4O9sLotGcnrK/oOiVlJzhjS7C1
         sTRg9i+lxG7Hy886aIuv6n5FYqcj6S5Hih9lM1Q6G3AEzVQxNkOXigq0//FNRbVRUICD
         ngv0ruii0BsXwo/WCmJxzivUX+2UDV9AGNddN7frNdiEI+CUUKIWBz8Vsd5NBlnTAJfD
         5uBYzFqGFKXaNSEs9jvXKURffkiwu21yJkd/u+QFrj9VIr/omE6/Qi8jFtYLJJNTix1J
         LYRDlxKCtL22ddBc7W+7LAFl1kcEKNlpZDcBXRbBXN82OWHalr4BTomxkXE+C/uuQCHC
         sivw==
X-Gm-Message-State: AOAM5328UYvguAfA6zJxXtklT6PC+8M/2gXf5TJKyBKzatfhr/zMoc+3
        JjbQziK/2Sh0dHmwJwkrhpc1Bz82iNYC+Zr4FXFouw==
X-Google-Smtp-Source: ABdhPJx6RkummIEone8ls4QlHgyOMLzJ3jPTYR6lAGVfQnqYSK8NmXfxl4FrhUrfiGgd4OsMP078hHxGHYtZFxS08mI=
X-Received: by 2002:ab0:6298:: with SMTP id z24mr19715384uao.105.1600418441630;
 Fri, 18 Sep 2020 01:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <1599553026-11745-1-git-send-email-pragalla@qti.qualcomm.com>
 <CAJfpegunet-5BOG74seeL3Gr=xCSStFznphDnuYPWEisbenPog@mail.gmail.com>
 <0101017478aef256-c8471520-26b1-4b87-a3b8-8266627b704f-000000@us-west-2.amazonses.com>
 <CAJfpegtpLoskZDWwZpsEi=L_5jrvr7=xFG9GZJd8dTdJr647ww@mail.gmail.com>
 <a98eb58e0aff49ea0b49db1e90155a2d@codeaurora.org> <3ccc311257ac24096a94fb7b45013737@codeaurora.org>
In-Reply-To: <3ccc311257ac24096a94fb7b45013737@codeaurora.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Sep 2020 10:40:30 +0200
Message-ID: <CAJfpegsszydzh2O5V83mQMjHp0uqF2Xz=QUNZpJrP0L32uEDQQ@mail.gmail.com>
Subject: Re: [PATCH V4] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero
 ref count page
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     Pradeep P V K <pragalla@qti.qualcomm.com>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        sayalil@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 5:31 PM <ppvk@codeaurora.org> wrote:
>
> On 2020-09-14 19:02, ppvk@codeaurora.org wrote:

> > Thanks for the patch. It is an one time issue and bit hard to
> > reproduce but still we
> > will verify the above proposed patch and update the test results here.
> >
> Not seen any issue during 24 hours(+) of stability run with your
> proposed patch.
> This covers reads/writes on fuse paths + reboots + other concurrency's.

Great, thanks for verifying.

Pushed to fuse.git#for-next.

Thanks,
Miklos
