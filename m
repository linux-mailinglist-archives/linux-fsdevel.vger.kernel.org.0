Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98AE6AB3C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 10:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389171AbfIFIP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 04:15:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34970 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733020AbfIFIPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:15:25 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so10137820ion.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=71+P9Y1aQOgw6Dp9fK4XNoBcCfSmpfYHfETpowIUBEc=;
        b=mOY+F7IoXze5/oEY9qnxW4BtDV3c6OGnOM65rcAz4tBQ+pP1oCmZx3kBCsHFdm9ssi
         tdD9aqu1qDCinK7SZKtFdQ7WsDaXA5OVnxl3jnwgL/Rl00M0BEsmJ/uoAk72kSFu5qei
         FYQzoLZKR/w9+CtVp9n067d669r/fYv2PpYlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=71+P9Y1aQOgw6Dp9fK4XNoBcCfSmpfYHfETpowIUBEc=;
        b=tAnRpTy+JdXAqj5n3e7XAPV2NZ6/odSrE5NB9dZUbUe54oL8KOPOr3qyx50ieWdB1C
         fkOmJ5EIMWqsRTx34GUydyhsnKO5Y6HEEsCm+vd3cTaOYqP1jDLG1QWPTh+GiPuUpadl
         4PaB3XQM4wnDOV484tSywBBvQytNscv1xf6ie2VXTlQUtBYBjB2iQ6dNNSinm+Dz3+3n
         gbOjy6e2HCI2kpq5gi6Jupei1vyMaLECe/sSIB5MZSfB7rHBc0Fd6RhJ4zGDK7VlP+8y
         QwWjWTEZYCU8+peHOysFf+Gfh+Tq3BxjJD6IvfaHTcfZt5DSu8Z+DtTTI669idziUk1n
         ejbA==
X-Gm-Message-State: APjAAAUFJO4iHNdzZfcQmnyg1qiNEHVaoz+XoGlNRN0txgxx6YzF++20
        HEmPeNEstcWL5OZYwZezufsloDj2Po+9yersWGqfRlqd
X-Google-Smtp-Source: APXvYqzMtxa4XtA7wApmndxSDp7Bu8ZqzrPn0Tms4HAAjPUjMhyeA/vR5U1wZspaH+eF6zgoriVn3BWfEXcffE6I7Is=
X-Received: by 2002:a6b:bec6:: with SMTP id o189mr8631585iof.62.1567757724963;
 Fri, 06 Sep 2019 01:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190905194859.16219-1-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Sep 2019 10:15:14 +0200
Message-ID: <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi,
>
> Michael Tsirkin pointed out issues w.r.t various locking related TODO
> items and races w.r.t device removal.
>
> In this first round of cleanups, I have taken care of most pressing
> issues.
>
> These patches apply on top of following.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
>
> I have tested these patches with mount/umount and device removal using
> qemu monitor. For example.

Is device removal mandatory?  Can't this be made a non-removable
device?  Is there a good reason why removing the virtio-fs device
makes sense?

Thanks,
Miklos
