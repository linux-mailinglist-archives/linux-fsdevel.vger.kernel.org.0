Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE4C43763F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 13:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhJVMA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhJVMA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:00:26 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A15EC061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 04:58:09 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id u5so7026672uao.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 04:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Wc3p9KWj+YmLamWydB5axnjfzhQ2OkM88LlcCsKrT8=;
        b=mlfCfbdtkjAmYoen1OyzbgJ2ZKNXgcgqc/uLbDDLkTbqvOQvydKTVl46ZBq6lB1egv
         owUG4+JcsYxw4E9dZycZmJF7PdLA/er0R4Q7yx2ryvZGImBrCdZb3/fgeyadvQ045X08
         714CHWU4orXjbpToqHUQ5XhrB6SFSwt5334NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Wc3p9KWj+YmLamWydB5axnjfzhQ2OkM88LlcCsKrT8=;
        b=I+p/zwCcEuoQ/XV1x+JxYN4iTQ12KNep43lhVDOmU0UsuygayteBWyN6tDIikytCZ3
         A01fSo5/C31DuPNivrcRWQg8KDr9sB0r+2XTidcDmp+REoOKxtZZuttaCoL1O0Rf5TXM
         Ah7HY0w04y8iwRmPUYpo6FETY//TFDwE9+sUKMISjNcV2pQ1XQvVIzIua+HY8Lr3HwOc
         b0shKOEe7HrXWmoQKkx2NVn1U6Pr5TzYpfkwEOPyiWLh4/3fhzsR0pzaRrJgbfUPBM9f
         2UIjE9iFBAa9VKhHVJgFn+yEDRAgPqi1K0MlmKuqkk7WRA6QRe5HDxtOgHVb2ebxMkKu
         SMVA==
X-Gm-Message-State: AOAM532jzVMIwNnLTFAh86GAdJPHsLYSXVhFaf+fVgQkULH0MjpGlBO1
        7OSDkrQe8o7LfI7w6XUc5tE5OikfmWKJG0yss0Wup+VjYBM=
X-Google-Smtp-Source: ABdhPJxW4QrGBSegreGJW/7nsNCI7G4CkJ30Uno8CHAUK86bHE9qmrYKu9MJj6UzUt6wA2l20vFnTdv9iIvsUvbrHX0=
X-Received: by 2002:a67:d504:: with SMTP id l4mr14640621vsj.42.1634903888325;
 Fri, 22 Oct 2021 04:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <77b7da23-1c01-46e2-aa90-c08639acb398@www.fastmail.com>
In-Reply-To: <77b7da23-1c01-46e2-aa90-c08639acb398@www.fastmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 22 Oct 2021 13:57:57 +0200
Message-ID: <CAJfpegtE8kmAED-pqOT-LJF3u2Sjbjgzi=6wmNoBiyTkz8gvpA@mail.gmail.com>
Subject: Re: [FUSE]: io_submit() always blocks?
To:     Nikolaus Rath <nikolaus@rath.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Oct 2021 at 12:47, Nikolaus Rath <nikolaus@rath.org> wrote:
>
> Hello,
>
> I noticed that with a FUSE filesystem, calls to io_submit(2) for read requests always block if the request would have to be passed on to the FUSE userspace process.
>
> Is that expected?

Yes, unless the file was opened with O_DIRECT, in which case it would be a bug.

The newer io_uring API does implement async buffered I/O and this
should work with FUSE too.

Thanks,
Miklos
