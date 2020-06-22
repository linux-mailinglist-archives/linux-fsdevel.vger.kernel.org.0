Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1526A20370B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgFVMmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 08:42:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43082 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgFVMmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:42:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id j12so6137587pfn.10;
        Mon, 22 Jun 2020 05:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eZIvSoaeoetQ1jhe+tUmzTZniV3Vjg3TwcUn9XcJZg0=;
        b=kKS1HW3YK3GVi03JECU2EME8lfjR3mBkTdbKVvWMzWUvIEwsf6AECkCYwx0twgIap8
         qzak8v0OJZ3POjEGxBmW62nTtLc+M0tl+ta5lOjJrA6gEzGlJmXC1P5GVzQ0gkjz+2/D
         4UEH0RklRd2ZiqnxHIO01s3lSkaFNBMqeL2+SexFASI67wYv6HW4G14e6GHUQf8dxfrU
         D6skiRYGjxCjuuJ7Fxj6bFDoCtrfrGnox1bbgi/s0TkPY5xJmmkfpomlEvCqVvIiHutl
         IWzO/ep9u0pfdgB/KisvDMLM+lUiQkB67QCdfuoXIobU0WDk0zcEHpeuhtWZNuRzugId
         U5bQ==
X-Gm-Message-State: AOAM5309INBlUrjpXgJ6v/jUlmD9m2A6S0533NDLcDzVPbKpEOhxeuZm
        +L9uE83rmAvRkTCt36F+SuM=
X-Google-Smtp-Source: ABdhPJzbR2A9IaZZuWZL9dXfY/ud3Lh1aZezzViYVOPeMiA3bWIwI/DKubiDM5mP3ixooEqRBs0niA==
X-Received: by 2002:a63:5024:: with SMTP id e36mr12198090pgb.438.1592829730707;
        Mon, 22 Jun 2020 05:42:10 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 137sm11288142pgg.72.2020.06.22.05.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 05:42:09 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7D5A140430; Mon, 22 Jun 2020 12:42:08 +0000 (UTC)
Date:   Mon, 22 Jun 2020 12:42:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/8] block: create the request_queue debugfs_dir on
 registration
Message-ID: <20200622124208.GW11244@42.do-not-panic.com>
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-9-mcgrof@kernel.org>
 <02112994-4cd7-c749-6bd7-66a772593c90@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02112994-4cd7-c749-6bd7-66a772593c90@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 11:07:43AM -0700, Bart Van Assche wrote:
> On 2020-06-19 13:47, Luis Chamberlain wrote:
> > We were only creating the request_queue debugfs_dir only
> > for make_request block drivers (multiqueue), but never for
> > request-based block drivers. We did this as we were only
> > creating non-blktrace additional debugfs files on that directory
> > for make_request drivers. However, since blktrace *always* creates
> > that directory anyway, we special-case the use of that directory
> > on blktrace. Other than this being an eye-sore, this exposes
> > request-based block drivers to the same debugfs fragile
> > race that used to exist with make_request block drivers
> > where if we start adding files onto that directory we can later
> > run a race with a double removal of dentries on the directory
> > if we don't deal with this carefully on blktrace.
> > 
> > Instead, just simplify things by always creating the request_queue
> > debugfs_dir on request_queue registration. Rename the mutex also to
> > reflect the fact that this is used outside of the blktrace context.
> 
> There are two changes in this patch: a bug fix and a rename of a mutex.
> I don't like it to see two changes in a single patch.

I thought about doing the split first, and I did it at first, but
then I could hear Christoph yelling at me for it. So I merged the
two together. Although it makes it more difficult for review,
the changes do go together.

Kind of late to split this as its already merged now.

> Additionally, is the new mutex name really better than the old name? The
> proper way to use mutexes is to use mutexes to protect data instead of
> code. Where is the documentation that mentions which member variable(s)
> of which data structures are protected by the mutex formerly called
> blk_trace_mutex?

It does not exist, and that is the point. The debugfs_dir use after
free showed us *when* that UAF can happen, and so care must be taken
if we are to use the mutex to protect the debugfs_dir but also re-use
the same directory for other block core shenanigans.

> Since the new name makes it even less clear which data
> is protected by this mutex, is the new name really better than the old name?

I thought the new name makes it crystal clear what is being protected. I
can however add a comment to explain that the q->debugfs_mutex protects
the q->debugfs_dir if it is created, otherwise it protects the ephemeral
debugfs_dir directory which would otherwise be created in lieue of
q->debugfs_dir, however the patch still lies under <debugfs_root>/block/.

Let me know if you think that will help.

  Luis
