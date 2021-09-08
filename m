Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC552403405
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 08:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347594AbhIHGFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 02:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhIHGFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:05:00 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B048C061575
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Sep 2021 23:03:53 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id bf15so1090394vsb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 23:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9LIm2NI4J2ECL3El5kZArfy1ZWkx4EHOdvVqDqSuUw=;
        b=Rs+pHJMqqr8oSYFDl89dFh/Haf1WX2j6VDqel7r4hrFlaN4vUWORYNPS1wtKwPuCIA
         uRZxY6oAm6HUh1+06T10Nx9qb4Wd9NEXZBQXybGvSTKv4dIApBxt2wmcxo6BmxcghOUr
         FFfeqLOrInXhNZJWdSqb+3TTSNW7u/Sf4sqCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9LIm2NI4J2ECL3El5kZArfy1ZWkx4EHOdvVqDqSuUw=;
        b=fZnVPRSqiVbNtZPFmaRmKGNSRTs6iB40b21S6p21md73LlatjKmz3kORvxKvai5Ti/
         IX6rYpLl+Lky5V50TCeVUDS6Fl4AaAdVBxRx4XQHROLspKSmkiFykyD64x2mD8urexHq
         YZDievY4zE8KIZn6XOlz7uxBLNvRpQzM56mof9VDY1w+EdB3E0yqdHvfqT83+H+sPAZW
         lmUeftFpgqg18ZzalIoNiUAl1UPbRJ1+HkLsc4PyYTW2sT7QEuk4FgkzcCHXf14tO9Y0
         povQqFV8rNhTslFhJ6qpoclsr6OVbP1zrEUxdi8/88o1h4+jRPpkEzpqMk7UTpEdBm/S
         eaqQ==
X-Gm-Message-State: AOAM533aAGW2xVKNH/EG3fLRHIY0/tdd5m3ob3EkBj4Tpptq35MCmmn6
        OpjmM0qOdqBYcZXY5JCH7II44D+NO/4Mg5KcvBERwg==
X-Google-Smtp-Source: ABdhPJxMFK1wc/rkHnrmhs75rBCUkEOXvRYFESr303spNGhoQqdWQTFm40Z8DOpOL5XobCIRN4Yq6pjwrJtfol8X554=
X-Received: by 2002:a05:6102:347:: with SMTP id e7mr1015896vsa.51.1631081032740;
 Tue, 07 Sep 2021 23:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50a+MKpDFSoNr9gtYRaE4FQgeihpvc6NDdcs8za8X1ZVQGQ@mail.gmail.com>
In-Reply-To: <CAPm50a+MKpDFSoNr9gtYRaE4FQgeihpvc6NDdcs8za8X1ZVQGQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 8 Sep 2021 08:03:41 +0200
Message-ID: <CAJfpegu=0AovQ064-iFX3D8s1WiAjvUfi1eYU6zzjQek0+nDbg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Use kmap_local_page()
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 8 Sept 2021 at 04:03, Hao Peng <flyingpenghao@gmail.com> wrote:
>
> From : Peng Hao <flyingpeng@tencent.com>
>
> Due to the introduction of kmap_local_*, the storage of slots
> used for short-term mapping has changed from per-CPU to per-thread.
> kmap_atomic() disable preemption, while kmap_local_*() only disable
> migration.
> There is no need to disable preemption in several kamp_atomic
> places used in fuse.
> The detailed introduction of kmap_local_*d can be found here:
> https://lwn.net/Articles/836144/

Okay.  The patch is still garbled.  Please use git-send-email or some
other mail client.

Thanks,
Miklos
