Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD1D75247B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjGMN7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjGMN7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:59:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6941FFC;
        Thu, 13 Jul 2023 06:59:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EEF761488;
        Thu, 13 Jul 2023 13:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E0FC433C8;
        Thu, 13 Jul 2023 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689256758;
        bh=od/k2weWbY2ISabpoTFOzr7beLPfSTgApU7fB8lgd6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNi/S1lOO1471olGdFnUIMMcK5jFwAu778ARjgcfZYy1Jl8Z8B23kxVNjCIyAa8pW
         kdtWnLv2S0I9ZpUZG29hMb5gL5oU40ysX1esEKqv3Sw/cczqyq3cEOhIm7Gce2XhA7
         QmQ7TfKA1G+d4DssV7dRFJzn0ZRFpskwlbSmjgSLIcybFI1Fen2L/NA/r8u/sOZ1+6
         KpUfl/g2/a6tchia4y2Yrc3a73DePp0sklq4CLki7+kBD+shIvwH3R9sXQbAdfRbTq
         Rp5sui+hEF/gIDKKG2CK1YcSn1CxJzTwJeL9a9MFkDM33VasrcByaY8idxT/Nnrm0Y
         dpoPjIfwqc/0w==
Date:   Thu, 13 Jul 2023 15:59:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2: fix timestamp handling on quota inodes
Message-ID: <20230713-vorrecht-laderaum-f00a57d22496@brauner>
References: <20230713135249.153796-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713135249.153796-1-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 09:52:48AM -0400, Jeff Layton wrote:
> While these aren't generally visible from userland, it's best to be
> consistent with timestamp handling. When adjusting the quota, update the
> mtime and ctime like we would with a write operation on any other inode,
> and avoid updating the atime which should only be done for reads.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/gfs2/quota.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Christian,
> 
> Would you mind picking this into the vfs.ctime branch, assuming the GFS2
> maintainers ack it? Andreas and I had discussed this privately, and I

Happy to!
