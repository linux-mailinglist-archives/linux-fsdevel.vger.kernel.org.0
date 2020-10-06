Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8032849C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 11:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgJFJyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFJyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 05:54:45 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B481CC061755
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2020 02:54:44 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id j21so1677349uak.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2020 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izApQwLJB5xPWcDbk9LN+B6IrXmrGQdSEQHBKE/yABU=;
        b=fpqf5dT61cMzTgvRhlVympy9TJKqv3ohM7WHPKQXL3i7K7ngMfot+Y+oWwO8CNTCGy
         bd1UEQWTE7IrhVcTG4S1fH9tuCMpJOOyvT6vEgNpYjqW/KWb2ArFVwcI0SvoXDWM0+Mn
         4CtVjT0Rw1hwtt9rVTRqc2gunccE7Ey7oTyik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izApQwLJB5xPWcDbk9LN+B6IrXmrGQdSEQHBKE/yABU=;
        b=CoFxHg/TlyKKYB79JARJffLapTnyU6sdHWwB/bP4gEBQax1vUOz0vht2hCsyLWJvpH
         53vs7SzPiBSwP9oT5auJ8VUSKxmXWWEH604TYpGTzCGHjh05l/v/Zwol6YxKNWk2hdVE
         pIQZb5gZFRC3RmwFcSmh9QBgTTe+2Vomm90lrWWHvNBvVbXaYH+mombqF1+sEsEEX1qb
         6ZGH31ge+6lZXwpYbVJPfJXrTYQp/cZpekD+LIlMCVNo2Jd3KO2vRstJFYKRBMC19oga
         G0FlRjicd2Qdl9Iy65HP6BE04KwvRW0eL0LOisKq0bNbPPWqy0SRCTQ7SNvgkjQwIbLp
         zLmg==
X-Gm-Message-State: AOAM5311tK8fKvmqIFQHp7iwbSnjQ1D6f5xWeY6RxYA3iOmx2hzdzPAN
        TcF7Qdkg7uSd7ZgFbuMQRk8agFUVE6eZF6ufD5kr4w==
X-Google-Smtp-Source: ABdhPJxV86chRtP6w3u4OVoe9k5LOEGi8t+NTLL+/pC+E4MyMJFZkel/aoG8IL1rzehJhmqxb5jdR2LEH5aH269JqW0=
X-Received: by 2002:ab0:6709:: with SMTP id q9mr2345943uam.142.1601978083945;
 Tue, 06 Oct 2020 02:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
 <20201005170227.11340-1-alexander.mikhalitsyn@virtuozzo.com>
 <83d78791-b650-c8d5-e18a-327d065d53d7@infradead.org> <20201005201222.d1f42917d060a5f7138b6446@virtuozzo.com>
 <CAOQ4uxiGq40XLhjx_Nz1ymGj967QsMAj_PvuSKH1_4dX=dRMXA@mail.gmail.com> <20201005223948.6e9769ded3301b2d04a2bdae@virtuozzo.com>
In-Reply-To: <20201005223948.6e9769ded3301b2d04a2bdae@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Oct 2020 11:54:33 +0200
Message-ID: <CAJfpegtEbkdLnYvNVJYEb6yCtAjDAs4PWLVO53uQ3y5uprEELw@mail.gmail.com>
Subject: Re: [RFC PATCH] overlayfs: add OVL_IOC_GETINFOFD ioctl that opens ovlinfofd
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        David Howells <dhowells@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 5, 2020 at 9:40 PM Alexander Mikhalitsyn
<alexander.mikhalitsyn@virtuozzo.com> wrote:

> Oh, yes, it's just another one choice for us ;)
> I decided to create ioctl which opens fd for transferring
> data about overlayfs.
> Sure, let's look on sys fs. I will dive into it!

Or maybe use fsinfo(2) or whatever it's going to be called?

That one seems stuck at the moment, but having a clear set of use
cases can possibly help move it forward.

Thanks,
Miklos
