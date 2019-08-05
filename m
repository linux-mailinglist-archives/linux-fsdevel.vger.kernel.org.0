Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C655827EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 01:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfHEXeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 19:34:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43698 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfHEXeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 19:34:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1humU9-0007b9-41; Mon, 05 Aug 2019 23:33:49 +0000
Date:   Tue, 6 Aug 2019 00:33:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] i915: convert to new mount API
Message-ID: <20190805233349.GA27746@ZenIV.linux.org.uk>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
 <20190805160307.5418-3-sergey.senozhatsky@gmail.com>
 <20190805181255.GH1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805181255.GH1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 07:12:55PM +0100, Al Viro wrote:
> On Tue, Aug 06, 2019 at 01:03:06AM +0900, Sergey Senozhatsky wrote:
> > tmpfs does not set ->remount_fs() anymore and its users need
> > to be converted to new mount API.
> 
> Could you explain why the devil do you bother with remount at all?
> Why not pass the right options when mounting the damn thing?

Incidentally, the only remaining modular user of get_fs_type() is the
same i915_gemfs.c.  And I wonder if we should aim for unexporting
the damn thing instead of exporting put_filesystem()...

Note that users in tomoyo and apparmor are bogus - they are in the
instances of ill-defined method that needs to be split and moved,
with the lookups (fs type included) replaced with callers passing
the values they look up and will end up using.

IOW, outside of core VFS we have very few legitimate users, and the
one in kernel/trace might be better off as vfs_submount_by_name().
