Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C84179884
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 20:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgCDTDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 14:03:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47921 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729600AbgCDTDO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:03:14 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 024J2v05005325
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Mar 2020 14:02:57 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DE8A242045B; Wed,  4 Mar 2020 14:02:56 -0500 (EST)
Date:   Wed, 4 Mar 2020 14:02:56 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tj@kernel.org, jack@suse.cz, bvanassche@acm.org
Subject: Re: [PATCH v2 0/7] bdi: fix use-after-free for bdi device
Message-ID: <20200304190256.GB74069@mit.edu>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200304172907.GA1864710@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304172907.GA1864710@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 06:29:07PM +0100, Greg KH wrote:
> The rule should be, "whenever you pass a pointer to a device off, the
> reference count is incremented".  Somehow that is not happening here and
> RCU is not going to solve the issue really, it's only going to delay the
> problem from showing up until much later.
> ...
> The struct device refcount should be all that is needed, don't use RCU
> just to "delay freeing this object until some later time because someone
> else might have a pointer to id".  That's ripe for disaster.

I agree that this is a better fix than trying to continue to paper
over the problem.

That being said, I also think it would be better if we could *also*
send a notification to the file system (or device mapper) when a block
device has disappeared, so we can set a flag in struct super
indicating, "this is an ex-device" so that we don't have to have
potentially hundreds of I/O errors clogging up the console and/or any
error notification ifrastructure we might want to add in the future,
as we attempt to send I/O to a device is not coming back.  This would
allow us to short-circuit things like writeback, instead of letting
everything drain via pointless io_submits sending bios that will never
go anywhere useful.

					- Ted
