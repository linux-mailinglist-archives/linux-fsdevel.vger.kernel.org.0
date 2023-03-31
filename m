Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55C86D1513
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 03:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjCaBmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 21:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCaBmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 21:42:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7CDEB72;
        Thu, 30 Mar 2023 18:42:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id iw3so19865885plb.6;
        Thu, 30 Mar 2023 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680226962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tfm+hbs/jl6LALmLyvo0+JGmZiFpCrqmfVmO3EjPG/U=;
        b=TrpXzdzRu5jUI7LHqyu7stpCOlAN1ukTs0SqCkuDb7kbwhuIxqEh99BpwSYfmOtpcO
         SS5Tz4Aycr0UvccPQmjXBZlZRxxQps7hY11C90XxQPmDUaEAxcTa//PbYqRi6BH24jmz
         ap4WFQ+oxxdcNAkU8BuS8lj1iiIBB+dXRUxWYdYi1vawR89cMTYj7dQuROR9lfMskADY
         srkspqNZBuFQM6TZt4QIVTAGAfzhRmejGbwZfLF2PpkvxQxwDM0++PButpMJW5GorX6D
         gq6gPUhURDbB7jlw0jFwvblAxzjAdEFxNRe5L8ox/WEJruXEcOWqM/l6N4mfjbhQ7TVq
         4g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680226962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tfm+hbs/jl6LALmLyvo0+JGmZiFpCrqmfVmO3EjPG/U=;
        b=myFxY0tT8Ju05TOWSiHLjBLbhv5eIlEsqnJDbe3wEgxDHf0jXrNoR2jOsgdGb68HRm
         O0MarRwQ9KVMMZAkS87cFmDYR5nBFJxp7y++pB2dPHUbE7NGGVQ54fkJSGftpVASA1qo
         gjd0pQFsj7+XAG69GBn5tr5hSndbzZC4do26QhzwHYEOviIPdnCbjrMnX0o9M2KcFYjk
         9//Sn7HB+P+b9PhhHsPMITr+VZfXdodcEGUHRZBNnwO5VPHzaOYoxk2im4iCIR4UMMNP
         S42+yAOTZSj8De2k+gdlDqA7LGUJpQXKJDKRh757LjK8BwYtkjQcZNXjkRw0fAkCy5rj
         raAQ==
X-Gm-Message-State: AAQBX9cy7+gg9iwyJeZYIhHcLtuIiACOZ7TuQgvVIxfH+dXy2jSNFqQs
        y16cHXiQJAZ0yCc0Y9QOYPo=
X-Google-Smtp-Source: AKy350buo2Zzy4xjvCuquW12XdoWy6na2heI1Y3+soPRp1dbwTzaLnv9aqUFtI85XkcfPJ1kEr73fA==
X-Received: by 2002:a17:902:d48f:b0:1a1:af64:380c with SMTP id c15-20020a170902d48f00b001a1af64380cmr29599940plg.27.1680226961690;
        Thu, 30 Mar 2023 18:42:41 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:93aa:8e39:c08b:8c2c])
        by smtp.gmail.com with ESMTPSA id bf5-20020a170902b90500b001a2574813b8sm307862plb.278.2023.03.30.18.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 18:42:40 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 30 Mar 2023 18:42:38 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, martin@omnibond.com,
        axboe@kernel.dk, akpm@linux-foundation.org, hubcap@omnibond.com,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, brauner@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-mm@kvack.org, devel@lists.orangefs.org
Subject: Re: [PATCH 1/5] zram: remove the call to page_endio in the bio
 end_io handler
Message-ID: <ZCY6jsKdhOXGkYYT@google.com>
References: <20230328112716.50120-1-p.raghav@samsung.com>
 <CGME20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1@eucas1p2.samsung.com>
 <20230328112716.50120-2-p.raghav@samsung.com>
 <ZCYSincU0FlULyWJ@google.com>
 <ZCYYSdpmWRJynC6d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCYYSdpmWRJynC6d@infradead.org>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:16:25PM -0700, Christoph Hellwig wrote:
> On Thu, Mar 30, 2023 at 03:51:54PM -0700, Minchan Kim wrote:
> > > to remove the call to page_endio() function that unlocks or marks
> > > writeback end on the page.
> > > 
> > > Rename the endio handler from zram_page_end_io to zram_read_end_io as
> > > the call to page_endio() is removed and to associate the callback to the
> > > operation it is used in.
> > 
> > Since zram removed the rw_page and IO comes with bio from now on,
> > IIUC, we are fine since every IO will go with chained-IO. Right?
> 
> writeback_store callszram_bvec_read with a NULL bio, that is it just
> fires off an async read without any synchronization.

It should go under zram_read_from_zspool, not zram_bvec_read_from_bdev.
The ZRAM_UNDER_WB and ZRAM_WB under zram_slot_lock should synchronize.
