Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0740C38E26C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 10:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhEXIkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 04:40:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:52538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232415AbhEXIks (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 04:40:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621845559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjxvWAvOCJRMEsP/LeDM6TS4/Fq6dQC1dCNTIlx2sgc=;
        b=WmCYjj0zXXpbdQSFXXM2fC8bPnZhxUcQOxQ10YDIyRgnnChp8HU714tRRlWxYaAaIIyul5
        VpR5zFWOFkpRXzJr+lAF1MbHrQQU5qMLAUS/85fkSvqlZOv9Q2FnHEvUJPNBPn4+bo1Apw
        0OfWqG5mmVxRCl562CEHfaD52h07AKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621845559;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjxvWAvOCJRMEsP/LeDM6TS4/Fq6dQC1dCNTIlx2sgc=;
        b=l50JzRBtn8w7158ZD3kE3ZFSfqo873ry/nCxpkwHMV4uA2Z/Fv3nDNAT4Z1RehOWNopnkt
        xW52JOBaZV+J1VCA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8720BABB1;
        Mon, 24 May 2021 08:39:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1DDAD1F2CA2; Mon, 24 May 2021 10:39:19 +0200 (CEST)
Date:   Mon, 24 May 2021 10:39:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Andy Lutomirski <luto@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] gfs2: Fix mmap + page fault deadlocks (part 2)
Message-ID: <20210524083919.GA32705@quack2.suse.cz>
References: <20210520122536.1596602-1-agruenba@redhat.com>
 <20210520122536.1596602-7-agruenba@redhat.com>
 <20210520133015.GC18952@quack2.suse.cz>
 <CAHc6FU7ESASp+G59d218LekK8+YMBvH9GxbPr-qOVBhzyVmq4Q@mail.gmail.com>
 <20210521152352.GQ18952@quack2.suse.cz>
 <CAHc6FU6df7cBbjmYOZE35v_FALWRO62cYjg2Y9rY+Hd6x5yeyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU6df7cBbjmYOZE35v_FALWRO62cYjg2Y9rY+Hd6x5yeyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 21-05-21 17:46:04, Andreas Gruenbacher wrote:
> On Fri, May 21, 2021 at 5:23 PM Jan Kara <jack@suse.cz> wrote:
> > On Thu 20-05-21 16:07:56, Andreas Gruenbacher wrote:
> > > > So you probably need to add a new VM_FAULT_
> > > > return code that will behave like VM_FAULT_SIGBUS except it will not raise
> > > > the signal.
> > >
> > > A new VM_FAULT_* flag might make the code easier to read, but I don't
> > > know if we can have one.
> >
> > Well, this is kernel-internal API and there's still plenty of space in
> > vm_fault_reason.
> 
> That's in the context of the page fault. The other issue is how to
> propagate that out through iov_iter_fault_in_readable ->
> fault_in_pages_readable -> __get_user, for example. I don't think
> there's much of a chance to get an additional error code out of
> __get_user and __put_user.

Yes, at that level we'd get EFAULT as in any other case. Really the only
difference of the new VM_FAULT_ error code from a case of "standard" error
and VM_FAULT_SIGBUS would be not raising the signal.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
