Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8F628D443
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 21:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgJMTMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 15:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729530AbgJMTMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602616354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Geoviw+gNgwSk9MTAZob0fo0cDmAP4quy2bMV3V7xg=;
        b=gH+pocIJ0078VmUV7UA2pqY4LdnU0LYFcxgsFyweEnPm1ksWrWgnTh/xU6Isp3uY6Ar0uP
        P9hQKkiHFbpMFUkpC0X/si7wvUSfbrJb80OJ6U0zYWJavm351qtibI1OFustkVLWLXGAj0
        k2rt4dF7hitQtfccHOGSy4DovRZUgmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-ejcES3vtPsmfzayTtJ1XYA-1; Tue, 13 Oct 2020 15:12:30 -0400
X-MC-Unique: ejcES3vtPsmfzayTtJ1XYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4A281868410;
        Tue, 13 Oct 2020 19:12:29 +0000 (UTC)
Received: from ovpn-118-16.rdu2.redhat.com (ovpn-118-16.rdu2.redhat.com [10.10.118.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0946960C07;
        Tue, 13 Oct 2020 19:12:22 +0000 (UTC)
Message-ID: <c38fe9ee57c142e1cb720520b4f9b68666bcb2b8.camel@redhat.com>
Subject: Re: Unbreakable loop in fuse_fill_write_pages()
From:   Qian Cai <cai@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Date:   Tue, 13 Oct 2020 15:12:22 -0400
In-Reply-To: <20201013185808.GA164772@redhat.com>
References: <7d350903c2aa8f318f8441eaffafe10b7796d17b.camel@redhat.com>
         <20201013184026.GC142988@redhat.com> <20201013185808.GA164772@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-10-13 at 14:58 -0400, Vivek Goyal wrote:
> I am wondering if virtiofsd still alive and responding to requests? I
> see another task which is blocked on getdents() for more than 120s.
> 
> [10580.142571][  T348] INFO: task trinity-c36:254165 blocked for more than 123
> +seconds.
> [10580.143924][  T348]       Tainted: G           O	 5.9.0-next-20201013+ #2
> [10580.145158][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> +disables this message.
> [10580.146636][  T348] task:trinity-c36     state:D stack:26704 pid:254165
> ppid:
> +87180 flags:0x00000004
> [10580.148260][  T348] Call Trace:
> [10580.148789][  T348]  __schedule+0x71d/0x1b50
> [10580.149532][  T348]  ? __sched_text_start+0x8/0x8
> [10580.150343][  T348]  schedule+0xbf/0x270
> [10580.151044][  T348]  schedule_preempt_disabled+0xc/0x20
> [10580.152006][  T348]  __mutex_lock+0x9f1/0x1360
> [10580.152777][  T348]  ? __fdget_pos+0x9c/0xb0
> [10580.153484][  T348]  ? mutex_lock_io_nested+0x1240/0x1240
> [10580.154432][  T348]  ? find_held_lock+0x33/0x1c0
> [10580.155220][  T348]  ? __fdget_pos+0x9c/0xb0
> [10580.155934][  T348]  __fdget_pos+0x9c/0xb0
> [10580.156660][  T348]  __x64_sys_getdents+0xff/0x230
> 
> May be virtiofsd crashed and hence no requests are completing leading
> to a hard lockup?
No, it was not crashed. After I had to forcibly close the guest, the virtiofsd
daemon will exit normally. However, I can't tell exactly if the virtiofsd daemon
was still functioning normally. I'll enable the debug and retry to see if there
is anything interesting.

