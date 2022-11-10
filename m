Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB862477D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 17:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiKJQt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 11:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiKJQtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:49:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C138C07
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668098844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SFPKDxh3aAxTZxEpFem52jYuT8SA7V/A/0d7a45/TMQ=;
        b=WlcZavw0UE4M8ER5MzDl9zoPFBt/ovvAY0FK5KZr1NDxDiC7XlpuEd5Mb6s/zhLZq1HKI4
        jUfdOgLrU+/8sYrovEQTvG1m6AiDDyJHJ1SKBWO44txVwgwH8aL7OG6SBMk+iAUlvw1PUi
        i2GDYUimrj+6K2+XVv7/TYJYYwTmi7I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-_zPDFr08M0asX-5Zfbsrmw-1; Thu, 10 Nov 2022 11:47:12 -0500
X-MC-Unique: _zPDFr08M0asX-5Zfbsrmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85ECB857F92;
        Thu, 10 Nov 2022 16:47:12 +0000 (UTC)
Received: from localhost (unknown [10.39.208.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 354E62166B29;
        Thu, 10 Nov 2022 16:47:11 +0000 (UTC)
Date:   Thu, 10 Nov 2022 17:47:10 +0100
From:   Niels de Vos <ndevos@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>
Subject: Re: [RFC 0/4] fs: provide per-filesystem options to disable fscrypt
Message-ID: <Y20rDl45vSmdEo3N@ndevos-x1>
References: <20221110141225.2308856-1-ndevos@redhat.com>
 <Y20a/akbY8Wcy3qg@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20a/akbY8Wcy3qg@mit.edu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 10, 2022 at 10:38:37AM -0500, Theodore Ts'o wrote:
> On Thu, Nov 10, 2022 at 03:12:21PM +0100, Niels de Vos wrote:
> > While more filesystems are getting support for fscrypt, it is useful to
> > be able to disable fscrypt for a selection of filesystems, while
> > enabling it for others.
> 
> Could you say why you find it useful?  Is it because you are concerned
> about the increased binary size of a particular file system if fscrypt
> is enabled?  That hasn't been my experience, the hooks to call into
> fscrypt are small and don't add too much to any one particular file
> system; the bulk of the code is in fs/crypto.

No, this isn't really a concern. I don't think the small size difference
is worth the effort.

> Is it because people are pushing buggy code that doesn't compile if
> you enable, say, CONFIG_FS_XXX and CONFIG_FSCRYPT at the same time?

It is a little of this. Not necessarily for the compiling part, more of
a functional thing. And that is what comes next...

> Is it because a particular distribution doesn't want to support
> fscrypt with a particular file system?  If so, there have been plenty
> of file system features for say, ext4, xfs, and btrfs, which aren't
> supported by a distro, but there isn't a CONFIG_FS_XXX_YYY to disable
> that feature, nor have any distros requested such a thing --- which is
> good because it would be an explosion of new CONFIG parameters.

This is mostly why I sent this RFC. We are interested in enabling
fscrypt for CephFS (soonish) as a network filesystem, but not for local
filesystems (we recommend dm-crypt for those). The idea is that
functionality that isn't available, can also not (easily) cause
breakage.

And, there actually are options like CONFIG_EXT4_FS_POSIX_ACL and
CONFIG_EXT4_FS_SECURITY. Because these exist already, I did not expect
too much concerns with proposing a CONFIG_EXT4_FS_ENCRYPTION...

> Or is it something else?
> 
> Note that nearly all of the file systems will only enable fscrypt if
> some file system feature flag enabls it.  So I'm not sure what's the
> motivation behind adding this configuration option.  If memory serves,
> early in the fscrypt development we did have per-file system CONFIG's
> for fscrypt, but we consciously removed it, just as we no longer have
> per-file system CONFIG's to enable or disable Posix ACL's or extended
> attributes, in the name of simplifying the kernel config.

Thanks for adding some history about this. I understand that extra
options are needed while creating/tuning the filesystems. Preventing
users from setting the right options in a filesystem is not easy, even
if tools from a distribution do not offer setting the options. Disks can
be portable, or network-attached, and have options enabled that an other
distributions kernel does not (want to) support.

Note that even with the additional options, enabling only
CONFIG_FS_ENCRYPTION causes all the filesystems that support fscrypt to
have it enabled. For users there is no change, except that they now have
an option to disable fscrypt support per filesystem.

I hope this explains the intention a bit better. And as there are
existing options for many filesystems to select support for xattrs,
security or ACLs, I hope new options for (de)selecting filesystem
encryption support is not too controversial.

Thanks!
Niels

