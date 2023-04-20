Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27626E9E7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 00:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjDTWBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 18:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDTWBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:01:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F9B1FE9;
        Thu, 20 Apr 2023 15:01:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E88B21977;
        Thu, 20 Apr 2023 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682028075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cb8IiwjydDFkqlnvJ5earL3cRdYCKepnWgTZfGAvdNY=;
        b=btlmuxa8+pnhB9jt0FVV9gGS00TUvk2ZqWHZbRspfIbp64M1NTHJ4cTLDqxO/GXiNJihR3
        tUENpp4+zMdApET9iakw38WuoB0I6aF0XEMY6akMkwfybfCbJ3Cze2H/U1b8SROTrnl8NT
        IyUzjTe1bOXEMnhi4ityRcaa8J/vdv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682028075;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cb8IiwjydDFkqlnvJ5earL3cRdYCKepnWgTZfGAvdNY=;
        b=2NxBvrRi8IOXIAppZMz0n07ICY9+x1yn+CRBsl4W47SS98edks30UV5VtPQGEYaM3dRtF2
        VURFtCcKu72NcXDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9099E1333C;
        Thu, 20 Apr 2023 22:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bNg2Eii2QWRtEAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 20 Apr 2023 22:01:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Christian Brauner" <brauner@kernel.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Dave Wysochanski" <dwysocha@redhat.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs" <linux-nfs@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
In-reply-to: <20230420213529.GS3390869@ZenIV>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>,
 <168168683217.24821.6260957092725278201@noble.neil.brown.name>,
 <20230417-beisein-investieren-360fa20fb68a@brauner>,
 <168176679417.24821.211742267573907874@noble.neil.brown.name>,
 <20230420213529.GS3390869@ZenIV>
Date:   Fri, 21 Apr 2023 08:01:09 +1000
Message-id: <168202806952.24821.15445938161479912532@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 Apr 2023, Al Viro wrote:
> On Tue, Apr 18, 2023 at 07:26:34AM +1000, NeilBrown wrote:
> 
> > MNT_FORCE is, I think, a good idea and a needed functionality that has
> > never been implemented well.
> > MNT_FORCE causes nfs_umount_begin to be called as you noted, which
> > aborts all pending RPCs on that filesystem.
> 
> Suppose it happens to be mounted in another namespace as well.  Or bound
> at different mountpoint, for that matter.  What should MNT_FORCE do?
> 

1/ set a "forced-unmount" flag on the vfs_mount which causes any syscall
   that uses the vfsmount (whether from an fd, or found in a path walk,
   or elsewhere), except for close(), to abort with an error;
2/ call ->umount_begin passing in the vfs_mount.  The fs can abort any
   outstanding transaction on any fd from that vfs_mount.   Possibly
   it might instead abort a wait rather than the whole transaction,
   particularly if requests using some other vfs_mount might also be
   interested in the transaction
3/ ->close() on a force-unmount vfs_mount would clean up without
   blocking indefinitely, discarding dirty data if necessary.

This still depends on the application to close all fds that return
errors (and to chdir out of a problematic directory).  But at least it
*allows* applications to do that without requiring that they be killed.

Thanks,
NeilBrown
