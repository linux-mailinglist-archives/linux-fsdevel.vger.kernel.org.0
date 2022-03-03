Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883DC4CB367
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 01:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiCCAIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 19:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiCCAIU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:08:20 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41728BDE5D;
        Wed,  2 Mar 2022 16:07:36 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9285572C6; Wed,  2 Mar 2022 19:07:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9285572C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1646266055;
        bh=+2OkF/NbJLCsAX1YGMh/jwrJmXkW2FAPJw5PAYnoPYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gI3GIGM6C0MEcPAy+bBBGMVcEZWZjctZ2+aCQVwNnLybLTBKOcX8Su1Q81IUdoOhE
         aVIL368KpDB+8n7SPCKG0VDpawfDnHrD9i6L+u2Tf51NAMpjLqk39a1NKLXQChlbYY
         gKzE0bQIoMk5c0ggIZ/khQmfMZznjPprOkfReSRk=
Date:   Wed, 2 Mar 2022 19:07:35 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: nfs generic/373 failure after "fs: allow cross-vfsmount
 reflink/dedupe"
Message-ID: <20220303000735.GA21944@fieldses.org>
References: <20220301184221.371853-1-amir73il@gmail.com>
 <20220302065952.GE3927073@dread.disaster.area>
 <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com>
 <20220302082658.GF3927073@dread.disaster.area>
 <CAOQ4uxgiL2eqx-kad+dddXvXPREKT-w3_BnLzdoJaJqGm=H=vA@mail.gmail.com>
 <20220302211226.GG3927073@dread.disaster.area>
 <20220302220450.GD10757@fieldses.org>
 <Yh/vADRGuPFGIEc+@localhost.localdomain>
 <20220302224250.GF10757@fieldses.org>
 <YiABiLtH/4nMJE+u@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiABiLtH/4nMJE+u@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 06:45:12PM -0500, Josef Bacik wrote:
> On Wed, Mar 02, 2022 at 05:42:50PM -0500, J. Bruce Fields wrote:
> > On Wed, Mar 02, 2022 at 05:26:08PM -0500, Josef Bacik wrote:
> > > On Wed, Mar 02, 2022 at 05:04:50PM -0500, J. Bruce Fields wrote:
> > > > I started seeing generic/373 fail on recent linux-next in NFS testing.
> > > > 
> > > > Bisect lands it on aaf40970b1d0 "fs: allow cross-vfsmount
> > > > reflink/dedupe".
> > > > 
> > > > The test fails because a clone between two mounts is expected to fail,
> > > > and no longer does.
> > > > 
> > > > In my setup both mounts are nfs mounts.  They are mounts of different
> > > > exports, and the exports are exports of different filesystems.  So it
> > > > does make sense that the clone should fail.
> > > > 
> > > > I see the NFS client send a CLONE rpc to the server, and the server
> > > > return success.  That seems wrong.
> > > > 
> > > > Both exported filesystems are xfs, and from the code it looks like the
> > > > server calls vfs_clone_file_range(), which ends up calling
> > > > xfs_file_remap_range().
> > > > 
> > > > Are we missing a check now in that xfs case?
> > > > 
> > > > I haven't looked any more closely at what's going on, so I could be
> > > > missing something.
> > > > 
> > > 
> > > Yeah there's a few fstests that test this functionality that need to be removed,
> > > I have patches pending for this in our fstests staging tree (since we run
> > > fstests nightly on our tree)
> > > 
> > > https://github.com/btrfs/fstests/tree/staging
> > > 
> > > Right now the patches just remove the tests from auto since that's what we run,
> > > I'll remove them properly once the patch lands in linus.  Thanks,
> > 
> > So, out of curiosity, what is xfs doing in this case?  These are two
> > filesystems on separate partitions, is it falling back on a read/write
> > loop or something?
> 
> I don't think so?  I'm actually kind of confused, because nfsd does
> vfs_clone_file_range, and the only place I messed with for CLONE was
> ioctl_clone_file, so the patch changed literally nothing, unless you aren't
> using nfsd for the server?
> 
> And if they are in fact two different file systems the i_sb != i_sb of the
> files, so there's something pretty strange going on here, my patch shouldn't
> affect your setup.  Thanks,

Sorry, took me a minute to understand, myself:

It's actually only the client behavior that changed.  Previously the
client would reject an attempt to clone across filesystems, so the
server never saw such a request.  After this patch, the client will go
ahead and send the CLONE.  (Which, come to think of it, is probably the
right thing for the client to do.)

So the server's probably always had a bug, and this just uncovered it.

I'd be curious what the consequences are.  And where the check should be
(above or below vfs_clone_file_range()?).

--b.
