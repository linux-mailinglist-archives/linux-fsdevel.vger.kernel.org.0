Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DCF722189
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjFEI4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjFEI4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EA4E53;
        Mon,  5 Jun 2023 01:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06AFA61D40;
        Mon,  5 Jun 2023 08:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98999C433EF;
        Mon,  5 Jun 2023 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685955378;
        bh=EvMjOmcR0DzI75LU8ZbEStkGi2bPjEetDmC8ubTy+uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9VuCJscetyT57f7B0/jJSX2mOJWUOdJS0+bTsmp2kqSZkS+82WSr1SFDU5eiRxwO
         00RwJC9XiAKtDmwsfbfgnm5tAQ7s7PSOFGKMuI77sLXN1tcyzXz637jok9ttKRhgwv
         ihMX4JsLXDpX+U54g3TI30LT6F2JfppkEqkYPC5irp3cdpOkjb0tGnBPGhpaHH/roT
         umfryHZN3rL2zvfQMGkO6atQn7qXQYydl99YEFUBPDznOjrSqvRWoMf+tNVeP+UqX0
         LqTofFKTQIb1L8ArbkZdXoG4WDJ/6MPuKrsnTJs/4FKno4h0LyBJRSngnLwstwE5Uo
         y58vKf9BKp58w==
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re: [PATCH] cachefiles: Allow the cache to be non-root
Date:   Mon,  5 Jun 2023 10:56:07 +0200
Message-Id: <20230605-baumhaus-niemals-e54f42ee6697@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1853230.1684516880@warthog.procyon.org.uk>
References: <1853230.1684516880@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=993; i=brauner@kernel.org; h=from:subject:message-id; bh=EvMjOmcR0DzI75LU8ZbEStkGi2bPjEetDmC8ubTy+uM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTULlbM+6vXPafMzOrp0XPGZ58pzNSOPTG1mDs8LHBV9Rbj D4lJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5/Inhf4Cse+Oh38YBL09NOcATlJ 0ZzuxlkmOZcTDpw5KjewykzjD84c+OfJS6ZYfoj/QlC5cffj2Je6bXqnKFC3PzytRbWJ/X8wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 19 May 2023 18:21:20 +0100, David Howells wrote:
> 
> Set mode 0600 on files in the cache so that cachefilesd can run as an
> unprivileged user rather than leaving the files all with 0.  Directories
> are already set to 0700.
> 
> Userspace then needs to set the uid and gid before issuing the "bind"
> command and the cache must've been chown'd to those IDs.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] cachefiles: Allow the cache to be non-root
      https://git.kernel.org/vfs/vfs/c/a64498ff493f
