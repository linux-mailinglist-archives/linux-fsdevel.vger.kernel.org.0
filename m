Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA2578FDD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 14:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349491AbjIAM4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 08:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245413AbjIAM4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:56:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B23010EF;
        Fri,  1 Sep 2023 05:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEE6CB8252D;
        Fri,  1 Sep 2023 12:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E410C433C7;
        Fri,  1 Sep 2023 12:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693572980;
        bh=32kmGOuLmvSvjrq9/iH5am+PYDV+51XH+7LUiRgdtyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agKgWGYzqr9AMz06E7FZAKXggRL+XYnvCI6w+0J+eP9qmZrfPDgzoEMRWeqqD2KLN
         hdIc08wBTD57fdfCiLegx5Y6YtMagxrIBi6svc/nLKOBrFzUOoL/MYAoP2D3bIAxwL
         +osxDjtT4fcRTX31kSN4sTRHz1SQHo3mS0w31DYZwji7tHlPS2r8pkPhsJJFM+rEf+
         THYKVJmdg0D7f4dheChHut/+D9PxDSTDQ/W6sQgysq4HQ/QtmJ/6JOcBGmwluOZPvh
         NS3BmKVwt7bxo7ci5oJzxl6AYmMp05+OOrFFwOaoGxhSReu9vxzM3dM2qxtEH/fI3f
         G4St1cd9LpQUA==
Date:   Fri, 1 Sep 2023 14:56:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Michal Clapinski <mclapinski@google.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] fcntl: add fcntl(F_CHECK_ORIGINAL_MEMFD)
Message-ID: <20230901-lockt-erbfolge-e1f9a26f0d63@brauner>
References: <20230831203647.558079-1-mclapinski@google.com>
 <20230831203647.558079-2-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831203647.558079-2-mclapinski@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 10:36:46PM +0200, Michal Clapinski wrote:
> Add a way to check if an fd points to the memfd's original open fd
> (the one created by memfd_create).
> Useful because only the original open fd can be both writable and
> executable.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
>  fs/fcntl.c                 | 3 +++
>  include/uapi/linux/fcntl.h | 9 +++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index e871009f6c88..301527e07a4d 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -419,6 +419,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  	case F_SET_RW_HINT:
>  		err = fcntl_rw_hint(filp, cmd, arg);
>  		break;
> +	case F_CHECK_ORIGINAL_MEMFD:
> +		err = !(filp->f_mode & FMODE_WRITER);
> +		break;

Honestly, make this an ioctl on memfds. This is so specific that it
really doesn't belong into fcntl().
