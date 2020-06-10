Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050B11F5D8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 23:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgFJVJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 17:09:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39327 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgFJVJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:09:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id w20so1530032pga.6;
        Wed, 10 Jun 2020 14:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d8BFYFKBmzV6dUdQ9QzQfynNSFZ6LYMbzbQZFvp4F6I=;
        b=mXspwi6qfqfXD5q7rwybwbMXZAOCu/6VLkp5H7537IWdMF/NX2MDV2FbRn1yjr5vio
         rJURE0cPWZk08ZjW87h+Q1nHUc9xeSEETsJWPbCMUtFRzOp+I/bTfR28My5ih0Aw5k6k
         RWAJwvd3eOPoPXxOgg4y8k+gRL9D3SLYZTdFDGRF7G4V17c2fZFtuTF4/xp9fuOS9dyC
         WyALXtpjxNCNZkO8kQ9zlsmUGMdC/Ijs67KpANQVX90NULByfHvyweBiw7HcfBmkrm8N
         RbeZI3G5iXMebug/hhp9L3HGpYLLTGOIKdoeJ1eMabhzOSfi9oOZHbSw7LuIbS9Xx76H
         AUBA==
X-Gm-Message-State: AOAM530dByAHHgZVH91y/9PspVrT9/d+b1pDJQ4NpNKY198ELgFBFXns
        IatKG2K8AbjnRzCe3SlAouQ=
X-Google-Smtp-Source: ABdhPJy9+lD7U4qc9JUoiPb50Gv6ycU7LoqiwDQKy43ONOw5V4yjlKfcEJcOV9smlWXvgROS3QWcPg==
X-Received: by 2002:a65:64c1:: with SMTP id t1mr4240625pgv.247.1591823358925;
        Wed, 10 Jun 2020 14:09:18 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h3sm636371pgk.67.2020.06.10.14.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:09:17 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 26EE5403AB; Wed, 10 Jun 2020 21:09:17 +0000 (UTC)
Date:   Wed, 10 Jun 2020 21:09:17 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v6 6/6] blktrace: fix debugfs use after free
Message-ID: <20200610210917.GH11244@42.do-not-panic.com>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-7-mcgrof@kernel.org>
 <20200609150602.GA7111@infradead.org>
 <20200609172922.GP11244@42.do-not-panic.com>
 <20200609173218.GA7968@infradead.org>
 <20200609175359.GR11244@42.do-not-panic.com>
 <20200610064234.GB24975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610064234.GB24975@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 11:42:34PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 09, 2020 at 05:53:59PM +0000, Luis Chamberlain wrote:
> > > Feel free to add more comments, but please try to keep them short
> > > and crisp.  At the some point long comments really distract from what
> > > is going on.
> > 
> > Sure.
> > 
> > Come to think of it, given the above, I think we can also do way with
> > the the partition stuff too, and rely on the buts->name too. I'll try
> > this out, and test it.
> 
> Yes, the sg path should work for partitions as well.  That should not
> only simplify the code, but also the comments, we can do something like
> the full patch below (incorporating your original one). 

Indeed I ended up with something similar, will use this variation.

> This doesn't
> include the error check on the creation - I think that check probably
> is a good idea for this case based on the comments in the old patch, but
> also a separate issue that should go into another patch on top.

Makes sense.

  Luis
