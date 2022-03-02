Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DDE4CB26D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 23:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiCBWnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 17:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiCBWnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:43:37 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8DF10EC76;
        Wed,  2 Mar 2022 14:42:51 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A1F9448FA; Wed,  2 Mar 2022 17:42:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A1F9448FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1646260970;
        bh=Qx6NKtUe5o75Z9gf7VSs5r+qgeQ2e7OyNFVV7LHWRB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lB1W8h8JxQ7YLMmVWNenwiNQjKNgTJhsgjXly0iXBVL7u5VVKbA6AI1MlHwZjZwfw
         21FrqANh/mI7ycNxM8nMVukDfA/IOUbROnIMIktTaYFz3hYXDQtl+I2fPaOpiBSe7e
         epAd7lpwaKswcTVHDa6g3HIdgh/W1DMnO+gJISVg=
Date:   Wed, 2 Mar 2022 17:42:50 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: nfs generic/373 failure after "fs: allow cross-vfsmount
 reflink/dedupe"
Message-ID: <20220302224250.GF10757@fieldses.org>
References: <20220301184221.371853-1-amir73il@gmail.com>
 <20220302065952.GE3927073@dread.disaster.area>
 <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com>
 <20220302082658.GF3927073@dread.disaster.area>
 <CAOQ4uxgiL2eqx-kad+dddXvXPREKT-w3_BnLzdoJaJqGm=H=vA@mail.gmail.com>
 <20220302211226.GG3927073@dread.disaster.area>
 <20220302220450.GD10757@fieldses.org>
 <Yh/vADRGuPFGIEc+@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh/vADRGuPFGIEc+@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:26:08PM -0500, Josef Bacik wrote:
> On Wed, Mar 02, 2022 at 05:04:50PM -0500, J. Bruce Fields wrote:
> > I started seeing generic/373 fail on recent linux-next in NFS testing.
> > 
> > Bisect lands it on aaf40970b1d0 "fs: allow cross-vfsmount
> > reflink/dedupe".
> > 
> > The test fails because a clone between two mounts is expected to fail,
> > and no longer does.
> > 
> > In my setup both mounts are nfs mounts.  They are mounts of different
> > exports, and the exports are exports of different filesystems.  So it
> > does make sense that the clone should fail.
> > 
> > I see the NFS client send a CLONE rpc to the server, and the server
> > return success.  That seems wrong.
> > 
> > Both exported filesystems are xfs, and from the code it looks like the
> > server calls vfs_clone_file_range(), which ends up calling
> > xfs_file_remap_range().
> > 
> > Are we missing a check now in that xfs case?
> > 
> > I haven't looked any more closely at what's going on, so I could be
> > missing something.
> > 
> 
> Yeah there's a few fstests that test this functionality that need to be removed,
> I have patches pending for this in our fstests staging tree (since we run
> fstests nightly on our tree)
> 
> https://github.com/btrfs/fstests/tree/staging
> 
> Right now the patches just remove the tests from auto since that's what we run,
> I'll remove them properly once the patch lands in linus.  Thanks,

So, out of curiosity, what is xfs doing in this case?  These are two
filesystems on separate partitions, is it falling back on a read/write
loop or something?

--b.
