Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143E1573CE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 21:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiGMTFg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 15:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiGMTFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:05:35 -0400
X-Greylist: delayed 403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 12:05:33 PDT
Received: from relay5.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C145D25582
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 12:05:33 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id EB65360B37;
        Wed, 13 Jul 2022 18:58:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 183E120028;
        Wed, 13 Jul 2022 18:58:48 +0000 (UTC)
Message-ID: <4d7e96ac0125bf8296689385f3f9dd54f7e2c0f1.camel@perches.com>
Subject: Re: [PATCH 3/6] fs/ntfs3: Refactoring attr_punch_hole to restore
 after errors
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 13 Jul 2022 11:58:48 -0700
In-Reply-To: <33c5b044-23a4-60a6-1649-9e5db228c2f7@paragon-software.com>
References: <2101d95b-be41-6e6d-e019-bc70f816b2e8@paragon-software.com>
         <33c5b044-23a4-60a6-1649-9e5db228c2f7@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 5i71eabwi3gnjdxdbku1yt9cdkro3i1k
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 183E120028
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18AYEEQZy5oL163g1bCUetolL4AeYrwDHU=
X-HE-Tag: 1657738728-702200
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-07-13 at 19:46 +0300, Konstantin Komarov wrote:
> Added comments to code
> Added new function run_clone to make a copy of run
> Added done and undo labels for restoring after errors

trivia:

> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
[]
> index 7bcae3094712..24d545041787 100644llocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
>   		}
>   
>   		if (lcn != SPARSE_LCN) {
> -			mark_as_free_ex(sbi, lcn, clen, trim);
> +			if (sbi) {
> +				/* mark bitmap range [lcn + clen) as free and trim clusters. */

presumably the brackets or parentheses [ ) should match

[]

> @@ -2091,69 +2098,91 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
[]
> +
> +		/* Make a hole range (sparse) [vcn1 + zero). */

here too

> diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
[]
> @@ -1157,3 +1157,28 @@ int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
>   	*highest_vcn = vcn64 - 1;
>   	return 0;
>   }
> +
> +/*
> + * run_clone
> + *
> + * Make a copy of run
> + */
> +int run_clone(const struct runs_tree *run, struct runs_tree *new_run)
> +{
> +	size_t bytes = run->count * sizeof(struct ntfs_run);
> +
> +	if (bytes > new_run->allocated) {
> +		struct ntfs_run *new_ptr = kvmalloc(bytes, GFP_KERNEL);

kvmalloc_array ?

> +
> +		if (!new_ptr)
> +			return -ENOMEM;
> +
> +		kvfree(new_run->runs);
> +		new_run->runs = new_ptr;
> +		new_run->allocated = bytes;
> +	}
> +
> +	memcpy(new_run->runs, run->runs, bytes);
> +	new_run->count = run->count;
> +	return 0;
> +}

