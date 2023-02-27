Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9023B6A4946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 19:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjB0SI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 13:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjB0SIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3614B22783
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 10:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677521218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A0XiMaVk2NRHD3G7gBjNzwZV65APgDc5PN3bQr3CxgQ=;
        b=X50tPI7l4cL7yiT+rvVNQXFVa9QVpEMsKBxpFKvrgRo86rod2HQubSSMtEtCdLzj/Lbvvw
        VFxOgjh79jA1aq2p44QQPDvT+GozSuHvMuFn4HQF0ogOBPSr66Io58vgNThE4yCaXiIjMB
        wxmLdi94jj2fbHIjdDG7kAxYQMR1+ZM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-xsKvlzbSMLCqXzj1QpnMwQ-1; Mon, 27 Feb 2023 13:06:52 -0500
X-MC-Unique: xsKvlzbSMLCqXzj1QpnMwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FD97802D2E;
        Mon, 27 Feb 2023 18:06:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A71062026D4B;
        Mon, 27 Feb 2023 18:06:51 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
        id 40EAF139788; Mon, 27 Feb 2023 13:06:51 -0500 (EST)
Date:   Mon, 27 Feb 2023 13:06:51 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, helen.koike@collabora.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, akpm@linux-foundation.org,
        David Heidelberg <david@ixit.cz>
Subject: Re: [RESEND v2 PATCH] init/do_mounts.c: add virtiofs root fs support
Message-ID: <Y/zxO9PMaES8SenN@redhat.com>
References: <20230224143751.36863-1-david@ixit.cz>
 <Y/zSCarxyabSC1Zf@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/zSCarxyabSC1Zf@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:53:45AM -0500, Stefan Hajnoczi wrote:
> On Fri, Feb 24, 2023 at 03:37:51PM +0100, David Heidelberg wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > Make it possible to boot directly from a virtiofs file system with tag
> > 'myfs' using the following kernel parameters:
> > 
> >   rootfstype=virtiofs root=myfs rw
> > 
> > Booting directly from virtiofs makes it possible to use a directory on
> > the host as the root file system.  This is convenient for testing and
> > situations where manipulating disk image files is cumbersome.
> > 
> > Reviewed-by: Helen Koike <helen.koike@collabora.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> > v2: added Reviewed-by and CCed everyone interested.
> > 
> > We have used this option in Mesa3D CI for testing crosvm for
> > more than one years and it's proven to work reliably.
> > 
> > We are working on effort to removing custom patches to be able to do 
> > automated apply and test of patches from any tree.                              
> > 
> > https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/crosvm-runner.sh#L85
> >  init/do_mounts.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> 
> Vivek, do you remember where we ended up with boot from virtiofs? I
> thought a different solution was merged some time ago.

We merged a patch from Christoph Hellwig to support this.

commit f9259be6a9e7c22d92e5a5000913147ae17e8321
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Jul 14 16:23:20 2021 -0400

    init: allow mounting arbitrary non-blockdevice filesystems as root

Now one should be able to mount virtiofs using following syntax.

"root=myfs rootfstype=virtiofs rw"

IIUC, this patch should not be required anymore.

Thanks
Vivek

> 
> There is documentation from the virtiofs community here:
> https://virtio-fs.gitlab.io/howto-boot.html
> 
> Stefan
> 
> > 
> > diff --git a/init/do_mounts.c b/init/do_mounts.c
> > index 811e94daf0a8..11c11abe23d7 100644
> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -578,6 +578,16 @@ void __init mount_root(void)
> >  			printk(KERN_ERR "VFS: Unable to mount root fs via SMB.\n");
> >  		return;
> >  	}
> > +#endif
> > +#ifdef CONFIG_VIRTIO_FS
> > +	if (root_fs_names && !strcmp(root_fs_names, "virtiofs")) {
> > +		if (!do_mount_root(root_device_name, "virtiofs",
> > +				   root_mountflags, root_mount_data))
> > +			return;
> > +
> > +		panic("VFS: Unable to mount root fs \"%s\" from virtiofs",
> > +		      root_device_name);
> > +	}
> >  #endif
> >  	if (ROOT_DEV == 0 && root_device_name && root_fs_names) {
> >  		if (mount_nodev_root() == 0)
> > -- 
> > 2.39.1
> > 


