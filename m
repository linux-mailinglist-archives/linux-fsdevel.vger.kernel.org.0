Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5BE20DB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 19:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfEPRHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 13:07:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59624 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfEPRHM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 13:07:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hRJqV-0004SL-PF; Thu, 16 May 2019 17:07:07 +0000
Date:   Thu, 16 May 2019 18:07:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] fs: create simple_remove() helper
Message-ID: <20190516170707.GE17978@ZenIV.linux.org.uk>
References: <20190516102641.6574-1-amir73il@gmail.com>
 <20190516102641.6574-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516102641.6574-3-amir73il@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 01:26:29PM +0300, Amir Goldstein wrote:
> There is a common pattern among pseudo filesystems for removing a dentry
> from code paths that are NOT coming from vfs_{unlink,rmdir}, using a
> combination of simple_{unlink,rmdir} and d_delete().
> 
> Create an helper to perform this common operation.  This helper is going
> to be used as a place holder for the new fsnotify_{unlink,rmdir} hooks.

This is the wrong approach.  What we have is a bunch of places trying
to implement recursive removal of a subtree.  They are broken, each in
its own way, and I'm not talking about fsnotify crap - there are
much more unpleasant issues there.

Trying to untangle that mess is not going to be made easier by mandating
the calls of that helper of yours - if anything, it makes the whole
thing harder to massage.

It needs to be dealt with, no arguments here, but that's not a good
starting point for that...  I've taken several stabs at that, never
got anywhere satisfactory with those ;-/  I'll try to dig out the
notes/existing attempts at patch series; if you are willing to participate
in discussing those and sorting the whole thing out, you are very welcome;
just ping me in a couple of days.
