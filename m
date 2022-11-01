Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA18614C71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 15:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiKAOSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 10:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiKAOSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:18:38 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A371AF14;
        Tue,  1 Nov 2022 07:18:37 -0700 (PDT)
Date:   Tue, 1 Nov 2022 15:18:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1667312315;
        bh=eWSIPclms01KjYjA5VUmApls1+Dnk2NcSxLgH6ipEM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NL6hLCNtVI6itNLH/NgfTKNv4KpmMSsmnOwvYKVhkwLHYDFgYgSE5IYz5uiuUEaBX
         APHhx9dsBjG4mOK+Ul6uBmQ+3hAe+3O400RL/WJ0ecFaZEcRGcEQo8Rwo+TW0dt/z8
         hZwXqHaLaMoZPL/tdSciqrXg6Y9hbJenQxpaHtMI=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karel Zak <kzak@redhat.com>,
        Masatake YAMATO <yamato@redhat.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] proc: add byteorder file
Message-ID: <5366767c-2282-4de3-9023-3468b14ec947@t-8ch.de>
References: <20221101130401.1841-1-linux@weissschuh.net>
 <Y2EfK2CnHLq5HF9B@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2EfK2CnHLq5HF9B@kroah.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-11-01 14:29+0100, Greg KH wrote:
> On Tue, Nov 01, 2022 at 02:04:01PM +0100, Thomas Weißschuh wrote:
> > Certain files in procfs are formatted in byteorder dependent ways. For
> > example the IP addresses in /proc/net/udp.
> > 
> > Assuming the byteorder of the userspace program is not guaranteed to be
> > correct in the face of emulation as for example with qemu-user.
> > 
> > Also this makes it easier for non-compiled applications like
> > shellscripts to discover the byteorder.
> 
> Your subject says "proc" :(

Will fix.

> Also you do not list the new file name here in the changelog text, why
> not?

Please see below, or am I missing something?

> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > 
> > ---
> > 
> > Development of userspace part: https://github.com/util-linux/util-linux/pull/1872
> > 
> > v1: https://lore.kernel.org/lkml/20221101005043.1791-1-linux@weissschuh.net/
> > v1->v2:
> >   * Move file to /sys/kernel/byteorder
                    ^^^^^^^^^^^^^^^^^^^^^^
New filename in changelog above

> > ---
> >  .../ABI/testing/sysfs-kernel-byteorder         | 12 ++++++++++++
> >  kernel/ksysfs.c                                | 18 ++++++++++++++++++
> >  2 files changed, 30 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-kernel-byteorder
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-byteorder b/Documentation/ABI/testing/sysfs-kernel-byteorder
> > new file mode 100644
> > index 000000000000..4c45016d78ae
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-byteorder
> > @@ -0,0 +1,12 @@
> > +What:		/sys/kernel/byteorder
> > +Date:		February 2023
> > +KernelVersion:	6.2
> > +Contact:	linux-fsdevel@vger.kernel.org
> 
> Why is this a filesystem thing?  I don't see how that is true.

For procfs this is the list that was repored by get_maintainer.pl, so I reused
it.

I'm not entirely sure whom to put here.
Myself? You? Some mailing list?

> > +Description:
> > +		The current endianness of the running kernel.
> > +
> > +		Access: Read
> > +
> > +		Valid values:
> > +			"little", "big"
> > +Users:		util-linux
> > diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> > index 65dba9076f31..7c7cb2c96ac0 100644
> > --- a/kernel/ksysfs.c
> > +++ b/kernel/ksysfs.c
> > @@ -6,6 +6,7 @@
> >   * Copyright (C) 2004 Kay Sievers <kay.sievers@vrfy.org>
> >   */
> >  
> > +#include <asm/byteorder.h>
> >  #include <linux/kobject.h>
> >  #include <linux/string.h>
> >  #include <linux/sysfs.h>
> > @@ -20,6 +21,14 @@
> >  
> >  #include <linux/rcupdate.h>	/* rcu_expedited and rcu_normal */
> >  
> > +#if defined(__LITTLE_ENDIAN)
> > +#define BYTEORDER_STRING	"little"
> > +#elif defined(__BIG_ENDIAN)
> > +#define BYTEORDER_STRING	"big"
> > +#else
> > +#error Unknown byteorder
> > +#endif
> > +
> >  #define KERNEL_ATTR_RO(_name) \
> >  static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
> >  
> > @@ -34,6 +43,14 @@ static ssize_t uevent_seqnum_show(struct kobject *kobj,
> >  }
> >  KERNEL_ATTR_RO(uevent_seqnum);
> >  
> > +/* kernel byteorder */
> > +static ssize_t byteorder_show(struct kobject *kobj,
> > +			      struct kobj_attribute *attr, char *buf)
> > +{
> > +	return sprintf(buf, "%s\n", BYTEORDER_STRING);
> 
> sysfs_emit() please.

The rest of the file also uses plain `sprintf()` everywhere. I'll fix my patch
and send a second commit to migrate the other users.

> And this really is CPU byteorder, right?  We have processors that have
> devices running in different byteorder than the CPU.  userspace usually
> doesn't need to know about that, but it might be good to be specific.

Will do.

Thomas
