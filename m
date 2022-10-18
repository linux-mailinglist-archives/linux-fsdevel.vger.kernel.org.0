Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C31602EF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJRO5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJRO5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:57:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F01D9960;
        Tue, 18 Oct 2022 07:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87A2BB81F93;
        Tue, 18 Oct 2022 14:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3400BC433D6;
        Tue, 18 Oct 2022 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666105019;
        bh=qmaUREKKpKGIfPeuyHVYJiyiQ+vwR1CgcRLVNMmVems=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tSWyO8KMO7Eo2SWIkFm8Fv/jNMSEMNYxqaBmHHVSbbPRHMjQfB2ay/FZpgWA7e39W
         TXzVXcbSBYKTZ5fDw6ycHeG2ZTRJPHwkt14ThiP4HYcDhErgUhpJVbQfvVaIOLU4Hj
         n6JpOEQlYl6uDQfd3C84PQ6Q2/jgU+2bRd5IR49wX/FwG1rqbD4l6srz8vsxOWGD+y
         YkcPnRVYrf6eavusnsT1t5IkuOEkCLvZbH8GxwUUSJqI3MiE7L1adVjFQjNhBTx4L4
         K85dWprbcFpCdFAxFmEWOcBJIZ3Fy/WiJeAJMd+gsrfjlReJDVtqMeAgHj1faQyG4C
         +ZEqAplLOQp2A==
Message-ID: <c303cf0701a2c09487bda33012bc0ceb79f211c0.camel@kernel.org>
Subject: Re: [RFC PATCH v7 9/9] vfs: expose STATX_VERSION to userland
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Tue, 18 Oct 2022 10:56:55 -0400
In-Reply-To: <1e01f88bcde1b7963e504e0fd9cfb27495eb03ca.camel@kernel.org>
References: <20221017105709.10830-1-jlayton@kernel.org>
         <20221017105709.10830-10-jlayton@kernel.org>
         <20221017221433.GT3600936@dread.disaster.area>
         <1e01f88bcde1b7963e504e0fd9cfb27495eb03ca.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-10-18 at 06:35 -0400, Jeff Layton wrote:
> On Tue, 2022-10-18 at 09:14 +1100, Dave Chinner wrote:
> > On Mon, Oct 17, 2022 at 06:57:09AM -0400, Jeff Layton wrote:
> > > From: Jeff Layton <jlayton@redhat.com>
> > >=20
> > > Claim one of the spare fields in struct statx to hold a 64-bit inode
> > > version attribute. When userland requests STATX_VERSION, copy the
> > > value from the kstat struct there, and stop masking off
> > > STATX_ATTR_VERSION_MONOTONIC.
> >=20
> > Can we please make the name more sepcific than "version"? It's way
> > too generic and - we already have userspace facing "version" fields
> > for inodes that refer to the on-disk format version exposed in
> > various UAPIs. It's common for UAPI structures used for file
> > operations to have a "version" field that refers to the *UAPI
> > structure version* rather than file metadata or data being retrieved
> > from the file in question.
> >=20
> > The need for an explanatory comment like this:
> >=20
> > > +	__u64	stx_version; /* Inode change attribute */
> >=20
> > demonstrates it is badly named. If you want it known as an inode
> > change attribute, then don't name the variable "version". In
> > reality, it really needs to be an opaque cookie, not something
> > applications need to decode directly to make sense of.
> >=20
>=20
> Fair enough. I started with this being named stx_change_attr and other
> people objected. I then changed to stx_ino_version, but the "_ino"
> seemed redundant.
>=20
> I'm open to suggestions here. Naming things like this is hard.
>=20

How about:

    STATX_CHANGE / statx->stx_change / STATX_ATTR_CHANGE_MONOTONIC

?
--=20
Jeff Layton <jlayton@kernel.org>
