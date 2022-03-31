Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F874EE21C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 21:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbiCaTv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbiCaTvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:51:54 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9CF49FA2;
        Thu, 31 Mar 2022 12:50:07 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1na0o2-001HRI-0L; Thu, 31 Mar 2022 19:50:06 +0000
Date:   Thu, 31 Mar 2022 19:50:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, xiubli@redhat.com, idryomov@gmail.com,
        lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 01/54] vfs: export new_inode_pseudo
Message-ID: <YkYF7XdrXoWrphGi@zeniv-ca.linux.org.uk>
References: <20220331153130.41287-1-jlayton@kernel.org>
 <20220331153130.41287-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331153130.41287-2-jlayton@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:30:37AM -0400, Jeff Layton wrote:
> Ceph needs to be able to allocate inodes ahead of a create that might
> involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
> but it puts the inode on the sb->s_inodes list and when we go to hash
> it, that might be done again.
> 
> We could work around that by setting I_CREATING on the new inode, but
> that causes ilookup5 to return -ESTALE if something tries to find it
> before I_NEW is cleared. This is desirable behavior for most
> filesystems, but doesn't work for ceph.
> 
> To work around all of this, just use new_inode_pseudo which doesn't add
> it to the sb->s_inodes list.

Umm...  I can live with that, but... why not just leave the hash insertion
until the thing is fully set up and you are ready to clear I_NEW?
