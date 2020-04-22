Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31E71B3909
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgDVHev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 03:34:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43031 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgDVHev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:34:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id v63so640460pfb.10;
        Wed, 22 Apr 2020 00:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xv3CClgNM59iAjDs4jAyjCmiyK+zMtMkYtDjchx4A/4=;
        b=dDk/SQA0IzXPjgeu0yIb59yzu/kuKns0rKQq87n8XIcrAxHumqcENxj2+eAuhKxk0F
         40kJJi6H0DZqd+/XcpiIfK/Me0m2Jg1sgIfBZvN3paYjvzankAcdd0fU/tBoChoXVfz0
         CZ9UAwJB5OpgSp5qpOxqbSPkO/ddOAOcfl1Jn/cqE8SKOVABaHIIUM5GFthJGqGu/uIr
         eNfapxl8h67kdmsfrly9dbu52f4+309RhXfGrczpIpybsKKTDiBseDH3yERmAKah5AVL
         e7f0bV8HOPu9GfgbOXFJ57el2+gDCMJhZVUxwoDVoWO08grmVYKQiW28lRsTVz9zw9sI
         Jezg==
X-Gm-Message-State: AGi0PuZ1hUFIINEytbqdOfWCFYu7fwRBmqjSEYHwAC8v8uytqioCF9Fr
        LocQD90YJ41IktoIBMcOzNA=
X-Google-Smtp-Source: APiQypIMihueeTQ943/uTYtrvog7ersMvpf7K7XYY8myv59EdZuGEtFE1ttqG91Zu2F3zNVNy168tQ==
X-Received: by 2002:a62:1bd0:: with SMTP id b199mr25631509pfb.283.1587540890239;
        Wed, 22 Apr 2020 00:34:50 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a13sm4534042pjq.0.2020.04.22.00.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 00:34:49 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 64CC1402A1; Wed, 22 Apr 2020 07:34:48 +0000 (UTC)
Date:   Wed, 22 Apr 2020 07:34:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, rostedt@goodmis.org,
        mingo@redhat.com, jack@suse.cz, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
Message-ID: <20200422073448.GR11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <20200420201615.GC302402@kroah.com>
 <20200420204156.GO11244@42.do-not-panic.com>
 <20200422072942.GD19116@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422072942.GD19116@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:29:42AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 20, 2020 at 08:41:56PM +0000, Luis Chamberlain wrote:
> > Its already there. And yes, after my changes it is technically possible
> > to just re-use it directly. But this is complicated by a few things. One
> > is that at this point in time, asynchronous request_queue removal is
> > still possible, and so a race was exposed where a requeust_queue may be
> > lingering but its old device is gone. That race is fixed by reverting us
> > back to synchronous request_queue removal, therefore ensuring that the
> > debugfs dir exists so long as the device does.
> > 
> > I can remove the debugfs_lookup() *after* we revert to synchronous
> > request_queue removal, or we just re-order the patches so that the
> > revert happens first. That should simplify this patch.
> 
> Yes, please move the synchronous removal first instead of working around
> the current problems.

Sounds good. At first it was questionable, now its understood we need it.

  Luis
