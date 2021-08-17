Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BDB3EEEAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 16:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbhHQOnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbhHQOnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:43:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFD3C061764;
        Tue, 17 Aug 2021 07:42:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y34so41818924lfa.8;
        Tue, 17 Aug 2021 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYqEXJfiN18yCZI6p8+AKI7fLyyfIF/2Rhy4MgWxORs=;
        b=Cgp4XiI/ioCeNTwNFXQjYKGi8WTg8i/ZA62xg8W1eygB/LANHDdvZYsFESebJx2ZAc
         Vargn/+b9VLuUwubXGGnlicEBibS6etHatqnaIU46lk8Nq4ropCtsNzo8bJysznslVR/
         wxrsfuZgKKLdz9lgV/gyyFiPtIi4v8V+10nDlf7NMCO+44d/2+1PPh90WTFfpJKbOmGl
         ljZkn5z+W5MYjMdGbe4Nl5SivKnId+8q4e5yaJF0d+uINN/2D2+AhT+2iYqLyVZcTl3n
         vQGsm5l8HGzrRuV1JEUYDn8d1QuhzCYgcUEdGYERT0cWlFGVVOUKaQrHF8eE813oKSvP
         EfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYqEXJfiN18yCZI6p8+AKI7fLyyfIF/2Rhy4MgWxORs=;
        b=FpgOJsR+faR2mL8ShdThxp9do8gXwZgsYWgJUkg5LRDM4vvZtFg/SMbYWl6DcAG5gu
         FhwA5gUkA5mw0teH7HDEkk+uRMS/0/CJlI6AoW8mIjozqXSimTfqloNhNXzXdEh3dNjn
         51D11jGE29SL5e4LI7EmdEEifSheoDte7o3RhnOuhL2W8hcFVqubcigBrNF2tx7Hht0r
         RWegD2zHg9VBHYTjANb+hjyq+zhyAifzTj1Xo9IQwphxMZMEvWU6vDzrTzsKm32uodI7
         I5AJ1OobD0Pu9GXa+CuUMfYE66XBMhqPPOk2foGi2vBRleQnnIo7ZWo4AxkBDlcguel9
         chTw==
X-Gm-Message-State: AOAM530ritbDITvv70IJCNbIq64L798i1yQ5ms1t6+28dSyXbLm3NTba
        Tt0TwqL/iXuEctzU/XjdDPUewtANiU3swEqsn0w=
X-Google-Smtp-Source: ABdhPJzaMq7CWUOoMolITqe/TuYuwS1QvR8N16pqlMH4rqZKY4UMF98ZToXGodeF25valw2giFNpcKQdBw8IOwnP8Gc=
X-Received: by 2002:ac2:5b9d:: with SMTP id o29mr2734522lfn.26.1629211368980;
 Tue, 17 Aug 2021 07:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101753epcas5p4f4257f8edda27e184ecbb273b700ccbc@epcas5p4.samsung.com>
 <20210817101423.12367-3-selvakuma.s1@samsung.com> <YRu02+RgnZekKSqi@kroah.com>
In-Reply-To: <YRu02+RgnZekKSqi@kroah.com>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Tue, 17 Aug 2021 20:12:37 +0530
Message-ID: <CAOSviJ3tziyBmeP5Op_NAPhyt5vDprjPLaGH8Fu_rbK8UcQYPA@mail.gmail.com>
Subject: Re: [PATCH 2/7] block: Introduce queue limits for copy-offload support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
        snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 6:38 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 17, 2021 at 03:44:18PM +0530, SelvaKumar S wrote:
> > From: Nitesh Shetty <nj.shetty@samsung.com>
> >
> > Add device limits as sysfs entries,
> >         - copy_offload (READ_WRITE)
> >         - max_copy_sectors (READ_ONLY)
> >         - max_copy_ranges_sectors (READ_ONLY)
> >         - max_copy_nr_ranges (READ_ONLY)
>
> You forgot to add Documentation/ABI/ entries for your new sysfs files,
> so we can't properly review them :(
>

Sorry, we will update the documentation in the next version.

Thanks,
Nitesh Shetty
