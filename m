Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3857795700
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 07:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfHTF42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 01:56:28 -0400
Received: from verein.lst.de ([213.95.11.211]:53805 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbfHTF42 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 01:56:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A94A668B02; Tue, 20 Aug 2019 07:56:23 +0200 (CEST)
Date:   Tue, 20 Aug 2019 07:56:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2 2/2] i915: do not leak module ref counter
Message-ID: <20190820055623.GC27501@lst.de>
References: <20190820031359.11717-1-sergey.senozhatsky@gmail.com> <20190820031359.11717-2-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820031359.11717-2-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 12:13:59PM +0900, Sergey Senozhatsky wrote:
> Always put_filesystem() in i915_gemfs_init().
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  - v2: rebased (i915 does not remount gemfs anymore)

Which means it real doesn't need its mount anyore, and thus can use
plain old shmem_file_setup and doesn't need to mess with file system
types at all.

Assuming we find a legitimate rason for why a driver should be able
to create a kernel mount or a file system type where it doesn't have
access to the struct file_system_type an API that mount by file system
name and thus hides the get_fs_type and put_filesystem would be a much
better API than adding this random export.
