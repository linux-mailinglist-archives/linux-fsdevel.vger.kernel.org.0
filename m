Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A2945AEB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 22:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhKWVxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 16:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhKWVxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:53:11 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBAFC061714
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:50:03 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id u80so582537pfc.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
        b=Zg2lBRkAMXF8A+wvUtTCMUUrMwJSgDxXgPFdIJ6mN7vtPUcxzmlaWcpTf9u8Q3z98h
         X/Q6JeK0cyueZaLleVAsw/AXaT4zKEIJmobxui02H2iRJwR6JQ6k+7ohKUH/xkhZtcrk
         AUpJh1ywhRU6oaywvvX2nXCy9HlVnkwENOYB/cohnRCUpdHTb0Po2TpaAZ5v/3eSZpRI
         8V3uh9/QGNOkIwreJn4bL+pCGYZydEDpnqKywmkmy4aH4tbxUO5DJdIr7F4HLJ2A0sqA
         ygzmFWm5Okq9v0BfBD825f1vPnJFQ6RvtJm08BV2t1iAQ4uh6Zl3udb+YoU4MJmQj7Nw
         WjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
        b=xdbie/t1TTMHp9Rv0yeo4vf18XPyu2/i7hDEoZk421l1dMAwza+8JE2hd+8sxRGGGr
         G66OYdZHErGGxyXgl2SXMs1d7oKQhIywdGe30zKoaxh0zyokWZzDasC0o9q44rgjpNV9
         V5P4FYP/6foKrAPNO5H60B6i6+sB4E1O+7iBm/vmGOB4U8O8/febRCvCAv1SM0ON924S
         gj/77c/W6JA+PjoPp60uzyIYta4hctUZRjezo8U60pNMtR0NfbvfPvdCHVDz/znAPw7M
         DkN/0O+qupScna8XjGHauZmBXcYfA3+LXDR8ta1b1UHD7VJl/O6t8ldAo5VKPTMb6A88
         4P7A==
X-Gm-Message-State: AOAM531SkgbNoOQTcYi5CJOnefva3hFt11TwBVD/v8+H0Y7916/HiRML
        Z15VoHJ3OuuUcVH86jTjvyB3SnCFQuO1pg8F9Lo3mw==
X-Google-Smtp-Source: ABdhPJyGFtcTnW/NcVjiSH5pncdxregmswvMZp0GGEC99SZ7f8Vh58bATLOZJ9aYCBUx/N4xWCbII0nzMB7q2Ks2bo4=
X-Received: by 2002:a63:5401:: with SMTP id i1mr6259530pgb.356.1637704203058;
 Tue, 23 Nov 2021 13:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-21-hch@lst.de>
In-Reply-To: <20211109083309.584081-21-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 13:49:52 -0800
Message-ID: <CAPcyv4htTDV10OkdXfWJzES2dUdm+7PDsX6LPYSxEYFnNVeMwA@mail.gmail.com>
Subject: Re: [PATCH 20/29] ext4: cleanup the dax handling in ext4_fill_super
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Only call fs_dax_get_by_bdev once the sbi has been allocated and remove
> the need for the dax_dev local variable.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
