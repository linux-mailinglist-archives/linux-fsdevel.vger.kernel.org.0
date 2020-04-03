Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195AA19DEBD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 21:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgDCTtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 15:49:36 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35801 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCTtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:49:35 -0400
Received: by mail-pj1-f65.google.com with SMTP id g9so3430516pjp.0;
        Fri, 03 Apr 2020 12:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x2pc80oThxV6qNBWGlmeKcETWFQG6BcGqDuUp7g6seI=;
        b=C2saI+xzCvwnV/1XYD57j0sd03Kn0Pxvtx0U7LSuL39D94znfofRiE65lLXz2BjhDb
         ppwov8P+H4mup/f1IOY+nD9v+F17EJzl9xLqq/eGvKuvujph/qcIYeg8LTDu+KCdkK15
         PnMP8bBvdBv4a6Wd/x8C0yiTlqYURftz+qC+MHHF1x7YoiqE6186o3w6xegfGc1ljRP1
         3WxAjnRE+eXoIS6mUAek9fyadSb8Je0j8NK2o2SWOBHwkOmB8AT0TmmSKtN7ASvrImlY
         edqvZv62PWOKZpAaYEo+MeYxPzi0phmf+VV61WROu3c6+WzcSmqINOCh68rxWSZOv85i
         sGGw==
X-Gm-Message-State: AGi0PuaMllxoXgSxG/EOMODA2oIhpN248rPMCnnRqhDLfocpVsbw7iR8
        qy8+bBoGOQf8F/tRtI8Wa0c=
X-Google-Smtp-Source: APiQypJ+IXj4OXk7K8o38nrR2hClG27wXJLbJPmZCN3t6HqOTaFX1aLIqDevdMmiOCGfeqtU7eugyg==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2mr9227374plb.221.1585943372496;
        Fri, 03 Apr 2020 12:49:32 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id ml17sm6443717pjb.13.2020.04.03.12.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 12:49:30 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7938E40297; Fri,  3 Apr 2020 19:49:29 +0000 (UTC)
Date:   Fri, 3 Apr 2020 19:49:29 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        nstange@suse.de, mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [RFC 0/3] block: address blktrace use-after-free
Message-ID: <20200403194929.GZ11244@42.do-not-panic.com>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200403081929.GC6887@ming.t460p>
 <15236c59-6b48-2fcf-1a84-f98cb8b339ab@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15236c59-6b48-2fcf-1a84-f98cb8b339ab@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 07:13:47AM -0700, Bart Van Assche wrote:
> On 2020-04-03 01:19, Ming Lei wrote:
> > BTW, Yu Kuai posted one patch for this issue, looks that approach
> > is simpler:
> > 
> > https://lore.kernel.org/linux-block/20200324132315.22133-1-yukuai3@huawei.com/
> 
> That approach is indeed simpler but at the expense of performing dynamic
> memory allocation in a cleanup path, something I'm not enthusiast about.

I also think that its important to annotate that there are actually two
issues here. Not one. One is the misuse of debugfs, the other is how
the deferral exposed the misuse and complications of its misuse.

  Luis
