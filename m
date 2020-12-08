Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F852D3240
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 19:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbgLHSfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 13:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgLHSfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:35:47 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A10C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Dec 2020 10:35:07 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id f24so21129154ljk.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Dec 2020 10:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=voLO0p3JKgBqdFAV+eE0VtYglGMqvAnD20Qcprcp1eU=;
        b=Rb3yB97rD4Jd09jB1o/7GugG34ZyX32ATZjk4sAGSTpj11Jg5M0x97OA7D/aj1dg8o
         tRtB/Md3dssWMo4XJjaEetlgq5hwf3cnlVq+rgiijO9tpW6gTVdxhrcQ3J58bsnPIlbg
         2+RmSGDu+naDhJQPeAR9B/tFcLahy4KmGnOcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voLO0p3JKgBqdFAV+eE0VtYglGMqvAnD20Qcprcp1eU=;
        b=hEMLMN/CIPMNfH9gx9jj9Btb+sZ6iraFZwdYg6f54iYrQakdi+VQzkloxA/PTgBkdB
         VALrSSph5xcIrNZTWBBeqwYRpkS5/s/pMKdP6h5pP7Mkrbh2Cjlh9JBp32UdnZfMFRlE
         QsARfoiC37H5kBUSvKOYHmt2TkJeWu0e+XNRpRv2lszNlO78sCCjhz/AJPRAZX6PKnlu
         kQW1Itfk+OF7OsPaCot/s1rk8I+WXemWL0fHL1WrfUGH3dvq7KW3BuZgpZFGk80lkuKr
         OT3A3iQVHQ5AY8h8OmQaYo/MuxrY4OJMWZXW+tE4ajTfZQwqeCdycSq7v77G+qgRsQRy
         HvVw==
X-Gm-Message-State: AOAM531G2txlirRvAzr0555imQEqf4m7Y1urid7U2jPJb1c3ReyufQRb
        7lyeQIMLz1di6qU2mukO+0AaQsjexBNcqQ==
X-Google-Smtp-Source: ABdhPJx3PykNRaoKp7V+sYeccVTPd24UrUUyevxDGJX8wmPDCUvM1cJ9XF02P12/lfX0BnO+F9jtUw==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr11684193ljg.27.1607452505336;
        Tue, 08 Dec 2020 10:35:05 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id b25sm3324643lfo.23.2020.12.08.10.35.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 10:35:02 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id d20so25312407lfe.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Dec 2020 10:35:02 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr10997620lfb.421.1607452502153;
 Tue, 08 Dec 2020 10:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20201114070025.GO3576660@ZenIV.linux.org.uk> <20201114205000.GP3576660@ZenIV.linux.org.uk>
 <20201115155355.GR3576660@ZenIV.linux.org.uk> <20201115214125.GA317@Ryzen-9-3900X.localdomain>
 <20201115233814.GT3576660@ZenIV.linux.org.uk> <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk> <20201116003416.GA345@Ryzen-9-3900X.localdomain>
 <20201116032942.GV3576660@ZenIV.linux.org.uk> <20201127162902.GA11665@lst.de> <20201208163552.GA15052@lst.de>
In-Reply-To: <20201208163552.GA15052@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 10:34:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
Message-ID: <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 8, 2020 at 8:35 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Shouldn't this go to Linus before v5.10 is released?
>
> ping?

So by now I'm a bit worried about this series, because the early fixes
caused more problems than the current state.

So considering the timing and Al having been spotty, I think this is
post-5.10 and marked for stable.

Al, I'm willing to be convinced otherwise, but you need to respond..

              Linus
