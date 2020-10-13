Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1028D501
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 21:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgJMT5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 15:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728145AbgJMT5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602619056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LRFJqT7I3kohH/YYD4XEKjFcPLlGRFDozndI1UK1Zmc=;
        b=NIKmi/c3k21xx5Pb/FVky+XLD+Xmp9oJbSqoBJCl9lK7VEEYMNVCq//1jnHzyafQD0Rpll
        o0exakTT5j10RljnR6uUqQYrZslf/2IVmB+OUtjLFsxzpFlUinnwaMsFQ894pLEiEz9jwf
        5mTyzMc0aTF9OpDEubaWenr4Omr78Ho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-jr1SUanyP2--xBHG_Fyx3Q-1; Tue, 13 Oct 2020 15:57:32 -0400
X-MC-Unique: jr1SUanyP2--xBHG_Fyx3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F32D2107AFA9;
        Tue, 13 Oct 2020 19:57:30 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-207.rdu2.redhat.com [10.10.115.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27B7E5D9CD;
        Tue, 13 Oct 2020 19:57:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 96F1C223D0F; Tue, 13 Oct 2020 15:57:19 -0400 (EDT)
Date:   Tue, 13 Oct 2020 15:57:19 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Qian Cai <cai@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Subject: Re: Unbreakable loop in fuse_fill_write_pages()
Message-ID: <20201013195719.GD142988@redhat.com>
References: <7d350903c2aa8f318f8441eaffafe10b7796d17b.camel@redhat.com>
 <20201013184026.GC142988@redhat.com>
 <20201013185808.GA164772@redhat.com>
 <d14f6a08b4ada85289e70cbb34726fd084ccac05.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14f6a08b4ada85289e70cbb34726fd084ccac05.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 03:53:19PM -0400, Qian Cai wrote:
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

Hmm..., So how do I reproduce it. Just run trinity as root and it will
reproduce after some time?

Vivek

