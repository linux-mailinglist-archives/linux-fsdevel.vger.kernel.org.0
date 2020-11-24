Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477DE2C25A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 13:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbgKXM02 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 07:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733231AbgKXM01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:26:27 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85ACC0613D6;
        Tue, 24 Nov 2020 04:26:27 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id d5so6831449qtn.0;
        Tue, 24 Nov 2020 04:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3VmFnou2nD4lcYGUPrMqThXCue7L4UhclP4oij42Kbk=;
        b=Q2pmLjkQax53DfEJqAJ++rfXRuCUfTMdSrNvTnPX432cf0gQiAL3+rv3sWj3pG2My/
         oRdarF4chfZ/NGCWEsg2aUxLBAr7DM0+LX5j3dmwR37bMrIIw9a2t0+E+kgW+uzsRvYc
         g8kM86RUe+4+vv//4l1WUE0yyA289I+AFdLve44wNIShUP964g0YZBC6/O2hSjbZ07AU
         S+AiwdwqWWOpdsi3wwn8TVFeRWE/u7jWG4pRzv/CGg3KS5VD7Ier0L558UzN4+P3vh8c
         3eIrk+wHnJy7NT29VnOUcXmovGz+97HAGUQWfQatJC0i/4bkcHptLw7Lu0lLat1XLRR0
         0C4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3VmFnou2nD4lcYGUPrMqThXCue7L4UhclP4oij42Kbk=;
        b=QOYY+DvKsuE0yZzIGpF/TxiYGY4nSbKE8vc0R3o3dMWP1uONBI5+0FkK2KnLpT8AqO
         FdeqTtDEvUWSWMyU6b28rYOnoZrV+Ri/oHeQ6M60I1QsaSjALCV3dfEi7saK0fqD44P9
         Q8m4jC69bL7NuNi9kcowGH1lg9nOynHfa5z3rJQV3vJP/PLWVHvmxhBi/rFA8FbEpFhn
         /Tvg12vKjlqt8OTo63e6qhrLblkuLItbRa+Og5rxkhRBPWwbHo6ZedIMT+UiXRMajQZf
         70o/pF5ip9G9ulZnnWhRJwussE1vZmeRb8sjuvQpSG/jGBxKsdVNFSDVvC3pkbCy+xgV
         ppLg==
X-Gm-Message-State: AOAM530Bxm/5R8BDUG5TUKrJOFqkJMRCKobL7XADZ0eVl6+UkjZAvw0N
        SGv/o3sTp5QCGSLjvH4Cqk8=
X-Google-Smtp-Source: ABdhPJzEc+iLQWYgDMndDYVqthGkMbJAnqvSsODxlzYXE5vX4s2url7RgqZoX9eivJ6nNv6zlRow0w==
X-Received: by 2002:aed:3c42:: with SMTP id u2mr4081287qte.159.1606220786736;
        Tue, 24 Nov 2020 04:26:26 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id t2sm8643187qkb.2.2020.11.24.04.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 04:26:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 07:26:03 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 01/20] blk-cgroup: fix a hd_struct leak in
 blkcg_fill_root_iostats
Message-ID: <X7z7215hVXzg3FGA@mtj.duckdns.org>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:47:41AM +0100, Christoph Hellwig wrote:
> disk_get_part needs to be paired with a disk_put_part.
> 
> Fixes: ef45fe470e1 ("blk-cgroup: show global disk stats in root cgroup io.stat")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
