Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF298AB07A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 04:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404309AbfIFCAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 22:00:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46100 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404307AbfIFCAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:00:24 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i63Xt-0005wH-AW; Fri, 06 Sep 2019 02:00:17 +0000
Date:   Fri, 6 Sep 2019 03:00:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jun Li <jun.li@nxp.com>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "renxudong1@huawei.com" <renxudong1@huawei.com>
Subject: Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190906020017.GV1131@ZenIV.linux.org.uk>
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
 <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <20190905174744.GP1131@ZenIV.linux.org.uk>
 <VE1PR04MB652816E4C0903D7489F2E08589BA0@VE1PR04MB6528.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB652816E4C0903D7489F2E08589BA0@VE1PR04MB6528.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 12:55:22AM +0000, Jun Li wrote:
> > Huh?
> > In drivers/usb/typec/tcpm/tcpm.c:
> > static void tcpm_debugfs_exit(struct tcpm_port *port) {
> >         int i;
> > 
> >         mutex_lock(&port->logbuffer_lock);
> >         for (i = 0; i < LOG_BUFFER_ENTRIES; i++) {
> >                 kfree(port->logbuffer[i]);
> >                 port->logbuffer[i] = NULL;
> >         }
> >         mutex_unlock(&port->logbuffer_lock);
> > 
> >         debugfs_remove(port->dentry);
> >         if (list_empty(&rootdir->d_subdirs)) {
> >                 debugfs_remove(rootdir);
> >                 rootdir = NULL;
> >         }
> > }
> > 
> > Unrelated, but obviously broken.  Not only the locking is deeply suspect, but it's trivially
> > confused by open() on the damn directory.  It will definitely have ->d_subdirs non-empty.
> > 
> > Came in "usb: typec: tcpm: remove tcpm dir if no children", author Cc'd...  Why not
> > remove the directory on rmmod?
> 
> That's because tcpm is a utility driver and there may be multiple instances
> created under the directory, each instance/user removal will call to tcpm_debugfs_exit()
> but only the last one should remove the directory.

Er...  So why not have the directory present for as long as the module is in,
removing it on rmmod?

> Below patch changed this by using dedicated dir for each instance:
> 
> https://www.spinics.net/lists/linux-usb/msg183965.html

*shrug*

Up to you; the variant in mainline is obviously broken (open the debugfs
directory and you'll confuse the hell out of that check).  My preference
in fixing those would've been to make mkdir and rmdir of the parent
unconditional, happening on module_init() and module_exit() resp., not
bothering with "is that the last one" checks, but I'm (a) not a user of that
code and (b) currently not quite sober, so I'll just leave that to you guys.
