Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011A81C1966
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 17:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgEAPYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 11:24:49 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55527 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgEAPYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 11:24:49 -0400
Received: by mail-pj1-f66.google.com with SMTP id a32so18295pje.5;
        Fri, 01 May 2020 08:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X20mKpRRVq/ark63BbLpoCynpLjPmjVnD3XcfxieJmo=;
        b=nxLBwiUyssNTIBTkfse5CKboAwAshhtDUb2MiZ4uTej8w+2Hp7VUFZr+RiLxxUjANg
         41i5Bn193Ai81hZUpbFSOIs/yWTn3f55Dd5nhrQehajf0UZBbKOQn1HPs32g87MxZ4aN
         aA69TRjwlhffllEZg3LToNIXn5AJEPJ7elNznjbdgCn86PXOo9GaDHPfCNMoHMb2eeaV
         efGcT1hMGtxFs7R9EgdgoRoqqDeal0KmSzOATx3kWGywGo0cC3SRFQlJ3KWPzFUVP6Y8
         Cj3gJSvSirnh8egzSkODjBzhP/JIFamm3wTv97F0hZux/wV7bABL/OXg+RCdBRZyyFfi
         OZAw==
X-Gm-Message-State: AGi0Pua5rXtk1NfvOsomIPaNSfCZWQWDABp2iWnK7mUSQACtNWL4++6f
        FhzDo4ZUL/U/xL4n0gXfUxI=
X-Google-Smtp-Source: APiQypIS4cJmDrisB6sfUSd9KAjmqSPPBVrVSde1HXQ1i+jak+p623AzeudhI/4PsYT0cfEmmyEQeA==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr5192257plq.84.1588346687212;
        Fri, 01 May 2020 08:24:47 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a15sm11899pju.3.2020.05.01.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:24:45 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5D8FD4046C; Fri,  1 May 2020 15:24:45 +0000 (UTC)
Date:   Fri, 1 May 2020 15:24:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, rostedt@goodmis.org,
        mingo@redhat.com, jack@suse.cz, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 4/6] blktrace: fix debugfs use after free
Message-ID: <20200501152445.GN11244@42.do-not-panic.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-5-mcgrof@kernel.org>
 <20200429112637.GD21892@infradead.org>
 <20200429114542.GJ11244@42.do-not-panic.com>
 <20200429115051.GA27378@infradead.org>
 <20200429120230.GK11244@42.do-not-panic.com>
 <20200429120406.GA913@infradead.org>
 <20200429122152.GL11244@42.do-not-panic.com>
 <20200429125726.GA2123334@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429125726.GA2123334@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 02:57:26PM +0200, Greg KH wrote:
> On Wed, Apr 29, 2020 at 12:21:52PM +0000, Luis Chamberlain wrote:
> > On Wed, Apr 29, 2020 at 05:04:06AM -0700, Christoph Hellwig wrote:
> > > On Wed, Apr 29, 2020 at 12:02:30PM +0000, Luis Chamberlain wrote:
> > > > > Err, that function is static and has two callers.
> > > > 
> > > > Yes but that is to make it easier to look for who is creating the
> > > > debugfs_dir for either the request_queue or partition. I'll export
> > > > blk_debugfs_root and we'll open code all this.
> > > 
> > > No, please not.  exported variables are usually a bad idea.  Just
> > > skip the somewhat pointless trivial static function.
> > 
> > Alrighty. It has me thinking we might want to only export those symbols
> > to a specific namespace. Thoughts, preferences?
> > 
> > BLOCK_GENHD_PRIVATE ?
> 
> That's a nice add-on issue after this is fixed.  As Christoph and I
> pointed out, you have _less_ code in the file if you remove the static
> wrapper function.  Do that now and then worry about symbol namespaces
> please.

So it turns out that in the old implementation, it was implicit that the
request_queue directory was shared with the scsi drive. So, the
q->debugfs_dir *will* be set, and as we have it here', we'd silently be
overwriting the old q->debugfs_dir, as the queue is the same. To keep
things working as it used to, with both, we just need to use a symlink
here. With the old way, we'd *always* create the sg directory and re-use
that, however since we can only have one blktrace per request_queue, it
still had the same restriction, this was just implicit. Using a symlink
will make this much more obvious and upkeep the old functionality. We'll
need to only export one symbol. I'll roll this in.

  Luis
