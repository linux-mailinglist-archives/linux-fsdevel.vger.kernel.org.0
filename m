Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533D917F4C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 11:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCJKO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 06:14:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44762 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgCJKO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:14:28 -0400
Received: by mail-io1-f68.google.com with SMTP id t26so4421045ios.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=676hlAi9nQvJqPNZ6R7D8KQCs7ZMaZyVMWv6FGrNSog=;
        b=BlCyZg3qAzKRX5Es9ctA1azKKf+fCW18+Z3+RK9WV/bkETeslBQeWcDJHakZv3N75m
         A6xAk+tgOsrscdsv7V5kr5AAIdlxfsdJAjtkbuQYXis/pP7Ia8QDfP0Vckn4/arnS5uG
         m2flT5Fwl10Vbx1mKDKvXEHME5GPc47vE9KVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=676hlAi9nQvJqPNZ6R7D8KQCs7ZMaZyVMWv6FGrNSog=;
        b=SnuUdBh9uakAvGws0LJn0tH/G0b8W5X1epL/E64hzpqn1BtSZA0XCn7sGIOhdEhMQ+
         j+FFa40OYzWR8JhjhL6EaaXQFaBRzWkODDvV35FqzA0w04cB4nf5Ie27JPop9Lx4A3r7
         vgaCSlDobBRhjTb9WzmBF8/w3p623j9kMDYKQu/co6F50lyuhUwMEX1MmgzIg3aH8v7Z
         BWa3CG03zepu7nu1H9gDLyPGWTOnjauLd/AoBeYTpyV9uZ76lVnn3iA4xk+ymJ+4hh8K
         h8mvpbiQ5u+QI8HV6FfgIau7ZxNxpsba8A1G04DpElNZkLHUbK091JmSDNHOSKNi83PM
         H0sQ==
X-Gm-Message-State: ANhLgQ0+bUnt7vpbwHf4cMFrjF8i8rP5W4Ej/ep2jR/sQM3swpKMDmZZ
        dfxW1G/v2g6SLNR4YWFb323csGbvK+FEhMv91NjYaG7bMsw=
X-Google-Smtp-Source: ADFU+vvCaU8zbzwq2gsU68w2ibW959XXTKgLBuWjPsXDT38s3bV7RH0ODrcT+kiS2iiKEzshEiNQhWgybdyrE3YQlJk=
X-Received: by 2002:a02:70cc:: with SMTP id f195mr18482283jac.78.1583835268061;
 Tue, 10 Mar 2020 03:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <1583270111-76859-1-git-send-email-bo.liu@linux.alibaba.com>
In-Reply-To: <1583270111-76859-1-git-send-email-bo.liu@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 11:14:17 +0100
Message-ID: <CAJfpegtFWqEAV-Jb_KoHihJ5-UpU=JkdxEg_stz6JM5OP_LXMQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: make written data persistent after writing
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>, virtio-fs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 3, 2020 at 10:15 PM Liu Bo <bo.liu@linux.alibaba.com> wrote:
>
> If this is a DSYNC write, make sure we push it to stable storage now
> that we've written data.

If this is direct I/O then why do we need an fysnc() call?

The only thing needed should be correct setting O_DSYNC in the flags
field of the WRITE request, and it appears to me that that is already
being done.

Thanks,
Miklos
