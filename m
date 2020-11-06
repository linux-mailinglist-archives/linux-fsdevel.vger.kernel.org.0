Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81422A97CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 15:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKFOjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 09:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgKFOjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:39:41 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD60C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 06:39:40 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id x11so766858vsx.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2020 06:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sxqVLa3iciqPLgCG+JwX1CHkcPF2gNhZXkGpXNNWzqI=;
        b=iAgDYvkBrhl4CMU3P9ur27IlYwOJCc4vApoUuHrs99MpyhdVw0SZ5rmcOzqUBTJl4j
         JnqRJxTOnYOX05Sb/afsRtaDDhpZt0WPeFuzsStMIIfnfLt1S7PT0trtzbWfFBagCxbE
         3/cX38U0+NVDf3cx1ZzBfE6xivZfHrCfanNhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sxqVLa3iciqPLgCG+JwX1CHkcPF2gNhZXkGpXNNWzqI=;
        b=m6pSt8ke3eXeTso/dGRiVaKx8iBqg+MIYqgZNN8W9L8+oUUiDIR9PiVY2ND2QdUsBQ
         ZiM7YleJHyHX59a3wLSk3ND0BBJ+tt9j++IDfRSLuhO3R9Nvx95VRvLWHt6UYk7z4zt6
         +iz6xF6HK/RYZ3mi0bSN4AhQXvm8rCZ8drvvvOGZUzNs5oi1YCJh5rvUrpDr72xYIzve
         KOo0UcgETnpPK6p6yQENcFuNiQHrh4vnyLcqF0W2pudV3fK0kvI7Xh9od2UYcGwJ5uJ1
         lgh8AWcOXJtvOJCiM7OkX3eeREzb1XrVHxUQXr4mOi07GsTCk09R0DDwHg82FY9qZ67s
         zDPg==
X-Gm-Message-State: AOAM533PP2OQSoT6vyoE4ZeXJyKLHM88y21+a1u4VFG4dwNaAHlSv5RR
        HSEeNZcFiwW0gFjFf6BqZsLmnOjdEDitFAvkQLFFKQ==
X-Google-Smtp-Source: ABdhPJzh0mt28HcuUCNoEV3ySuerCtdkIL5145+rkRqzAMKEHlz9gD19tgbuie4qL1SahnTkAg6Y7tfuPeIr8+nq5kM=
X-Received: by 2002:a05:6102:126c:: with SMTP id q12mr1259129vsg.9.1604673580180;
 Fri, 06 Nov 2020 06:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20201009181512.65496-1-vgoyal@redhat.com> <20201009181512.65496-4-vgoyal@redhat.com>
In-Reply-To: <20201009181512.65496-4-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Nov 2020 15:39:29 +0100
Message-ID: <CAJfpegu=ooDmc3hT9cOe2WEUHQN=twX01xbV+YfPQPJUHFMs-g@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] fuse: setattr should set FATTR_KILL_PRIV upon size change
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 9, 2020 at 8:16 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> If fc->handle_killpriv_v2 is enabled, we expect file server to clear
> suid/sgid/security.capbility upon chown/truncate/write as appropriate.
>
> Upon truncate (ATTR_SIZE), suid/sgid is cleared only if caller does
> not have CAP_FSETID. File server does not know whether caller has
> CAP_FSETID or not. Hence set FATTR_KILL_PRIV upon truncate to let
> file server know that caller does not have CAP_FSETID and it should
> kill suid/sgid as appropriate.
>
> We don't have to send this information for chown (ATTR_UID/ATTR_GID)
> as that always clears suid/sgid irrespective of capabilities of
> calling process.

I'm  undecided on this.   Would it hurt to set it on chown?  That
might make the logic in some servers simpler, no?

What would be the drawback of setting FATTR_KILL_PRIV for chown as well?

Thanks,
Miklos
