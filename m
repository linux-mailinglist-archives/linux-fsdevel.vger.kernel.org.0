Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02E02C2EEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 18:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403951AbgKXRje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 12:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403793AbgKXRjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:39:33 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1190C0613D6;
        Tue, 24 Nov 2020 09:39:33 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q22so21507289qkq.6;
        Tue, 24 Nov 2020 09:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gccbgbDD7s/mdcXht2fL6iBUT8Prx6ozPAIi1oy24XY=;
        b=iAaQvjyW2JnxhLhsfg8rCUwKx68+n4VYv+x/cr19/l2gHjZ5rqQ2eHUQa56Yyrf+V0
         0EBO+8uJl3e7TpL8GOVdi3mPtP96tXMXp7if6adHqmGOPUC9KUkBCbpdOTkT7hALT+Ah
         7EHhHu8GvT+6D/0VCKlT2valDN6Ru1DvIbYtbLzR9+yA8jAAqgTW92ZCQEl3Pxl49Unt
         n/9PGjVy4f9zVoTzBvz1OlBcvmK214hyEQI6i4iF3fx4WQFt+rk4+OOUR5M42Vw6rBoM
         uLOJwtqDc9FyseTQMx+P4zZsyxqAY70M/tC6pBQFw6EbxPD3Q0UbNVnIzJCU6WGu3JSB
         P/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gccbgbDD7s/mdcXht2fL6iBUT8Prx6ozPAIi1oy24XY=;
        b=CIwk8obOrRmPDyrwEldzSxRcUVSS/yIMfV8/qHfDme86MWQlSJaJDszaO6CN8FqONA
         im0L0izXEx8t94D0ZKm6nLkRTOgbmSqPW9Y/1RxjWFEVRa2hK/XE6wrBObewLOzuMF0D
         947UvYs4qoiyllrOuj4V4u6igAYu+luN/WmAD/12xmXP1hSMFreiPdFyH9MomlewrCly
         U8kMQYnN8GsWTASnRlGbexZyqVc07Cu8MR+UqJpLu2e3GzazzmVvUZtDDw3ar7eBCNcT
         8ZCvRhkSZPUMxTL9c1g7icAzcUwJaXZX2iwXBEY/hZBHRIn6MYQCZjoD1ah6Y2W7TZne
         GRLA==
X-Gm-Message-State: AOAM533yNZFd5iRkM90lyZLeINgQGCczQFk0JRpJnVavkraEWuMIgYDI
        eArLnxDacDgG5YaSKfdjIZE=
X-Google-Smtp-Source: ABdhPJxIyQph6LZGahQWIRSjw01El8frTqGQNdMpj1StAekmqcFeaj8JjyjEpK9CN9Iflo08fhI4fA==
X-Received: by 2002:a05:620a:a1d:: with SMTP id i29mr5820661qka.466.1606239572817;
        Tue, 24 Nov 2020 09:39:32 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id e10sm13416860qkn.126.2020.11.24.09.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:39:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 12:39:10 -0500
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
Subject: Re: [PATCH 19/45] init: cleanup match_dev_by_uuid and
 match_dev_by_label
Message-ID: <X71FPpCgw9t3JfIr@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-20-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:25PM +0100, Christoph Hellwig wrote:
> Avoid a totally pointless goto label, and use the same style of
> comparism for both helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
