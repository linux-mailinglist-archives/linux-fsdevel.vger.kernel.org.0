Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0EC12253
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEBTG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 15:06:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43629 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfEBTG6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 15:06:58 -0400
Received: by mail-io1-f68.google.com with SMTP id v9so3153351iol.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fIgWPMu4dT0B8gJmmjQwvEVnxx/ZOqmet5FPftsvV+Y=;
        b=gFT44Wu3lKdun1XF4XMh6OLEbPkvxGh2kCnxyHrl6zJj3zh/cZHuZGzUhwsH26Bepe
         4RyRBClT9LlrdsPGCwOkXQloQYT/Ibb96ES/7UiL8HlMmcRVtYA/7JcoiWWFxpXNWoCa
         wnSutDnVnaUmJNcyNqw5Npkx2VzkjFiOPIiLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fIgWPMu4dT0B8gJmmjQwvEVnxx/ZOqmet5FPftsvV+Y=;
        b=hjKjogA8gj+scALuBYCUuQBRRrL+bau6SW30KcxLE4/X4kFE3ajZ5ExdwOvILsqYzl
         YYpirEkVBSoLunYnsx07NqNyN3ynBi+1MH5QBa0oqxwon9H6WrxI0y6N+lX53rPfL/vU
         6TFbHo711PAIElUUhqCGBzA3VRXK82V6wEC+yaekDwsDNbQJ/EpUqeQdCgYpLh38D3OB
         7rFItYAFmD236YqYA0wTVtNKqZ2nLsdArHanMCepBuZsQEDNSXnX4cFZd9tqESf90kR0
         geul2IppyGYgmhvyCeJq7PUUq6PvToIu/sMjm8ju7k6zCjSV8xMZ7ILThPjXUp0PR88d
         Mo+g==
X-Gm-Message-State: APjAAAVSclvTiJtaAZqs+wggArOMhL1OfDIXtnvgwEKm29ZwE9xquhV2
        S59+7GCUYTQuEBi7SJym0oOgGM9NR3dt6T/C1d8l4Q==
X-Google-Smtp-Source: APXvYqz63yqq5an9lzcgS/a6qY5Js1eaP2b9EDav/t1D6OuHW0KzmdBLG0duTdyye0ALN30pK8raWUQ5jvovzMO3KaI=
X-Received: by 2002:a5d:88d1:: with SMTP id i17mr3801046iol.294.1556824017415;
 Thu, 02 May 2019 12:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <20190502040331.81196-2-ezemtsov@google.com>
In-Reply-To: <20190502040331.81196-2-ezemtsov@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 May 2019 15:06:46 -0400
Message-ID: <CAJfpegtqPYfE_s711+FUj5SCbQzGjUPpwtxyQ=7bdgNzu0NUaQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] incfs: Add first files of incrementalfs
To:     ezemtsov@google.com
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 12:03 AM <ezemtsov@google.com> wrote:

> +Design alternatives
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Why isn't incremental-fs implemented via FUSE?
> +----------------------------------------------
> +TLDR: FUSE-based filesystems add 20-80% of performance overhead for targ=
et
> +scenarios, and increase power use on mobile beyond acceptable limit
> +for widespread deployment. A custom kernel filesystem is the way to over=
come
> +these limitations.

he 80% performance overhead sounds bad.   As fuse maintainer I'd
really be interested in finding out the causes.

> +
> +From the theoretical side of things, FUSE filesystem adds some overhead =
to
> +each filesystem operation that=E2=80=99s not handled by OS page cache:
> +
> +    * When an IO request arrives to FUSE driver (D), it puts it into a q=
ueue
> +      that runs on a separate kernel thread

 The queue is run on a *user* thread, there's no intermediate kernel
thread involved.

> +    * Then another separate user-mode handler process (H) has to run,
> +      potentially after a context switch, to read the request from the q=
ueue.

Yes.   How is it different from the data loader doing read(2) on .cmd?

> +      Reading the request adds a kernel-user mode transition to the hand=
ling.
> +    * (H) sends the IO request to kernel to handle it on some underlying=
 storage
> +      filesystem. This adds a user-kernel and kernel-user mode transitio=
n
> +      pair to the handling.
> +    * (H) then responds to the FUSE request via a write(2) call.
> +      Writing the response is another user-kernel mode transition.
> +    * (D) needs to read the response from (H) when its kernel thread run=
s
> +      and forward it to the user

Again, you've just described exactly the same thing for data loader
and .cmd.  Why is the fuse case different?

Thanks,
Miklos
