Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519C75C4BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 12:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjGUKfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 06:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjGUKe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:34:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A171BC6;
        Fri, 21 Jul 2023 03:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94E9460916;
        Fri, 21 Jul 2023 10:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8651C433C8;
        Fri, 21 Jul 2023 10:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689935682;
        bh=WJzJxCInUKPeiWu8BOjg9n0XyseJhFEbFfzut3tCW84=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=il8M+HwFbc0/nsctZmOVaHVk0eX+KeRZfVGVo8UVI63eDXS1q6wOCuTyL7wAjcEwW
         wdv/dTEC8rcBatvW7Fco1o7YLdLQ+0wCj8ZfaPBjeC2DrI0vIeE9nNdLmGVMhOZeXc
         vsVi+Wh1NP+uUJOpI1k8elTNdF33rlqORUmSRvqAIzhyzHHVqIWLdONhcABS4ZmkQ2
         ZyaPTiwlnlvTF1CwluBT27SIUMD/KwAVSfiTiJ5k/+bZZMaI52RnXv8pFAwp4PC2ld
         6zMPtQfClT6f17TDEeURPwcaA83ivhx3Nz43vCxhHfHTTn/x4LaU8ipSm4b3n00ynt
         JIGZi07H/13fQ==
Message-ID: <d50c6c34035f1a0b143507d9ab9fcf0d27a5dc86.camel@kernel.org>
Subject: Re: [PATCH] Fix BUG: KASAN: use-after-free in
 trace_event_raw_event_filelock_lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Will Shiu <Will.Shiu@mediatek.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Fri, 21 Jul 2023 06:34:40 -0400
In-Reply-To: <20230721051904.9317-1-Will.Shiu@mediatek.com>
References: <20230721051904.9317-1-Will.Shiu@mediatek.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-07-21 at 13:19 +0800, Will Shiu wrote:
> As following backtrace, the struct file_lock request , in posix_lock_inod=
e
> is free before ftrace function using.
> Replace the ftrace function ahead free flow could fix the use-after-free
> issue.
>=20
> [name:report&]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> BUG:KASAN: use-after-free in trace_event_raw_event_filelock_lock+0x80/0x1=
2c
> [name:report&]Read at addr f6ffff8025622620 by task NativeThread/16753
> [name:report_hw_tags&]Pointer tag: [f6], memory tag: [fe]
> [name:report&]
> BT:
> Hardware name: MT6897 (DT)
> Call trace:
>  dump_backtrace+0xf8/0x148
>  show_stack+0x18/0x24
>  dump_stack_lvl+0x60/0x7c
>  print_report+0x2c8/0xa08
>  kasan_report+0xb0/0x120
>  __do_kernel_fault+0xc8/0x248
>  do_bad_area+0x30/0xdc
>  do_tag_check_fault+0x1c/0x30
>  do_mem_abort+0x58/0xbc
>  el1_abort+0x3c/0x5c
>  el1h_64_sync_handler+0x54/0x90
>  el1h_64_sync+0x68/0x6c
>  trace_event_raw_event_filelock_lock+0x80/0x12c
>  posix_lock_inode+0xd0c/0xd60
>  do_lock_file_wait+0xb8/0x190
>  fcntl_setlk+0x2d8/0x440
> ...
> [name:report&]
> [name:report&]Allocated by task 16752:
> ...
>  slab_post_alloc_hook+0x74/0x340
>  kmem_cache_alloc+0x1b0/0x2f0
>  posix_lock_inode+0xb0/0xd60
> ...
>  [name:report&]
>  [name:report&]Freed by task 16752:
> ...
>   kmem_cache_free+0x274/0x5b0
>   locks_dispose_list+0x3c/0x148
>   posix_lock_inode+0xc40/0xd60
>   do_lock_file_wait+0xb8/0x190
>   fcntl_setlk+0x2d8/0x440
>   do_fcntl+0x150/0xc18
> ...
>=20
> Signed-off-by: Will Shiu <Will.Shiu@mediatek.com>
> ---
>  fs/locks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index df8b26a42524..a552bdb6badc 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1301,6 +1301,7 @@ static int posix_lock_inode(struct inode *inode, st=
ruct file_lock *request,
>   out:
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
> +	trace_posix_lock_inode(inode, request, error);
>  	/*
>  	 * Free any unused locks.
>  	 */
> @@ -1309,7 +1310,6 @@ static int posix_lock_inode(struct inode *inode, st=
ruct file_lock *request,
>  	if (new_fl2)
>  		locks_free_lock(new_fl2);
>  	locks_dispose_list(&dispose);
> -	trace_posix_lock_inode(inode, request, error);
> =20
>  	return error;
>  }

Could you send along the entire KASAN log message? I'm not sure I see
how this is being tripped. The lock we're passing in here is "request"
and that shouldn't be freed since it's allocated and owned by the
caller.

--=20
Jeff Layton <jlayton@kernel.org>
