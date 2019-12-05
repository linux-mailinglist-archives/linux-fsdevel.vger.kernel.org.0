Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D51AD114620
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfLERmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:42:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43380 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLERmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:42:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so4534597ljm.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 09:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbUJTjP9F3GwOz1HFUh2s3Qmcb6CiYFw+YJqleMOHnU=;
        b=At+uWZuKrLZ9S7SyRUatFCEd1Mv2OAsl5w3v+FMN3slvSqWktBXK4CWewfKJV7jSv0
         jpx4YsZEPIQAb72cz8O870cYWisRieSJNwsV8ZKkMw0312Czo8jJrbF9lgpKcnqShANR
         4t99ocyvjH84jbC8Y0/H3HnaS1ee2Sr9m+fHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbUJTjP9F3GwOz1HFUh2s3Qmcb6CiYFw+YJqleMOHnU=;
        b=BJ3coXh1NckK2xr796NDB3XTn7/lvQumuclr/qwcXlBVgM09UvrXQw97lnQ6O2cLmj
         Cww5q1SFmFoRTm1XTO78Cj61POezwGtUObEf6IyWpChi9sZb2NPcpabLD9QCN6UoZYvy
         SiXP4nXB11f14V2J+NuV58ESfrZRYjXMPWAtCbcgxP50p+o0pCMLZ6SSa85im8IcD1w/
         mZALbiQ89hvJTecbgc5xNlPEhib4qhHdu1PsCXimnCEOixSdIQWr1FU0HcXIUlAiqjb9
         r9BhHYl2mcYOXwFpjgsUSmdrEMUoBm+07NaayPSkn+4wXY49F/WnDQ8XXriUHdWHPzdX
         l2Iw==
X-Gm-Message-State: APjAAAVVUuTreCNPrw7ek7QxL4iHFhlDt5ItbZqBESm/ANxQ7qGfOiW6
        hTNrc6wIpXrbz+7UJpzqpHWhJZJgLGU=
X-Google-Smtp-Source: APXvYqz0A78PirT8YQfSz8Gu6+v5YtYebksgB2Vub27h7URNFLlFIv4fKHqcMhV3aJ9ahwhJbKbgkA==
X-Received: by 2002:a05:651c:32a:: with SMTP id b10mr6363103ljp.132.1575567743416;
        Thu, 05 Dec 2019 09:42:23 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id j18sm5317621lfh.6.2019.12.05.09.42.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:42:22 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id b15so3146008lfc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 09:42:22 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr5923371lfi.170.1575567742310;
 Thu, 05 Dec 2019 09:42:22 -0800 (PST)
MIME-Version: 1.0
References: <157556649610.20869.8537079649495343567.stgit@warthog.procyon.org.uk>
 <157556650320.20869.10314267987837887098.stgit@warthog.procyon.org.uk>
In-Reply-To: <157556650320.20869.10314267987837887098.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:42:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgBLUeMUwfWGfqeihz4K=QhXxEgskOo6aUfTmLa=XMvzQ@mail.gmail.com>
Message-ID: <CAHk-=wgBLUeMUwfWGfqeihz4K=QhXxEgskOo6aUfTmLa=XMvzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pipe: Remove assertion from pipe_poll()
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 5, 2019 at 9:21 AM David Howells <dhowells@redhat.com> wrote:
>
> An assertion check was added to pipe_poll() to make sure that the ring
> occupancy isn't seen to overflow the ring size.  However, since no locks
> are held when the three values are read, it is possible for F_SETPIPE_SZ to
> intervene and muck up the calculation, thereby causing the oops.
>
> Fix this by simply removing the assertion and accepting that the
> calculation might be approximate.

This is not what the patch actually does.

The patch you sent only adds the wakeup when the pipe size changes.

Please re-generate both patches and re-send.

              Linus
