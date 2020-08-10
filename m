Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB1240286
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgHJHaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 03:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgHJHaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:30:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB5CC061786
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 00:29:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so8346382ejb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43SZmp+vV8Sn7GE9PjnhjxxvuNGsA7FckBZzSlZ2a3A=;
        b=TfaRUWxgqzFbKktIb4Hqt920WExOCG8A/B8G6G3gHeQdfzhyhPlBj3W4n4wmXPXo1h
         H3SXSQKn6gjCRj/BO/qLLXhzfMro01CW6pGmfkXR1hG/J0BdHRaNCAoaEamtlVc5Ix0p
         j6FQdh1QoUTYwtEnyVXcm96qmYLTqaCg0ZJ2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43SZmp+vV8Sn7GE9PjnhjxxvuNGsA7FckBZzSlZ2a3A=;
        b=bLwlmeR0i+BV/dfAGjFACJUKhYdVFnGgSpVeH5SjZE2NqJMyGdd8B1Sii5WT+VcGYl
         jDGswd20YtpCgOKgdNhCxgK7aanFRH+Pmb+qaSbJswzAGF0XGv2iGQBsYSRvRp9P/Hi1
         34tFBkrAQbQymmS46en5llIw7KTg42DZQKByp71+z5g0Smk/ymfQQjoSKcj6VUkIQSwt
         F8LgthwjYRxot+dHmKe946YGWw+wOK8Btx0vuABmQnDdVA157pws3qSrhX4qHjCFDVmP
         HIgAwRikjF2hYIZ1tC1vsoU6XMsPhFyvGNSXuRzqYg/eIp1MNRVv5OcHjgFYpefQzaFR
         WBWA==
X-Gm-Message-State: AOAM530fP2RgH6ttmCMNzybsK3WoDdQZMyHuvcPYp/oApzpOWXv+MvcH
        wdBb85RpdVArJNbICGc+herYhaLvoui2Iv5UbLbcIfCkdWQ=
X-Google-Smtp-Source: ABdhPJyciQYT53K7IaRz/5fZqD7hYIYr+Hh6aU/eSXECWt4BwXLBhbw9V/kG4kM7Be3fj25NOBPcRN9OluwZ2eziDe8=
X-Received: by 2002:a17:906:4e4f:: with SMTP id g15mr5805547ejw.443.1597044598271;
 Mon, 10 Aug 2020 00:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200807195526.426056-1-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 10 Aug 2020 09:29:47 +0200
Message-ID: <CAJfpegtboe-XssmqrcvsJm1R0FBP8fYFrTMv5cuBhfmebiGfQw@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] virtiofs: Add DAX support
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 7, 2020 at 9:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>

> Most of the changes are limited to fuse/virtiofs. There are couple
> of changes needed in generic dax infrastructure and couple of changes
> in virtio to be able to access shared memory region.

So what's the plan for merging the different subsystems?  I can take
all that into the fuse tree, but would need ACKs from the respective
maintainers.

Thanks,
Miklos
