Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16D331C494
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 01:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhBPA0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 19:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBPA0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 19:26:04 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECA8C061574;
        Mon, 15 Feb 2021 16:25:24 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v24so13233368lfr.7;
        Mon, 15 Feb 2021 16:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ObQgczvE8R33D3cAuZo8fgSRVSdB2ZqxOCCYpoFtjv0=;
        b=e9zxxHz1e7pAv3pU9NG4BuMQZ5DWngKrFtXaQo7gV8rSt4tJMPEF27HZv69/CW7ea/
         /vLC32dq7fxlZhABT+nWhOp919k34UlfE/mlqwpbdgQnSZwkV+/r/Xt8x753rGZ1RTH2
         S+yDoeWvtxFvYrSGlkVWcu/UdexliysthMcI+smWYVzurNi3WX4n90aQwATlf1qgokP3
         GaWZhZXP2FKEadpKMKR4sc+rknFkIDqQvtyTkagsU4n80JxaK8yXJOr81z3gqEXr3DqW
         iJALt5NhZ4fV5VQ/Pza5AX3aD2AUHJPVMDgo98ihj2J2kkzXt3gU06EwEAt88jVP7NfI
         smsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObQgczvE8R33D3cAuZo8fgSRVSdB2ZqxOCCYpoFtjv0=;
        b=AEA31faFoNdosJXGFDGsMz+VcLc796gFAC5Rd0eaUutz2ajiwYjcMXcZv/KNSSUB35
         u/wIski13f4wp6g8+Wd7Cm1X4wlL9ZBf9ti+5aGgjglm39GCKNVLH3oSAyXTA3wWGXFk
         PLFw9oEoJeLOgvIYKpjYHGrOhXsguqWpB3dTNQlXpV/sgXRi18qeNgc74WceFg0bTQje
         v9zP1kajfVVwbYX22mts1pB5MmTPh72uEsFelH58+cLeOeWihYr4nFWDXtIvqJNzHyAq
         3WKttrMU9RJgq0EPtwOWCjSHWqYWEGI0QpQgVLfSTwgzF8pk7q344MOFdoqQahfoEUZA
         tHiw==
X-Gm-Message-State: AOAM532ubarOqYiJkXrVTw8StLb9k9e5OCxRF1OQDi+3RLd5C4/Zh2J0
        eFfVObZiSCzJ7fnVsDTXea7+1yBxFXir0p5wcY8vwmY0HuM=
X-Google-Smtp-Source: ABdhPJwpbGfZrSvCI3ABnbC9IBo8oG4rOHvzFLGU7ukunhQ4On71xzIGoWuS/3fSxipTHKxgarNopdwZT7vsuD67hhk=
X-Received: by 2002:a05:6512:2118:: with SMTP id q24mr4435716lfr.133.1613435122509;
 Mon, 15 Feb 2021 16:25:22 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de> <ec3a5337b9da71a7bc9527728067a4a3d027419b.camel@hammerspace.com>
In-Reply-To: <ec3a5337b9da71a7bc9527728067a4a3d027419b.camel@hammerspace.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 15 Feb 2021 18:25:11 -0600
Message-ID: <CAH2r5msJtUSKm0rX9UttUB5xEmsz8jfEev6UqVu31n2x7Gj-ug@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "iant@google.com" <iant@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "llozano@chromium.org" <llozano@chromium.org>,
        "lhenriques@suse.de" <lhenriques@suse.de>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 10:11 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Mon, 2021-02-15 at 15:43 +0000, Luis Henriques wrote:
> > Nicolas Boichat reported an issue when trying to use the
> > copy_file_range
> > syscall on a tracefs file.  It failed silently because the file
> > content is
> > generated on-the-fly (reporting a size of zero) and copy_file_range
> > needs
> > to know in advance how much data is present.
>
> That explanation makes no sense whatsoever. copy_file_range is a non-
> atomic operation and so the file can change while being copied. Any
> determination of 'how much data is present' that is made in advance
> would therefore be a flaw in the copy process being used (i.e.
> do_splice_direct()). Does sendfile() also 'issue' in the same way?

I agree that the explanation of the tracefs problem motivating this
patch doesn't make sense.


-- 
Thanks,

Steve
