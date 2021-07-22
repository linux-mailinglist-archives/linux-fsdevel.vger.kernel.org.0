Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07133D24CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhGVNF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 09:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhGVNF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:05:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71314C061575;
        Thu, 22 Jul 2021 06:46:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u13so8570455lfs.11;
        Thu, 22 Jul 2021 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S5FBe7ueCEgBBBcVlYIV5ZQBPwUEDI96bGTpteUkpVg=;
        b=ODQJCwhH4fpxxhVlyvc7qpPwR4JZiWsrgG8NvFvy5X3NG25wTU6ksHsU1cL8b1QGuU
         tp875eIubB65RbEhE7PNrtCX89VD3dgDJHWmRbjJ9fWOo3S8i12JKyydfYJK5k8O4IOE
         KTHILQtAAJA7SsGOAWfryjyQXAaZZg4ZS8+7xtQnzgv4DZGAUwMf2/poxEvFSI8dteOf
         5V4oFyStMw5PiChxrAqttDR6C45175WAIq1FLMI6wrOKrPLTvI3CtdF7ipHlFsV8/MWo
         u3I7bty7jolpesArC0A8mwuHZEK3ccnYiL+3b7KRvvG4ZsPH2OnVhIcDTlGXByw1z8Qv
         mkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S5FBe7ueCEgBBBcVlYIV5ZQBPwUEDI96bGTpteUkpVg=;
        b=qKsoV6DOtwq/IYHkfEmOL4V+oAkfvmyeGpG9qGGasShQzmKMT32D07B+AqhlZaiyhZ
         wOrsxgaPVkepUi7KGsNrEcm2RHufFt0eM1cRlKqE8wKel8TlsmpEjSVu7OZPkmrNjx3D
         pykGXLHUxkvsLeXxK1NmOOWneD1aKqxHOlPIhLUKOGUfwDEwk0BC1BA8zDZMxAOHirQd
         kMdZHpfG2PQfmawrkIctM8dLOsErxoZsvRQ1iONMIZ99L6+vbU39ZIi7dGLRx4mYyy/A
         KqeJOAeeZO2V2XqHGASfqZRrZ7FdhbNbsv8z0byZt5x8T5I8aIogKGYcKWxZfE74W32L
         EHMA==
X-Gm-Message-State: AOAM532SRjaHJft8Tq+k7DfwjKLNBvwTyy/AGvbMdloHH+aNpVxZfJep
        +3GVvXwh7p68UA8FWnPP0QY=
X-Google-Smtp-Source: ABdhPJy36a3gqQAyT0+tVLg1bfWSzgW5dYJ2GTCxgOvalOUdOoeV5NbZ3uVv5LxINryzPiIxhI7AOg==
X-Received: by 2002:a05:6512:3326:: with SMTP id l6mr28891434lfe.658.1626961560871;
        Thu, 22 Jul 2021 06:46:00 -0700 (PDT)
Received: from [192.168.2.145] (79-139-184-182.dynamic.spd-mgts.ru. [79.139.184.182])
        by smtp.googlemail.com with ESMTPSA id d23sm3102281ljl.115.2021.07.22.06.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 06:46:00 -0700 (PDT)
Subject: Re: [PATCH v14 062/138] mm/migrate: Add folio_migrate_copy()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-63-willy@infradead.org>
 <a670e7c1-95fb-324f-055f-74dd4c81c0d0@gmail.com>
 <YPlko1ObxD/CEz8o@casper.infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fd3fe780-1a1b-1ba7-1725-72286470ce4c@gmail.com>
Date:   Thu, 22 Jul 2021 16:45:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPlko1ObxD/CEz8o@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

22.07.2021 15:29, Matthew Wilcox пишет:
> On Thu, Jul 22, 2021 at 02:52:28PM +0300, Dmitry Osipenko wrote:
...
> The obvious solution is just to change folio_copy():
> 
>  {
> -       unsigned i, nr = folio_nr_pages(src);
> +       unsigned i = 0;
> +       unsigned nr = folio_nr_pages(src);
> 
> -       for (i = 0; i < nr; i++) {
> -               cond_resched();
> +       for (;;) {
>                 copy_highpage(folio_page(dst, i), folio_page(src, i));
> +               if (i++ == nr)

This works with the ++i precedence change. Thanks!

> +                       break;
> +               cond_resched();
>         }
>  }
> 
> now it only calls cond_resched() for multi-page folios.

...

Thank you for the explanation and for the fix!

The fs/ and mm/ are mostly outside of my scope, hope you'll figure out
the buffer-head case soon.
