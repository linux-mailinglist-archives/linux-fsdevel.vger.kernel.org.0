Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5FD3518A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhDARq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbhDARmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:42:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC52C02FE9C
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 09:05:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b14so3583422lfv.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iP5XcIUiB65F0LLqCoqPxiX0Svs4vaWqQzfjqgIZ9Cs=;
        b=FPeG12D75gTLYSxzhBVuCFWZ7afdxQScJL/saT72QoEEkvkmu4OPQw4w4cozkk1n20
         XGxo2yvy2/NQ44qtUM+WNWfgCPAl37mw1L1LrAe/r3PRY8uK8TbAN3gNKWlLrgAsry3t
         3RGscXoiWR2M5XVNZ7QurRIJZkl+KHhoU2ZaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iP5XcIUiB65F0LLqCoqPxiX0Svs4vaWqQzfjqgIZ9Cs=;
        b=qkCqTdD5RoSD/2NIjNJWnCKCB60dFeHssBqQx7xJ7Fhuo1JiMz+l72r4CFHoEXYCcN
         9uLLTmEm0GvvJNDmdxK20B5N2Yj0HV1EKNXu/k+9auSAHqVT8i9fzw5Ccp3q61f1sYeY
         eVbdXwh28SYvfL+wIa1hHqUxhz2u7rJ4LzUA007WpwmpdYlLK5NoyWQhMztrICVHtB8g
         5Lmg7sqRhADwjkRGr5n0cwUHI7GCvamEY2L5OTwpxEjnhtyfYRpDI4bq53v/DsQO3k2e
         Nxc/dv93P5Yu3n3aFpjNicyt+wv/Uln459SwQL8U2JhAbnUFw+d41kwZ2IXNdYMsVRo0
         XVXw==
X-Gm-Message-State: AOAM530xrXAVEG6cTUksLmwepDyToVcxdCBIlWzU2/JoNufNgk/OQZv6
        4S0JDR37uZTfrHlLlpW+ZQRKuVCKX3BBUYQb
X-Google-Smtp-Source: ABdhPJwT3Yoaj5lxx3Eot+8SaKHr1MNZGHhun33x7FyRsEn5RjPcMHutikRFUQrIc/QKBg+60CZApA==
X-Received: by 2002:ac2:4e82:: with SMTP id o2mr5801365lfr.489.1617293142173;
        Thu, 01 Apr 2021 09:05:42 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id y22sm583128lfg.133.2021.04.01.09.05.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 09:05:40 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id u9so2790927ljd.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 09:05:39 -0700 (PDT)
X-Received: by 2002:a05:651c:3c1:: with SMTP id f1mr5836522ljp.507.1617293139746;
 Thu, 01 Apr 2021 09:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617258892.git.osandov@fb.com> <0e7270919b461c4249557b12c7dfce0ad35af300.1617258892.git.osandov@fb.com>
In-Reply-To: <0e7270919b461c4249557b12c7dfce0ad35af300.1617258892.git.osandov@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Apr 2021 09:05:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpn=GYW=2ZNizdVdM0qGGk_iM_Ho=0eawhNaKHifSdpg@mail.gmail.com>
Message-ID: <CAHk-=wgpn=GYW=2ZNizdVdM0qGGk_iM_Ho=0eawhNaKHifSdpg@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:51 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> + *
> + * The recommended usage is something like the following:
> + *
> + *     if (usize > PAGE_SIZE)
> + *       return -E2BIG;

Maybe this should be more than a recommendation, and just be inside
copy_struct_from_iter(), because otherwise the "check_zeroed_user()"
call might be quite the timesink for somebody who does something
stupid.

But otherwise this new version (still) looks fine to me.

            Linus
