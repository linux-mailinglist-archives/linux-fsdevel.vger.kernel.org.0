Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF934D3BD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 22:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiCIVN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 16:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiCIVN4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:13:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D539CFF9;
        Wed,  9 Mar 2022 13:12:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59EA561AD1;
        Wed,  9 Mar 2022 21:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFE7C340F4;
        Wed,  9 Mar 2022 21:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646860375;
        bh=iRtGcZSySF09u13R1mT5NLROo7Lq5VVmijSoeUqM3ds=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qqZNH2I1hX/JXgejzg8J5o0RBIaMFKyeq+jxOEujWuRmeL8cFAcORukF3OATCbFsE
         zxqka9zCPUPZtwq3cs5vLlUvHTuQIBqlC9oggV3q+JsnzOMIhTSHI3AdL2F61VfcOl
         uJclZFett5KSVbAu633cHl813HG5HeYRnzyLGPB8Kr0TgdL9LBuXiXMgOxJIbXba5G
         1TzcbW44p9l4cM33AjRDUzZU19yCPGUXJ0NY0Nnom1M+Av+ogdEPQCGpFE9/8Bhsx3
         dzRv2Gpp9lrtGqRqxWpX83pgjpDVBc1cfpFHBo3JlCsT7eN0/YJAwCg5BWrv6dQ5sG
         DiTv+0laLP1Fw==
Message-ID: <92ebc9fbdda967c14274f2b246ef3f77a1f21224.camel@kernel.org>
Subject: Re: [PATCH v2 19/19] afs: Maintain netfs_i_context::remote_i_size
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     linux-afs@lists.infradead.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Mar 2022 16:12:52 -0500
In-Reply-To: <164678220204.1200972.17408022517463940584.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
         <164678220204.1200972.17408022517463940584.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-03-08 at 23:30 +0000, David Howells wrote:
> Make afs use netfslib's tracking for the server's idea of what the current
> inode size is independently of inode->i_size.  We really want to use this
> value when calculating the new vnode size when initiating a StoreData RPC
> op rather than the size stat() presents to the user (ie. inode->i_size) as
> the latter is affected by as-yet uncommitted writes.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> cc: linux-afs@lists.infradead.org
> 
> Link: https://lore.kernel.org/r/164623014626.3564931.8375344024648265358.stgit@warthog.procyon.org.uk/ # v1
> ---
> 
>  fs/afs/inode.c |    1 +
>  fs/afs/write.c |    7 +++----
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 5b5e40197655..2fe402483ad5 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -246,6 +246,7 @@ static void afs_apply_status(struct afs_operation *op,
>  		 * idea of what the size should be that's not the same as
>  		 * what's on the server.
>  		 */
> +		vnode->netfs_ctx.remote_i_size = status->size;
>  		if (change_size) {
>  			afs_set_i_size(vnode, status->size);
>  			inode->i_ctime = t;
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index e4b47f67a408..85c9056ba9fb 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -353,9 +353,10 @@ static const struct afs_operation_ops afs_store_data_operation = {
>  static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t pos,
>  			  bool laundering)
>  {
> +	struct netfs_i_context *ictx = &vnode->netfs_ctx;
>  	struct afs_operation *op;
>  	struct afs_wb_key *wbk = NULL;
> -	loff_t size = iov_iter_count(iter), i_size;
> +	loff_t size = iov_iter_count(iter);
>  	int ret = -ENOKEY;
>  
>  	_enter("%s{%llx:%llu.%u},%llx,%llx",
> @@ -377,15 +378,13 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
>  		return -ENOMEM;
>  	}
>  
> -	i_size = i_size_read(&vnode->vfs_inode);
> -
>  	afs_op_set_vnode(op, 0, vnode);
>  	op->file[0].dv_delta = 1;
>  	op->file[0].modification = true;
>  	op->store.write_iter = iter;
>  	op->store.pos = pos;
>  	op->store.size = size;
> -	op->store.i_size = max(pos + size, i_size);
> +	op->store.i_size = max(pos + size, ictx->remote_i_size);

Ahh ok, so if i_size is larger than is represented by this write, you'll
have a zeroed out region until writeback catches up. Makes sense.

>  	op->store.laundering = laundering;
>  	op->mtime = vnode->vfs_inode.i_mtime;
>  	op->flags |= AFS_OPERATION_UNINTR;
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
