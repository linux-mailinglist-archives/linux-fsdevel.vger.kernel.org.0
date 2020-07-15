Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FDD220CD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgGOMU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 08:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgGOMU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:20:27 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95050C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 05:20:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so1948403ejc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeTHDFfLVETkERx6UHMSuqnimLPDuMv2Twprnpi/zB8=;
        b=PQD3bmXdYBZjEJ2Z0urtOmxELCrWCtlqmK8ddgomSKQOP1vip1EyjSl7tYKq+A14hx
         Nj9QCnoYgpR0psa4hSp1Gn3xMtQFAeoX8Wc9DaP/AoxRg5copSm0AVwCnlkLS8/RmzGj
         k89dufCnR6qdWFBhKewVRomBeA1hfPTDk5Xvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeTHDFfLVETkERx6UHMSuqnimLPDuMv2Twprnpi/zB8=;
        b=PpBuX7TWN3D+XcmQl6VUCTfRFka+oBpqePPy/p1AbRkqu1EHHvZEikfM/R0I8YTDnl
         ZsbXIgFoR90LZ0yjvZsQ1loVzIykuDliiN0pZ5354Gtr4NnvNxDcb/HdQvqU5/Wy+ra9
         Q4X57SwGAhjgxyhiw/z64yzjU86Rwa1BTIUZLA+LE+OByfPS8WJVMiKIjlEHCm38/Q2x
         B14NLiUv4RrR4Q284GKLYUjs8Nl7ziBbbM8yOZizoE27Z9Jk9va7ykLxDWwIvsWtcC2C
         dZ9H9mbOu3eJyO4owXTkyLOL8VeA3lutZGZznxuUtPNgTxHWiHDKeR758nwJJaaoBkpi
         YBmg==
X-Gm-Message-State: AOAM531PvEp1lPid6NvBDEsUChjBbtidTFGWvsd09OttBbNSiu6dB+yY
        Yw4NcsR9e/JQJWTP1HTkKcTBUQ5YaQFJ2UN+qoS0bw==
X-Google-Smtp-Source: ABdhPJw4u9Qg0JDt4YVvuFrVa6gdZ72EvuyZe6cBBiKHy9ozBIKZ0GpVVrWv1PR4VgoZ7YPW1UkHN10Hp+Bck1mbPls=
X-Received: by 2002:a17:906:b74e:: with SMTP id fx14mr8621021ejb.202.1594815626117;
 Wed, 15 Jul 2020 05:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200714102639.662048-1-chirantan@chromium.org>
In-Reply-To: <20200714102639.662048-1-chirantan@chromium.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Jul 2020 14:20:15 +0200
Message-ID: <CAJfpegvd3nHWLtxjeC8BfW8JTHKRmX5iNgdWYYFj+MEK-ogiFw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix parameter for FS_IOC_{GET,SET}FLAGS
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:26 PM Chirantan Ekbote
<chirantan@chromium.org> wrote:
>
> The ioctl encoding for this parameter is a long but the documentation
> says it should be an int and the kernel drivers expect it to be an int.
> If the fuse driver treats this as a long it might end up scribbling over
> the stack of a userspace process that only allocated enough space for an
> int.
>
> This was previously discussed in [1] and a patch for fuse was proposed
> in [2].  From what I can tell the patch in [2] was nacked in favor of
> adding new, "fixed" ioctls and using those from userspace.  However
> there is still no "fixed" version of these ioctls and the fact is that
> it's sometimes infeasible to change all userspace to use the new one.

Okay, applied.

Funny that no one came back with this issue for 7 years.

Thanks,
Miklos
