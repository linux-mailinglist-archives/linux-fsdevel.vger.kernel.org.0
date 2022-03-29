Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960074EB183
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 18:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbiC2QM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239457AbiC2QM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:12:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A298C17ADAF;
        Tue, 29 Mar 2022 09:11:13 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 18A827363; Tue, 29 Mar 2022 12:11:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 18A827363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1648570273;
        bh=mE2tEE+fKpjkZGcwJndFB32IuXYKjLfSjSkVMOeAI5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1JY/qlQgFkMe8Ux3Lv17v58PZJGDB50nfz82cJczexcPDKPrzmLG/DWihhuhmGZq
         qjHE0kQU/36YcZXNN11VD416Dw71GTTuWSmQYVhrEZ1X5OP0uGH8GYBOEUJeYtzaY5
         tF2B6veOC6OIvuUrB3GNaJPskAZBxjrsL6i+lq7s=
Date:   Tue, 29 Mar 2022 12:11:13 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v18 05/11] NFSD: Update nfs4_get_vfs_file() to handle
 courtesy client
Message-ID: <20220329161113.GF29634@fieldses.org>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
 <1648182891-32599-6-git-send-email-dai.ngo@oracle.com>
 <20220329152400.GD29634@fieldses.org>
 <e2b0140e-0580-5885-9305-d72b5a4f1d78@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2b0140e-0580-5885-9305-d72b5a4f1d78@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:06:23AM -0700, dai.ngo@oracle.com wrote:
> 
> On 3/29/22 8:24 AM, J. Bruce Fields wrote:
> >On Thu, Mar 24, 2022 at 09:34:45PM -0700, Dai Ngo wrote:
> >>Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
> >>reservation conflict with courtesy client.
> >>
> >>Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
> >>reservation conflict with courtesy client.
> >>
> >>When we have deny/access conflict we walk the fi_stateids of the
> >>file in question, looking for open stateid and check the deny/access
> >>of that stateid against the one from the open request. If there is
> >>a conflict then we check if the client that owns that stateid is
> >>a courtesy client. If it is then we set the client state to
> >>CLIENT_EXPIRED and allow the open request to continue. We have
> >>to scan all the stateid's of the file since the conflict can be
> >>caused by multiple open stateid's.
> >>
> >>Client with CLIENT_EXPIRED is expired by the laundromat.
> >>
> >>Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >>---
> >>  fs/nfsd/nfs4state.c | 85 +++++++++++++++++++++++++++++++++++++++++++++--------
> >>  1 file changed, 72 insertions(+), 13 deletions(-)
> >>
> >>diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>index f20c75890594..fe8969ba94b3 100644
> >>--- a/fs/nfsd/nfs4state.c
> >>+++ b/fs/nfsd/nfs4state.c
> >>@@ -701,9 +701,56 @@ __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
> >>  		atomic_inc(&fp->fi_access[O_RDONLY]);
> >>  }
> >>+/*
> >>+ * Check if courtesy clients have conflicting access and resolve it if possible
> >>+ *
> >>+ * access:  is op_share_access if share_access is true.
> >>+ *	    Check if access mode, op_share_access, would conflict with
> >>+ *	    the current deny mode of the file 'fp'.
> >>+ * access:  is op_share_deny if share_access is false.
> >>+ *	    Check if the deny mode, op_share_deny, would conflict with
> >>+ *	    current access of the file 'fp'.
> >>+ * stp:     skip checking this entry.
> >>+ * new_stp: normal open, not open upgrade.
> >>+ *
> >>+ * Function returns:
> >>+ *	false - access/deny mode conflict with normal client.
> >>+ *	true  - no conflict or conflict with courtesy client(s) is resolved.
> >>+ */
> >>+static bool
> >>+nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
> >>+		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
> >>+{
> >>+	struct nfs4_ol_stateid *st;
> >>+	struct nfs4_client *clp;
> >>+	bool conflict = true;
> >>+	unsigned char bmap;
> >>+
> >>+	lockdep_assert_held(&fp->fi_lock);
> >>+	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
> >>+		/* ignore lock stateid */
> >>+		if (st->st_openstp)
> >>+			continue;
> >>+		if (st == stp && new_stp)
> >>+			continue;
> >>+		/* check file access against deny mode or vice versa */
> >>+		bmap = share_access ? st->st_deny_bmap : st->st_access_bmap;
> >>+		if (!(access & bmap_to_share_mode(bmap)))
> >>+			continue;
> >As I said before, I recommend just doing *both* checks here.  Then you
> >can remove the "bool share_access" argument.  I think that'll make the
> >code easier to read.
> 
> Bruce, I'm not clear how to check both here as I mentioned in my previous
> email.
> 
> nfs4_resolve_deny_conflicts_locked is called from nfs4_file_get_access
> and nfs4_file_check_deny to check either access or deny mode separately
> so how do we check both access and deny in nfs4_resolve_deny_conflicts_locked?

Sorry, I forgot.

Uh, I guess on a quick skim I don't see a way to do that nicely, so,
fine, I'm OK with it as is.

--b.
