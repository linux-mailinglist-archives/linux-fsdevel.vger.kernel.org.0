Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93DC78ED40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 14:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346283AbjHaMgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 08:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjHaMgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812CDE43;
        Thu, 31 Aug 2023 05:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08E95632ED;
        Thu, 31 Aug 2023 12:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D009C433C7;
        Thu, 31 Aug 2023 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693485374;
        bh=YTE6VXGsNhwwnE1WRR+jiKmCFv8IQTGmHPP7b83zi08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R7qpQa4MA07HylLZFu3oc5ztNx14fNsvCYu1KK6a5nAmk+n7tAMXgnUofERjdizTO
         DfIiK2nFNw9zwW/bbS/+/He6ohZkSi3aFOf1XOzFIv0HcgfnpHmyGFDucR80Q8Vmrc
         SMonwuIHUUMXY197yN9LbfDK/Wc8A6dyCqqJ70Cg575G1MvBi6w0THyIvafx+RRz/j
         mU51da11VPhIt4oao2mtzHaXXNHTyax47nDwfUcJupUNwQvEGgGq8yiMl8nBV83Vh9
         wfqzDlfl/iWJ09heVj+tEElA8ghwIR3eSW59EyUBlcNuL6bUsuT4wcl9FgvU/QdwZQ
         Nn6VrGHvTAULw==
Date:   Thu, 31 Aug 2023 14:36:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        linux-mm@kvack.org, linux-integrity@vger.kernel.org
Subject: Re: LSM hook ordering in shmem_mknod() and shmem_tmpfile()?
Message-ID: <20230831-nachverfolgen-meditation-dcde56b10df7@brauner>
References: <CAHC9VhQr2cpes2W0oWa8OENPFAgFKyGZQu3_m7-hjEdib_3s3Q@mail.gmail.com>
 <f75539a8-adf0-159b-15b9-4cc4a674e623@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f75539a8-adf0-159b-15b9-4cc4a674e623@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 02:19:20AM -0700, Hugh Dickins wrote:
> On Wed, 30 Aug 2023, Paul Moore wrote:
> 
> > Hello all,
> > 
> > While looking at some recent changes in mm/shmem.c I noticed that the
> > ordering between simple_acl_create() and
> > security_inode_init_security() is different between shmem_mknod() and
> > shmem_tmpfile().  In shmem_mknod() the ACL call comes before the LSM
> > hook, and in shmem_tmpfile() the LSM call comes before the ACL call.
> > 
> > Perhaps this is correct, but it seemed a little odd to me so I wanted
> > to check with all of you to make sure there is a good reason for the
> > difference between the two functions.  Looking back to when
> > shmem_tmpfile() was created ~2013 I don't see any explicit mention as
> > to why the ordering is different so I'm looking for a bit of a sanity
> > check to see if I'm missing something obvious.
> > 
> > My initial thinking this morning is that the
> > security_inode_init_security() call should come before
> > simple_acl_create() in both cases, but I'm open to different opinions
> > on this.
> 
> Good eye.  The crucial commit here appears to be Mimi's 3.11 commit
> 37ec43cdc4c7 "evm: calculate HMAC after initializing posix acl on tmpfs"
> which intentionally moved shmem_mknod()'s generic_acl_init() up before
> the security_inode_init_security(), around the same time as Al was
> copying shmem_mknod() to introduce shmem_tmpfile().
> 
> I'd have agreed with you, Paul, until reading Mimi's commit:
> now it looks more like shmem_tmpfile() is the one to be changed,
> except (I'm out of my depth) maybe it's irrelevant on tmpfiles.

POSIX ACLs generally need to be set first as they are may change inode
properties that security_inode_init_security() may rely on to be stable.
That specifically incudes inode->i_mode:

* If the filesystem doesn't support POSIX ACLs then the umask is
  stripped in the VFS before it ever gets to the filesystems. For such
  cases the order of *_init_security() and setting POSIX ACLs doesn't
  matter.
* If the filesystem does support POSIX ACLs and the directory of the
  resulting file does have default POSIX ACLs with mode settings then
  the inode->i_mode will be updated.
* If the filesystem does support POSIX ACLs but the directory doesn't
  have default POSIX ACLs the umask will be stripped.

(roughly from memory)

If tmpfs is compiled with POSIX ACL support the mode might change and if
anything in *_init_security() relies on inode->i_mode being stable it
needs to be called after they have been set.

EVM hashes do use the mode and the hash gets updated when POSIX ACLs are
changed - which caused me immense pain when I redid these codepaths last
year.

IMHO, the easiest fix really is to lump all this together for all
creation paths. This is what most filesystems do. For examples, see

xfs_generic_create()
-> posix_acl_create(&mode)
-> xfs_create{_tmpfile}(mode)
-> xfs_inode_init_security()

or

__ext4_new_inode()
-> ext4_init_acl()
-> ext4_init_security()
