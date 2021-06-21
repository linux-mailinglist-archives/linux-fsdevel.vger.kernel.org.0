Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7243AEBC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFUOz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:55:26 -0400
Received: from verein.lst.de ([213.95.11.211]:42281 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhFUOzZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:55:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E2D4F68B05; Mon, 21 Jun 2021 16:53:09 +0200 (CEST)
Date:   Mon, 21 Jun 2021 16:53:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Subject: Re: [PATCH 1/2] init: split get_fs_names
Message-ID: <20210621145309.GA4995@lst.de>
References: <20210621062657.3641879-1-hch@lst.de> <20210621062657.3641879-2-hch@lst.de> <YNCmTSTcubslmj7k@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNCmTSTcubslmj7k@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 02:46:37PM +0000, Al Viro wrote:
> TBH, I would rather take that one into fs/filesystems.c.  Rationale:
> get_filesystem_list(), for all its resemblance to /proc/filesystems
> contents, is used only by init/*.c and it's not a big deal to make
> it

Yeah, unwinding this mess actually is a good idea.  I didn't really
look outside of do_mounts.c, but once doing that it becomes completely
obvious.

> int __init get_filesystem_list(char *buf, bool is_dev)

As-is we don't even really need the is_dev argument, as the only
callers wants block device file systems anyway.  In fact it would
much rather have a cursor based iteration so that we can skip the
allocation, but that is probaby overengineering the problem.
