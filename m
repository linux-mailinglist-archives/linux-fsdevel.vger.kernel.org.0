Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E8D40F675
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 13:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbhIQLGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 07:06:19 -0400
Received: from verein.lst.de ([213.95.11.211]:44656 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233439AbhIQLGT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:06:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12D3867357; Fri, 17 Sep 2021 13:04:55 +0200 (CEST)
Date:   Fri, 17 Sep 2021 13:04:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Could we get an IOCB_NO_READ_HOLE?
Message-ID: <20210917110454.GA10535@lst.de>
References: <2315872.1631874463@warthog.procyon.org.uk> <2349284.1631875439@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2349284.1631875439@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 11:43:59AM +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > Would it be possible to get an IOCB_NO_READ_HOLE flag that causes a read to
> > either fail entirely if there's a hole in the file or to stop at the hole,
> > possibly returning -ENODATA if the hole is at the front of the file?
> > 
> > Looking at iomap_dio_iter(), IOMAP_HOLE should be enabled in
> > iomap_iter::iomap.type for this?  Is it that simple?
> 
> Actually, that's not the right thing.  How about the attached - at least for
> direct I/O?

This looks pretty reasonable.  We'll just need to make sure to reject
the flag for the many file operations instances that do not support it.
