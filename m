Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B35BD6BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 00:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiISWEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 18:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiISWEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:04:11 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEBF4B0F8
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 15:04:10 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d16so393457ils.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qNYV3IV0I9YzwwSZ2rZyAqVFa5Tlo4vYZXx3dOJbGyE=;
        b=Qty/UGzJPzVpzuR8ZRGWaw4OqK7+0psLp6IlAAoHmqCoiibLIWcxZuG8kLn+fkLEFf
         j/OkpRK2jaOifDUN+9QU1sLJzZG10d8Ive2+Vyhj3ozLNNAvGJJVfFpjwZsIKarZ8e7G
         Y6gREMq9sCfacCLE+zsycgHlfjdEoEio2VGOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qNYV3IV0I9YzwwSZ2rZyAqVFa5Tlo4vYZXx3dOJbGyE=;
        b=bODJc5Ia8R2n3e7CcgXzcgGygcN4RoV5P4kPxNls1VPK1G9rDjVzzW4CClZJwl7Jj3
         4Xsk5lAC8R9hG3825Smc7/Bu71DooXMmtJSHRXXbYkxomDe9wohHMe9oWehI5cdSbUNw
         hRqvzLyPemp9DHJClp4zAMsH6OK3zCEHwJwo0reGt/kuBXiQv9lqmKZK+hdbxo9tq8bH
         JvSilzsiQTVrPdVBbSonLGTqfymCxrg2fFXIzZ523lDIiYHcedrTcppvgJ2/l8H8qno1
         EXT19l7EyJiC43+MAmW5zgOCQZ54CuPjQPNsCADtm434yh18U9MU4Mk8TqSqk3Gy7R8Q
         Ad5w==
X-Gm-Message-State: ACrzQf2hYDU7K1sKIl/isKtzvICpK4CCYlFRsvnxY21sRjSXSYe2XarB
        Rr10LgIPBC9GvllBmd4vdk0Pid8CgGbo0kTINKgcnw==
X-Google-Smtp-Source: AMsMyM7LQVYifqh7kE/lADrhv3OXw2zz5b3jicXubBcTn9EEtcWrTDVFPfIfJi7sCxwDcxdMdpMrXH+1MtaBN4Yl/6A=
X-Received: by 2002:a05:6e02:188a:b0:2f5:3486:e6f4 with SMTP id
 o10-20020a056e02188a00b002f53486e6f4mr5779885ilu.65.1663625049588; Mon, 19
 Sep 2022 15:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220916230853.49056-1-ivan@cloudflare.com> <20220916170115.35932cba34e2cc2d923b03b5@linux-foundation.org>
 <YyV0AZ9+Zz4aopq4@localhost.localdomain> <CABWYdi1LX5n1DdL1B7s+=TVK=5JDMVyp91d3yRDA0_GW4Xy8wg@mail.gmail.com>
 <Yyhg3L3S0e3zvnP5@localhost.localdomain>
In-Reply-To: <Yyhg3L3S0e3zvnP5@localhost.localdomain>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 19 Sep 2022 15:03:58 -0700
Message-ID: <CABWYdi0_cdketW=Rc-6s1n7ZQ4ALJL7EuOquUSjOGNb5oVjvRA@mail.gmail.com>
Subject: Re: [RFC] proc: report open files as size in stat() for /proc/pid/fd
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 5:30 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Sat, Sep 17, 2022 at 11:32:02AM -0700, Ivan Babrou wrote:
> > > > > * Make fd count acces O(1) and expose it in /proc/pid/status
> > >
> > > This is doable, next to FDSize.
> >
> > It feels like a better solution, but maybe I'm missing some context
> > here. Let me know whether this is preferred.
>
> I don't know. I'd put it in st_size as you did initially.
> /proc/*/status should be slow.

Could you elaborate what you mean?

* Are you saying that having FDUsed in /proc/*/status _would_ be slow?
I would imagine that adding atomic_read() there shouldn't slow things
down too much.
* Are you saying that reading /proc/*/status is already slow and
reading the number of open files from there would be inefficient?
