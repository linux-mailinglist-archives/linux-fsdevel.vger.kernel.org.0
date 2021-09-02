Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC963FF126
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 18:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbhIBQUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 12:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346043AbhIBQUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:20:17 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B62FC061757
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Sep 2021 09:19:19 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h1so4574554ljl.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iMvWLkdWUtkaR1dklSOOm8LWF6kDmId1zmm7zZNctbo=;
        b=UqYwBgxkGgrjPUjuhbRaR+xLyGBDGqNcXTGQY2dH1sazdx9URXp5fCnNYrBqs5Yf7J
         TvrKnb971ru+ib8HBTPlUc11Ft7o6IkhsByM2Jk+y8Ovf8G4HlaCr9CiPAmTrIPQfYbb
         q5nIzlUcLfmsFEKimVxis1ZpI3WSJxF/9jqfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iMvWLkdWUtkaR1dklSOOm8LWF6kDmId1zmm7zZNctbo=;
        b=AiGbvsZgsDahqyplWBb24FiWpD9zYR1tzeay+hkJZTtfjWHw6QLQ+xRTpuxS7MtZbm
         HddupF/8yGz8NUum6KdVOZuW87sged6p/TgiUTIlLmuX05WVn/J0b0b/mrz7v/HDoDk5
         x/c9vnurdpUhbaLVQwYyKEnprsARCoRbb+TkRiPDlQHmnxj3+x2vlpxw2Bk6DURMpZ7d
         QdqiO7I2AMkGLCzKNuAOc8jdRl6XkLSvZcZP8y8k/ihfY9JUBEfHVPrHAp5567gAWXch
         7sqNPsbO2Ao3elOq16h3/yyfkMzrdqiT7xQ5YGtpfpLbdse3zTejdOAoewya5dz7S2IH
         PuPw==
X-Gm-Message-State: AOAM533j7BMBhi+9Ox2/HQ5Bxn/mpIc87pPMO9HBP3JLWKMc6kyH+DTx
        Aq1RnapfbHw55xb33GOcJe2JqcAjJJ++XhRm
X-Google-Smtp-Source: ABdhPJwy+vEYcs43zMKuJoAcAGeuXcepaozJlSVVHvkctQWioV7f1HIu35yXTFRi0cExqJvsVV9HVA==
X-Received: by 2002:a05:651c:33b:: with SMTP id b27mr3366514ljp.314.1630599556650;
        Thu, 02 Sep 2021 09:19:16 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id i3sm239289lfr.217.2021.09.02.09.19.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 09:19:15 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id z2so5521701lft.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 09:19:15 -0700 (PDT)
X-Received: by 2002:a05:6512:681:: with SMTP id t1mr3132726lfe.487.1630599555287;
 Thu, 02 Sep 2021 09:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 09:18:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com>
Message-ID: <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com>
Subject: Re: [GIT PULL] erofs updates for 5.15-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huang Jianan <huangjianan@oppo.com>,
        Yue Hu <huyue2@yulong.com>, Miao Xie <miaoxie@huawei.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 31, 2021 at 4:00 PM Gao Xiang <xiang@kernel.org> wrote:
>
> All commits have been tested and have been in linux-next. Note that
> in order to support iomap tail-packing inline, I had to merge iomap
> core branch (I've created a merge commit with the reason) in advance
> to resolve such functional dependency, which is now merged into
> upstream. Hopefully I did the right thing...

It all looks fine to me. You have all the important parts: what you
are merging, and _why_ you are merging it.

So no complaints, and thanks for making it explicit in your pull
request too so that I'm not taken by surprise.

         Linus
