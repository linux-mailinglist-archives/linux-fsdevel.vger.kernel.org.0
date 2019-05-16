Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D5A20CC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfEPQRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 12:17:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58908 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfEPQRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 12:17:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hRJ4l-0003JI-Co; Thu, 16 May 2019 16:17:47 +0000
Date:   Thu, 16 May 2019 17:17:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH v2 00/14] Sort out fsnotify_nameremove() mess
Message-ID: <20190516161747.GA17978@ZenIV.linux.org.uk>
References: <20190516102641.6574-1-amir73il@gmail.com>
 <20190516122506.GF13274@quack2.suse.cz>
 <CAOQ4uxjiHuN7dcciucaRXvhj6g9wgz4k313NV3c_XbUrC8+sug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjiHuN7dcciucaRXvhj6g9wgz4k313NV3c_XbUrC8+sug@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 04:56:20PM +0300, Amir Goldstein wrote:

> > Why is this a cleanup? detach_groups() is used also from
> > configfs_detach_group() which gets called from configfs_rmdir() which is
> > real deletion.
> 
> True, configfs is a special case where both cleanup and real deletion
> use the same helper. configfs_detach_group() is either called for cleanup
> or from vfs_rmdir->configfs_rmdir()/configfs_unregister_{group,subsystem}()
> the latter 3 cases have new fsnotify hooks.

FWIW, I've an old series on configfs, from the "deal with kernel-side rm -rf
properly" pile.

I'll try to resurrect and post it.  A _lot_ of locking crap in there is
due to the bad idea of having the subtree being built reachable from
root as we are putting it together; massaging it to the form when we
build a subtree and move it in place only when we are past the last
failure makes for much simpler logics, for obvious reasons.  The massage
is not trivial, though.

In general, the problem with kernel-side recursive removals is that
a bunch of places are trying to cobble local solutions for the problem
that is actually a missing primitive.  And fucking it up in all kinds
of ways.  We definitely want a unified primitive for that; the question
is what kind of API would be kludge-free for callers.

I've a pile of notes and half-assed patch series in that direction;
I'll dig it out and try to get something coherent out of it.
