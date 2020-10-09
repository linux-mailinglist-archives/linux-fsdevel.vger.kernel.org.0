Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622042880FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 06:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgJIEFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 00:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgJIEFn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 00:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602216342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0LJZLfN1evxEALdYZ+iKwkAO+jzveYCVlDmJws2G9/M=;
        b=Wp/+Ul05m5Z38E6jrIORBn/VXkA940X8/okUjJWcOaLWmTQB9hq8gFGBWtn/iR2DVe8A76
        kmjLib4DhuBjOcgeXFNlCKtXaFzFxk57zNNeWRbPIiH7iU/HuHP3KaBSSuBjlPRm1OZebv
        sLpFCsiU77jjCWzKaSyXcBz/0XrwGIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-xglw9SF9NZWwo7f1JWlwBg-1; Fri, 09 Oct 2020 00:05:39 -0400
X-MC-Unique: xglw9SF9NZWwo7f1JWlwBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 299D457083;
        Fri,  9 Oct 2020 04:05:37 +0000 (UTC)
Received: from T590 (ovpn-13-88.pek2.redhat.com [10.72.13.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 851FC10013C1;
        Fri,  9 Oct 2020 04:05:29 +0000 (UTC)
Date:   Fri, 9 Oct 2020 12:05:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+fd15ff734dace9e16437@syzkaller.appspotmail.com>,
        bcrl@kvack.org, hch@lst.de, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        viro@zeniv.linux.org.uk, vkabatov@redhat.com
Subject: Re: general protection fault in percpu_ref_exit
Message-ID: <20201009040525.GB27356@T590>
References: <000000000000b1412b05b12eab0a@google.com>
 <165db20c-bfc5-fca8-1ecf-45d85ea5d9e2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165db20c-bfc5-fca8-1ecf-45d85ea5d9e2@kernel.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 08, 2020 at 07:23:02PM -0600, Jens Axboe wrote:
> On 10/8/20 2:28 PM, syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit 2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e
> > Author: Ming Lei <ming.lei@redhat.com>
> > Date:   Thu Oct 1 15:48:41 2020 +0000
> > 
> >     percpu_ref: reduce memory footprint of percpu_ref in fast path
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126930d0500000
> > start commit:   8b787da7 Add linux-next specific files for 20201007
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=116930d0500000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=166930d0500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=aac055e9c8fbd2b8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=fd15ff734dace9e16437
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119a0568500000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106c0a8b900000
> > 
> > Reported-by: syzbot+fd15ff734dace9e16437@syzkaller.appspotmail.com
> > Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> Ming, this looks like a call of percpu_ref_exit() on a zeroed refs (that
> hasn't been initialized). Really a caller error imho, but might make sense
> to be a bit safer there.

Hello Jens,

The fix is sent out as:

https://lore.kernel.org/linux-block/20201009040356.43802-1-ming.lei@redhat.com/T/#u

Sorry for making the trouble.

Thanks,
Ming

