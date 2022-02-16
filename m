Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B014B7C7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 02:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245495AbiBPBee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 20:34:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245490AbiBPBec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:34:32 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195AEF955C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 17:34:20 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v22so96883pgb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 17:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvTayVguxhrumT3w+R+Kjfmd3diECndIkorPQyxblp0=;
        b=NFjoQ+hOdtNnkcduj0LnOAfr0t13qJU0g+H3qDYhxHXNY2kSOBhjJ57id3nggkZ63z
         bd+0no5Sz1hfOpOM7FqU7/lcj3mw/zA9iIJGXn1/3gABVkhTJwDuVFXiLCiF+AoiAuvP
         xzHa0AMAlBDyRB3g8rVKOe7JL6peWAms2JmtnTljT+4i1CykaarkkcY2Phufrs+l4f98
         tIBmQaYCJwnUN4p1EvcyxZr3Y2TIDezPhrxlygMSyqcqJutwde5Wmrbzs8FUsbjeBtAE
         KAXJkvUlQ4SnUi7Ml0QZWal8mO29LLZbB5qS5ZaYGR1b1d2ZM10qVKD8leaATzhRe6MQ
         OvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvTayVguxhrumT3w+R+Kjfmd3diECndIkorPQyxblp0=;
        b=wFyRFoDXEZxQ/+i43aLjT+G+xHmuBJF3L02m82YDH9nF1C4fpkEx14o0WfAB8vfeFz
         H0mqcqNC3eqUn9I4Hl9avev7e7WfPhpophOPVth4b0e+wRhoYzVbURnkgab8mJy7ltbI
         XcDMnvyLjOoxzMZOWLIuhe52T0anRS4VRb5dyl/LnrVubqr0ElXF9x+tSAhI+k+YG9de
         qZWkLzRVlFkQ2Ke3bKKKZ9MvKWUjlvAI4THo/5Gp3LS2nuzbVPUI0ilfoozXPIG2LXmW
         nyi7dOIouDEwFWOlIfToO7s6gAxWsVmvbGDcj6Y3vGCTU+zBR/OxE//pnTqglAVExZtE
         x0pA==
X-Gm-Message-State: AOAM5308wRDwXP4+rQIhf2Ko7UDWs1fcukif5n2ZWoP44AMg6yu2pmgq
        agvcj7jY/kWH0xJHnb95uTSCi7Z7T1OfXmRKjYbGTJhJf17zVg==
X-Google-Smtp-Source: ABdhPJzAqkHS4nuPDQC4F8eXmkoN7S6evLhsGsn+9OiK2Onw6wqEebsZdEzEmmlrTDiHX9fR4bL6Yj1AYLHUkW1bqes=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr370669pgb.74.1644975259581; Tue, 15 Feb
 2022 17:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com> <20220127124058.1172422-6-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220127124058.1172422-6-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 17:34:12 -0800
Message-ID: <CAPcyv4jWuWWWBAEesMorK+LL6GVyqf-=VSChdw6P8txtckC=aw@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] fsdax: Introduce dax_load_page()
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 4:41 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> The current dax_lock_page() locks dax entry by obtaining mapping and
> index in page.  To support 1-to-N RMAP in NVDIMM, we need a new function
> to lock a specific dax entry

I do not see a call to dax_lock_entry() in this function, what keeps
this lookup valid after xas_unlock_irq()?
