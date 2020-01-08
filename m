Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0156113390A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 03:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgAHCMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 21:12:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46932 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgAHCMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:12:45 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0082CcAW011129
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 21:12:39 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 676804207DF; Tue,  7 Jan 2020 21:12:38 -0500 (EST)
Date:   Tue, 7 Jan 2020 21:12:38 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH -v2] memcg: fix a crash in wb_workfn when a device
 disappears
Message-ID: <20200108021238.GA218104@mit.edu>
References: <20191227194829.150110-1-tytso@mit.edu>
 <20191228005211.163952-1-tytso@mit.edu>
 <20200107153348.388a20e85e045d209c459e52@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107153348.388a20e85e045d209c459e52@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 03:33:48PM -0800, Andrew Morton wrote:
> On Fri, 27 Dec 2019 19:52:11 -0500 "Theodore Ts'o" <tytso@mit.edu> wrote:
> 
> > Unfortunately, del_gendisk() in block/gen_hd.c never got the memo
> > about the Brave New memcg World, and calls bdi_unregister directly.
> > It does this without informing the file system, or the memcg code, or
> > anything else.  This causes the root wb associated with the bdi to be
> > unregistered, but none of the memcg-specific wb's are shutdown.  So when
> > one of these wb's are woken up to do delayed work, they try to
> > dereference their wb->bdi->dev to fetch the device name, but
> > unfortunately bdi->dev is now NULL, thanks to the bdi_unregister()
> > called by del_gendisk().   As a result, *boom*.
> > 
> > Fortunately, it looks like the rest of the writeback path is perfectly
> > happy with bdi->dev and bdi->owner being NULL, so the simplest fix is
> > to create a bdi_dev_name() function which can handle bdi->dev being
> > NULL.  This also allows us to bulletproof the writeback tracepoints to
> > prevent them from dereferencing a NULL pointer and crashing the kernel
> > if one is tracing with memcg's enabled, and an iSCSI device dies or a
> > USB storage stick is pulled.
> 
> Is hotremoval of a device while tracing writeback the only known way of
> triggering this?

The most common way of triggering this will be hotremoval of a device
while writeback with memcg enabled is going on.  It was triggering
several times a day in a heavily loaded production environment.

> Is it worth a cc:stable?

Yes, I think so.

						- Ted
