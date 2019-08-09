Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D467882E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 20:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfHISra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 14:47:30 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36560 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfHISra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:47:30 -0400
Received: by mail-ua1-f67.google.com with SMTP id v20so38091967uao.3;
        Fri, 09 Aug 2019 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvM3NNhwGMvvfx2MkO3/MD3iVuNxF0JxJmKT+PwR5W4=;
        b=PTqDgTfJDI6Ddsg4uDOHOgkzKF5/hMMju2mgUT5LWN/QtY3UlV+Emsr5Gsq0+5Aiyk
         a5B/DizHQFb3ToCirXCgirmD2ZL/kujDPSeRwLFuHFxseSmIjVeQTtFGq+7KKngtRQME
         4fTt39ovBiycauq1jhnjSYvQLxj8m7SLQfRwddnOwSWWczWOpiMbmp7t/bHwpNeSRc9A
         mFQQSyUtW74/eTrUGjKQzl5KBGXvUam+SfiDeg1vfoIDSqavsAW5HcQgatUjUA+RhH/b
         4nrKK01T3GAGEY/r4AWLwlxPfjzV8hrVBpqpDBOd3wR4ZhL/8seT2Tkzlbxakk5qdc5m
         YYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvM3NNhwGMvvfx2MkO3/MD3iVuNxF0JxJmKT+PwR5W4=;
        b=KxnBlETVhqf0w9jsNVsowl2yAqkCUP+5KKQmBEWZhFzThE0QZwpBZ8ql+H6qsaZC4C
         dHPicKsLu+Mjpk2eRsR/U1gSuMdk+DlHorypn25i9hGfzfVsdc/AzDZH7QIjbMa6r0Kf
         mLUUpm1FOATWPvndKK5jGGbQFzX3IRJ+TpXDvL/ytWRX05pN9fTEsduy6Z1Q7bk2EhUd
         qvGRBzszCtnk5gzVBJhZVjBz1/XbdUNy7J1zyFF4Hk2gluvI8ETqza+mGCYyEr0iWT9h
         v2K1wiNC3l0LXT+QTEkBcAShIFY0GZQpChMMzcU7N/tT5x/nRvUUm96X5JrOxacucItC
         nOhg==
X-Gm-Message-State: APjAAAU2lwlXGkJMFIhvy8vNXdJyy6ktoE6By7MqdlLeF0ONVepX+kXG
        IMsm7u1fm48Uh6o3CnwnCWBwhCkucv4tVk8DA2U=
X-Google-Smtp-Source: APXvYqwNUvZ4tnZE9Es0itFcZvDe8vvnYLoMxGxU87idwaNvgZecJqPAN9crbxDKWeXxjDKCOPx4blroSe5rCFlGgXw=
X-Received: by 2002:ab0:4108:: with SMTP id j8mr14248017uad.104.1565376448875;
 Fri, 09 Aug 2019 11:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190808172226.18306-1-chris@chris-wilson.co.uk>
In-Reply-To: <20190808172226.18306-1-chris@chris-wilson.co.uk>
From:   Matthew Auld <matthew.william.auld@gmail.com>
Date:   Fri, 9 Aug 2019 19:47:02 +0100
Message-ID: <CAM0jSHP0BZJyJO3JeMqPDK=eYhS-Az6i6fGFz1tUQgaErA7mfA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Stop reconfiguring our shmemfs mountpoint
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 8 Aug 2019 at 18:23, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> The filesystem reconfigure API is undergoing a transition, breaking our
> current code. As we only set the default options, we can simply remove
> the call to s_op->remount_fs(). In the future, when HW permits, we can
> try re-enabling huge page support, albeit as suggested with new per-file
> controls.
>
> Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
