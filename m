Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B152C328D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 22:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgKXVVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 16:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbgKXVVV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:21:21 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EBDC0613D6;
        Tue, 24 Nov 2020 13:21:19 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h20so549763qkk.4;
        Tue, 24 Nov 2020 13:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Y3MLcmrdxWQffIhMnyKnSmG7B3ov7cDZAqFDsa+q7k=;
        b=JkzooPxJ8GeNrayRsu98YvwsNpW2uc9rVRoj4imwYpA6JzY+Piu1EJS2IziPBdeDkF
         Ow5qmzMcHaeZs2+oG1fSVsEAssWG0DO4F1vW/5P9q+2+DEbGyYUH1jozKg00Go0h3+ja
         YVkgi/EGLciFHd/Iul8YpgRz7FCu1kfvXaFXbSFsbyZTqz8JAJ48o8dWwKmdI5uElByj
         9UjvAnbnEBhxu3Tw7tEroOvSCxNENuu6nvEC1MTUGX0lcXIIF4ARzithi6KpCvnT/fAl
         Mp0ipaM81mRq+veWggOWfzfqSyIb3Y60deO3bam/RyYuBfYbgPa2E9CAR1VR8pj1MpV8
         kFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7Y3MLcmrdxWQffIhMnyKnSmG7B3ov7cDZAqFDsa+q7k=;
        b=tqYW6H/GplPi0DfuAPOcrdaFX63IsRchs432+u1723lUqpz1hpEyQLXEn1S9o5e4IU
         l7vljLaUSZD2Ufamo3LJrAG9n2ddwKwkYFQ7+U9nwWRp1e72e5ywIi0AyZtolI6jBqEv
         Jr0WHLwZnjcYY8Rb3WYClSR2bukcbS7vvVMJsyuQP0AFBlKER6ZHKWBIrv2ioeTKrlcQ
         /lreZaLGOxdJRn6I61WX+pbOGuOog1YG0/QY28vYAkNQAKqCShmWzWIQh98vSKqo1r2p
         KNB9pB4zYlSxxk9ilxxCd/pmcgDzvu7Imq83+tGeq8Xxt4XMLgMajESTpGrX4NiWnA+N
         aiDQ==
X-Gm-Message-State: AOAM530lDTeOLM68sbiCGzfNAgOELSI593vn+G94W/l76j17T3yo+XJT
        QzLJS9BE86+b3pMy1iWy3rw=
X-Google-Smtp-Source: ABdhPJx26oBT8NwtvheSnoKT8jLyoQC45bZaDNVCxy9rquKXHNVFfdT0K9nlXQGVBdDZtOMR/OxmVA==
X-Received: by 2002:a37:9ed3:: with SMTP id h202mr199931qke.126.1606252879118;
        Tue, 24 Nov 2020 13:21:19 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id y44sm292925qtb.50.2020.11.24.13.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:21:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 16:20:56 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 29/45] block: initialize struct block_device in bdev_alloc
Message-ID: <X715OP+dR8KzH1wA@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-30-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-30-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:35PM +0100, Christoph Hellwig wrote:
> Don't play tricks with slab constructors as bdev structures tends to not
> get reused very much, and this makes the code a lot less error prone.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
