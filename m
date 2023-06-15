Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF0273193C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbjFOMyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 08:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjFOMx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:53:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23DE213B
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 05:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 767966210F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 12:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92527C433C0;
        Thu, 15 Jun 2023 12:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686833637;
        bh=g4nvSA4qg2jW7ByTgyTwHQZ9kQ46Tqmv9DIdFysHmtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qnW7RVInd3N9eDnZvJliNhHWgmipk1L8Fu2wsQy+BzOubfJtNHtFXXzlPUSAT3lEZ
         2w6zlb3eYkGN7529U+KTGR4Tp/0o/unAaxsD+4ZAqvXvmdnNgxDDlV3xjzz9h9j+d9
         u3LHeX1ZBjfaAF7BNcySSVirqFzeCa09xiMLJT1fk1l3WdF2K5TH8TKrGHKRfj/KeF
         90cuopc5l8i2JxK3vCbzBSD5J5Py+9wbyMlvaDpQuEFaI1NfTCXWm8DsElXKC1PZrz
         MY3/MItBKQuoTHnYHMt52ZNsMQP+u1CMpW6nF+vmLDHcaIwV7w6dyilyISoyUXsAAs
         MNRTwUD+e5B+w==
Date:   Thu, 15 Jun 2023 14:53:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Protect reconfiguration of sb read-write from racing
 writes
Message-ID: <20230615-zarte-locher-075323828cd1@brauner>
References: <20230615113848.8439-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615113848.8439-1-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:38:48PM +0200, Jan Kara wrote:
> The reconfigure / remount code takes a lot of effort to protect
> filesystem's reconfiguration code from racing writes on remounting
> read-only. However during remounting read-only filesystem to read-write
> mode userspace writes can start immediately once we clear SB_RDONLY
> flag. This is inconvenient for example for ext4 because we need to do
> some writes to the filesystem (such as preparation of quota files)
> before we can take userspace writes so we are clearing SB_RDONLY flag
> before we are fully ready to accept userpace writes and syzbot has found
> a way to exploit this [1]. Also as far as I'm reading the code
> the filesystem remount code was protected from racing writes in the
> legacy mount path by the mount's MNT_READONLY flag so this is relatively
> new problem. It is actually fairly easy to protect remount read-write
> from racing writes using sb->s_readonly_remount flag so let's just do
> that instead of having to workaround these races in the filesystem code.
> 
> [1] https://lore.kernel.org/all/00000000000006a0df05f6667499@google.com/T/
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

So looking at the ext4 code this can only happen when you clear
SB_RDONLY in ->reconfigure() too early (and the mount isn't
MNT_READONLY). Afaict, this was fixed in:

a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled")

by clearing SB_RDONLY late, right before returning from ->reconfigure()
when everything's ready. So your change is not about fixing that bug in
[1] it's about making the vfs give the guarantee that an fs is free to
clear SB_RDONLY because any ro<->rw transitions are protected via
s_readonly_remount. Correct? It seems ok to me just making sure.
