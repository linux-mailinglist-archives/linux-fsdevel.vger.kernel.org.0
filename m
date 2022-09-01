Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0465A8D06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 07:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiIAFEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 01:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiIAFEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:04:34 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C881157F5;
        Wed, 31 Aug 2022 22:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9MgdM/4E/TOLmi5ouDu792LxVmllOqtYXJ7y3pATFgQ=; b=pSZCdMPw4gdcTYtt1r9bP+HAlK
        gU+1IgMTmybd7HuQhOOMEkC6JigND3VXY7zlyLDvXJiSMswIBSVrQGt9s9NROjx8QZ18YBGuVNUv8
        kdfGLL2VqDpbs77GqAQNt7PSgOP9rD2VAH610+zip0lIuDWyGW0WwOQETLLEaCaw529fi3UKzjQs5
        s7/sJZoF5/ns40rXGoptnnJMNQ+8/A/9oGgnzn6dtYiI3rdntD6yqwUyebhsjcXKwRU3GNw7UGe0y
        3Ti/O5aDOvsVO9na6UmeQnRUMSTrlibkrj+p1hRpypHQonh4ix9Bc8plfJl5W1Qrv0/sw8sOXzfFq
        tf+YRkkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTcNI-00Ar6I-Sm;
        Thu, 01 Sep 2022 05:04:21 +0000
Date:   Thu, 1 Sep 2022 06:04:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
Message-ID: <YxA9VJuQpQSgGnhB@ZenIV>
References: <166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 24, 2022 at 11:09:50AM +0100, David Howells wrote:

What's the reason for difference between selinux and smack instances of
context_init?  The former allocates only on submount, the latter -
unconditionally...

> +static int selinux_fs_context_init(struct fs_context *fc,
> +				   struct dentry *reference)
> +{
> +	const struct superblock_security_struct *sbsec;
> +	const struct inode_security_struct *root_isec;
> +	struct selinux_mnt_opts *opts;
> +
> +	if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {
> +		opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> +		if (!opts)
> +			return -ENOMEM;
> +
> +		root_isec = backing_inode_security(reference->d_sb->s_root);
> +		sbsec = selinux_superblock(reference->d_sb);
> +		if (sbsec->flags & FSCONTEXT_MNT)
> +			opts->fscontext_sid	= sbsec->sid;
> +		if (sbsec->flags & CONTEXT_MNT)
> +			opts->context_sid	= sbsec->mntpoint_sid;
> +		if (sbsec->flags & DEFCONTEXT_MNT)
> +			opts->defcontext_sid	= sbsec->def_sid;
> +		fc->security = opts;
> +	}
> +
> +	return 0;
> +}

> +/**
> + * smack_fs_context_init - Initialise security data for a filesystem context
> + * @fc: The filesystem context.
> + * @reference: Reference dentry (automount/reconfigure) or NULL
> + *
> + * Returns 0 on success or -ENOMEM on error.
> + */
> +static int smack_fs_context_init(struct fs_context *fc,
> +				 struct dentry *reference)
> +{
> +	struct superblock_smack *sbsp;
> +	struct smack_mnt_opts *ctx;
> +	struct inode_smack *isp;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	fc->security = ctx;
> +
> +	if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {
> +		sbsp = smack_superblock(reference->d_sb);
> +		isp = smack_inode(reference->d_sb->s_root->d_inode);
