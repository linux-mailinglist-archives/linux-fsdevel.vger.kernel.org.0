Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0778585796
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 03:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfHHBXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 21:23:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49848 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfHHBXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:23:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvX98-0000RZ-U7; Thu, 08 Aug 2019 01:23:15 +0000
Date:   Thu, 8 Aug 2019 02:23:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hugh Dickins <hughd@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Howells <dhowells@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] i915: convert to new mount API
Message-ID: <20190808012314.GK1131@ZenIV.linux.org.uk>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
 <20190805160307.5418-3-sergey.senozhatsky@gmail.com>
 <20190805181255.GH1131@ZenIV.linux.org.uk>
 <20190805182834.GI1131@ZenIV.linux.org.uk>
 <alpine.LSU.2.11.1908060007190.1941@eggly.anvils>
 <20190807063002.GG6627@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807063002.GG6627@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 07, 2019 at 08:30:02AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 06, 2019 at 12:50:10AM -0700, Hugh Dickins wrote:
> > Though personally I'm averse to managing "f"objects through
> > "m"interfaces, which can get ridiculous (notably, MADV_HUGEPAGE works
> > on the virtual address of a mapping, but the huge-or-not alignment of
> > that mapping must have been decided previously).  In Google we do use
> > fcntls F_HUGEPAGE and F_NOHUGEPAGE to override on a per-file basis -
> > one day I'll get to upstreaming those.
> 
> Such an interface seems very useful, although the two fcntls seem a bit
> odd.
> 
> But I think the point here is that the i915 has its own somewhat odd
> instance of tmpfs.  If we could pass the equivalent of the huge=*
> options to shmem_file_setup all that garbage (including the
> shmem_file_setup_with_mnt function) could go away.

... or follow shmem_file_super() with whatever that fcntl maps to
internally.  I would really love to get rid of that i915 kludge.
