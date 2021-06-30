Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E73B7D05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 07:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhF3Fic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 01:38:32 -0400
Received: from verein.lst.de ([213.95.11.211]:42826 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhF3Fib (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 01:38:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E3C267373; Wed, 30 Jun 2021 07:36:01 +0200 (CEST)
Date:   Wed, 30 Jun 2021 07:36:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Virtio-fs] [PATCH 3/2] fs: simplify get_filesystem_list /
 get_all_fs_names
Message-ID: <20210630053601.GA29241@lst.de>
References: <20210621062657.3641879-1-hch@lst.de> <20210622081217.GA2975@lst.de> <YNGhERcnLuzjn8j9@stefanha-x1.localdomain> <20210629205048.GE5231@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629205048.GE5231@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 04:50:48PM -0400, Vivek Goyal wrote:
> May be we should modify mount_block_root() code so that it does not
> require that extra "\0". Possibly zero initialize page and that should
> make sure list_bdev_fs_names() does not have to worry about it.
> 
> It is possible that a page gets full from the list of filesystems, and
> last byte on page is terminating null. In that case just zeroing page
> will not help. We can keep track of some sort of end pointer and make
> sure we are not searching beyond that for valid filesystem types.
> 
> end = page + PAGE_SIZE - 1;
> 
> mount_block_root()
> {
> 	for (p = fs_names; p < end && *p; p += strlen(p)+1) {
> 	}
> }

Maybe.  To honest I'd prefer to not even touch this unrelated code given
how full of landmines it is :)
