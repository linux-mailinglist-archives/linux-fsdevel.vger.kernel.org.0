Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE58744B941
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 00:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhKIXPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 18:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhKIXPc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 18:15:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8318E610F8;
        Tue,  9 Nov 2021 23:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636499565;
        bh=Fom+Ax97u7w3PNz5gEkObwZv8n8uQp3HEcHMODzeDQY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=aetsznP4yOAsjEQs7jqrWe6yQsbp+tTxzOitiv/Hw5E2wMyPmezTQDAIUJiIV2cZg
         UJ6w0phW3JPyplEc7cfmmMNxl/qHOt4CHVy3sN4ltMmAKqZNuFdchdlXCHEalcn4uk
         G5kVk4hiejqtOY5s+l2GHH9mgV839wlro8Pzsa6O3Myq/1JuV+9LYQ43tS2f6IfgDu
         F2A0Js1WiDGRlyp+v4WQgRMx0PBjDWAjRjGmIwFYYvBh9+Dv4EPoWCDBd0q1DqsPt7
         Rsk+LAuN/kJkjQruQd6yaEl6VoaYM7CQ5wp4VX1qvzF8PjO3JR6wvL5OQ5vqqvx59G
         6UvaAtQZ9B6pg==
Received: by mail-ua1-f51.google.com with SMTP id b17so1084921uas.0;
        Tue, 09 Nov 2021 15:12:45 -0800 (PST)
X-Gm-Message-State: AOAM533KECI8xdGQFFEdcYpFXDEF73mii4fT3WDTDTDN2EYvnSP70O3+
        cRP4l1onKipXs3Tp0Q9UGqFyPl5Vyvxn8FN7ZVI=
X-Google-Smtp-Source: ABdhPJxuXdjeYFdP2XLe30D3LVXr20BcPrblW7q+ZORd5K8SzYaxNACcJ+DOxlzHLmwok6f+53C26ggQDT241Gok5uU=
X-Received: by 2002:a67:e40d:: with SMTP id d13mr69103151vsf.11.1636499564639;
 Tue, 09 Nov 2021 15:12:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:b20c:0:0:0:0:0 with HTTP; Tue, 9 Nov 2021 15:12:43 -0800 (PST)
In-Reply-To: <YYp40A2lNrxaZji8@casper.infradead.org>
References: <CAKYAXd8KvqTQ-RnmWPFChmMEKGw9zA37chPM0H=FSewfRqx1zA@mail.gmail.com>
 <YYp40A2lNrxaZji8@casper.infradead.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 10 Nov 2021 08:12:43 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-zxdAiM7A0b=Zy-hycJ66dPxPYt7zG_-_u+fSYms5FTQ@mail.gmail.com>
Message-ID: <CAKYAXd-zxdAiM7A0b=Zy-hycJ66dPxPYt7zG_-_u+fSYms5FTQ@mail.gmail.com>
Subject: Re: Hitting BUG_ON trap in read_pages() - : [PATCH v2] mm: Optimise put_pages_list()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        Hyeoncheol Lee <hyc.lee@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-11-09 22:34 GMT+09:00, Matthew Wilcox <willy@infradead.org>:
> On Tue, Nov 09, 2021 at 07:45:47PM +0900, Namjae Jeon wrote:
>> Hi Matthew,
>>
>> This patch is hitting BUG_ON trap in read_pages() when running
>> xfstests for cifs.
>> There seems to be a same issue with other filesystems using .readpages ?
>
> The real fix, of course, is to migrate away from using ->readpages ;-)
> I think both 9p and nfs are going away this cycle.  CIFS really needs
> to move to using the netfs interfaces.
Okay.
>
>> Could you please take a look ?
>
> Please try this patch:
Work fine.
>
> While free_unref_page_list() puts pages onto the CPU local LRU list, it
> does not remove them from the list they were passed in on.  That makes
> the list_head appear to be non-empty, and would lead to various corruption
> problems if we didn't have an assertion that the list was empty.
>
> Reinitialise the list after calling free_unref_page_list() to avoid
> this problem.
>
> Fixes: 988c69f1bc23 ("mm: optimise put_pages_list()")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Tested-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 1841c24682f8..e8c9dc6d0377 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -156,6 +156,7 @@ void put_pages_list(struct list_head *pages)
>  	}
>
>  	free_unref_page_list(pages);
> +	INIT_LIST_HEAD(pages);
>  }
>  EXPORT_SYMBOL(put_pages_list);
>
>
