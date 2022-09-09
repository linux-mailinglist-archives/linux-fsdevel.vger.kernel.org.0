Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479A35B34D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 12:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIIKIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 06:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiIIKIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:08:41 -0400
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Sep 2022 03:08:40 PDT
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3210212EDBA
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 03:08:39 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 114C52055FA0;
        Fri,  9 Sep 2022 19:01:10 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 289A18E2027336
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 19:01:09 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-1) with ESMTPS id 289A18W7052559
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 19:01:08 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Submit) id 289A17um052558;
        Fri, 9 Sep 2022 19:01:07 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: port to vfs{g,u}id_t and associated helpers
In-Reply-To: <20220909093019.936863-1-brauner@kernel.org> (Christian Brauner's
        message of "Fri, 9 Sep 2022 11:30:19 +0200")
References: <20220909093019.936863-1-brauner@kernel.org>
Date:   Fri, 09 Sep 2022 19:01:07 +0900
Message-ID: <87czc4rhng.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

> A while ago we introduced a dedicated vfs{g,u}id_t type in commit
> 1e5267cd0895 ("mnt_idmapping: add vfs{g,u}id_t"). We already switched
> over a good part of the VFS. Ultimately we will remove all legacy
> idmapped mount helpers that operate only on k{g,u}id_t in favor of the
> new type safe helpers that operate on vfs{g,u}id_t.

If consistent with other parts in kernel, looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> Cc: Seth Forshee (Digital Ocean) <sforshee@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>  fs/fat/file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 3e4eb3467cb4..8a6b493b5b5f 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -461,8 +461,9 @@ static int fat_allow_set_time(struct user_namespace *mnt_userns,
>  {
>  	umode_t allow_utime = sbi->options.allow_utime;
>  
> -	if (!uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode))) {
> -		if (in_group_p(i_gid_into_mnt(mnt_userns, inode)))
> +	if (!vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode),
> +			    current_fsuid())) {
> +		if (vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)))
>  			allow_utime >>= 3;
>  		if (allow_utime & MAY_WRITE)
>  			return 1;
>
> base-commit: 7e18e42e4b280c85b76967a9106a13ca61c16179

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
