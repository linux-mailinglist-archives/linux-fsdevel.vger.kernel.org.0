Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD7562F587
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 14:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiKRNGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 08:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241927AbiKRNGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:06:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D14742FB
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 05:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668776752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MkbPf8lANvr8MINxjwyWmUuJ/1c5U1P0oOc0E961cnI=;
        b=emxXN/Ax3QTqwfSchjz+eNGy+coYgQ3Tv1GDju9yicGmY5LqUQWcuWmlhNV6QsxLJavh0T
        1Ne/JAo3dX727jTh1xxJX2+tk4hFalmTxJkaHShdccQScg9r4gDgUVGGvnxq2IVIxDM66S
        VqHtuodNn/deo9+xLrkOD5wkDBz2IGc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-pvkcvqwVOpuRJvz_nLHg3w-1; Fri, 18 Nov 2022 08:05:51 -0500
X-MC-Unique: pvkcvqwVOpuRJvz_nLHg3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9B9385A59D;
        Fri, 18 Nov 2022 13:05:50 +0000 (UTC)
Received: from localhost (unknown [10.39.208.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 760CB2028CE4;
        Fri, 18 Nov 2022 13:05:50 +0000 (UTC)
Date:   Fri, 18 Nov 2022 14:05:46 +0100
From:   Niels de Vos <ndevos@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>
Subject: Re: [RFC 0/4] fs: provide per-filesystem options to disable fscrypt
Message-ID: <Y3eC1tEoUGdgBP9i@ndevos-x1>
References: <20221110141225.2308856-1-ndevos@redhat.com>
 <Y20a/akbY8Wcy3qg@mit.edu>
 <Y20rDl45vSmdEo3N@ndevos-x1>
 <Y20/ynxvIqOyRbxK@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20/ynxvIqOyRbxK@mit.edu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 10, 2022 at 01:15:38PM -0500, Theodore Ts'o wrote:
> On Thu, Nov 10, 2022 at 05:47:10PM +0100, Niels de Vos wrote:
> > And, there actually are options like CONFIG_EXT4_FS_POSIX_ACL and
> > CONFIG_EXT4_FS_SECURITY. Because these exist already, I did not expect
> > too much concerns with proposing a CONFIG_EXT4_FS_ENCRYPTION...
> 
> Actually, I was thinking of getting rid of them, as we've already
> gotten rid of EXT4_FS_POSIX_ACL....
> 
> > Thanks for adding some history about this. I understand that extra
> > options are needed while creating/tuning the filesystems. Preventing
> > users from setting the right options in a filesystem is not easy, even
> > if tools from a distribution do not offer setting the options. Disks can
> > be portable, or network-attached, and have options enabled that an other
> > distributions kernel does not (want to) support.
> 
> Sure, but as I said, there are **tons** of file system features that
> have not and/or still are not supported for distros, but for which we
> don't have kernel config knobs.  This includes ext4's bigalloc and
> inline data, btrfs's dedup and reflink support, xfs online fsck, etc.,
> etc., etc.  Heck, ext4 is only supported up to a certain size by Red
> Hat, and we don't have a Kernel config so that the kernel will
> absolutely refuse to mount an ext4 file system larger than The
> Officially Supported RHEL Capacity Limit for Ext4.  So what makes
> fscrypt different from all of these other unsupported file system
> features?
> 
> There are plenty of times when I've had to explain to customers why,
> sure they could build their own kernels for RHEL 4 (back in the day
> when I worked for Big Blue and had to talk to lots of enterprise
> customers), but if they did, Red Hat support would refuse to give them
> the time of day if they called asking for help.  We didn't set up use
> digitally signed kernels with trusted boot so that a IBM server would
> refuse to boot anything other than An Officially Signed RHEL
> Kernel...
> 
> What makes fscrypt different that we think we need to enforce this
> using technical means, other than a simple, "this feature is not
> supported"?

Thanks again for the added details. What you are explaining makes sense,
and I am not sure if there is an other good reason why splitting out
fscrypt support per filesystem would be required. I'm checking with the
folks that suggested doing this, and see where we go from there.

Niels

