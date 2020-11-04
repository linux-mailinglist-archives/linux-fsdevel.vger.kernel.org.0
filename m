Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57192A5D42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 05:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgKDEAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 23:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKDEAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 23:00:02 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAA2C061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 20:00:02 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m13so11749472oih.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 20:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPUivy6G/3y/UroF9ZxK5NSi1QTvT70rLMi2Ek7DgK8=;
        b=dIYeodvKjWgoSDouF7I/spHxpLTaLxx/sU/fweJy6VfuZCyZhtEWMIXzXiuwxagOgw
         z/0rN06t+OtTfT6YOyF8piHUdRGuOsHQazvBnQY/G6ZhqI0x0qmR8Naj95Fy1z6zwT1W
         dbg0nJwNGOsMpxYw83aJvf8QMuWM66MOjRMY9QHyKhBj4pYhMbU1W0kjgphO8OF7ffgQ
         ZtW4BGognt/s6aT8jcoRk0Gd9ka1D+HWjlbcqgc4h/3rBWWO6PH9PmYc2jfbbPY7mgok
         B39g5H7ntQmNBC9U3gFpJaD3llNLpRDp40czyKNOTE/hRidNSThsXmjmTzgXCwFpX8EH
         RTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPUivy6G/3y/UroF9ZxK5NSi1QTvT70rLMi2Ek7DgK8=;
        b=FLLGuShpV+eYBBEPPBcXX93juZRJGTy9/T0YJKo76HdCtbXe9qe9mrzZCDeIQSjlFI
         lb6EDsceQKu+KdHTG2YacY0zLV5FYdjxJfJG+J/ksqb04M3aDVA90Vke7euwZpyz63kB
         25mdOJsyM6rpxJoyxQ0KSx+ugt0gnCl+HyeoN34mdc9v+CyzqWLjqj1773AQcaVDlzZS
         yR+irKSDyzXMGxiMrifs6Co59gD1Ru7YlGN45eN5RkZXdYpt2i6FjU+BfhGJocmwzadp
         uc/xXbx+ecZ44ahjk+qOQxchQxCZUF2QaCXLJmtocDziLiyMWqA02T4jY0oCrYhTskUM
         LBPA==
X-Gm-Message-State: AOAM531y8uAewEZzVzvCqwvDDiKT6+Zl7I/tKr/cdBd2CosgDqk82r6q
        hkaz4KNJnl/ZjTTtIY8+VQE/bvo40KRlKFmqEFw=
X-Google-Smtp-Source: ABdhPJz5uTBKFNV+/j4Q1sw8dr+Hg681+E53y9ebcxLGIrRTKWl4/i2FpMvOW3Y9rYMAsyIZEi3+GMlDISIXoPxvwG4=
X-Received: by 2002:a05:6808:2c4:: with SMTP id a4mr1404383oid.114.1604462401809;
 Tue, 03 Nov 2020 20:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20201103143828.GU27442@casper.infradead.org> <20201104012017.19311-1-vvghjk1234@gmail.com>
In-Reply-To: <20201104012017.19311-1-vvghjk1234@gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 19:59:51 -0800
Message-ID: <CAE1WUT6aMytHrWpyM2r-YgOjRyfNXYm-E+Ye=360v6T3AV_Q0w@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix panic in __readahead_batch()
To:     Wonhuyk Yang <vvghjk1234@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 3, 2020 at 5:21 PM Wonhuyk Yang <vvghjk1234@gmail.com> wrote:
>
> From: Wonhyuk Yang <vvghjk1234@gmail.com>
>
> Thank you for your reply.
>
> > By the way, this isn't right.  You meant 'if (xa_is_value(page))'.
>
> I think you missed a ! operator. Actually I was not sure that there
> are other internal entries except retry entry and zero entry in
> the xas_for_each().
>
> > The reason we can see a retry entry here is that we did a readahead of a
> > single page at index 0.  Between that page being inserted and the lookup,
> > another page was removed from the file (maybe the file was truncated
> > down) and this caused the node to be removed, and the pointer to the
> > page got moved into the root of the tree.  The pointer in the node was
> > replaced with a retry entry, indicating that the page is still valid,
> > it just isn't here any more.  And so we retry the lookup.
>
> It's a little difficult for me, but thank you for your specific explanation.

Could you link the earlier thread for reference? You forgot to include
it in your
email subtext.

Best regards,
Amy Parker
(they/them)
