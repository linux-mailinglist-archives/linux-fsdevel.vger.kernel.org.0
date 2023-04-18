Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FEC6E5BB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 10:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjDRIMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDRIMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D687C7DA1;
        Tue, 18 Apr 2023 01:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B288762832;
        Tue, 18 Apr 2023 08:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828DEC433EF;
        Tue, 18 Apr 2023 08:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681805468;
        bh=47CcCLPFRbSzEx2dtsDj6wC+Pybk8d2lE+zPpHdQOWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8miB+QvcNOoA6tbJojRLTwGwWRAH+R33Od0kvQRYLL0u3+8BRyZHpxVkRGD7J+13
         f8BtPEBjEgbrxrgOzQQdOsEc/d7xtJR+Wzm3Kif7FVYadshM5PJOHOkKeCcndt5Ghu
         Nn8vAh8dzqkmKhaza82gsH7/34JiTdZxoIYbmRav0lC2ZpUdcotj497DKrCZKJGe7y
         qk3955Fxk9Ot6MjPf697F+dx41wLsrmm75VthYort5VXo5J41bZefXIpIk6Bp2Eo9q
         oHFbISI5zWXs6T8L8F13LDpuX9cf/dqERr/mPe0b5nep38Q31Yuj0RHXdUwzV7AV1u
         yKZK/GIjzIZdQ==
Date:   Tue, 18 Apr 2023 10:10:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
Message-ID: <20230418-akzentfrei-zerkleinern-09ab96d78e21@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168168683217.24821.6260957092725278201@noble.neil.brown.name>
 <20230417-beisein-investieren-360fa20fb68a@brauner>
 <6c08ad94ca949d0f3525f7e1fc24a72c50affd59.camel@kernel.org>
 <20230417-relaxen-selektiert-4b4b4143d7f6@brauner>
 <85774a5de74b2b7828c8b8f7e041f0e9e2bc6094.camel@kernel.org>
 <168176725469.24821.12655103124286729608@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <168176725469.24821.12655103124286729608@noble.neil.brown.name>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 07:34:14AM +1000, NeilBrown wrote:
> On Tue, 18 Apr 2023, Jeff Layton wrote:
> > 
> > The last thing we want in that case is for the server to decide to
> > change some intermediate dentry in between the two operations. Best
> > case, you'll get back ENOENT or something when the pathwalk fails. Worst
> > case, the server swaps what are two different mountpoints on your client
> > and you unmount the wrong one.
> 
> Actually, the last think I want is for the server to do something that
> causes a directory to be invalidated (d_invalidate()).  Then any mount
> points below there get DETACHed and we lose any change to use MNT_FORCE
> or to wait for the unmount to complete.  Of course this can also happen
> during any other access, not just umount....

Any rmdir/unlink from another mount namespace where the mountpoint isn't
a local mountpoint would lazily unmount the whole mount tree. You can't
guard against this anyway.
