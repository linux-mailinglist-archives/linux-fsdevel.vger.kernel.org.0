Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7F628139
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 14:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiKNN0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 08:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiKNN0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:26:08 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CCD186DB
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 05:26:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f7so17286526edc.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 05:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7bOKX5TmubEFskw4ICGVY0HuA0Ifnh0YrvDjw0FPwIw=;
        b=plr7sz64IIJ+YKeOBQwdEF60I8YYhToAoTtQSWJnUoDLY3YmH8HfsKQMiRS9gK73Ap
         r4o35wxvxQ6WKXnvBasNO/C727QB0hG+oUbtEvc40Q2oGMS47LDr9i3Y0bj4F4FfJgfs
         5JPmJw9gEHSraq/4D6scIf/o/11djiYIPp+bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bOKX5TmubEFskw4ICGVY0HuA0Ifnh0YrvDjw0FPwIw=;
        b=cUeIVQAEz8zg3LNRRxBbL3uX+MxSeoF/5EY54qbWtTE//DDJNIi9hTM1pccwUfd9MH
         lofl5WLaFAgqOj/IcbL8sprwtd+AuEuHro1Z+e88XfISgP6+EbpD8SdJ2/gAKjp5Empj
         hXqzxwS7IBwuPaZ8DI8TqshnrZTfxETtlayYxrC07wpVDVQ1u5aZNqKTPuM43Z+zjGiA
         ZGafp2ZZua+T7r/eW3kHdAyaFlO+G2KE6wetd0wbeYzXiBbfzLDSxx++ScWoII298Ihg
         apDDnT21L8VwskEkkLc+1RBpr5M+G69ywIdrXd0pY8PlfjU+FTzUOSfdl+O5dU5HWAAF
         7yvg==
X-Gm-Message-State: ANoB5pmUArH/rbukNq6N1X5zG5GP95EmVuljvVRFXPZOFL7clsuklppj
        oYS8LCX9FlEwo8z+lzaOkRzVMAWbY7ohHx6TZBAUJw==
X-Google-Smtp-Source: AA0mqf4GhiAmKUpwyR2O1bQEFuhJCU40aqld6qS+QNo0yXE8Q41MRiyRCsE8OEKSd35zVlY76dQfoEvIt9lj16tvF6E=
X-Received: by 2002:a50:fa9a:0:b0:467:6c56:df3e with SMTP id
 w26-20020a50fa9a000000b004676c56df3emr9602096edr.270.1668432361653; Mon, 14
 Nov 2022 05:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-3-vishal.moola@gmail.com> <Y2FkV0wogVhMHkkO@casper.infradead.org>
 <CAOzc2px2POjBU-6X=YB+rd-87vhDx0cUu0m8EFWA=Q_Peu1gUg@mail.gmail.com>
In-Reply-To: <CAOzc2px2POjBU-6X=YB+rd-87vhDx0cUu0m8EFWA=Q_Peu1gUg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 14 Nov 2022 14:25:50 +0100
Message-ID: <CAJfpegtRCngZtKpTuL47bvjrzisV2wPY5pwZkPJPqD=HGnW+vA@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: Convert fuse_try_move_page() to use folios
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Nov 2022 at 19:36, Vishal Moola <vishal.moola@gmail.com> wrote:
>
> On Tue, Nov 1, 2022 at 11:24 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Nov 01, 2022 at 10:53:23AM -0700, Vishal Moola (Oracle) wrote:
> > > Converts the function to try to move folios instead of pages. Also
> > > converts fuse_check_page() to fuse_get_folio() since this is its only
> > > caller. This change removes 15 calls to compound_head().
> >
> > This all looks good.  I wonder if we should't add an assertion that the
> > page we're trying to steal is !large?  It seems to me that there are
> > assumptions in this part of fuse that it's only dealing with order-0
> > pages, and if someone gives it a page that's part of a large folio,
> > it's going to be messy.  Miklos, any thoughts?
>
> Miklos, could you please look over this patch?

I think this should take care of the large folio case in fuse_try_move_page():

    if (cs->len != PAGE_SIZE)
        goto out_fallback;

The patch looks okay.

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
