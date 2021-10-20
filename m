Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4AC434F3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 17:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJTPrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 11:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229570AbhJTPrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634744706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WuuIsN7C2S1G+5M5cwToPHcThlVfLk7/Vcq15pYpeqw=;
        b=KtDXpEkXZwUE1Z9Ewa/ApMbZQmDDsRehuh4tPSCnUdCxz7hqImIbE0K5nwGjqP9FyoN2VU
        9pfS8o2uADU8I7ipyBaB0m6Cmb7Q1n2f56sl/h8psosOVltLDBgvjaV62PSkXZrEymgEqP
        qkYFnW4FXpppCt+K/OGdA+gLXtMRMdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-0i6RdFSsM1C-FNvWkbccAg-1; Wed, 20 Oct 2021 11:45:03 -0400
X-MC-Unique: 0i6RdFSsM1C-FNvWkbccAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9869801B1C;
        Wed, 20 Oct 2021 15:45:00 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C105018032;
        Wed, 20 Oct 2021 15:44:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 160B02256FC; Wed, 20 Oct 2021 11:44:53 -0400 (EDT)
Date:   Wed, 20 Oct 2021 11:44:53 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 4/7] fuse: negotiate per-file DAX in FUSE_INIT
Message-ID: <YXA5dWiJseIcdxiH@redhat.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-5-jefflexu@linux.alibaba.com>
 <YW2E6jaTbv1FcFnu@redhat.com>
 <778cd99d-fb40-1135-5d62-58a008c14919@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <778cd99d-fb40-1135-5d62-58a008c14919@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:10:30AM +0800, JeffleXu wrote:
> 
> 
> On 10/18/21 10:30 PM, Vivek Goyal wrote:
> > On Mon, Oct 11, 2021 at 11:00:49AM +0800, Jeffle Xu wrote:
> >> Among the FUSE_INIT phase, client shall advertise per-file DAX if it's
> >> mounted with "-o dax=inode". Then server is aware that client is in
> >> per-file DAX mode, and will construct per-inode DAX attribute
> >> accordingly.
> >>
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> ---
> >>  fs/fuse/inode.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >> index b4b41683e97e..f4ad99e2415b 100644
> >> --- a/fs/fuse/inode.c
> >> +++ b/fs/fuse/inode.c
> >> @@ -1203,6 +1203,8 @@ void fuse_send_init(struct fuse_mount *fm)
> >>  #ifdef CONFIG_FUSE_DAX
> >>  	if (fm->fc->dax)
> >>  		ia->in.flags |= FUSE_MAP_ALIGNMENT;
> >> +	if (fm->fc->dax_mode == FUSE_DAX_INODE)
> >> +		ia->in.flags |= FUSE_PERFILE_DAX;
> > 
> > Are you not keeping track of server's response whether server supports
> > per inode dax or not. Client might be new and server might be old and
> > server might not support per inode dax. In that case, we probably 
> > should error out if user mounted with "-o dax=inode".
> > 
> 
> Yes, if guest virtiofs is mounted with '-o dax=inode' while virtiofsd is
> old and doesn't support per inode dax, then guest virtiofs will never
> receive FUSE_ATTR_DAX and actually behaves as '-o dax=never'. So the
> whole system works in this case, though the behavior may be beyond the
> expectation of users ....
> 
> If the behavior really matters, I could change the behavior and fail
> directly if virtiofsd doesn't advertise supporting per inode DAX.

I think it probably is better to error out if client asked for per-inode
DAX and server does not support it. 

Vivek
> 
> -- 
> Thanks,
> Jeffle
> 

