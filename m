Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82E16D9B7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 17:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbjDFPBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjDFPBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2438895;
        Thu,  6 Apr 2023 08:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A24647F4;
        Thu,  6 Apr 2023 15:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF86C433EF;
        Thu,  6 Apr 2023 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680793280;
        bh=67Z2E96bZy7BCqWEhCsj19y7v8ycg2iEwkSVbNFV43s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqkD+bXl9Cv9PACGClbea7PmXsLCGtizGea6Q8cX5/eZndr3cFfCgtw+tyDvaV0T+
         tzKBnG97kn83kKwcRwuNLTD29F9X+L5ujbC74XEZhx3lg2lxSbMViVVzCWo9EL51Ex
         3/uIfnE+3EcUu0IDvVLb0YCXXnP1cOFR8Fxo/vAeoUmhb+EXqB4GDzzhDyO2i1FDwB
         nDhi0z3niUDYiWqFuyvDCOcCR4jypMI4rST4i/PVQQKByDTAPOxdmiM96KuL2UV799
         mvV2ss6tx1VAeGl1qNnFnQP/FFXbgqwoP3zE6lvgDNYeDxC+W6IaV5UExMf0LXeTUG
         QypH2nv5YMheQ==
Date:   Thu, 6 Apr 2023 17:01:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Message-ID: <20230406-wasser-zwanzig-791bc0bf416c@brauner>
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
 <20230406-diffamieren-langhaarig-87511897e77d@brauner>
 <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
 <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
 <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
> On Thu, Apr 6, 2023 at 10:20 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
> > On 4/6/23 10:05, Paul Moore wrote:
> > > On Thu, Apr 6, 2023 at 6:26 AM Christian Brauner <brauner@kernel.org> wrote:
> > >> On Wed, Apr 05, 2023 at 01:14:49PM -0400, Stefan Berger wrote:
> > >>> Overlayfs fails to notify IMA / EVM about file content modifications
> > >>> and therefore IMA-appraised files may execute even though their file
> > >>> signature does not validate against the changed hash of the file
> > >>> anymore. To resolve this issue, add a call to integrity_notify_change()
> > >>> to the ovl_release() function to notify the integrity subsystem about
> > >>> file changes. The set flag triggers the re-evaluation of the file by
> > >>> IMA / EVM once the file is accessed again.
> > >>>
> > >>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > >>> ---
> > >>>   fs/overlayfs/file.c       |  4 ++++
> > >>>   include/linux/integrity.h |  6 ++++++
> > >>>   security/integrity/iint.c | 13 +++++++++++++
> > >>>   3 files changed, 23 insertions(+)
> > >>>
> > >>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > >>> index 6011f955436b..19b8f4bcc18c 100644
> > >>> --- a/fs/overlayfs/file.c
> > >>> +++ b/fs/overlayfs/file.c
> > >>> @@ -13,6 +13,7 @@
> > >>>   #include <linux/security.h>
> > >>>   #include <linux/mm.h>
> > >>>   #include <linux/fs.h>
> > >>> +#include <linux/integrity.h>
> > >>>   #include "overlayfs.h"
> > >>>
> > >>>   struct ovl_aio_req {
> > >>> @@ -169,6 +170,9 @@ static int ovl_open(struct inode *inode, struct file *file)
> > >>>
> > >>>   static int ovl_release(struct inode *inode, struct file *file)
> > >>>   {
> > >>> +     if (file->f_flags & O_ACCMODE)
> > >>> +             integrity_notify_change(inode);
> > >>> +
> > >>>        fput(file->private_data);
> > >>>
> > >>>        return 0;
> > >>> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > >>> index 2ea0f2f65ab6..cefdeccc1619 100644
> > >>> --- a/include/linux/integrity.h
> > >>> +++ b/include/linux/integrity.h
> > >>> @@ -23,6 +23,7 @@ enum integrity_status {
> > >>>   #ifdef CONFIG_INTEGRITY
> > >>>   extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
> > >>>   extern void integrity_inode_free(struct inode *inode);
> > >>> +extern void integrity_notify_change(struct inode *inode);
> > >>
> > >> I thought we concluded that ima is going to move into the security hook
> > >> infrastructure so it seems this should be a proper LSM hook?
> > >
> > > We are working towards migrating IMA/EVM to the LSM layer, but there
> > > are a few things we need to fix/update/remove first; if anyone is
> > > curious, you can join the LSM list as we've been discussing some of
> > > these changes this week.  Bug fixes like this should probably remain
> > > as IMA/EVM calls for the time being, with the understanding that they
> > > will migrate over with the rest of IMA/EVM.
> > >
> > > That said, we should give Mimi a chance to review this patch as it is
> > > possible there is a different/better approach.  A bit of patience may
> > > be required as I know Mimi is very busy at the moment.
> >
> > There may be a better approach actually by increasing the inode's i_version,
> > which then should trigger the appropriate path in ima_check_last_writer().
> 
> I'm not the VFS/inode expert here, but I thought the inode's i_version
> field was only supposed to be bumped when the inode metadata changed,
> not necessarily the file contents, right?
> 
> That said, overlayfs is a bit different so maybe that's okay, but I
> think we would need to hear from the VFS folks if this is acceptable.

Ccing Jeff for awareness since he did the i_version rework a short time ago.

The documentation in include/linux/iversion.h states:

 * [...] The i_version must
 * appear larger to observers if there was an explicit change to the inode's
 * data or metadata since it was last queried.

what I'm less sure in all of this is why this is called in ovl_release() and
whether it's correct to increment the overlayfs inode's i_version.

The change is done to the inode of the copied up/modified file's inode in the
upper layer. So the i_version should already be incremented when we call into
the upper layer usually via vfs_*() methods.
