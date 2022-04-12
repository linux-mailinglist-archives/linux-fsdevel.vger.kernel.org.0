Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D0E4FCE59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 06:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbiDLFAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 01:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347201AbiDLFAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:00:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E460233340
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 21:57:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n18so15747793plg.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 21:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8TleCaBIhpvoj6MzJmrMyC3ucMSm6WO1y+eL8xleJY4=;
        b=fkN36mDpM4Pd1sCv3rNuy9oyYD/gLOwueus4xphJV1YDbeNRSQ8IyujzwsptiZfgYe
         QUQIV9qghorMpdWWz6Mmsr/1DpHVZ96zqos/O3uhBAyz4TBRkDPpFJ5YoWKm0lCFZweQ
         RoEFhL/uQjowL2aggfNFdXl2Ztg3A9451oiIjvEilBdbF+7t1islEN8KsPhMNJASWFOK
         SUVweWmAjr6bfH/tyV4dylbfizqkoRZTCLZaofjld5K7oDzCT9ORDsz4TyjMGKUqQ8M4
         Qet/LWoJSVXRFpDjGoHVJDsMMopWIZP4HzpS68RD9q73tLwybQtTxPuEsqT+1brdIvEZ
         etIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TleCaBIhpvoj6MzJmrMyC3ucMSm6WO1y+eL8xleJY4=;
        b=TS2Q02iJAl6KK7+WsASnpRb+zPUMoqWvwV2HuaA/cyx6lJUOoXo1V88ljskgRHKynZ
         2Gmd/JM3+gtjp6YWYUy9vhM3Tyrpra292Boyx3YIqRE/0wzwcAZ8MCMykx52k0Z9zmMH
         ozydknAkVfW5p6LWDudSvp/o2BDwKKAtWSeY0wVC2dkVYSWSs7Z9W1k3FBn6/u0UHzMI
         UTt8ksz2etLvJATc6yBheGnb+K9qEc8vEInfOXJ3f0TDsja9BLc3AEI6u5J8PWKwdDLY
         eY9uiPQ6GK3CMkjc5zEfAJFCTyBlrszSngtOdqiiO3F4o3QiofD/O+0mYe/WjCbSJ0Zb
         vOzg==
X-Gm-Message-State: AOAM531zYOcgvqPGZzeK8bjviSZJexJtQT2e6kfzqQc/dRrgisUk71mD
        pdVq05sQgQUuZSfAt6jV8vvruviIJK7C40JLOF5sJA==
X-Google-Smtp-Source: ABdhPJxBATyoJAyblOakoZzlFS+GtSy3AbBTLdouj+8YmPDRCb1cpkksbCSmeWKkXDHtWwI5LR7XG/b+KrOX8AklXlQ=
X-Received: by 2002:a17:902:eb92:b0:158:4cc9:698e with SMTP id
 q18-20020a170902eb9200b001584cc9698emr12430897plg.147.1649739467468; Mon, 11
 Apr 2022 21:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220405194747.2386619-1-jane.chu@oracle.com> <20220405194747.2386619-5-jane.chu@oracle.com>
In-Reply-To: <20220405194747.2386619-5-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Apr 2022 21:57:36 -0700
Message-ID: <CAPcyv4jpOss6hzPgM913v_QsZ+PB6Jzo1WV=YdUvnKZiwtfjiA@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write dev_pgmap_ops
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>, X86 ML <x86@kernel.org>
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

On Tue, Apr 5, 2022 at 12:48 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> Introduce DAX_RECOVERY flag to dax_direct_access(). The flag is
> not set by default in dax_direct_access() such that the helper
> does not translate a pmem range to kernel virtual address if the
> range contains uncorrectable errors.  When the flag is set,
> the helper ignores the UEs and return kernel virtual adderss so
> that the caller may get on with data recovery via write.

It strikes me that there is likely never going to be any other flags
to dax_direct_access() and what this option really is an access type.
I also find code changes like this error prone to read:

 -       rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
 +       rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, 0, &kaddr, NULL);

...i.e. without looking at the prototype, which option is the nr_pages
and which is the flags?

So how about change 'int flags' to 'enum dax_access_mode mode' where
dax_access_mode is:

/**
 * enum dax_access_mode - operational mode for dax_direct_access()
 * @DAX_ACCESS: nominal access, fail / trim access on encountering poison
 * @DAX_RECOVERY_WRITE: ignore poison and provide a pointer suitable
for use with dax_recovery_write()
 */
enum dax_access_mode {
    DAX_ACCESS,
    DAX_RECOVERY_WRITE,
};

Then the conversions look like this:

 -       rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
 +       rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1,
DAX_ACCESS, &kaddr, NULL);

...and there's less chance of confusion with the @nr_pages argument.
