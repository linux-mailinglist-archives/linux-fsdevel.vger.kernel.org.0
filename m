Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E628E2DB9B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 04:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgLPDdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 22:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPDdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:33:35 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8DC061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:32:55 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i18so22654367ioa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzUvpf/Z4+FDnMTNimcxjYoQv25zdWhrv/P0OheMKxk=;
        b=CjzbLgtmPDr4yrhKahPogRQ2Q5No07mGF4SeIOt8wvvBduTyqAPlF/rkCx+9KkRHby
         VANTYgnjWpcc6L0mcI+AlaekGllzEblFqTrJpURu7Vm5ubJngkHN5S/bsasX5Rz9ILvQ
         IfHDxdwoZB54Cwa9C/YSGsz2faDj2fAWHUkUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzUvpf/Z4+FDnMTNimcxjYoQv25zdWhrv/P0OheMKxk=;
        b=cPgWtB5wnYsvXNMZXgDBhBCwaYsOlNK+qeIBag54CU7aEARs+M1+h5VE6fKB++IlCG
         ilV+RrOMfPqNc5MbQTpzU7ZDbgQp2yLJdTAroQllkRtJL2IZM0zd/voSwaLEDMeTuXRy
         UjNBANhPAxaRqZE7bIKJ4149qAoW9IzXUUUVk6Ah9O8sDHFts0eSAtNA9rrWz5LlbGvm
         7I2PZ6/kgxDVlPMH3lHduTDd73iSUYNvewlTdCdk5V/i/oK3oOP1Z9kMFtpLz0Q3Px1y
         9WDaA9BUSoH7yYSd24qzeoddDJ1dMhyC9DqgbcBPI1liCCOfXB4V4zNWdG7ZQyEQJ+XK
         thNw==
X-Gm-Message-State: AOAM532HbkoTB4QCulwJBPzOIxjQFKTQvPQYuYEE1dzaE3+FyT/YkkZZ
        9To4V/Z6sOoRG8x84tfiZmue58MqcVTshA==
X-Google-Smtp-Source: ABdhPJyM4gH6QYp2h8yEhMFARAmWW1ioFMlEI4fdshy2HHZ7QZhDXXi7ygX4/UQO9nrwDNbpoWzqlw==
X-Received: by 2002:a02:7692:: with SMTP id z140mr41283616jab.21.1608089574545;
        Tue, 15 Dec 2020 19:32:54 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id u24sm309314ili.47.2020.12.15.19.32.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 19:32:53 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id p187so22644596iod.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:32:53 -0800 (PST)
X-Received: by 2002:a02:9107:: with SMTP id a7mr15972769jag.12.1608089573545;
 Tue, 15 Dec 2020 19:32:53 -0800 (PST)
MIME-Version: 1.0
References: <871rfqad5g.fsf@x220.int.ebiederm.org>
In-Reply-To: <871rfqad5g.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 19:32:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijn40PoFccpQZExuyWnz2i+wmBx+9gw5nKJPVQVmzb5g@mail.gmail.com>
Message-ID: <CAHk-=wijn40PoFccpQZExuyWnz2i+wmBx+9gw5nKJPVQVmzb5g@mail.gmail.com>
Subject: Re: [GIT PULL] exec fixes for v5.11-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 3:00 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> There is a minor conflict with parallel changes to the bpf task_iter
> code.  The changes don't fundamentally conflict but both are removing
> code from same areas of the same function.

Ok, that was somewhat confusing.

I think I got it right, but I'd appreciate you giving my resolution a
second look. Just to be safe.

              Linus
