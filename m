Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AB540A761
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbhINHb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:31:26 -0400
Received: from verein.lst.de ([213.95.11.211]:58878 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239257AbhINHbZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:31:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9922B67373; Tue, 14 Sep 2021 09:30:04 +0200 (CEST)
Date:   Tue, 14 Sep 2021 09:30:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] xfs: convert xfs_sysfs attrs to use ->seq_show
Message-ID: <20210914073003.GA31077@lst.de>
References: <20210913054121.616001-1-hch@lst.de> <20210913054121.616001-14-hch@lst.de> <YT7vZthsMCM1uKxm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT7vZthsMCM1uKxm@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 08:27:50AM +0200, Greg Kroah-Hartman wrote:
> Anyway, I like the idea, but as you can see here, it could lead to even
> more abuse of sysfs files.  We are just now getting people to use
> sysfs_emit() and that is showing us where people have been abusing the
> api in bad ways.

To be honest I've always seen sysfs_emit as at best a horrible band aid
to enforce the PAGE_SIZE bounds checking.  Better than nothing, but
not a solution at all, as you can't force anyone to actually use it.

> Is there any way that sysfs can keep the existing show functionality and
> just do the seq_printf() for the buffer returned by the attribute file
> inside of the sysfs core?

Well, you'd need one page allocated in the seq_file code, and one in
the sysfs code.  At which point we might as well drop using seq_file
at all.  But in general seq_file seems like a very nice helper for
over flow free printing into a buffer.  If sysfs files actually were
all limited to a single print we wouldn't really need it, and could
just have something like sysfs_emit just with the buffer hidden inside
a structure that is opaqueue to the caller.  But looking at various
attributes that is not exactly the case.  While the majority certainly
uses a single value and a single print statement there is plenty where
this is not the case.  Either because they use multiple values, or
often also because they dynamically append to the string to print
things like comma-separated flags.
