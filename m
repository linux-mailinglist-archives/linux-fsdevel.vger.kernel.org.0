Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F8036BF74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 08:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhD0Gu1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 02:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhD0Gu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:50:27 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBCEC061574;
        Mon, 26 Apr 2021 23:49:42 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b9so6574221iod.13;
        Mon, 26 Apr 2021 23:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1jTpRmc2KSVl4/75I1+x30oNZwT8EP+wM9qHtCp5hk=;
        b=W+vGBVl+Og/OT6pEGEjcAyA3R8CejUsG8iFJ0y4n6KmNri9yXyex3HCrWr/oTEWv2f
         JOJ6IVK0u5fqQOh9h9AF9yyQpeZTgc2Ark6OhySnQJf7BBw/blhC1rI8Ad8+lLvipqmv
         C5CjHodzgTx1DI8JDpZmefkgUJ547FwUEtnWJbM+5I0tuJ/gM4WZgXTTt7hAysej1Atg
         gC9a1i99OOgklppfLAME3ASyw4ltdGZpAbScsw0Xw6LqsN4PUA51j649napY/XeDs9UL
         41gNVZyduZuC+xaMIpuBejVRshAsHxlG93ig1keMdcvJd0jkbisPeWc6SA3/hEWqWSDt
         02iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1jTpRmc2KSVl4/75I1+x30oNZwT8EP+wM9qHtCp5hk=;
        b=nl6rlQuYRYrHDIDgsHVzP45Z5XwkkXXF2k0xXejXxhEI3/W/b920FbRL582BfQBTDX
         DSzIWqKO/v1aPQ5vb7FxAl7V4XMCH9Rchz1I+zixegGeixmWaiScdAGU6CRZund1qzcc
         LFfFx++MzyoeqYioK5c8n2v4CC/WOW4pItOxhwJRkkz4MvG/FfZ5BsKPi9S0B1Pe76CY
         /4ocsjYsFRbH2EXBZzrMKjj3yF1tLbyX3/uVr9IXLlukGVe6EClQvfMCt0yl0jm6SxNI
         mPAddbOyY0dAAGiXTHcK+f3ZrQNZkBAqsPB5ZRayFlTLBwjICLuSM+vT8bsKm355+tjF
         FSmQ==
X-Gm-Message-State: AOAM532nKu8smFY6WkIu1Vi2bbg+4MSk8knQDZiZMkaci/2Pj3HHg3zo
        4dbuT+68hXa9BUeyGFvdLqeHzWxnNa2zsoSSYh5jIuWK2rk=
X-Google-Smtp-Source: ABdhPJyjv199Hg5JdFZeFiQw4Fkhr1huiuZRXibQMmBCyN4ePbMH/LmuNV6saxnDqlevcCA7vzYcaPWdPNCROFl8kDc=
X-Received: by 2002:a6b:d213:: with SMTP id q19mr17731537iob.203.1619506182378;
 Mon, 26 Apr 2021 23:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-9-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-9-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 09:49:31 +0300
Message-ID: <CAOQ4uxgmH2BXuJ=NJvS=_pDLjiQrrE0TiL8LRntDGCiiFFKJRg@mail.gmail.com>
Subject: Re: [PATCH RFC 08/15] fsnotify: Introduce helpers to send error_events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 9:42 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  include/linux/fsnotify.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index f8acddcf54fb..b3ac1a9d0d4d 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -317,4 +317,19 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
>                 fsnotify_dentry(dentry, mask);
>  }
>
> +static inline void fsnotify_error_event(int error, struct inode *dir,
> +                                       const char *function, int line,
> +                                       void *fs_data, int fs_data_size)
> +{
> +       struct fs_error_report report = {
> +               .error = error,
> +               .line = line,
> +               .function = function,
> +               .fs_data_size = fs_data_size,
> +               .fs_data = fs_data,
> +       };
> +
> +       fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR, dir, NULL, NULL, 0);

The way you use this helper from ext4_fsnotify_error() it would make more sense
to name the inode argument 'inode' and call:

       fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR, NULL, NULL, inode, 0);

Also, if we stick with returning ENOMEM instead of overflow event (I
don't think we should),
then this helper should return the error as well.

Thanks,
Amir.
