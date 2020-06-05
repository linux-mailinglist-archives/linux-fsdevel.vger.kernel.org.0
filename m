Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E051EF639
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgFELLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 07:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgFELLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:11:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19256C08C5C2;
        Fri,  5 Jun 2020 04:11:10 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k18so9862124ion.0;
        Fri, 05 Jun 2020 04:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=1GKHLWvpFNoUWFlXO7nOa3ze1UpYMNpnsUeV0FBF7UU=;
        b=OfNiz3jf+Vxz6C0L41VVz29Y/Zb5tN0TMhtnQAjYTKvMCCs/ws8UP8hwOPAckgdmEg
         taAfHT1DirHPEHOUZm9Jx+oUCIOTf5d64c5hgePpe4UNGjpVKX6hrAvM0f6+S+xx18qz
         LyrSh+BKkam+wlDUcxWPS+XVT7Ol7aZIs2/xquZWkI4YCLrCxE6HZsY7WKVRTJQfkYd+
         q+57Cn0saXtASzVXzI7etV1G2HmZJS5dY7J2jDJnoMt75eMs6HJhBe/Urj2BdpnUkhKS
         nJUzZLDDhpPGNz7PiS4UqVwzH8uTlxZVaJVwnCO7jksfKNt+c46sxo4mxAhhoLejtr/F
         TYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=1GKHLWvpFNoUWFlXO7nOa3ze1UpYMNpnsUeV0FBF7UU=;
        b=KowvldTyy7+dZYiGeFbHeeuDgHwicmYhQXWtioYum0wUZl1s4uHidxRz9NHHbNv4i1
         eFA64OZEF/ZXUp++6Yk683MMhvmSOjXDXa7DJXtO0NLsqnMQ6bScelTbW2lm/VdLyXHF
         9+CdgkSD78wREFpJhj6fwAtApcS9IqjHN+S+Y7qEK8d2LjavQwXR8MXnDijm3xRi5gWQ
         jzylIz0BJqD1xUl0Xw58ygp2PP4fZFrpSFfkk84MMjebwH02VGbBWfIGCymWPPU+ivDD
         34tlUUeLxca+gfc7MJSUMhoWIUCG7ykQNrWyJM5eJIIeLk0nH/DyFxlJYmehEFPJ+TQc
         Gvbg==
X-Gm-Message-State: AOAM5339QmuMuk6EMsQKEms8z57b1irQ1jeOEsmS0/3RufLCCMmLCjXy
        ++OPxjhIyCdTPUdoC4tNNYbH0kxglLfeCKKzKGg=
X-Google-Smtp-Source: ABdhPJz6FfjkRT/DaW1LV+bW2+wEb1gHqRDisnlPRPITT/0TQtcZIgwyPFeBvowh+QbVY4PVz6JcQxsL7Q/YQinx2jQ=
X-Received: by 2002:a05:6638:406:: with SMTP id q6mr8192265jap.125.1591355469426;
 Fri, 05 Jun 2020 04:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de> <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam>
In-Reply-To: <20200605094353.GS30374@kadam>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Jun 2020 13:10:57 +0200
Message-ID: <CA+icZUVFQaXGVtfGEO2=covaaRR2iKOTASsLEXv7+CsV5ibShQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: Fix use-after-free in blkdev_get()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jason Yan <yanaijie@huawei.com>, Jan Kara <jack@suse.cz>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hulkci@huawei.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 5, 2020 at 11:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> A lot of maintainers have blocked Markus and asked him to stop trying
> to help people write commit message.  Saying "bdev" instead of "block
> device" is more clear so your original message was better.
>
> The Fixes tag is a good idea though:
>
> Fixes: 89e524c04fa9 ("loop: Fix mount(2) failure due to race with LOOP_SET_FD")
>
> It broke last July.  Before that, we used to check if __blkdev_get()
> failed before dereferencing "bdev".
>
> I wonder if maybe the best fix is to re-add the "if (!res) " check back
> to blkdev_get().  The __blkdev_get() looks like it can also free "whole"
> though if it calls itself recursively and I don't really know this code
> so I can't say for sure...
>

In things of Fixes: tag...

For the first hunk I found:

commit 8266602033d6adc6d10cb8811c1fd694767909b0 ("fix bdev leak in
block_dev.c do_open()")

- Sedat -
