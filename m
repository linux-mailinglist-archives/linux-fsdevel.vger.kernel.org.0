Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669284AB5DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 08:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiBGHYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 02:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239806AbiBGHOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:14:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188ADC043181;
        Sun,  6 Feb 2022 23:14:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8AD560F1C;
        Mon,  7 Feb 2022 07:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461A0C004E1;
        Mon,  7 Feb 2022 07:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644218080;
        bh=nniw70zMD1lKzi3bsESypvce1FBgSmU6hzhxOyTg6f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jstWx8JddCSgvPIAV9wlSPQdIkMYIpz4LNBcEqkUl9QmFIRyUZ5PDBxeW1clz27ek
         ZEG/1tHsXP6nGyN+a87Xes3hqV/h12a/XBnyEYIjLvly0Jq7C+wvp9pAFve1MQxcyl
         EGG09eqc25QSDMecwnWoYiTIiKP2yg1HuKeQBeIU=
Date:   Mon, 7 Feb 2022 08:14:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Xu <xuyu@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        arnd@arndb.de, viro@zeniv.linux.org.uk, dhowells@redhat.com
Subject: Re: [PATCH] chardev: call tty_init() in real chrdev_init()
Message-ID: <YgDG2sLEDfkTwpxh@kroah.com>
References: <4e753e51d0516413fbf557cf861d654ca73486cc.1644164597.git.xuyu@linux.alibaba.com>
 <Yf//U1s3DbTuSqo2@kroah.com>
 <e4eb9000-e246-c01b-abde-de1535ff0374@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4eb9000-e246-c01b-abde-de1535ff0374@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 07, 2022 at 02:37:46PM +0800, Yu Xu wrote:
> On 2/7/22 1:03 AM, Greg KH wrote:
> > On Mon, Feb 07, 2022 at 12:27:31AM +0800, Xu Yu wrote:
> > > It is confusing that tty_init() in called in the initialization of
> > > memdev, i.e., static chr_dev_init().
> > > 
> > > Through blame, it is introduced by commit 31d1d48e199e ("Fix init
> > > ordering of /dev/console vs callers of modprobe"), which fixes the
> > > initialization order of /dev/console driver. However, there seems
> > > to be a typo in the patch, i.e., chrdev_init, instead of chr_dev_init.
> > > 
> > > This fixes the typo, IIUC.
> > > 
> > > Note that the return value of tty_init() is always 0, and thus no error
> > > handling is provided in chrdev_init().
> > > 
> > > Fixes: 31d1d48e199e ("Fix init ordering of /dev/console vs callers of modprobe")
> > > Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> > > ---
> > >   drivers/char/mem.c | 2 +-
> > >   fs/char_dev.c      | 1 +
> > >   2 files changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> > > index cc296f0823bd..8c90881f8115 100644
> > > --- a/drivers/char/mem.c
> > > +++ b/drivers/char/mem.c
> > > @@ -775,7 +775,7 @@ static int __init chr_dev_init(void)
> > >   			      NULL, devlist[minor].name);
> > >   	}
> > > -	return tty_init();
> > > +	return 0;
> > >   }
> > >   fs_initcall(chr_dev_init);
> > > diff --git a/fs/char_dev.c b/fs/char_dev.c
> > > index ba0ded7842a7..fc042a0a098f 100644
> > > --- a/fs/char_dev.c
> > > +++ b/fs/char_dev.c
> > > @@ -667,6 +667,7 @@ static struct kobject *base_probe(dev_t dev, int *part, void *data)
> > >   void __init chrdev_init(void)
> > >   {
> > >   	cdev_map = kobj_map_init(base_probe, &chrdevs_lock);
> > > +	tty_init();
> > >   }
> > 
> > You just changed the ordering sequence here, are you SURE this is
> > correct?
> 
> To be honest, not 100% sure.
> 
> > 
> > How was this tested?  Did you verify that the problem that the original
> > commit here was fixing is now not happening again?
> 
> I tried to reproduce the issue described in the original commit, and
> failed. The issue does not appear, or my reproduction is wrong.
>   1. revert 31d1d48e199e manually;
>   2. request_module("xxx") anywhere before do_initcalls(), since
>      tty_init() now is initialized by module_init();
>   3. no warning on request_module is shown.
> 
> > 
> > And what real problem is this solving?  How did you hit the issue that
> > this solves?
> 
> No real problem actually. As described in the log, it is confusing that
> tty_init() in called in the initialization of memdev. They don't have
> strong dependencies. I found the issue when I read through codes of
> drivers/char/mem.c.

It was added here as the linker order is what describes the init calls,
and this call is probably needed before other code in the init call
order, when things are built into the kernel.

That might help in your debugging.

good luck!

greg k-h
