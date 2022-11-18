Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33C62F5EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 14:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbiKRN0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 08:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241464AbiKRN0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:26:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7556885A37
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 05:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668777948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ypVqQDovsotVHlRyYzXKwNPuqQJ+h49uCV3eLEnwSg=;
        b=cS89cym8ufGlVZ4FdUFabECyFtXXra/btCVLhRkbp+L0OcTbQ7G0o+vxx9c1KH5PFYLb6a
        /TVpPm+z5oSc+minQ0H65WXjK5dYprXo9hTTe3PJqGHBcq85MJ10i/AGwsFar50axiIDrb
        5XN2s6ms/fCJP/BVPlwTaFcJmgETYes=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-sT1BHtADPDOxk9C1G4xGzA-1; Fri, 18 Nov 2022 08:25:45 -0500
X-MC-Unique: sT1BHtADPDOxk9C1G4xGzA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 094B7101A528;
        Fri, 18 Nov 2022 13:25:45 +0000 (UTC)
Received: from localhost (unknown [10.39.208.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A77374B3FCE;
        Fri, 18 Nov 2022 13:25:44 +0000 (UTC)
Date:   Fri, 18 Nov 2022 14:25:41 +0100
From:   Niels de Vos <ndevos@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>
Subject: Re: [RFC 0/4] fs: provide per-filesystem options to disable fscrypt
Message-ID: <Y3eH1XOGlXUKCiMZ@ndevos-x1>
References: <20221110141225.2308856-1-ndevos@redhat.com>
 <Y3RGs5dONBt+GAxN@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3RGs5dONBt+GAxN@sol.localdomain>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 06:10:59PM -0800, Eric Biggers wrote:
> On Thu, Nov 10, 2022 at 03:12:21PM +0100, Niels de Vos wrote:
> > While more filesystems are getting support for fscrypt, it is useful to
> > be able to disable fscrypt for a selection of filesystems, while
> > enabling it for others.
> > 
> > The new USE_FS_ENCRYPTION define gets picked up in
> > include/linux/fscrypt.h. This allows filesystems to choose to use the
> > empty function definitions, or the functional ones when fscrypt is to be
> > used with the filesystem.
> > 
> > Using USE_FS_ENCRYPTION is a relatively clean approach, and requires
> > minimal changes to the filesystems supporting fscrypt. This RFC is
> > mostly for checking the acceptance of this solution, or if an other
> > direction is preferred.
> > 
> > ---
> > 
> > Niels de Vos (4):
> >   fscrypt: introduce USE_FS_ENCRYPTION
> >   fs: make fscrypt support an ext4 config option
> >   fs: make fscrypt support a f2fs config option
> >   fs: make fscrypt support a UBIFS config option
> 
> So as others have pointed out, it doesn't seem worth the complexity to do this.
> 
> For a bit of historical context, before Linux v5.1, we did have per-filesystem
> options for this: CONFIG_EXT4_ENCRYPTION, CONFIG_F2FS_FS_ENCRYPTION, and
> CONFIG_UBIFS_FS_ENCRYPTION.  If you enabled one of these, it selected
> CONFIG_FS_ENCRYPTION to get the code in fs/crypto/.  CONFIG_FS_ENCRYPTION was a
> tristate, so the code in fs/crypto/ could be built as a loadable module if it
> was only needed by filesystems that were loadable modules themselves.
> 
> Having fs/crypto/ possibly be a loadable module was problematic, though, because
> it made it impossible to call into fs/crypto/ from built-in code such as
> fs/buffer.c, fs/ioctl.c, fs/libfs.c, fs/super.c, fs/iomap/direct-io.c, etc.  So
> that's why we made CONFIG_FS_ENCRYPTION into a bool.  At the same time, we
> decided to simplify the kconfig options by removing the per-filesystem options
> so that it worked like CONFIG_QUOTA, CONFIG_FS_DAX, CONFIG_FS_POSIX_ACL, etc.
> 
> I suppose we *could* have *just* changed CONFIG_FS_ENCRYPTION to a bool to solve
> the first problem, and kept the per-filesystem options.  I think that wouldn't
> have made a lot of sense, though, for the reasons that Ted has already covered.

Yes, it seems that there is a move to reduce the Kconfig options and
(re)adding per-filesystem encryption support would be counterproductive.

> A further point, beyond what Ted has already covered, is that
> non-filesystem-specific code can't honor filesystem-specific options.  So e.g.
> if you had a filesystem with encryption disabled by kconfig, that then called
> into fs/iomap/direct-io.c to process an I/O request, it could potentially still
> call into fs/crypto/ to enable encryption on that I/O request, since
> fs/iomap/direct-io.c would think that encryption support is enabled.
> 
> Granted, that *should* never actually happen, because this would only make a
> difference on encrypted files, and the filesystem shouldn't have allowed an
> encrypted file to be opened if it doesn't have encryption support enabled.  But
> it does seem a bit odd, given that it would go against the goal of compiling out
> all encryption code for a filesystem.

Ah, yes, indeed! The boundaries between the options would be less clear,
and potential changes to shared functions under fs/ could have incorrect
assumptions about CONFIG_FS_ENCRYPTION. Even if this is not the case
now, optimizations/enhancements in the future might be more complicated
because of this.

Thanks for the additional details! Have a good weekend,
Niels

