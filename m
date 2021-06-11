Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA73A42DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhFKNR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 09:17:27 -0400
Received: from mail-vk1-f182.google.com ([209.85.221.182]:38629 "EHLO
        mail-vk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKNR0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:17:26 -0400
Received: by mail-vk1-f182.google.com with SMTP id 27so2512968vkl.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4p7Da6Bo96meqCCmYg1il+szOZMpXmVP32ev1MWjqw=;
        b=Ot4WYiEYRIGG3AWEh0UfJ0VBCs67SEfKPGht+bHJknT5g7pwYlgHwxQOciIHRzx08m
         hIt7/+kXeW2MYUANeixNF4W5KD5kfebehNQo/rfBst3oCwi3WSyG6RpK1tOaGaf/tEsw
         ZAWXWpBc4AkEFVwaWWEK6gFWoOOSKw571BVes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4p7Da6Bo96meqCCmYg1il+szOZMpXmVP32ev1MWjqw=;
        b=nH03YRHMzb/Ql7pLEIwS9nUP0pN5GkC4t8+6skKJVxodseIgi+jJKPqKUtx3LrLhH8
         xRi7vmxGHoFnQ2k1jPrdA6mCGMHIyXZWFziQmwCMttEXLJU3WdtkVyOrvIa9hxAu32ZG
         TNVbsdckKWlSrFgk+aWhxR95eN1GoEmNWqzXjUzjMvjZugzDmThaJ+o6AiNm1NfJBJNw
         FfUZDRqj01fIl6WQxWpzfWa5SF762H2hOlQC7ztHs81Mc1J7x0xOfRTHk+L/HbSIRjW4
         eFl68SS0AJzA5gGsFdY7fTvr+7taHcyOBzgcDou/iPtylrZPCIjp4GRf0I4ZJcFWzxV5
         kZXA==
X-Gm-Message-State: AOAM531KMlNnJZ7UttcNG61mGg/ggbVadDxcrdvmDbUmpAZrUJyKWmn4
        Sf5Oq4+4aoYoA6rV06tEfNe8/m+goj0aqBKLOeznfg==
X-Google-Smtp-Source: ABdhPJykpGz+EVt6yKODI9QwMAUVsXqDJL2V4qGkSQk27RFpMDRg7Bxel51dVr3TK8CqlFwAjV275wHFlPReYTBQ0Cg=
X-Received: by 2002:ac5:c9b5:: with SMTP id f21mr8183303vkm.23.1623417268493;
 Fri, 11 Jun 2021 06:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322874509.361452.3143376113190093370.stgit@web.messagingengine.com>
In-Reply-To: <162322874509.361452.3143376113190093370.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Jun 2021 15:14:17 +0200
Message-ID: <CAJfpegtCfgpZ7UpOf+-1qCijWTEvPtCEEPLwd1n4LWeqEraTAg@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] kernfs: dont call d_splice_alias() under kernfs
 node lock
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Jun 2021 at 10:52, Ian Kent <raven@themaw.net> wrote:
>
> The call to d_splice_alias() in kernfs_iop_lookup() doesn't depend on
> any kernfs node so there's no reason to hold the kernfs node lock when
> calling it.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
