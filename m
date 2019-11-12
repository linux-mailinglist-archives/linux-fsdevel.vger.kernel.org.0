Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A064F938D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 16:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKLPCZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 10:02:25 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45982 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKLPCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:02:25 -0500
Received: by mail-yb1-f193.google.com with SMTP id i7so895127ybk.12;
        Tue, 12 Nov 2019 07:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZFRniNhkoskVISAxUPeKakHBMQw+lNuf+IeHyPW8fg=;
        b=IYPNXW/16scfq1EQSeJjgiRt9gf0Ihi8xOO1YtKKyYO3okjUsc2jRHymidZlT8BbpT
         0+hvI7D1vQ7BFMGlwYtBjQ5x7jBPSfj1xcYWjd9+B0TR81kKGp4nvdSrou3M32dhEeH4
         M3iydDpMHJ5VDnGhkuWI0X9pUH8sfPrQOeYwEtFVHUBsEsAMwOdgAx5PX8sFS9ijtP0V
         1nWiaVuM4Dm5dAvmj8jd0zyqOVzSlvpWJKfXBqFOav67wfo/B6rvAj5h2fHHV5yRSJIi
         fTeVxd8ovxV75n4unI+L5vrZh/ZID+q10ggH+xXq1EF+MwgwU83aV08JG4BxXRvmeSt7
         ukYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZFRniNhkoskVISAxUPeKakHBMQw+lNuf+IeHyPW8fg=;
        b=lwstdxJI4A/b4kPC5FNeWovzyLgoxaYtpvUoDc0JAHzmYPOJQ9MVHKYuUGnxHK3kSx
         +aSwFgLDpkNf7ov/ua5bfyU8892PRhb1lTQROxnIE4cE6bCIUjZoGfY7SyVMkRUaL48F
         MxyGBxmXhFb0SdnLFu5ormguqsZhQyPzm5Lo3GQlvdu6WDHL7Nkj2QZdA69joRoIOJT1
         sImsgWJrLcRYdatygelFUIN+sTO3EiiB0hk7d55vXQDcMVueKOZdMQnZTG3O5hxmOsNY
         9ibWhE+BgjtJIfyZkele/OxueW4QnJ57yywKuS+upIkSrJIWZ6PrZTx9yNI9fHMs+Bwm
         F/jQ==
X-Gm-Message-State: APjAAAXl7ONEFH9BuLvLnNfPQt+XuNbIKXKlmfg2AJ9q5+aEJ4ULGyh3
        w22RM1ekVFclUeZn3q/k9smBKlknPH5NcfO/jDs=
X-Google-Smtp-Source: APXvYqyHwtwbFRvgeF129t68EvW0i9keSmsx+0602PGhkHqIOvlTFp4USwCvEsV67X31RKjUIoWL09g61d+vzxqxEwQ=
X-Received: by 2002:a25:3803:: with SMTP id f3mr23731431yba.144.1573570944008;
 Tue, 12 Nov 2019 07:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20191112120910.1977003-1-arnd@arndb.de> <20191112120910.1977003-5-arnd@arndb.de>
 <20191112141657.GC10922@lst.de>
In-Reply-To: <20191112141657.GC10922@lst.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 Nov 2019 17:02:12 +0200
Message-ID: <CAOQ4uxiGsydjS-hh4ANXz45n3x_LU_uXGtP1-paeT6cS-PWbCA@mail.gmail.com>
Subject: Re: [RFC 4/5] xfs: extend inode format for 40-bit timestamps
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>, y2038@lists.linaro.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 4:16 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Amir just send another patch dealing with the time stamps.  I'd suggest
> you chime into the discussion in that thread.

That's right I just posted the ext4 style extend to 34bits yesterday [1],
but I like your version so much better, so I will withdraw mine.

Sorry I did not CC you nor Deepa nor y2038 list.
I did not think you were going to actually deal with specific filesystems.

I'd also like to hear people's thoughts about migration process.
Should the new feature be ro_compat as I defined it or incompat?

If all agree that Arnd's format change is preferred, I can assist with
xfsprogs patches, tests or whatnot.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-xfs/20191112082524.GA18779@infradead.org/T/#mfa11ea3c035d4c21ec6a56b7c83a6dfa76e48068
