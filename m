Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5618220B89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGOLMZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 07:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgGOLMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:12:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AB4C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 04:12:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dr13so1758751ejc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GNZTlebsq0eWIwEljX2xeBdZEHRs2k6AtH87hm9Zwgg=;
        b=JZLRSBhWm0oHxV3fok6cxthIXvhjAenz53D8fezRJjLbsEGzev4V175VrT5tTOPQ0L
         XAnaq/Ov0CMEsnpV/F+V8rK7u1bIHghoUkChEQwbMY9tpBz4kn9ZGAYdf+rjrsnXqUDy
         +MzGC5vqoZD/qK6UbJ4A75mLpvNLy6Zar3ArQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GNZTlebsq0eWIwEljX2xeBdZEHRs2k6AtH87hm9Zwgg=;
        b=LyPu3gmdhvh85L5ssMJaPbfcjkzTjgbrcWHpVnGBv5QseJV/3reAeE6HQBFF2JgPhj
         LOCHsHTJiaL/pim1w5xBZxYfB5IxUeGljcwf3VJPClVCGSRdXV+6blMlUVR6QYLZS9yU
         JV+GsHjYuxEkUHnV3Fat/QJzkdKXokYziEuNmeirPjbJ5pQPnoAZ1ZGixW9eMtayHdoz
         9fEn+UaQSrKwdbwOZCJKcZ9ITLFijot7PU+MjgjyRF8OMoM9isgJwNOLACLR1ozlko9e
         4IjleEXjwwljg72E9zSJIU/JPs5nfIzWUeAvT3i9qyKwDjcWQXXtOyFc9olDF+E55/1k
         6Lzw==
X-Gm-Message-State: AOAM5321Tl9TvIjoJGuCJKYqaqm6MyhaNMGEG/NVSVivaLRqPs0QTrNy
        ksX3ThBLW/yOClNKeOaOKXvG7vddj30P6skPVugPWw==
X-Google-Smtp-Source: ABdhPJw0oIZdNNSQSx2dAWVRtVjY5tScV5cqBbhIhCHnr1dD6YokQZCqwZVPmd0NLTWPqfK15c8L+dhgVb8e5/u5u6o=
X-Received: by 2002:a17:906:b74e:: with SMTP id fx14mr8403146ejb.202.1594811541019;
 Wed, 15 Jul 2020 04:12:21 -0700 (PDT)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Jul 2020 13:12:09 +0200
Message-ID: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
Subject: strace of io_uring events?
To:     strace-devel@lists.strace.io, io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This thread is to discuss the possibility of stracing requests
submitted through io_uring.   I'm not directly involved in io_uring
development, so I'm posting this out of  interest in using strace on
processes utilizing io_uring.

io_uring gives the developer a way to bypass the syscall interface,
which results in loss of information when tracing.  This is a strace
fragment on  "io_uring-cp" from liburing:

io_uring_enter(5, 40, 0, 0, NULL, 8)    = 40
io_uring_enter(5, 1, 0, 0, NULL, 8)     = 1
io_uring_enter(5, 1, 0, 0, NULL, 8)     = 1
...

What really happens are read + write requests.  Without that
information the strace output is mostly useless.

This loss of information is not new, e.g. calls through the vdso or
futext fast paths are also invisible to strace.  But losing filesystem
I/O calls are a major blow, imo.

What do people think?

From what I can tell, listing the submitted requests on
io_uring_enter() would not be hard.  Request completion is
asynchronous, however, and may not require  io_uring_enter() syscall.
Am I correct?

Is there some existing tracing infrastructure that strace could use to
get async completion events?  Should we be introducing one?

Thanks,
Miklos
