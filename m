Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA3B2072E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 14:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389645AbgFXMIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 08:08:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35020 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbgFXMIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:08:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id h185so1093975pfg.2;
        Wed, 24 Jun 2020 05:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKoC80Wq7vgR/nEQP76EsMeVeQcGFmckg9WTm/ySZtU=;
        b=pzscmqkD2CfyMgtwS4bH5JMlgZRqTU24ntszPmhj9AXENcFPcwrPHImvzz2w+DYnlU
         z3OHoBg8qkCI0N4cjGuaALBQKFjjJlWbIJdXrh/VOtOzIVMAwdspdPVRFKskNiu9LBTE
         ogsY28r8WwWzWN6iuOt+vz/krf+GSbs4xZnVXrQwz45HiL8YKXTaF3uIuP0afygygbDL
         6tONFB959g2oN4aYEdr9IQdVkax8TtERCjVpotBVshfb15PSJkj8geq/nTL2SSF/8sVF
         THfTF2k9ogY+cAJQnGvChhxARHSeLWYE4XMTtElE1IvynJNAC6kIhuWm0hZUb+tlAR9O
         6yKA==
X-Gm-Message-State: AOAM532SXAPf2mUrjkAKxbiGHFxGxiD9Mq/WfItJ1QA6ehy/sdbRo9NI
        wq8HqIIZL3HcZUjWwpDjnkk=
X-Google-Smtp-Source: ABdhPJy7+qAAHibTBd59vj1TFF3NDV4/7CT9zsa35G/gvOUinbvpiYYa0boVxe+S9Xo6K6bzCLHpGg==
X-Received: by 2002:a63:395:: with SMTP id 143mr17860516pgd.57.1593000512400;
        Wed, 24 Jun 2020 05:08:32 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id cu9sm5249668pjb.28.2020.06.24.05.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 05:08:30 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id ADB9940430; Wed, 24 Jun 2020 12:08:29 +0000 (UTC)
Date:   Wed, 24 Jun 2020 12:08:29 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "nstange@suse.de" <nstange@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 5/8] loop: be paranoid on exit and prevent new
 additions / removals
Message-ID: <20200624120829.GE4332@42.do-not-panic.com>
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-6-mcgrof@kernel.org>
 <7e76d892-b5fd-18ec-c96e-cf4537379eba@acm.org>
 <20200622122742.GU11244@42.do-not-panic.com>
 <SN4PR0401MB35982B3522B95FADDD06DC4C9B940@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35982B3522B95FADDD06DC4C9B940@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 05:05:01PM +0000, Johannes Thumshirn wrote:
> On 22/06/2020 14:27, Luis Chamberlain wrote:
> [...]> If you run run_0004.sh from break-blktrace [0]. Even with all my patches
> > merged we still run into this. And so the bug lies within the block
> > layer or on the driver. I haven't been able to find the issue yet.
> > 
> > [0] https://github.com/mcgrof/break-blktrace
> 
> Would it be a good idea to merge this into blktests? Maybe start a blktrace 
> section for it, which could host other regression test for blktrace.
> 
> Thoughts?

Absolutely! That is the goal as well.

  Luis
