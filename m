Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF47651A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjG0Kt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 06:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjG0Kt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:49:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609961B0;
        Thu, 27 Jul 2023 03:49:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E794061E2D;
        Thu, 27 Jul 2023 10:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CBFC433C8;
        Thu, 27 Jul 2023 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690454996;
        bh=9W2ljgkyM4tLPmmGQe1w7tQZutLGGSdtT7DBysYE1gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujDlYZ1htpoVL0FDx0sd0QeI5j1BmBtMpui+5/gA8V45dat8OAdStu6qcfdxh2LcK
         7Lj+pwFXHuYP8kxrhtmfTzXm0gUA+nqF6EbwV5B4DmjEGkDPZbVFx6fcz5UYhapJm9
         QGwzEjmtpT3Lvqwmy3hnkaTEdSE0vC9dcJRl+S0wv/LlGqKOx506px/rVfcnc48f7f
         2aEP3dZScCyOR+FjxcwnKphVpW99wEy3uYIkI7nqJg20bxMpHd5Nh0UyCL5w+qxUVB
         pMadIs4imOl5s7rv47EGLX2hZf/8fCTN8J4pLC/0GHz677PQ4wbWM8mhgtnS1NMJ8c
         AKimb8tnAvIiw==
Date:   Thu, 27 Jul 2023 12:49:51 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>, viro@zeniv.linux.org.uk,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org
Subject: Re: [PATCH v2] init: Add support for rootwait timeout parameter
Message-ID: <20230727-speerwerfen-tiefpunkt-c4cde40994af@brauner>
References: <20230726152232.932288-1-loic.poulain@linaro.org>
 <1d363177-2629-1ab3-7a4b-bc67d94bb87a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d363177-2629-1ab3-7a4b-bc67d94bb87a@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:08:35PM -0700, Randy Dunlap wrote:
> Hi--
> 
> On 7/26/23 08:22, Loic Poulain wrote:
> > Add an optional timeout arg to 'rootwait' as the maximum time in
> > seconds to wait for the root device to show up before attempting
> > forced mount of the root filesystem.
> > 
> > Use case:
> > In case of device mapper usage for the rootfs (e.g. root=/dev/dm-0),
> > if the mapper is not able to create the virtual block for any reason
> > (wrong arguments, bad dm-verity signature, etc), the `rootwait` param
> > causes the kernel to wait forever. It may however be desirable to only
> > wait for a given time and then panic (force mount) to cause device reset.
> > This gives the bootloader a chance to detect the problem and to take some
> > measures, such as marking the booted partition as bad (for A/B case) or
> > entering a recovery mode.
> > 
> > In success case, mounting happens as soon as the root device is ready,
> > unlike the existing 'rootdelay' parameter which performs an unconditional
> > pause.
> > 
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > ---
> >  v2: rebase + reword: add use case example
> > 
> >  .../admin-guide/kernel-parameters.txt         |  4 ++++
> >  init/do_mounts.c                              | 19 +++++++++++++++++--
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> > 
> 
> > diff --git a/init/do_mounts.c b/init/do_mounts.c
> > index 1aa015883519..118f2bbe7b38 100644
> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/ramfs.h>
> >  #include <linux/shmem_fs.h>
> > +#include <linux/ktime.h>
> >  
> >  #include <linux/nfs_fs.h>
> >  #include <linux/nfs_fs_sb.h>
> > @@ -71,12 +72,20 @@ static int __init rootwait_setup(char *str)
> >  {
> >  	if (*str)
> >  		return 0;
> > -	root_wait = 1;
> > +	root_wait = -1;
> >  	return 1;
> >  }
> >  
> >  __setup("rootwait", rootwait_setup);
> >  
> > +static int __init rootwait_timeout_setup(char *str)
> > +{
> > +	root_wait = simple_strtoul(str, NULL, 0);
> 
> Better to use kstrtoul().  simple_strtoul() says:
> 
>  * This function has caveats. Please use kstrtoul instead.
> 
> and kstrtoul() says:
> 
>  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
>  * Preferred over simple_strtoul(). Return code must be checked.

Yes, this should check and at least log an error that rootwait is
ignored and fall back to either indefinite waiting or no waiting.
