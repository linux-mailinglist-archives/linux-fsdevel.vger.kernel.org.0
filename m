Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8731E31E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 00:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391067AbgEZWBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 18:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389630AbgEZWBA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 18:01:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505F9C03E96D
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 15:01:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b27so12411962qka.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZwwzxO17+0f92xu+E65BbQScQx/AP5VwvKaIskut9zM=;
        b=rFVM4x23qV4X2fbjmMbDbfW8BE//O63dwEI83+nf9RiCn82u2vgmzBe6uxrjX9diHX
         Xis+D4mIpGZRy+VlXibr+nvav1bnmleWViRSlsBZbD6wO47YqoG+xJKzT0DyENfn2Cf3
         6eH0qeuBR+szG69rgDH9mR+95W9t/Easz1XIfT4+usugiBihB/u2LH+4KhvPlPSr6Pl2
         aJHuPtBN+BCaPr1W1q6XU+kLH6gjPHrEtOY6dFLu/uf9aVt8HRLBgSZGW2/0FvllyUIc
         dOIHqAcLpDPd/13wn4sX0h2UaZVOwpuQqu30SmaFsjuZkRUvfkp8ypGkNZ9dK7vl6fsD
         RWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZwwzxO17+0f92xu+E65BbQScQx/AP5VwvKaIskut9zM=;
        b=KXgBDFGTE3GD9co0XlXhxBJgQGGkPQh5N4nyHfTur9Emz38gwXV7qVQ39EpOcabBtI
         avdyCkFO/xaD3REnX+ZqsU6JajGb12BN3Ie3sSaYcqdbCbkst//8zMB6U61Fe6YwoLPH
         XU54GoS0cwbd2g5vsfkD116FWjHojZQidWPL5wWuXjdvqa60+FE5bySRF6+O47jUiun9
         mnB8T4HvT8gD1JiLTBDWgszYvyqBJvvEostY7ZHOwnwMdCwzVkQ0KOnwwpkUDipuh62E
         QbnllIOF5XjS1FoLKkzdC1uYJ6wT3WPEzE6c0A9GgZREh11fNDiWt3stRcow1Ap07vXb
         KFMA==
X-Gm-Message-State: AOAM531+5T7UHJyRdOzshTitTHvYOE98pQ7v3KeepseBdHXTTxkpQSJu
        O8Jl5ASzA4DBC4qRw5rBInNeKYKkPek=
X-Google-Smtp-Source: ABdhPJwcs2lIFlebvMOJB532DIwuMysc4GxK7bOpNwv2KuUaNVUQmNah4iqFU4gIgoC9RjiPlBugyw==
X-Received: by 2002:a05:620a:13b0:: with SMTP id m16mr1032459qki.292.1590530459566;
        Tue, 26 May 2020 15:00:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2921])
        by smtp.gmail.com with ESMTPSA id a7sm841053qth.61.2020.05.26.15.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:00:58 -0700 (PDT)
Date:   Tue, 26 May 2020 18:00:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 05/12] mm: support async buffered reads in
 generic_file_buffered_read()
Message-ID: <20200526220035.GD6781@cmpxchg.org>
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200526195123.29053-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526195123.29053-6-axboe@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 01:51:16PM -0600, Jens Axboe wrote:
> Use the async page locking infrastructure, if IOCB_WAITQ is set in the
> passed in iocb. The caller must expect an -EIOCBQUEUED return value,
> which means that IO is started but not done yet. This is similar to how
> O_DIRECT signals the same operation. Once the callback is received by
> the caller for IO completion, the caller must retry the operation.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
