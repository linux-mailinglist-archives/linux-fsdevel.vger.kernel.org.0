Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FBC1AA439
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506317AbgDONU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 09:20:27 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56183 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506307AbgDONUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:20:22 -0400
Received: by mail-pj1-f66.google.com with SMTP id a32so6757488pje.5;
        Wed, 15 Apr 2020 06:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJpmPPEbW5DFD5EOE4e1MFnGEEY0tGlTM0SU0H+OaOw=;
        b=kwd3IsEe9y/QMKAsTq1Wc0vZoVM0KpCPxPTibciD4XEiexhNx/nHVOggAAkHFCc4pI
         Y9LrTG3WaHJWcbTV20e4t0WEKzbSOJQIzT8M+LV1309ZtiE1u0jIOzv8vTvRfKMooA0B
         JpUia6/+S3tAmUyWMaobP+htZGCKgTnKUprm02v6Htnscgiu0vcTdzyGT0ecYLeKY0JE
         oTgswhKaWqZJkeVoUqjn/TqjkXq4yqGrKh+4/AaldoW6GRV5pyFFFU8u6Y9XDeFr/bSn
         u7R+183U0M5ojGK4QPlPlU9P27gpQc9tmob+q+sxvg8WSfDu1n1kI9P2Mt2aqYRUtGEf
         phtQ==
X-Gm-Message-State: AGi0PuYBihfwD0tnL1IbAGDYaE3bepcPVcJ1VVFYgE3kxs2XPSdYUiMH
        nqC4tncEKXV4hDmfFJshcpA=
X-Google-Smtp-Source: APiQypJUeYCz7pZivMHyL551WxNhmqBNbGwfbuuxjlm8hRiqy/s1ws3J2v8JSkBdw41jCGt/Xs+WVw==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr4705177plk.141.1586956821686;
        Wed, 15 Apr 2020 06:20:21 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x3sm13521951pfq.95.2020.04.15.06.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 06:20:20 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EF32940277; Wed, 15 Apr 2020 13:20:19 +0000 (UTC)
Date:   Wed, 15 Apr 2020 13:20:19 +0000
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
Subject: Re: [PATCH 5/5] block: revert back to synchronous request_queue
 removal
Message-ID: <20200415132019.GW11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-6-mcgrof@kernel.org>
 <20200414154725.GD25765@infradead.org>
 <20200414205852.GP11244@42.do-not-panic.com>
 <20200415064644.GA28112@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415064644.GA28112@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:46:44PM -0700, Christoph Hellwig wrote:
> On Tue, Apr 14, 2020 at 08:58:52PM +0000, Luis Chamberlain wrote:
> > > I think this needs a WARN_ON thrown in to enforece the calling context.
> > 
> > I considered adding a might_sleep() but upon review with Bart, he noted
> > that this function already has a mutex_lock(), and if you look under the
> > hood of mutex_lock(), it has a might_sleep() at the very top. The
> > warning then is implicit.
> 
> It might just be a personal preference, but I think the documentation
> value of a WARN_ON_ONCE or might_sleep with a comment at the top of
> the function is much higher than a blurb in a long kerneldoc text and
> a later mutex_lock.

Well I'm a fan of making this explicit, so sure will just sprinkle a
might_sleep(), even though we have a mutex_lock().

  Luis
