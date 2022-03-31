Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D098C4EE3F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 00:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiCaWZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 18:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiCaWZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:25:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0113193156;
        Thu, 31 Mar 2022 15:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CF72B8217D;
        Thu, 31 Mar 2022 22:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FCCC340F0;
        Thu, 31 Mar 2022 22:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648765441;
        bh=KjCBdxBlUYuFSbhWJXBQ6IK1c2dHNtjMPfCxB/92r2Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B6Pxqc3rCgEhovnQeJFNrCafLvdAbWASObhYrPq2vsx/AwhpnKpfil0cQ3peat7Wq
         vXwLEHjpPp66r/83OBtcMj47TU8g2UHnw6RvEbGaGt7TK2AmsEsmtFDl+B4PFWr5VL
         8ZoP61DY35Q64vXn566bCe5kz1kI/vqS89fEoKTIaloLkwsE1PvSjjb4XtkiyKKc4J
         98UaR0WSjCjw279Sgy3yi1vHfdTDaMBB/KEslquJQK+SgOw+XfyPOwCOLFU4icL6Wm
         ZXaI6pN47KDX7tf5KPBjINgnpXysSkS4fvU1xPJIxGXgy2G9+jfadpA/Jvv4+Z/fZ7
         JSBIEPjC3Bllw==
Message-ID: <0eb1e458f225bc84364f3e1c0fefddf84739e81c.camel@kernel.org>
Subject: Re: [PATCH v12 01/54] vfs: export new_inode_pseudo
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     ceph-devel@vger.kernel.org, xiubli@redhat.com, idryomov@gmail.com,
        lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 31 Mar 2022 18:23:59 -0400
In-Reply-To: <YkYF7XdrXoWrphGi@zeniv-ca.linux.org.uk>
References: <20220331153130.41287-1-jlayton@kernel.org>
         <20220331153130.41287-2-jlayton@kernel.org>
         <YkYF7XdrXoWrphGi@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-03-31 at 19:50 +0000, Al Viro wrote:
> On Thu, Mar 31, 2022 at 11:30:37AM -0400, Jeff Layton wrote:
> > Ceph needs to be able to allocate inodes ahead of a create that might
> > involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
> > but it puts the inode on the sb->s_inodes list and when we go to hash
> > it, that might be done again.
> > 
> > We could work around that by setting I_CREATING on the new inode, but
> > that causes ilookup5 to return -ESTALE if something tries to find it
> > before I_NEW is cleared. This is desirable behavior for most
> > filesystems, but doesn't work for ceph.
> > 
> > To work around all of this, just use new_inode_pseudo which doesn't add
> > it to the sb->s_inodes list.
> 
> Umm...  I can live with that, but... why not just leave the hash insertion
> until the thing is fully set up and you are ready to clear I_NEW?

If the thing is already in the hash at the end then we have to go back
and redo the inode update with the correct inode. That can be messy too
-- in some cases we hand off strings and such.

On IRC, Al suggested that we instead change the test in inode_insert5 so
we can avoid the double list_add. I'm testing a patch now that seems to
be working, so I'll plan to drop this one in favor of that approach.

Thanks for the help!
-- 
Jeff Layton <jlayton@kernel.org>
