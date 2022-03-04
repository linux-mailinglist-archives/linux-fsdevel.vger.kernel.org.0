Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7394CDE3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 21:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiCDUKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 15:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiCDUJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:09:15 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D889120C2E0;
        Fri,  4 Mar 2022 12:03:28 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 19F587253; Fri,  4 Mar 2022 15:03:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 19F587253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1646424200;
        bh=ZNPhSxtZN/ks7FEtwW3By9jmrYTGNVzKwe2BPkQyF4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiZeXZiYMk5gm68OPikmt9bu1yk4SYuezouW0NySj87i/JWnGAQkQD/NzwmMUz8R1
         pcuHEPjP1jxU/DRaRwlqtqOR75p/mOyztxxBU7tI/0YwQ9RaQtsY3NWuqlCRGmCPXz
         hianw1bXIv4o3k2ME/zn4ZliHSWUMLfS4epyE3UE=
Date:   Fri, 4 Mar 2022 15:03:20 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: nfs generic/373 failure after "fs: allow cross-vfsmount
 reflink/dedupe"
Message-ID: <20220304200320.GB5037@fieldses.org>
References: <20220302082658.GF3927073@dread.disaster.area>
 <CAOQ4uxgiL2eqx-kad+dddXvXPREKT-w3_BnLzdoJaJqGm=H=vA@mail.gmail.com>
 <20220302211226.GG3927073@dread.disaster.area>
 <20220302220450.GD10757@fieldses.org>
 <Yh/vADRGuPFGIEc+@localhost.localdomain>
 <20220302224250.GF10757@fieldses.org>
 <YiABiLtH/4nMJE+u@localhost.localdomain>
 <20220303000735.GA21944@fieldses.org>
 <YiAL7uNA3ZiaBCE6@localhost.localdomain>
 <20220303005001.GB21944@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303005001.GB21944@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 07:50:01PM -0500, J. Bruce Fields wrote:
> On Wed, Mar 02, 2022 at 07:29:34PM -0500, Josef Bacik wrote:
> > On Wed, Mar 02, 2022 at 07:07:35PM -0500, J. Bruce Fields wrote:
> > > Sorry, took me a minute to understand, myself:
> > > 
> > > It's actually only the client behavior that changed.  Previously the
> > > client would reject an attempt to clone across filesystems, so the
> > > server never saw such a request.  After this patch, the client will go
> > > ahead and send the CLONE.  (Which, come to think of it, is probably the
> > > right thing for the client to do.)
> > > 
> > > So the server's probably always had a bug, and this just uncovered it.
> > > 
> > > I'd be curious what the consequences are.  And where the check should be
> > > (above or below vfs_clone_file_range()?).
> > > 
> > 
> > This is where I'm confused, this really shouldn't succeed
> > 
> > loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
> >                            struct file *file_out, loff_t pos_out,
> >                            loff_t len, unsigned int remap_flags)
> > {
> >         loff_t ret;
> > 
> >         WARN_ON_ONCE(remap_flags & REMAP_FILE_DEDUP);
> > 
> >         if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> >                 return -EXDEV;
> > 
> > 
> > loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
> >                             struct file *file_out, loff_t pos_out,
> >                             loff_t len, unsigned int remap_flags)
> > {
> >         loff_t ret;
> > 
> >         file_start_write(file_out);
> >         ret = do_clone_file_range(file_in, pos_in, file_out, pos_out, len,
> >                                   remap_flags);
> > 
> > And even if we get past here, I imagine XFS would freak out because it can't
> > find the extents (unless you're getting lucky and everything is lining up?).
> > I'm super confused...
> 
> Bah, I see what you mean.  Maybe there's something wrong with my setup.
> I'll try some more stuff and report back....

Sorry for the noise, you're right, generic/373 is just being dumb.

I assumed it was mounting different exports for some reason.  But in
fact it's just doing a bind mount and then "cp --reflink=always" between
two mounts of the same filesystem.  Previously that got rejected out of
hand, now the client sends a CLONE and the server handles it.

Which is an improvement.  So it's only generic/373 that needs fixing.

--b.
