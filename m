Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A1A65BE04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 11:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjACK2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Jan 2023 05:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbjACK2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:28:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81710AA;
        Tue,  3 Jan 2023 02:28:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 026BB61227;
        Tue,  3 Jan 2023 10:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECE4C433EF;
        Tue,  3 Jan 2023 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672741680;
        bh=6PGDo16yafa7I9D0QeQ4c1gBmHp7RJPl6cLfC9sVHg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCmQ8uEWkUFm9M3qCEafRk7Obrh0hhcE4CZOm0g4So3eKAhOovlKEkecgIcY6VmQZ
         PPMJk71kLnq2WZ487jmZqpZ1rYj5rS+8yxR8j3x5PYA6khDnIHuUvxmxx3uFOMIMnN
         GwUs3D3C+oOcfMJJGjSWJ6EDblMJFDOFX/Ilca95/qcLuUVzkwVAps4yvu2guo+pzA
         49iMu3mPaeqfCH0fxeiMohgXGuglz2uAa1yl2wzSUMSEpx1HEA59RmlTsuejwyo72J
         ndPiyFiRohR6UXdSstod7guwn9cQI9kO+lmibZ9YmYeDLmW9QmftsuPkWPn3znB1Zf
         tdQljd76RMI6w==
Date:   Tue, 3 Jan 2023 11:27:55 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Seth Forshee <sforshee@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftests <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/mount_setattr: Remove redefinition of struct
 mount_attr
Message-ID: <20230103102755.eks34kwcufoz7znx@wittgenstein>
References: <20221211092820.85527-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221211092820.85527-1-code@siddh.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 11, 2022 at 02:58:20PM +0530, Siddh Raman Pant wrote:
> It is already included via sys/mount.h on line 10.
> 
> GCC error reproducible by: make kselftest TARGETS="mount_setattr"
> 
> mount_setattr_test.c:107:8: error: redefinition of ‘struct mount_attr’
>   107 | struct mount_attr {
>       |        ^~~~~~~~~~
> In file included from /usr/include/x86_64-linux-gnu/sys/mount.h:32,
>                  from mount_setattr_test.c:10:
> ../../../../usr/include/linux/mount.h:129:8: note: originally defined here
>   129 | struct mount_attr {
>       |        ^~~~~~~~~~
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  tools/testing/selftests/mount_setattr/mount_setattr_test.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> index 8c5fea68ae67..582669ca38e9 100644
> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> @@ -103,13 +103,6 @@
>  	#else
>  		#define __NR_mount_setattr 442
>  	#endif
> -
> -struct mount_attr {
> -	__u64 attr_set;
> -	__u64 attr_clr;
> -	__u64 propagation;
> -	__u64 userns_fd;
> -};
>  #endif

Honestly, until the conflicts between linux/mount.h and sys/mount.h are
fixed properly we should probably just not include either linux/mount.h
nor sys/mount.h and just define all the things we need in this single
test file.
