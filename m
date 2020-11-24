Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA5F2C328B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 22:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbgKXVUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 16:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbgKXVUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:20:42 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F25DC0613D6;
        Tue, 24 Nov 2020 13:20:42 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id i199so536598qke.5;
        Tue, 24 Nov 2020 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ev/F4l5kU0JVd8J9T+Hn7/Emi68DyGqwAl9VsbylUp0=;
        b=ZNSLo8JoXJqjP5o+nIXl1wDfRlZM34G4UajJItZyFsuYjmXMkUKdp9TKdu4qQVAcH5
         1UtlzvL9QAOsVwNuRmLXs7qTazgrsdlD0c9Fg5jpMS46JIBuEyExozrq6Rpy6KkznpEk
         LK8bE886olCSw1TOZhi4r5Dvu6oUxUSyqj8CgYwDqSKsVWJ+RHfjDuv3hkDpzS8EceZD
         HTuSBVL4noo6GQEfe1lNegiK98NcOs7S2p1t2MSFBRzQhrkn/44t1OAHb6UpUFPD3EHa
         FTBQsVjSYGJSYiOLAEycBszTag6Jbur7U/Yzxl9519cveNmQk/zw99cBH024rHQM0vOy
         HpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ev/F4l5kU0JVd8J9T+Hn7/Emi68DyGqwAl9VsbylUp0=;
        b=SCVW++YQgqkL3kmZnygfBU5BbEAq5TisprmNGr7rvv3Vo2ypwWaOTUS4V3wYF8j/zy
         c7uXumP8IpCxjFgDC67m84EJTF0VkbzJrdrb688mGfSWZ6c+icUTq2hN6YJT8EqecDMn
         xyJGEyf9AC7Iy/ZkkrJPA3o+pUqp02K5MpEhyMvc6coeg8DrjZQwguvcwTNPtm1mzCCv
         qNHnlDwP+5m+zcf4oazvPX2T2zcfUO96qfSuqdSgi3tXovTyPRe96uCZJxv+ggVFQ12z
         +iQQQOsX9bo6IPwPZgml/2PPiHpQZgrjrjQAvUuJWSgIZgwC2FXSoasxdCVfXVxjbiY8
         hfTA==
X-Gm-Message-State: AOAM5304G34svIz7BWm4Ipp9X58tooAbk9Tq+rv4e4KqHvrx+aAOxOrQ
        Z4PIkyQISn/X93gIDG26ltk=
X-Google-Smtp-Source: ABdhPJxVPExCrpl6SBnHr8hh5lACFOCmcWgKuDYnGDx1xBxinXihB0MFiLxOfh+ARQAqrCZ49K/lyA==
X-Received: by 2002:a37:7481:: with SMTP id p123mr176688qkc.424.1606252841332;
        Tue, 24 Nov 2020 13:20:41 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id b33sm298244qta.62.2020.11.24.13.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:20:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 16:20:18 -0500
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
Subject: Re: [PATCH 28/45] block: simplify part_to_disk
Message-ID: <X715EkY5mafgeJWZ@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-29-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:34PM +0100, Christoph Hellwig wrote:
> Now that struct hd_struct has a block_device pointer use that to
> find the disk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
