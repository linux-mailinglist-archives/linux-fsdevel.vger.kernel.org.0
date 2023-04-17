Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B66E53F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 23:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjDQVeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 17:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDQVeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:34:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D294C3B;
        Mon, 17 Apr 2023 14:34:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 950951FD67;
        Mon, 17 Apr 2023 21:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681767260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCIojjCpC4UvJ3G9H1oAVERTrmaTIaJXYB/KqaiVScs=;
        b=FkAzQX0rrPAWb4sZXJpNGTy5t4eSzZ28IikN0G/IGjjNIcwdPakVNudMFlcdlRLwvio7wg
        UOAwLfSuaVj+FWXc2rb/a3L6TVdqBSR1v7SCeKOs+loSqbjIz1dRA3rXUShF38AQ+Qyc33
        6PJ6oBR7TPvJjgMdBVaDhOzxyWZxZLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681767260;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCIojjCpC4UvJ3G9H1oAVERTrmaTIaJXYB/KqaiVScs=;
        b=57+VKzPNsB4WnHaQYCx3+bMM7t+13Gn0HlsNlMO9RoU1PZi2NDIaKSeZaQrSSME+if4Vbe
        FthP9o5voSJox+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D292A1390E;
        Mon, 17 Apr 2023 21:34:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4jRgIVm7PWTJZgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 17 Apr 2023 21:34:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Christian Brauner" <brauner@kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Dave Wysochanski" <dwysocha@redhat.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs" <linux-nfs@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
In-reply-to: <85774a5de74b2b7828c8b8f7e041f0e9e2bc6094.camel@kernel.org>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>,
 <168168683217.24821.6260957092725278201@noble.neil.brown.name>,
 <20230417-beisein-investieren-360fa20fb68a@brauner>,
 <6c08ad94ca949d0f3525f7e1fc24a72c50affd59.camel@kernel.org>,
 <20230417-relaxen-selektiert-4b4b4143d7f6@brauner>,
 <85774a5de74b2b7828c8b8f7e041f0e9e2bc6094.camel@kernel.org>
Date:   Tue, 18 Apr 2023 07:34:14 +1000
Message-id: <168176725469.24821.12655103124286729608@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 18 Apr 2023, Jeff Layton wrote:
> 
> The last thing we want in that case is for the server to decide to
> change some intermediate dentry in between the two operations. Best
> case, you'll get back ENOENT or something when the pathwalk fails. Worst
> case, the server swaps what are two different mountpoints on your client
> and you unmount the wrong one.

Actually, the last think I want is for the server to do something that
causes a directory to be invalidated (d_invalidate()).  Then any mount
points below there get DETACHed and we lose any change to use MNT_FORCE
or to wait for the unmount to complete.  Of course this can also happen
during any other access, not just umount....

> 
> If we don't revaliate, then we're no worse off, and may be better off if
> something hinky happens to the server of an intermediate dentry in the
> path.

Exactly.  If we don't revalidate we might use old data, but it will be
old data that were were allowed to access.  It might be data that we are
not now allowed to access, but it will never be new data that were have
never been allowed to access.

Thanks,
NeilBrown

