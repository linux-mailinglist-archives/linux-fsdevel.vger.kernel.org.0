Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF6B4EE160
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 21:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbiCaTJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 15:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbiCaTJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:09:49 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B830A21DF18
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 12:08:00 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gi14so371572qvb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Mar 2022 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3OVG7rRs2TdxNhin07a4J/J4tSbwW3zVKWCQEqpy4T0=;
        b=RG4lduE77Jx8ZvyFt0EEudaFQPE1BG1QemD1WbZ9kW59cgVUqy0SCXMOSppS+G6cVf
         cxktuXi0BZS0Tx2g7D5YSybqxaGh43sibMhPHWEp+pI1F9ZrBxIKh8ykoQvHOKyatXvi
         O83/FHYqSuuR0U8E17Cc4cdXkpTR6pEf2jFCoCT7d88iTIOd+dNKFkCcAYW9QHVsQFtZ
         K7yZlpPoEdc/+L/xsgIOY3A4kPPItFYk+hrCwGpVsIebdDQErh3Bi962ANb6E/rDZx2o
         Rp+I8NRtEKfZAPWAMQpiN91TqH2SD1pTEFUNOiyi1jSOg0G78Ifnrn76h8iD1lTxDKk2
         ZFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3OVG7rRs2TdxNhin07a4J/J4tSbwW3zVKWCQEqpy4T0=;
        b=JONZd7vCrVTigyuQCfJrrPWuLuupYCA5+VXsQ6ZrIxpUAT9wM4NaFKQSyB6YABhmbq
         W7wdeIZcM55ZtWqPY0Y75ZI4TED7oEGpum/oCztZWJDNgIh0XWp/LTsQj+GprE8t9Mei
         9iCoNcyisYM9vo9JJBBdu0Rwzb4iPNGJEWG+gS/V1WgVobns4REeyDROherNiR8/Z6AB
         TPhM/8yH2QZAx/kp4QLq95BZWopIMM1f/Rf8OqzvArrXlVGoj2iYQMOC/kIrLR7Goe+V
         wUvRxTgeBCKXvESDzbYtF4g24S2SDe7KoIvZYqI3TpuvqqhDOYlwUCyPZMDhYdc900j6
         Xhaw==
X-Gm-Message-State: AOAM530EUvbykpAIBfT5r/UFCyIKNWtMJrJv4e8r4avoQN9oqVASwkC/
        QRdmCTWO3Q9iS7BS9xfHJtPTHQ==
X-Google-Smtp-Source: ABdhPJyZsiZ6vcPqXb9JIU/bdKv1RqimR5mlcEfT2c6Phpz4SDQIQ6ZLZZoYSIFpXtcU9pAJJXVoNg==
X-Received: by 2002:a05:6214:766:b0:441:a5df:8ace with SMTP id f6-20020a056214076600b00441a5df8acemr5388121qvz.87.1648753679514;
        Thu, 31 Mar 2022 12:07:59 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id b29-20020a05620a271d00b0067e0c273331sm78539qkp.111.2022.03.31.12.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:07:58 -0700 (PDT)
Date:   Thu, 31 Mar 2022 15:07:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     CGEL <cgel.zte@gmail.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
Message-ID: <YkX8DvWkYhBoSv+m@cmpxchg.org>
References: <623938d1.1c69fb81.52716.030f@mx.google.com>
 <YjnO3p6vvAjeMCFC@cmpxchg.org>
 <20220323061058.GA2343452@cgel.zte@gmail.com>
 <62441603.1c69fb81.4b06b.5a29@mx.google.com>
 <YkRUfuT3jGcqSw1Q@cmpxchg.org>
 <YkRVSIG6QKfDK/ES@infradead.org>
 <YkR7NPFIQ9h2AK9h@cmpxchg.org>
 <YkR9IW1scr2EDBpa@infradead.org>
 <YkSChWxuBzEB3Fqn@cmpxchg.org>
 <YkU49BQ4rPheOG0f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkU49BQ4rPheOG0f@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:15:32PM -0700, Christoph Hellwig wrote:
> On Wed, Mar 30, 2022 at 12:17:09PM -0400, Johannes Weiner wrote:
> > It's add_to_page_cache_lru() that sets the flag.
> > 
> > Basically, when a PageWorkingset (hot) page gets reclaimed, the bit is
> > stored in the vacated tree slot. When the entry is brought back in,
> > add_to_page_cache_lru() transfers it to the newly allocated page.
> 
> Ok.  In this case my patch didn't quite do the right thing for readahead
> either.  But that does leave a question for the btrfs compressed
> case, which only adds extra pages to a read to readahad a bigger
> cluster size - that is these pages are not read at the request of the
> VM.  Does it really make sense to do PSI accounting for them in that
> case?

I think it does.

I suppose it's an argument about readahead pages in general, which
technically the workload itself doesn't commission explicitly. But
those pages are still triggered by a nearby access, their reads
contribute to device utilization, and if they're PageWorkingset it
means they're only being read because there is a lack of memory.

In a perfect world, readahead would stop when memory or IO are
contended. But it doesn't, and the stalls it can inject into the
workload are as real as stalls from directly requested reads.
