Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B784949D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359357AbiATIqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359353AbiATIqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:46:36 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC665C06173F
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 00:46:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id j2so25423516edj.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 00:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgwK+h4TcKTuzoMVgpyjaT6hqJgZPgeFi9/82jcEytw=;
        b=bSaFa+URfbmU/MszEXVOlamjch2d/bVKLmiJuU4jZJRaWnRGqGHrY9tAQfmQRbRXiV
         uc/9kTk3/S5l1jHMLdTRmVU57otES44XeerqdTVprmM6I9EDUZQLX+yH0h63YbxWR9mE
         9nbGRPoufn7nse+dFWj62siY9k2GshoKLCrxbi33+uXmG5HvTOiNXAwJCNJOjjOHmaSp
         XOP01luyWgvqHzNdBA4wIYoRQp0k9Ft6zqCX+Ra/R90oY2R7/AxbMlg/sS1PwZuWZg03
         Z3JDZLtjXW1ZdUyTLOQOdSV8iGdn5zWa6hPXzsGCHlb9LWK1Z0CByscOqozFwyTfAd7X
         /t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgwK+h4TcKTuzoMVgpyjaT6hqJgZPgeFi9/82jcEytw=;
        b=PrwFMjpwEedNIsIkLgIZtPuDJM05rDsI9oFqvyeydp2zVQnayqow0b5LvbFTVDvvrR
         PX652yUQKjMC+wiD1OPNA87+80h6KJdwIjNDdx6L1Q9zJc4iMQWQPXjqSVc9+I+vpow3
         060QXv1NlZi1WoaH/CFuygL0M6PAqyeBp5nAnV9x8OD1Mw3y8CX8AvIn19VdTsSd6yXT
         3cVximnyKHXCa/ZW0vrKIiWIiCDONVRFu+5TklC1ETmWjwLqQj99WrNgLh3M6e25waun
         cdIK5i79P7K6Iw4Z9fUDBysQblLQnhnkPPvCRJPoFqZpTqcBV0a0R9TCWVuR5HfU9pNr
         q1iQ==
X-Gm-Message-State: AOAM530gGdlVp4pwKx9EXNsH+cbyagNTLBqypjq1XQDz9jWhYeoz+1iu
        vv8Z5K75oEtQ1qO2hBAOajKIwqW8J324hwn3nR25Mw==
X-Google-Smtp-Source: ABdhPJxuyj+5hYqiz1QG79H/zXO6tZsV+Dq+Pw3BW6UC4M2lhhCbPthTcTo8B1M9EwB4FqJ6g90lXSpEfvPIb7w08Cw=
X-Received: by 2002:a05:6402:195:: with SMTP id r21mr34247351edv.174.1642668394471;
 Thu, 20 Jan 2022 00:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20220118071952.1243143-1-hch@lst.de> <20220118071952.1243143-11-hch@lst.de>
 <CAMGffEmFZB1PPE09bfxQjKw-tJhdprEkF-OWrVF4Kjsf1OwQ_g@mail.gmail.com> <20220120083746.GA5622@lst.de>
In-Reply-To: <20220120083746.GA5622@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 20 Jan 2022 09:46:23 +0100
Message-ID: <CAMGffE=+ENBdRfugG4k3yB_ca3rqwnaKFXC4+8=CZ=LGvggA6w@mail.gmail.com>
Subject: Re: [PATCH 10/19] rnbd-srv: simplify bio mapping in process_rdma
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 9:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 19, 2022 at 01:20:54AM +0100, Jinpu Wang wrote:
> > this changes lead to IO error all the time, because bio_add_page return len.
> > We need  if (bio_add_page(bio, virt_to_page(data), datalen,
> >                      offset_in_page(data)) < datalen)
>
> Does this version look good to you?
>
> http://git.infradead.org/users/hch/block.git/commitdiff/62adb08e765b889dd8db4227cad33a710e36d631

Yes, lgtm, thank you!
Reviewed-by: Jack Wang <jinpu.wang@ionons.com>
Tested-by: Jack Wang <jinpu.wang@ionos.com>
