Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024F93DAFAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 01:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhG2XBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 19:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhG2XBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 19:01:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E5C061765
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 16:01:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a26so13882913lfr.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pY7m/Y43lyncS7WapXCMkLBirYxokclAcy/UGj99rQA=;
        b=XQtQEX/BG2JXB6WBNf/JB98ExbQAGG37D1sqjMTQzcAlbBF3cE9jO6h35na96096Nt
         9bLwxHZ0OUkMyTGxEIoxMov84KKm2MpsHsc39n6CfhXg+fMQAWyIBI3nG4bncuHMl/08
         g6bfAX7f+TIZ2iNmLpTBNrEuEjPlYNygVzzo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pY7m/Y43lyncS7WapXCMkLBirYxokclAcy/UGj99rQA=;
        b=m8cFBhX/Xq/jQT2f9Shs3pMMPnpoh5DmwVATPz9h5kSNdLXWXHWj4dQtoBQ9KmVymM
         gQObbTt5J0KXadhyHEpRYeFkpTZsD6bElBtWCu8V6a9n1tmfvOmcCNJHme/mrSX+AXS7
         qkfktHVellXNdpHQ1HxrBf0R8KTuGWb11nfr/gsV5pDrG4SUaN/WYx8Uk2QJi4Q6tYwY
         RaqGgKLIbzayabtV641DpvS7snIQybt9vKMZ2jwYEeqZT0oKyx1s6I3mNoyqfMNfijsv
         dErs3k3Rv8/JrUbr2KESqm40Bt8XeJMmCNr0eTOfgjB0BEs5F5mO8uzJAzl72GUdXY7e
         lNYA==
X-Gm-Message-State: AOAM532jdXWxK1cc6+7SkhE2w2E3QQ+lXO+Ia+HkWMsYrtj6fh4RShxx
        YvuUqKoat16mU5qIruvMJOTsBZFri8zzLbsB
X-Google-Smtp-Source: ABdhPJx3fg7R1BvlE/ZBWsSEAe0WVcSvS3uGOhaIo7KIXlzY97HjA0wz8nx7Ru4JHMnWlXXgM4D4Jg==
X-Received: by 2002:a19:f241:: with SMTP id d1mr5648672lfk.250.1627599684593;
        Thu, 29 Jul 2021 16:01:24 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id c32sm418864lfv.75.2021.07.29.16.01.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 16:01:24 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id r17so13965902lfe.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 16:01:23 -0700 (PDT)
X-Received: by 2002:a19:c3c1:: with SMTP id t184mr5315383lff.41.1627599683697;
 Thu, 29 Jul 2021 16:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210729222635.2937453-1-sspatil@android.com> <20210729222635.2937453-2-sspatil@android.com>
In-Reply-To: <20210729222635.2937453-2-sspatil@android.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jul 2021 16:01:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-DWvsFykwAy6uwyv24nasJ39d7SHT+15x+xEXBtSm_Q@mail.gmail.com>
Message-ID: <CAHk-=wh-DWvsFykwAy6uwyv24nasJ39d7SHT+15x+xEXBtSm_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: pipe: wakeup readers everytime new data written
 is to pipe
To:     Sandeep Patil <sspatil@android.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 3:27 PM Sandeep Patil <sspatil@android.com> wrote:
>
> So restore the old behavior to wakeup all readers if any new data is
> written to the pipe.

Ah-hahh.

I've had this slightly smaller patch waiting for the better part of a year:

  https://lore.kernel.org/lkml/CAHk-=wgjR7Nd4CyDoi3SH9kPJp_Td9S-hhFJZMqvp6GS1Ww8eg@mail.gmail.com/

waiting to see if some broken program actually depends on the bogus
epollet semantics.

Can you verify that that patch fixes the realm-core brokenness too?

             Linus
