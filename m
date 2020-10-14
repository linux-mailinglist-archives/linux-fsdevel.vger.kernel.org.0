Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5508728DB3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgJNI0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 04:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726554AbgJNI0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602663996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6dq3MRlI6NReDh3N09odZJTFDHZzl2ba3LxXy2RMXQ=;
        b=A63bzIpVSf55v+y6eCJHZUUyzpp12wP1FOntUZAGWMt7nw4yTmeu37M3e6tEdebtksYoOS
        RzJzjst/WhuOQbSTwqEVqljvNqusFXc+gGPMgHSXIEGp1/FbXj2Yae8eK1hhjYR0FEnISW
        Ak2WqAFkQr7fDNtBwTdP03x3N9qL34Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-DbuUsoliPUyqY74N6YAAzg-1; Wed, 14 Oct 2020 04:26:34 -0400
X-MC-Unique: DbuUsoliPUyqY74N6YAAzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 167618014D9;
        Wed, 14 Oct 2020 08:26:33 +0000 (UTC)
Received: from work-vm (ovpn-113-95.ams2.redhat.com [10.36.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D87F67666E;
        Wed, 14 Oct 2020 08:26:24 +0000 (UTC)
Date:   Wed, 14 Oct 2020 09:26:21 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Qian Cai <cai@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Virtio-fs] Unbreakable loop in fuse_fill_write_pages()
Message-ID: <20201014082621.GA2996@work-vm>
References: <7d350903c2aa8f318f8441eaffafe10b7796d17b.camel@redhat.com>
 <20201013184026.GC142988@redhat.com>
 <20201013185808.GA164772@redhat.com>
 <d14f6a08b4ada85289e70cbb34726fd084ccac05.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14f6a08b4ada85289e70cbb34726fd084ccac05.camel@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Qian Cai (cai@redhat.com) wrote:
> On Tue, 2020-10-13 at 14:58 -0400, Vivek Goyal wrote:
> 
> > I am wondering if virtiofsd still alive and responding to requests? I
> > see another task which is blocked on getdents() for more than 120s.
> > 
> > [10580.142571][  T348] INFO: task trinity-c36:254165 blocked for more than 123
> > +seconds.
> > [10580.143924][  T348]       Tainted: G           O	 5.9.0-next-20201013+ #2
> > [10580.145158][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > +disables this message.
> > [10580.146636][  T348] task:trinity-c36     state:D stack:26704 pid:254165
> > ppid:
> > +87180 flags:0x00000004
> > [10580.148260][  T348] Call Trace:
> > [10580.148789][  T348]  __schedule+0x71d/0x1b50
> > [10580.149532][  T348]  ? __sched_text_start+0x8/0x8
> > [10580.150343][  T348]  schedule+0xbf/0x270
> > [10580.151044][  T348]  schedule_preempt_disabled+0xc/0x20
> > [10580.152006][  T348]  __mutex_lock+0x9f1/0x1360
> > [10580.152777][  T348]  ? __fdget_pos+0x9c/0xb0
> > [10580.153484][  T348]  ? mutex_lock_io_nested+0x1240/0x1240
> > [10580.154432][  T348]  ? find_held_lock+0x33/0x1c0
> > [10580.155220][  T348]  ? __fdget_pos+0x9c/0xb0
> > [10580.155934][  T348]  __fdget_pos+0x9c/0xb0
> > [10580.156660][  T348]  __x64_sys_getdents+0xff/0x230
> > 
> > May be virtiofsd crashed and hence no requests are completing leading
> > to a hard lockup?
> Virtiofsd is still working. Once this happened, I manually create a file on the
> guest (in virtiofs) and then I can see the content of it from the host.

If the virtiofsd is still running, attach gdb to it and get a full bt;

gdb --pid  whatever

(gdb) t a a bt full

that should show if it's stuck in one particular place.

Dave


> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

