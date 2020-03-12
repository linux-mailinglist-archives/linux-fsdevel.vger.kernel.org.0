Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3AF9182E51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 11:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgCLKxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 06:53:48 -0400
Received: from verein.lst.de ([213.95.11.211]:36273 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLKxs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:53:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 476C168C4E; Thu, 12 Mar 2020 11:53:45 +0100 (CET)
Date:   Thu, 12 Mar 2020 11:53:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, mbobrowski@mbobrowski.org,
        darrick.wong@oracle.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Is ext4_dio_read_iter() broken? - and xfs_file_dio_aio_read()
Message-ID: <20200312105345.GA13559@lst.de>
References: <20200312104239.GA13235@lst.de> <969260.1584004779@warthog.procyon.org.uk> <1015227.1584007677@warthog.procyon.org.uk> <1023937.1584010180@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1023937.1584010180@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 10:49:40AM +0000, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > > > at the end of the function - but surely iocb should be expected to have
> > > > been freed when iocb->ki_complete() was called?
> > 
> > The iocb is refcounted and only completed when the refcount hits zero,
> > and an extra reference is held until the submission has completed.
> > Take a look at iocb_put().
> 
> Ah...  This is in struct aio_kiocb and not struct kiocb - that's why I missed
> it.  Thanks.

That being said we have a few other spots using ->ki_complete for
asynchronous execution, which might not be as careful.  As someone
having written one or two of those I have my doubts I got everthing
right and will audit those.

> 
> David
---end quoted text---
