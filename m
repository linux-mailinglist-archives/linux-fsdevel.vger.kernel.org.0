Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17436EE0F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjDYLNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 07:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjDYLNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:13:51 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A20E4B;
        Tue, 25 Apr 2023 04:13:50 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 82745C01C; Tue, 25 Apr 2023 13:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1682421228; bh=B5zb2CXg13s0Ew4Pa8AsIx4tjGGlfSVk1dK8pluCJLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSli27UiRzkF3RQzVb2pDH1qwMlqNKKeIB9IeHCVjsveZMWrxNd+iowSHjRhWzu98
         RmKt1D496AVLABixK18RlzoyLS5Ja/W2VOCDKmYTegnyFIBxFFJ4mwQ0sCw82GGUrn
         OEXi2h0kOHZHlCAdr5fQu4GRDnJdY5AftbZ3VO62iQ3x2qBL+j2xopz9h1to6lwwoJ
         VVUmblTNtCY2CCdILyAhqvLhs8tk6lVx2B7sNyrGvLDjrRr31u+T2G5TbxoVf6U63+
         vq2IBJh5TWD5baByn/l0zlO/lWcU/mMlUa80iIoK+wPXPKVWBUH6jeT7tgdE+UM6MN
         45W8MjYB+YfSw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 1A0CEC009;
        Tue, 25 Apr 2023 13:13:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1682421228; bh=B5zb2CXg13s0Ew4Pa8AsIx4tjGGlfSVk1dK8pluCJLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSli27UiRzkF3RQzVb2pDH1qwMlqNKKeIB9IeHCVjsveZMWrxNd+iowSHjRhWzu98
         RmKt1D496AVLABixK18RlzoyLS5Ja/W2VOCDKmYTegnyFIBxFFJ4mwQ0sCw82GGUrn
         OEXi2h0kOHZHlCAdr5fQu4GRDnJdY5AftbZ3VO62iQ3x2qBL+j2xopz9h1to6lwwoJ
         VVUmblTNtCY2CCdILyAhqvLhs8tk6lVx2B7sNyrGvLDjrRr31u+T2G5TbxoVf6U63+
         vq2IBJh5TWD5baByn/l0zlO/lWcU/mMlUa80iIoK+wPXPKVWBUH6jeT7tgdE+UM6MN
         45W8MjYB+YfSw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 23ed73fc;
        Tue, 25 Apr 2023 11:13:42 +0000 (UTC)
Date:   Tue, 25 Apr 2023 20:13:27 +0900
From:   asmadeus@codewreck.org
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux_oss@crudebyte.com
Subject: Re: [PATCH v5] fs/9p: remove writeback fid and fix per-file modes
Message-ID: <ZEe11w5mG_pv5X_o@codewreck.org>
References: <20230218003323.2322580-11-ericvh@kernel.org>
 <ZCEGmS4FBRFClQjS@7e9e31583646>
 <7686c810-4ed6-9e3a-3714-8b803e2d3c46@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7686c810-4ed6-9e3a-3714-8b803e2d3c46@wanadoo.fr>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christophe JAILLET wrote on Tue, Apr 25, 2023 at 09:11:01AM +0200:
> This code looks strange.
> P9_OWRITE is 0x01, so !P9_OWRITE is 0.
> So the code is equivalent to "p9_omode = P9_ORDWR;"
> 
> Is it what is expexted?
> 
> Maybe
> 	p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
> ?

Since we're discussing tooling, sparse caught this one:
fs/9p/vfs_inode.c:826:38: warning: dubious: x & !y
fs/9p/vfs_inode_dotl.c:291:38: warning: dubious: x & !y

(runing with make `M=fs/9p W=1 C=2` ; unfortunately error code doesn't
reflect a problem so that'll require inspecting output to automate...)


I've tried running scan-build in a very old-fashioned way (getting the
gcc lines from make V=1 and re-running with scan-build) and it had some
arguable warnings (setting `ret = 0` before it is overwritten again is
considered a dead store), but it had some real problems as well so it
might be worth fixing these just to reduce the clutter and run it all
the time.
I'll post a couple of patches tomorrow (unrelated to this)

-- 
Dominique
