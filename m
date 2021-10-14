Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B13542E2C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 22:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhJNUaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 16:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhJNUaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 16:30:06 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC0AC061570;
        Thu, 14 Oct 2021 13:28:01 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id n65so17538579ybb.7;
        Thu, 14 Oct 2021 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/5NOuaTC7GdG1HuEPP9I36zK6ViujDRxabRQSupDHo=;
        b=mZSIsOvJHc61pRh6A/XJqJhCkjUDhzyZEDo0NiXq4EYG0pvrL6zmdtCQRc4MVmsnRu
         W4bA9WqUDspnIcnE1LObWeijQbP2Fl0/5uDdIQ4qT3nxE/+dCQbziFDKajSfkPbjAgNq
         IXnp9Qlrkvoc0bTXmxaJD/zWelOAZMHWoSqggSezx//cPL1hGkxfSNQyepSzibIqTrvm
         VddHdN8lvISRpJDGlimsVktN+y7WaTFkTqlHJbVFTTu76vkxvCwvL+FDp+TCJs7fijDW
         FNsAfXZsNMCAnyBhw/sxSuF5cmu3+WH911MqcwCx6X0wRCAPkya1XWVHvwxT6JEK/bNO
         J5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/5NOuaTC7GdG1HuEPP9I36zK6ViujDRxabRQSupDHo=;
        b=j6ZZiBF7dfSnYqJXdTMSD/SZD/e9dDLxbKoW7wnI/Wv7SCiUe7Qf/fhCbCotJKvdZZ
         2bDD7xEf1C0JInG9FPeiJw3cUosh6T0GcuC5ygbuVoq7MOv0Ud+0dr/Nao+9tJQi41PT
         YoiDMzsLieXgTnAoLM+yIBky2dNBUqxJi0QZ9PxEfAUCXpqRK/BxoTBY7tfPCdLvN5KQ
         /tlz/lcY4ChgJQzLdR9hMYATf8N6hp5jI6L4+y1n2bGppsvOqoPfvl6Bpk98FqOnKdbd
         HRC8+vOmKM0wPYZRXSLAV3lTxD7KWYyuMHbW8e5X/6oEIC4MmZSLXqEdaHol1wbqTRTN
         WhQg==
X-Gm-Message-State: AOAM530e7L5UWrGErIpqAHrmh0Vce8Q09GQtb3o80YkzhCfFDIMTbfOY
        AeSULrKWOhI8jLbkeFgGTTy1cN9UdiewMz/EQfMaHDc6Jx0=
X-Google-Smtp-Source: ABdhPJwg9lqbsJzFdH/trlT3Wp/VmvB1S90EPeLIHPlWMMDAImHpzO0Jlbu8yUrDRh7Hw2O5YBe/lCa4d7ooWPe4eYg=
X-Received: by 2002:a25:45c6:: with SMTP id s189mr8443476yba.290.1634243280776;
 Thu, 14 Oct 2021 13:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210809141744.1203023-1-hch@lst.de> <20210809141744.1203023-5-hch@lst.de>
 <20211014143123.GA22126@u164.east.ru> <20211014143243.GA25700@lst.de>
In-Reply-To: <20211014143243.GA25700@lst.de>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Thu, 14 Oct 2021 23:27:50 +0300
Message-ID: <CADxRZqxgu_A=BMOPVCAUteLfLUWAmL_b-S8+TBW1j-eW5O6dwA@mail.gmail.com>
Subject: Re: [sparc64] kernel OOPS (was: [PATCH 4/5] block: move the bdi from
 the request_queue to the gendisk)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 14, 2021 at 5:32 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Anatoly,
>
> please try this patchset:
>
> https://lore.kernel.org/linux-block/CAHj4cs8tYY-ShH=QdrVirwXqX4Uze6ewZAGew_oRKLL_CCLNJg@mail.gmail.com/T/#m6591be7882bf30f3538a8baafbac1712f0763ebb

Christoph,

thanks. Tested (with 5.15.0-rc5 + patchset) and no-more hangs with the
test-suite. Thanks again.
