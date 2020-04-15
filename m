Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9E1AA46D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636093AbgDONZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 09:25:35 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38242 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2636090AbgDONZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:25:06 -0400
Received: by mail-pj1-f68.google.com with SMTP id t40so6672649pjb.3;
        Wed, 15 Apr 2020 06:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VxzOHBakm6zWRy000AuKfccE4q5d/hsyCc04Zt0DJtg=;
        b=IRZ0H8DcQ2OaXUc/yZtJgNL6K8Kx4uKT+N1omloeQ5Up8gtBfHz0pMmHPOFIh+KY0o
         BLvYaaZG0Y2X2gf9vclLe4Mzc9kAv1m27aqljqlzq9vVMY3IDG7egZC1nER4qWu8nhxc
         Rq2s83bupsK0AEKNwJlvCbrCH6er9+Qk9kXZh2V87xjycZBldqU0qQn35bGY868GaOUF
         sE7yOONXD7QbWLOAkDKIy1GAUmr09Ux+sldzykA9CrL+BnCtt58M6d7hsFAnEJQqB9mL
         ZOEmNUBQw05vKN6I3gJugVn+640CJZ3DPO82S8kHbTnWUjkKpSpBXL82fREbQCwwDkcX
         L1Dw==
X-Gm-Message-State: AGi0PuYsxlMo9zy/2c/lHHWifFBbmK/8GOuIX4Ith2NBS9NcTIMWtFN4
        K7rqaEK7DmIqk3di2nObq1A=
X-Google-Smtp-Source: APiQypLzsjEy5ye1O+lv4UjZnyAkJCntXBLPPdDHpWm50UQu9/3cAd14/acJ8Zmqjk3bVWJOaNRWQw==
X-Received: by 2002:a17:902:8608:: with SMTP id f8mr4959948plo.110.1586957105130;
        Wed, 15 Apr 2020 06:25:05 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z63sm13828068pfb.20.2020.04.15.06.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 06:25:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 757A040277; Wed, 15 Apr 2020 13:25:03 +0000 (UTC)
Date:   Wed, 15 Apr 2020 13:25:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 3/5] blktrace: refcount the request_queue during ioctl
Message-ID: <20200415132503.GX11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200414154044.GB25765@infradead.org>
 <20200415061649.GS11244@42.do-not-panic.com>
 <20200415071425.GA21099@infradead.org>
 <20200415123434.GU11244@42.do-not-panic.com>
 <20200415123925.GA14925@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415123925.GA14925@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 05:39:25AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 15, 2020 at 12:34:34PM +0000, Luis Chamberlain wrote:
> > I'll pile up a fix. I've also considered doing a full review of callers
> > outside of the core block layer using it, and maybe just unexporting
> > this. It was originally exported due to commit d86e0e83b ("block: export
> > blk_{get,put}_queue()") to fix a scsi bug, but I can't find such
> > respective fix. I suspec that using bdgrab()/bdput() seems more likely
> > what drivers should be using. That would allow us to keep this
> > functionality internal.
> > 
> > Think that's worthy review?
> 
> Probably.  I did in fact very quickly look into that but then gave
> up due to the fair amount of modular users.

Alright, then might as well then verify if the existing practice of
bdgrab()/bdput() is indeed valid logic, as otherwise we'd be puting
the atomic context / sleep concern to bdput(). As noted earlier I
am able to confirm easily that bdgrab() can be called in atomic contex,
however I cannot easily yet vet for *why* this was a safe assumption for
bdput().

  Luis
