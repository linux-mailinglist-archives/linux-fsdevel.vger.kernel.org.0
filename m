Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD3A9438
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 22:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfIDU4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 16:56:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37219 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDU4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:56:36 -0400
Received: by mail-qk1-f195.google.com with SMTP id s14so11621qkm.4;
        Wed, 04 Sep 2019 13:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rwFcbv8ysatmI5tLrkRcCFyc0txYVdfJq7aSGtxta8=;
        b=uVL9Sh+brLAh2oENCqd9GJim4fJD6f/2ZPJbt6Puxmi4psn+XdiHSLo59Ugh36kWQt
         MljWnlBoyhSXZD2ykdPQ7Q4iiPGItBMpJ3sEqC/qIY8Rsa7pXe0uxpCo1DEc47zTUksr
         jACC6ZOq8Kt+wMprg4K5HzSmurXTfIuOWu3MV023tb5g2U53QY4Jy+WCN7b17fH2/2bQ
         wYIo71njSc8A5L1CGB9kGGyP+bTUWPbmPHZ5ckXVjILvjRgrbK5url9teLhbenoPwL1I
         q//vl1FZFeJGsF6VKcH8UdXS/C5VY1ryreYWlVPyXt1Dz8kLTFlVCvWdBszWXefGVRCS
         GZEg==
X-Gm-Message-State: APjAAAW9gKeRQ+jh0dDndqBfsTMWn++Nfq2ppvbPkpZpFt6wtRgBrBwT
        /mcU1ArHaS6b9ND6f9cO+WHBPORm7bjgXr2dXRI=
X-Google-Smtp-Source: APXvYqyNf6/R0CbOS/YJtFLQ3Jl51yOjJsflDfUUqw3iFf5p9kL3WvWb3FQ6id+qoirrK19x8FXOv/jcWr5ZQm0ML2c=
X-Received: by 2002:a37:4051:: with SMTP id n78mr40135453qka.138.1567630595588;
 Wed, 04 Sep 2019 13:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <31a671ea-a00b-37da-5f30-558c3ab6d690@thelounge.net>
 <20190904150251.27004-1-deepa.kernel@gmail.com> <ECBC97E7-53C5-4B4C-BC4C-1FCDC4C371B9@dilger.ca>
In-Reply-To: <ECBC97E7-53C5-4B4C-BC4C-1FCDC4C371B9@dilger.ca>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Sep 2019 22:56:19 +0200
Message-ID: <CAK8P3a1YnNbzoRE_=3_F9ppqNaS7TO3a+ccN7mCgwjSUuNcW3w@mail.gmail.com>
Subject: Re: [PATCH] ext4: Reduce ext4 timestamp warnings
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Qian Cai <cai@lca.pw>, Jeff Layton <jlayton@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 4, 2019 at 8:39 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Sep 4, 2019, at 09:02, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > When ext4 file systems were created intentionally with 128 byte inodes,
> > the rate-limited warning of eventual possible timestamp overflow are
> > still emitted rather frequently.  Remove the warning for now.
> >
> > Discussion for whether any warning is needed,
> > and where it should be emitted, can be found at
> > https://lore.kernel.org/lkml/1567523922.5576.57.camel@lca.pw/.
> > I can post a separate follow-up patch after the conclusion.
> >
> > Reported-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>
> I'd be in favor of a severely rare-limited warning in the actual case
> that Y2038 timestamps cannot be stored, but the current message is
> too verbose for now and I agree it is better to remove it while discussions
> on the best solution are underway.
>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Agreed completely.

Applied on top of the y2038 branch now, thanks a lot for the update!

This should be part of tomorrow's linux-next then.

       Arnd
