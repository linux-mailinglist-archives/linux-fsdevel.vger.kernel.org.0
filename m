Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EAF28F313
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgJONSz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 09:18:55 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:52430 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728418AbgJONSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:18:53 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-tbMKmALHMZan0v96HjDSeQ-1; Thu, 15 Oct 2020 09:18:46 -0400
X-MC-Unique: tbMKmALHMZan0v96HjDSeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2123C18A822D;
        Thu, 15 Oct 2020 13:18:44 +0000 (UTC)
Received: from ovpn-112-177.rdu2.redhat.com (ovpn-112-177.rdu2.redhat.com [10.10.112.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 329766EF52;
        Thu, 15 Oct 2020 13:18:36 +0000 (UTC)
Message-ID: <df388727036a6ad85d5ad23f44da5420dda49b4d.camel@lca.pw>
Subject: Re: Unbreakable loop in fuse_fill_write_pages()
From:   Qian Cai <cai@lca.pw>
To:     Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Date:   Thu, 15 Oct 2020 09:18:36 -0400
In-Reply-To: <20201013184026.GC142988@redhat.com>
References: <7d350903c2aa8f318f8441eaffafe10b7796d17b.camel@redhat.com>
         <20201013184026.GC142988@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: lca.pw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-10-13 at 14:40 -0400, Vivek Goyal wrote:
> > == the thread is stuck in the loop ==
> > [10813.290694] task:trinity-c33     state:D stack:25888 pid:254219 ppid:
> > 87180
> > flags:0x00004004
> > [10813.292671] Call Trace:
> > [10813.293379]  __schedule+0x71d/0x1b50
> > [10813.294182]  ? __sched_text_start+0x8/0x8
> > [10813.295146]  ? mark_held_locks+0xb0/0x110
> > [10813.296117]  schedule+0xbf/0x270
> > [10813.296782]  ? __lock_page_killable+0x276/0x830
> > [10813.297867]  io_schedule+0x17/0x60
> > [10813.298772]  __lock_page_killable+0x33b/0x830
> 
> This seems to suggest that filemap_fault() is blocked on page lock and
> is sleeping. For some reason it never wakes up. Not sure why.
> 
> And this will be called from.
> 
> fuse_fill_write_pages()
>    iov_iter_fault_in_readable()
> 
> So fuse code will take inode_lock() and then looks like same process
> is sleeping waiting on page lock. And rest of the processes get blocked
> behind inode lock.
> 
> If we are woken up (while waiting on page lock), we should make forward
> progress. Question is what page it is and why the entity which is
> holding lock is not releasing lock.

FYI, it was mentioned that this is likely a deadlock in FUSE:

https://lore.kernel.org/linux-fsdevel/CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com/



