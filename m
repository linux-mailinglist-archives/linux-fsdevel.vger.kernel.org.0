Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4732C351313
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 12:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhDAKNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 06:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhDAKND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:13:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1616FC0613E6
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 03:13:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kt15so2017009ejb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtFfJN2reAn9UO8mOQ0mmSXpHJo5c3j1q/3mUQUptM4=;
        b=hbq03KlLdPC3F4WEFhl1Vs7y81/OLBYEvMeu7lK36E5ULiTBH4TywOGKEHGVWYtFJE
         sup+t+QOmVM0U2SXPQQjJnbhbhrxiLMgn4rlzccZM2t18QE9HDykPnL2XcrqKdEEgLAD
         oDON3PyYuvj4Tpi6cB8+FHPlWU6MJovhNzkBys7lZAuSm7hgD0NMOq3B9ercZkdNi5wo
         0s5isMGxmN7FZ3MQpPzpVOGjed29s+8ulBwdV5g7lDuEXnDeWzopvMIskqGl1YjWqdNA
         8wceBnr0h6gSC10eo2jxe2ZJQc4Ow1mnaUDAN3gSY9SrvzQifecfejjkQIhfnlI2g9ze
         Xbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtFfJN2reAn9UO8mOQ0mmSXpHJo5c3j1q/3mUQUptM4=;
        b=HvocdNNjhHox2Yx+XMKZoMU6sBOL6kF3yqR3KSYUBxIHLkCP4PTky/iVrxevhExsNK
         DDgV7S7gXAAMunOjRL3cYPPVUgUD4dXyX/TV0KCcal3+51wFLo+itiyU2+SEW9LwDNEC
         Bs9FeIAtLXYKeuUKQMxNyT8cM4RWWKhHD9HY9V65sTO57YoiF2rulf5MpH/KDbAZnEFk
         KQFQtVf+B0MFC7h5NrZhcnaC8ySR1TD2YmbxI5fVQlA/y0pgZGTTa+nHIGt5BfYe28uV
         V+lQVz5bbZca42MXb12WTmqEwks2RI52e9Z0I5UDoJeRAdeCSDTW93uVn6h5AjMUzPUO
         ILSA==
X-Gm-Message-State: AOAM533Acc0F5mQcJylipvnvOKfkN5A4XBThZ9rfvlOrOA9QgvIqzr6Q
        7nCIYrtheoUo6LKHg+uUr3/D9aflkPeIX4Nbj4iB
X-Google-Smtp-Source: ABdhPJz1ndUd+wOex9EqS6cQUu24aQ1f5kSBFaVQ8y0uzF9QayqHXtgmJN6KMf8aLpGttyQsZp7j268eAWGXL9Jov04=
X-Received: by 2002:a17:907:1749:: with SMTP id lf9mr8242084ejc.174.1617271981875;
 Thu, 01 Apr 2021 03:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210401090932.121-1-xieyongji@bytedance.com> <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
In-Reply-To: <YGWYZYbBzglUCxB2@kroah.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 1 Apr 2021 18:12:51 +0800
Message-ID: <CACycT3ux9NVu_L=Vse7v-xbwE-K0-HT-e-Ei=yHOQmF66nGjeQ@mail.gmail.com>
Subject: Re: Re: [PATCH 2/2] binder: Use receive_fd() to receive file from
 another process
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        viro@zeniv.linux.org.uk, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Jason Wang <jasowang@redhat.com>, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 5:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 01, 2021 at 05:09:32PM +0800, Xie Yongji wrote:
> > Use receive_fd() to receive file from another process instead of
> > combination of get_unused_fd_flags() and fd_install(). This simplifies
> > the logic and also makes sure we don't miss any security stuff.
>
> But no logic is simplified here, and nothing is "missed", so I do not
> understand this change at all.
>

I noticed that we have security_binder_transfer_file() when we
transfer some fds. I'm not sure whether we need something like
security_file_receive() here?

Thanks,
Yongji
