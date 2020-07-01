Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9D1211476
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGAUc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgGAUcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:32:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A79C08C5DD
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2020 13:32:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so28773848ljm.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2020 13:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQTuuRnTRD5guY+N3kjgnPLHXT6P3qZiYHrrKJ47r1w=;
        b=M5E2TfLcC3cfW8OMyrKhXxxtIvY0Y104cXmmv3Q4raTCa6ajB/XOROYaclyuBwWh+A
         QwyVYKRQgeqALuvdcW7sv0dw33dOl/5F5gCyZFcJBfQqk4HuU7lj0CC2aelEfwTDdC0Y
         4kjCbqfpjXn7jho9KN1KvD2s7uo+DH0VG6r6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQTuuRnTRD5guY+N3kjgnPLHXT6P3qZiYHrrKJ47r1w=;
        b=MT8kczKGZqXHsHJwNhiaS36UAiN2upaK2FN9xns+DnkYeR8jkFggTCyXtpssUg3/EI
         T5HccuB2pm8X9jySWQvG1eal+IzyNZjhl0MYNUbD5BYMai/ladwCGBkdA3Ktusn528F3
         cpusBUXhCtinLAZ0Zy82K07x2DdqMB6Xu/x1IG9kFPOCO0TXXEbdCY53Ga7QcIR1use7
         snK9FAcN1cLTCshauhYjbXVA9YlWOQJXD1705FfzgVCJs9AdQyBMJ8ynru4D4g0oP1d2
         vRSgVHdX3R2w/N2wDCDEbPKpiQq3Fu/sv//SZKi0CYXpRaFnKlGpPeFV9c9cFWiJe0RX
         xhZw==
X-Gm-Message-State: AOAM531fidLEmIIgdfbl6UrJ9iVu3P61ENkvsnOZir1avnFraucbPXeV
        hYiwXTKbysPoZdYdu4OrGI5UkBRJZCw=
X-Google-Smtp-Source: ABdhPJwK1KzikbW1iqU2LLblTeFGdJQz7/I/nCjw0m5dnFiVxw7D4MSOMcOsiDKxpxSr3fwLNEpQuw==
X-Received: by 2002:a2e:780e:: with SMTP id t14mr10165042ljc.444.1593635541083;
        Wed, 01 Jul 2020 13:32:21 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id e13sm2066725lfs.33.2020.07.01.13.32.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 13:32:19 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id o4so14513647lfi.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2020 13:32:19 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr16119813lfd.31.1593635539128;
 Wed, 01 Jul 2020 13:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200624161335.1810359-14-hch@lst.de> <20200701091943.GC3874@shao2-debian>
 <20200701121344.GA14149@lst.de>
In-Reply-To: <20200701121344.GA14149@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 13:32:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYihRm0brAXPc0dFcsU2M+FA4VoOiwGGdVLC_sHT=M1g@mail.gmail.com>
Message-ID: <CAHk-=whYihRm0brAXPc0dFcsU2M+FA4VoOiwGGdVLC_sHT=M1g@mail.gmail.com>
Subject: Re: [fs] 140402bab8: stress-ng.splice.ops_per_sec -100.0% regression
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 1, 2020 at 5:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> FYI, this is because stress-nh tests splice using /dev/null.  Which
> happens to actually have the iter ops, but doesn't have explicit
> splice_read operation.

Heh. I guess a splice op for /dev/null should be fairly trivial to implement..

               Linus
