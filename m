Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE413BB3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAOIgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:36:24 -0500
Received: from verein.lst.de ([213.95.11.211]:49581 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgAOIgX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:36:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D06A568B05; Wed, 15 Jan 2020 09:36:19 +0100 (CET)
Date:   Wed, 15 Jan 2020 09:36:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, hch@lst.de,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Making linkat() able to overwrite the target
Message-ID: <20200115083619.GA23039@lst.de>
References: <3326.1579019665@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3326.1579019665@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 04:34:25PM +0000, David Howells wrote:
> 
> when a file gets invalidated by the server - and, under some circumstances,
> modified locally - I have the cache create a temporary file with vfs_tmpfile()
> that I'd like to just link into place over the old one - but I can't because
> vfs_link() doesn't allow you to do that.  Instead I have to either unlink the
> old one and then link the new one in or create it elsewhere and rename across.
> 
> Would it be possible to make linkat() take a flag, say AT_LINK_REPLACE, that
> causes the target to be replaced and not give EEXIST?  Or make it so that
> rename() can take a tmpfile as the source and replace the target with that.  I
> presume that, either way, this would require journal changes on ext4, xfs and
> btrfs.

This sounds like a very useful primitive, and from the low-level XFS
point of view should be very easy to implement and will not require any
on-disk changes.  I can't really think of any good userspace interface but
a new syscall, though.
