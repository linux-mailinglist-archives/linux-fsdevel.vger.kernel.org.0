Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940DE767C2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 06:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjG2EwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 00:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjG2EwA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 00:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94F19AF;
        Fri, 28 Jul 2023 21:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EEC86023F;
        Sat, 29 Jul 2023 04:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0C6C433C8;
        Sat, 29 Jul 2023 04:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690606318;
        bh=8CzHdaD4e57PvnCBD6zGsTCAxTvP8AnAGmWTWStQ05A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUfHkctW5jrZ5oRfrm5BWOp99D4FhHHJ5FF3U/Cbwi6M4KINBV3OH7k0lEXiOAbqj
         m8cwbnIxa2hG76i7cjAIz8CZ3geskfUggZe46CY26qAzaeV8Z0B/W5Eh7XM6Zk4VU1
         eScItR55iQTiAaWHlabzrprU9mRIiYxuRahKKeFas7Qjd5I+mHo54kqhBf9q/MMrTK
         9zObyTz4OdaE9cV+3PJodwm8B0NBmSwonvQBpQ2NtiIoT1X5i45ALO70/yBFADPTGU
         Bk9QpnUEfSUi1vCVUswBy27hPgr+GocgZopvqRxB1O1JUbOHdLboxZ/PtMjKtcu8Jm
         qfC00n8oCyaYg==
Date:   Fri, 28 Jul 2023 21:51:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v4 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230729045156.GD4171@sol.localdomain>
References: <20230727172843.20542-1-krisman@suse.de>
 <20230727172843.20542-4-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727172843.20542-4-krisman@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:28:39PM -0400, Gabriel Krisman Bertazi wrote:
> dentry->d_name is only checked by the case-insensitive d_revalidate hook
> in the LOOKUP_CREATE/LOOKUP_RENAME_TARGET case since, for these cases,
> d_revalidate is always called with the parent inode read-locked, and
> therefore the name cannot change from under us.

"at least read-locked"?  Or do you actually mean write-locked?

> +static inline int generic_ci_d_revalidate(struct dentry *dentry,
> +					  const struct qstr *name,
> +					  unsigned int flags)

No need for inline here.

- Eric
