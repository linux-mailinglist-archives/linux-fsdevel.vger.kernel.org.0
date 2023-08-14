Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE1A77C085
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 21:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjHNTOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 15:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjHNTOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B773CB5;
        Mon, 14 Aug 2023 12:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50E1465921;
        Mon, 14 Aug 2023 19:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C21C433C8;
        Mon, 14 Aug 2023 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692040468;
        bh=ZMrO9kHt31aBiTfDQ2I66UBLQJaflkcOw7L4HeyTWHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgKmMW/BOVD3WXzBa+PpThz/SSQJ3Eb8LrnQjRsWWDpOaRJL0zPCwC0XT9zQijHMu
         o9AZVkUFCPZKZahlPAexwJmqT9gxEM0WHxH9esoLU6mo5N30PV0Xfe3VhdaqL5Cyg5
         c+x6v2TlqR8VnZv+eE+L+DyTKE6Kobk5q4yDRYoUnTjjcXFN7vXznYcUm4r0SkoFHy
         kpRGyqtQPaCWzI9M0h0C/2+d21EtLWHLQAd6veW9pL1wrWfSpYNG4rOUzYMFV8GOZO
         abfj0sOO7DL9ivFSQkkjotZ6utGZEv070+imPLZch46B0sgGJAz54wxCAMqwQL42b+
         Yw/c1J/CJ0MHQ==
Date:   Mon, 14 Aug 2023 12:14:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 01/10] fs: Expose helper to check if a directory needs
 casefolding
Message-ID: <20230814191426.GC1171@sol.localdomain>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-2-krisman@suse.de>
 <20230812015915.GA971@sol.localdomain>
 <875y5h7jld.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y5h7jld.fsf@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:02:38AM -0400, Gabriel Krisman Bertazi wrote:
> 
> Also, this patchset has been sitting for years before the latest
> discussions, and I'm tired of it, so I'm happy to keep this
> discussion for another time.  Will drop this patch and just check
> IS_CASEFOLDED in ecryptfs for the next iteration.
> 
> I'll follow up with another case-insensitive cleanup patchset I've been
> siting on forever, which includes this patch and will restart this
> discussion, among others.
> 

Well, as we know unfortunately filesystem developers are in short supply, and
doing proper reviews (identifying issues and working closely with the patchset
author over multiple iterations to address them, as opposed to just slapping on
a Reviewed-by) is very time consuming.  Earlier this year I tried to get the
Android Systems team, which is ostensibly responsible for Android's use of
casefolding, to take a look, but their entire feedback was just "looks good to
me".  Also, the fact that this patchset originally excluded the casefold+encrypt
case technically made it not applicable to Android, and discouraged me from
taking a look since encryption is my focus.  Sorry for not taking a look sooner.

Anyway, thanks for doing this, and I think it's near the finish line now.  Once
you address the latest feedback and get a couple acks, I think that Christian
should take this through the VFS tree.  BTW, in my opinion, as the maintainer of
the "Unicode subsystem" you are also authorized to send a pull request for this
to Linus yourself.  But VFS does seem ideal in this case, given the diffstat,
and Christian has been fairly active with taking patches.

- Eric
