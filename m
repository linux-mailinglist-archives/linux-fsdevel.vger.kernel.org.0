Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7473577F7F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351553AbjHQNm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 09:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351547AbjHQNlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B62D68
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 06:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCE8267014
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 13:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF05C433C7;
        Thu, 17 Aug 2023 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692279709;
        bh=C6Gw3UU2YWMsIrmzdcrTIjtM0cWmaIK5T5C1xxxVOxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtnaEwI8Jghgfj8/YC5Sf1r9grd8J2GvuzIj37czIvuOJTaE1JoRzC60/6zlA7ZxQ
         44t9+Dy8x3MT1fHRfsNvazG9OXOvp0jxnN5+NwPIvb764sr54HQK7+bAx2Rk/xdqCF
         t/qAYnM/NT7QnlUIyJTyJ8Z0TeTBvrbiYNvoH7uprk0wWxpef9Los64kjuOLVH3Vey
         uJvbVXzgyf2q3D+YBup+GdC2pKi6YDndTJj1Y5jEr7oh7EqUJuHnzULQ+cQwMEsgQa
         BJHoKP7PCovf5yZRDNW3Cym/VIGh/nDr44fWgtHKqlIQujRAV948czSsFYlqXh4DaA
         exyA6FYFQ1iRQ==
Date:   Thu, 17 Aug 2023 15:41:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] super: wait for nascent superblocks
Message-ID: <20230817-urzustand-serpentinen-8d661c04adc6@brauner>
References: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
 <20230817-vfs-super-fixes-v3-v1-2-06ddeca7059b@kernel.org>
 <20230817125021.l6h4ipibfuzd3xdx@quack3>
 <20230817-tortur-wallung-3512b32d8dd5@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230817-tortur-wallung-3512b32d8dd5@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Thanks for that question! I was missing something. Before these changes,
> when a superblock was unmounted and it hit deactivate_super() it could do:
> 
> P1                                                      P2
> deactivate_locked_super()                               grab_super()

s/deactivate_locked_super()/deactivate_super()
