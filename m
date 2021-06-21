Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C514C3AEBE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFUPB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 11:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUPB0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:01:26 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C956BC061574;
        Mon, 21 Jun 2021 07:59:11 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvLOD-00AraI-NG; Mon, 21 Jun 2021 14:59:05 +0000
Date:   Mon, 21 Jun 2021 14:59:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: Re: [PATCH 1/2] init: split get_fs_names
Message-ID: <YNCpOaNHRA9jEOpM@zeniv-ca.linux.org.uk>
References: <20210621062657.3641879-1-hch@lst.de>
 <20210621062657.3641879-2-hch@lst.de>
 <YNCmTSTcubslmj7k@zeniv-ca.linux.org.uk>
 <20210621145309.GA4995@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621145309.GA4995@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 04:53:09PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 21, 2021 at 02:46:37PM +0000, Al Viro wrote:
> > TBH, I would rather take that one into fs/filesystems.c.  Rationale:
> > get_filesystem_list(), for all its resemblance to /proc/filesystems
> > contents, is used only by init/*.c and it's not a big deal to make
> > it
> 
> Yeah, unwinding this mess actually is a good idea.  I didn't really
> look outside of do_mounts.c, but once doing that it becomes completely
> obvious.
> 
> > int __init get_filesystem_list(char *buf, bool is_dev)
> 
> As-is we don't even really need the is_dev argument, as the only
> callers wants block device file systems anyway.

*nod*

> In fact it would
> much rather have a cursor based iteration so that we can skip the
> allocation, but that is probaby overengineering the problem.

Very much so.

Sigh...  I really wish we had more uniform syntax, though -
e.g.  root=nfs(<options>) or root=xfs(sdb11,noatime), etc.
Oh, well...
