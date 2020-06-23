Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E11A205802
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 18:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbgFWQ4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 12:56:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34568 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732292AbgFWQ4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:56:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id d12so3375945ply.1;
        Tue, 23 Jun 2020 09:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JDvdZbZLgDkFFSdCv0TnjjXgUyD2AB2yEimWstVnawg=;
        b=uKhk2r5TqBmH0iwKPP5O1OBLcS3/eEY194eSg9VcRszPOEy9mlcPIQ6W1sgWFHaMVa
         5S3LEiLsszIzLBkqYxpBY5YEpBC5KOlrnGE0ZKS5oBkdqc1rHISk865P7VL6G+hjIOcJ
         PRrp7zjuMf2VSEugGTJ94yJz0rZYzN0oi6PyZr6ztuOtcbB/iZ7C/eM4wPDzr8oaHNTH
         WSphVDOxArvWXhfuK0IG5KcX6P9zHr/VCeR7c2Jdsbh7PqJHdxd4NK29ScsAhvottX8O
         gMVL37MtOoiZuoyHLNNclCxF0W+twbsoE3O6f+HmTxO1MGxVv8I2p1pG1PHNG0kwjvn8
         qREQ==
X-Gm-Message-State: AOAM530D00WVK1pSyRN9N/XpGqcFekBIfHu0LTxuqiAAGSPGrTW1HAcv
        a7HSc3c6r9PWFy6J83tpo1U=
X-Google-Smtp-Source: ABdhPJzCFTSHbh94OELz47L0BiNYIconLJwPLhznXY2yEus6l/oUG0gykNuFRS7NKmtbjU+o5z156w==
X-Received: by 2002:a17:902:7045:: with SMTP id h5mr24682778plt.151.1592931407230;
        Tue, 23 Jun 2020 09:56:47 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t22sm2801970pjy.32.2020.06.23.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 09:56:45 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9E0F240430; Tue, 23 Jun 2020 16:56:44 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:56:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 5/8] loop: be paranoid on exit and prevent new
 additions / removals
Message-ID: <20200623165644.GB4332@42.do-not-panic.com>
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-6-mcgrof@kernel.org>
 <7e76d892-b5fd-18ec-c96e-cf4537379eba@acm.org>
 <20200622122742.GU11244@42.do-not-panic.com>
 <14dc9294-fa99-cad0-871b-b69f138e8ac9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14dc9294-fa99-cad0-871b-b69f138e8ac9@acm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 07:16:15PM -0700, Bart Van Assche wrote:
> On 2020-06-22 05:27, Luis Chamberlain wrote:
> > Note: this will bring you sanity if you try to figure out *why* we still
> > get:
> > 
> > [235530.144343] debugfs: Directory 'loop0' with parent 'block' already present!
> > [235530.149477] blktrace: debugfs_dir not present for loop0 so skipping
> > [235530.232328] debugfs: Directory 'loop0' with parent 'block' already present!
> > [235530.238962] blktrace: debugfs_dir not present for loop0 so skipping
> > 
> > If you run run_0004.sh from break-blktrace [0]. Even with all my patches
> > merged we still run into this. And so the bug lies within the block
> > layer or on the driver. I haven't been able to find the issue yet.
> > 
> > [0] https://github.com/mcgrof/break-blktrace
> 
> Thanks Luis for having shared this information. If I can find the time I
> will have a look into this myself.

Let's keep track of it:

https://bugzilla.kernel.org/show_bug.cgi?id=208301

  Luis
