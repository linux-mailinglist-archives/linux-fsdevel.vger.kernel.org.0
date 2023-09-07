Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE4D79749C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 17:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjIGPkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjIGPYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:24:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B410E9;
        Thu,  7 Sep 2023 08:24:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2117F1F74D;
        Thu,  7 Sep 2023 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694095606;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VqPjYifbkeF3+t2RA3edn8iMNGo18hRP1/ESstRei+0=;
        b=f/pXO21mPTw67GwDjXvy+q5McylSHYIUb3fcUpGA4pG+ceHWzmPBKAo5pSNzh5/CCiw4sg
        TH67sJMgNeNhMAs1nFKxAcREyt/78FbXiWOWFLm6AmMaKu7cCR4QCZca4Lw9m9bzabzlHr
        c6cUeXRttcjsukRAupITjPVEeBhC5Tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694095606;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VqPjYifbkeF3+t2RA3edn8iMNGo18hRP1/ESstRei+0=;
        b=B3xC5wfx3s4slGZ50gWxMjK3CsJcwVa3aUgqEDbMbCF/7wKtzyIi3fCTC4eFlLWPjVFcaJ
        9CH5g/I9ZHZSukDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D250F138F9;
        Thu,  7 Sep 2023 14:06:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HkyJMvXY+WR2UQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 14:06:45 +0000
Date:   Thu, 7 Sep 2023 16:00:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/2] Use exclusive lock for file_remove_privs
Message-ID: <20230907140014.GP3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230831112431.2998368-1-bschubert@ddn.com>
 <20230905180259.GG14420@twin.jikos.cz>
 <20230906-teeservice-erbfolge-a23bfa3180eb@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906-teeservice-erbfolge-a23bfa3180eb@brauner>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 04:43:22PM +0200, Christian Brauner wrote:
> On Tue, Sep 05, 2023 at 08:02:59PM +0200, David Sterba wrote:
> > On Thu, Aug 31, 2023 at 01:24:29PM +0200, Bernd Schubert wrote:
> > > While adding shared direct IO write locks to fuse Miklos noticed
> > > that file_remove_privs() needs an exclusive lock. I then
> > > noticed that btrfs actually has the same issue as I had in my patch,
> > > it was calling into that function with a shared lock.
> > > This series adds a new exported function file_needs_remove_privs(),
> > > which used by the follow up btrfs patch and will be used by the
> > > DIO code path in fuse as well. If that function returns any mask
> > > the shared lock needs to be dropped and replaced by the exclusive
> > > variant.
> > > 
> > > Note: Compilation tested only.
> > 
> > The fix makes sense, there should be no noticeable performance impact,
> > basically the same check is done in the newly exported helper for the
> > IS_NOSEC bit.  I can give it a test locally for the default case, I'm
> > not sure if we have specific tests for the security layers in fstests.
> > 
> > Regarding merge, I can take the two patches via btrfs tree or can wait
> > until the export is present in Linus' tree in case FUSE needs it
> > independently.
> 
> Both fuse and btrfs need it afaict. We can grab it and provide a tag
> post -rc1? Whatever works best.

Git tree sync won't be needed, Bernd sent the fix within btrfs code.
