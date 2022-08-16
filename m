Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE55960BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 19:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiHPRBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiHPRBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:01:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6181680F64
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 10:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C728B81AA1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 17:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824CEC433C1;
        Tue, 16 Aug 2022 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660669293;
        bh=Wq3Xte4e1iLFnYWNYz7blqN6Lxo93dALV8o2mdnC0LQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dTeltfd8ApAvldlR6nqciRHfS4Dpi9WBSJXtuyUTU9OmqrphdF9k4W8Q/TtelZrRo
         x/8Er74d7afQ6SgMWb3Z/nKFC3GzHxyST4cOr8sXQi08tFNfVNhW3UYTuBLsK+/1GA
         /22GwDOqZorbPwB0MuEp1SoRUTYuAz2/YBqK4/wLOIq/9bPoY7GFFdu78DoEylrDso
         m9CUPkBXXaRpYYBSS+k6aHlNFvuglm34HHvs2wDXX7AmoUMCCFse+nWuISnB7Es6B3
         xDqYN2x8Ueu+Fn0H4PsDhvzMpRXB0+rBEN+dY+8uNV4PDmFnw34XNwaCD49IMQqL5w
         OhJnShJiL77Vw==
Date:   Tue, 16 Aug 2022 19:01:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com, jack@suse.cz,
        hch@lst.de, axboe@kernel.dk, djwong@kernel.org
Subject: Re: [PATCH v1] fs: __file_remove_privs(): restore call to
 inode_has_no_xattr()
Message-ID: <20220816170128.inzqyuj4snywiwqx@wittgenstein>
References: <20220816153158.1925040-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220816153158.1925040-1-shr@fb.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 08:31:58AM -0700, Stefan Roesch wrote:
> This restores the call to inode_has_no_xattr() in the function
> __file_remove_privs(). In case the dentry_meeds_remove_privs() returned
> 0, the function inode_has_no_xattr() was not called.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---

Looks good to me. As Jens said, this should get a fixes tag and should
probably also have a link to the perf regression I debugged this on so
that we can see whether this was actually the cause,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
