Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037254EE278
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 22:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbiCaUSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 16:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbiCaUSD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344902414D9;
        Thu, 31 Mar 2022 13:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE15E61ADE;
        Thu, 31 Mar 2022 20:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD50C340F0;
        Thu, 31 Mar 2022 20:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648757775;
        bh=ZAkVgKG4bsXkZcZ9X3iUl6n68H+bEWI6NUCYM+8C9Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXTq+MxTn0nYJLYfkh9JGS5DkTpZ3yi6iPeGnEeOQ0JhSlnLtYBhXuNMLqw/jOXsO
         d0+PxxiSbexzgxH9BytQvUSiwizjAkWk8iFLbaza+MLczJQO3ArteipT4E/CdA6XVO
         HWP/HtwpxVQL7y7kFSXDPUhv42kzIVqAWanWEElNY2G6yE0sZBwdZhp2GR3XAnFbkU
         vDAOS8aXY8mEq8EAJN+n3SLzqPuI+d6scwfACROIBpba+si/7rvXmatZ1imYKnoDnV
         gcNgB9VPwOM2fM2MtlZfvl9RccAtQhQXYxKUVgud3+HA8juqQrnSDJ7Jl/ypS6czSF
         c0erk0RWUj7Bg==
Date:   Thu, 31 Mar 2022 20:16:13 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, xiubli@redhat.com, idryomov@gmail.com,
        lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 07/54] ceph: support legacy v1 encryption policy
 keysetup
Message-ID: <YkYMDRTcGC6sJO8l@gmail.com>
References: <20220331153130.41287-1-jlayton@kernel.org>
 <20220331153130.41287-8-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220331153130.41287-8-jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:30:43AM -0400, Jeff Layton wrote:
> From: Luís Henriques <lhenriques@suse.de>
> 
> fstests make use of legacy keysetup where the key description uses a
> filesystem-specific prefix.  Add this ceph-specific prefix to the
> fscrypt_operations data structure.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/crypto.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index a513ff373b13..d1a6595a810f 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -65,6 +65,7 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
>  }
>  
>  static struct fscrypt_operations ceph_fscrypt_ops = {
> +	.key_prefix		= "ceph:",
>  	.get_context		= ceph_crypt_get_context,
>  	.set_context		= ceph_crypt_set_context,
>  	.empty_dir		= ceph_crypt_empty_dir,
> -- 
> 2.35.1
> 

As I mentioned before
(https://lore.kernel.org/r/20200908042925.GI68127@sol.localdomain), I don't
think you should do this, given that the filesystem-specific key description
prefixes are deprecated.  In fact, they're sort of doubly deprecated, since
first they were superseded by "fscrypt:", and then "login" keys were
superseded by FS_IOC_ADD_ENCRYPTION_KEY.

How about updating fstests to use "fscrypt:" instead of "$FSTYP:" if $FSTYP is
not ext4 or f2fs?

Or maybe fstests should just use "fscrypt:" unconditionally, given that this has
been supported by ext4 and f2fs since 4.8, and 4.9 is now the oldest supported
LTS kernel.

- Eric
