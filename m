Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B86C53CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 19:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCVShH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCVShF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:37:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3305962D95;
        Wed, 22 Mar 2023 11:37:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so1326584wms.1;
        Wed, 22 Mar 2023 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679510221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=StzG7MvS76Lz0lBTU33p2jJvbMwPuAHgPRJM3LdxuNs=;
        b=aU6w9ZbUGKtdWGcoRQ56YUNSi0tRdOA9APCN7zpdjeqKl+bu6dBkgazF9AsWQvEkhE
         cNXKG7OV+BYiQwDI3dZARsofXPglM5HBiarE/j0Zq+8afO/Xj0a4mOHzL5qZWXUm5tBv
         gtV00qDhtPOAlEBU9e6bJ6Wdshde/99A9Qp7UkxvIOgRmlEBzspB6I6oU1e0huMHFYVk
         YsbgMAZV0eNAaEkaKMu10mcHh/Surpwm19K567I2iuGSEiK58cs57V0I6RhHtWs5NUOI
         NCFqNmm5p34nAipecCiAsCp10lH8Fe7pcgdV/t0xHzpM7yveh6wW+K6hguLsYwJ+vJ+7
         HWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679510221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StzG7MvS76Lz0lBTU33p2jJvbMwPuAHgPRJM3LdxuNs=;
        b=qT1CNkXPecENLcZfU1Vkrua/cyerqiAzdCHNCMqnYmYepLn9/CJ7P9TeqStOiSK/Rj
         43VxGKzQcETIYE4HUFUi7VfHiAG4boHYnWFFrDsDdHLp3NmBcxNt9Gm/HMrCOQewpa+S
         F2O0HsOaym6dfxo/Pn2+bn0niyXGFdeE1Mn4vsRl9PFF7m9P/Ox8uZK+q96w6X4mu6oM
         464l5sbQo2ZR34O99dnWw3NRqU66u3khb2wIXQFrbt5p+H1QZbauibPgHSs8tnXSDbY1
         r8y9vWHT4xesDGG7k89dQvDiLdnuB7clCU1GQmtKBan7pxTywan8nIWkIT1ezJk/GsNF
         gOVg==
X-Gm-Message-State: AO0yUKWAmjekTgV/Oe1mnd8Eanwr8IpIQEZrIwQjx0E8fpGK6kMiBc/L
        rx/ySZYNWPpjPq7CGd+qNMY=
X-Google-Smtp-Source: AK7set+hKMIITZa3MkGfMXD93+CnbtF/QA2NO2suRtRzNOKQkYMslJNwGhDl52TL2tdQ06VsoWUTSQ==
X-Received: by 2002:a1c:7c18:0:b0:3ed:8bef:6a04 with SMTP id x24-20020a1c7c18000000b003ed8bef6a04mr393679wmc.27.1679510221426;
        Wed, 22 Mar 2023 11:37:01 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b003eddf30bab6sm11699959wmo.27.2023.03.22.11.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 11:37:00 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:36:59 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <bad5dc54-f614-430a-a6a2-e96fea6ce1ec@lucifer.local>
References: <cover.1679496827.git.lstoakes@gmail.com>
 <4f1b394f96a4d1368d9a5c3784ebee631fb8d101.1679496827.git.lstoakes@gmail.com>
 <3e2d1f69-5cd8-8824-0a2e-a1c2c9029f66@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e2d1f69-5cd8-8824-0a2e-a1c2c9029f66@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:02:34PM +0100, David Hildenbrand wrote:
> On 22.03.23 15:55, Lorenzo Stoakes wrote:
> > Having previously laid the foundation for converting vread() to an iterator
> > function, pull the trigger and do so.
> >
> > This patch attempts to provide minimal refactoring and to reflect the
> > existing logic as best we can, for example we continue to zero portions of
> > memory not read, as before.
> >
> > Overall, there should be no functional difference other than a performance
> > improvement in /proc/kcore access to vmalloc regions.
> >
> > Now we have eliminated the need for a bounce buffer in read_kcore_iter(),
> > we dispense with it, and try to write to user memory optimistically but
> > with faults disabled via copy_page_to_iter_nofault(). We already have
> > preemption disabled by holding a spin lock.
> >
> > If this fails, we fault in and retry a single time. This is a conservative
> > approach intended to avoid spinning on vread_iter() if we repeatedly
> > encouter issues reading from it.
>
> I have to ask again: Can you comment why that is ok? You might end up
> signaling -EFAULT to user space simply because swapping/page
> migration/whatever triggered at the wrong time.
>
> That could break existing user space or which important part am I missing?
>

Actually you're right, this is not ok. I was being mistakenly overcautious
about spinning but in actual fact I don't think this would be an issue
here.

I will respin with a while loop so under no odd timing circumstance do we
break userland.

> --
> Thanks,
>
> David / dhildenb
>
