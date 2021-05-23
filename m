Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BF338DC8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 May 2021 21:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhEWTRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 May 2021 15:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhEWTRT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 May 2021 15:17:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E51FC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 May 2021 12:15:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lz27so38308247ejb.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 May 2021 12:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VHYzmc+otfrR+KT6Q92j+o3OnwObzHpD+WPcnWEL15A=;
        b=mo9wwejpsrQZs6KDKfQBouK6goYhImXV/Sd+6L/Iy4Mbek8Fgd/iGwh96ILqGjfHgi
         WpZbOSOZioQHoON+bHzfw5LlNmYItkO4pfGcMG10TSSaFCR922aiIWgKyg5zvRMh72Xp
         VBE8vQjuSyUfwKqSrDMmtHknwBxJTATxwmFuZ3LjT8+yYcJ+5xpuWwR4+EJ4UVHQ7zPg
         CG91NzKfYqnKpoGl9SbO3/skIqdX/jSd288u1um41145VM+Jc3PoJz1TvjdQlOozBnej
         rZoTymfuZH17ZCLy76ZJN78SsYRpvyKkI0P35+XPmrijP2E3b/DPmCb9NbDVA3ReM1wE
         49cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VHYzmc+otfrR+KT6Q92j+o3OnwObzHpD+WPcnWEL15A=;
        b=TbJCIUgds9Kzn//EDklVTqj0QRNvpIZMZLqwd+6/e3MAPNZ/5aertzq4BJrnIO1XlE
         WrP3M4aI5ACTQ+2X50xJxQO/K+iX9gRGcTGg4vawKbbp9WwNYTm4mHjcMvHIzZm72txL
         Te2Bsn9Rx8wtcHJglzq+Wg5gTXrt1U2ec6k0MEqPUWHt6YHVeweVNiZcRg+L1UBFQ+Nj
         7AHeD5w/kA7ZwSy4XALAadNRXWSypG0NHxzzkL/XmK8xJiQS1/4iS1T0u2YW+IOsPJ/b
         pJRPbhCseTi/oTFzojcaLKGxkVk2+PioPrJKjng9ErkEyUklw3yNlb16JE96qWNlRisN
         5KrQ==
X-Gm-Message-State: AOAM531ALBHTsG4WrD+Y9K69C186EBRHpKlBEzOBpuEtDIo406VWMFnz
        4de/yJBjiDwt3Vz8ws3oCqo=
X-Google-Smtp-Source: ABdhPJwQUyfdhZ8+T05HWSR3iiaR/kMEWw35QvIZTG5HwegO1akAXt0mLF0aTBHLXKrFY1EPkccRBA==
X-Received: by 2002:a17:906:b2c1:: with SMTP id cf1mr19203871ejb.544.1621797350761;
        Sun, 23 May 2021 12:15:50 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id hb14sm4301938ejb.118.2021.05.23.12.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 12:15:50 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sun, 23 May 2021 21:15:49 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Enrico Zini <enrico@debian.org>
Subject: Re: Calling sendfile(2) on sparse files on tmpfs allocates space for
 them
Message-ID: <YKqp5XaV1OlUKXxf@eldamar.lan>
References: <20180520150940.4qtsc43vcnp5t34z@enricozini.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180520150940.4qtsc43vcnp5t34z@enricozini.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

On Sun, May 20, 2018 at 05:09:40PM +0200, Enrico Zini wrote:
> Hello,
> 
> thank you for your work on Linux. I'm trying to report what looks to me like a
> kernel issue: the code below, if run on a normal file system prints:
> 
> After creation: 0/1048576
> After read: 0/1048576
> 
> but if run on a tmpfs it prints:
> 
> After creation: 0/1048576
> After read: 1048576/1048576
> 
> This unexpected allocation happens only when using sendfile(2), not
> while reading the file with read(2).
> 
> I observed this behaviour on a range of kernels, from Centos7's 3.10.0
> to 4.16 currently running in my machine.
> 
> This is the code to reproduce it:
> 
> #include <sys/fcntl.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <sys/sendfile.h>
> #include <unistd.h>
> #include <stdio.h>
> 
> int main()
> {
>     int fd = open("test", O_WRONLY | O_CREAT, 0644);
>     if (fd == -1)
>     {
>         perror("cannot open for writing");
>         return 1;
>     }
> 
>     if (ftruncate(fd, 1024*1024) == -1)
>     {
>         perror("cannot ftruncate");
>         return 1;
>     }
> 
>     close(fd);
> 
>     struct stat st;
>     if (stat("test", &st) == -1)
>     {
>         perror("cannot stat after creation");
>         return 1;
>     }
>     fprintf(stdout, "After creation: %d/%d\n", st.st_blocks * 512, st.st_size);
> 
>     fd = open("test", O_RDONLY);
>     if (fd == -1)
>     {
>         perror("cannot open for reading");
>         return 1;
>     }
> 
>     int out = open("/dev/null", O_WRONLY);
>     if (out == -1)
>     {
>         perror("cannot open /dev/null");
>         return 1;
>     }
> 
>     off_t offset = 0;
>     ssize_t res = sendfile(out, fd, &offset, st.st_size);
>     if (res == -1)
>     {
>         perror("cannot sendfile");
>         return 1;
>     }
>     if (res != st.st_size)
>         fprintf(stderr, "warning: partial sendfile\n");
> 
>     if (stat("test", &st) == -1)
>     {
>         perror("cannot stat after read");
>         return 1;
>     }
>     fprintf(stdout, "After read: %d/%d\n", st.st_blocks * 512, st.st_size);
> 
>     close(out);
>     close(fd);
>     unlink("test");
>     return 0;
> }

This still seems reproducible in same way as well with 5.10.38. Is
this intentional behaviour in some way?

Note, this was originally reported downstream in Debian as
https://bugs.debian.org/899027 .

Regards,
Salvatore
