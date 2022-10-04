Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7145F4962
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 20:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJDSrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 14:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJDSrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:47:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9CC69F62;
        Tue,  4 Oct 2022 11:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C889AB81B7D;
        Tue,  4 Oct 2022 18:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661F6C433C1;
        Tue,  4 Oct 2022 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664909268;
        bh=+jQe3PZzLX/Ohw+7uBm6AvctKlwxHWI9Sloe5IY9do4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/dAARORqwZuJPZk+360LY6CP3JVSJ102GxnYysu/oEznVEoHCsANDdBHxh+dLw1y
         OZo3GQbKnH1HOUmVVjSW+ZZl2J0VQ+GqZmudtHw337ErwiICwHGAq+7O6R9FLwGHpf
         I+6KQ9Oc2SLXUvzdfwwJ2FkT6Gt5zgvBQjwDvBSTD22gjOLKPgKsUoLpKx4xom4r1n
         xkiI3BpLnEZqjoZSs+YiQx1+R+NrV+McTUnlS25kdq1nbgHpKEYCEyuicNigKAPD70
         epbc/txKzArgVGbfPmhZYF0a+vpkHQzxk/sIbMim8gpZa3B1UBOwkv/zYhDvfKxU2i
         n4cBgoITlSM4Q==
Date:   Tue, 4 Oct 2022 11:47:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: journal_path mount options should follow links
Message-ID: <Yzx/08kWtzX8HR5i@magnolia>
References: <20221004135803.32283-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004135803.32283-1-lczerner@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 04, 2022 at 03:58:03PM +0200, Lukas Czerner wrote:
> Before the commit 461c3af045d3 ("ext4: Change handle_mount_opt() to use
> fs_parameter") ext4 mount option journal_path did follow links in the
> provided path.
> 
> Bring this behavior back by allowing to pass pathwalk flags to
> fs_lookup_param().
> 
> Fixes: 461c3af045d3 ("ext4: Change handle_mount_opt() to use fs_parameter")
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

This bit me recently when I was debugging an old system that used an
external journal on an LVM LV and I wanted to know if the bug I was
chasing also reproduced on upstream.  Thanks for fixing this before I
got around to making a patch:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/mount_api.rst | 1 +
>  fs/ext4/super.c                         | 2 +-
>  fs/fs_parser.c                          | 3 ++-
>  include/linux/fs_parser.h               | 1 +
>  4 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
> index eb358a00be27..1d16787a00e9 100644
> --- a/Documentation/filesystems/mount_api.rst
> +++ b/Documentation/filesystems/mount_api.rst
> @@ -814,6 +814,7 @@ process the parameters it is given.
>         int fs_lookup_param(struct fs_context *fc,
>  			   struct fs_parameter *value,
>  			   bool want_bdev,
> +			   unsigned int flags,
>  			   struct path *_path);
>  
>       This takes a parameter that carries a string or filename type and attempts
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9a66abcca1a8..4c1b3972d53f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2271,7 +2271,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  			return -EINVAL;
>  		}
>  
> -		error = fs_lookup_param(fc, param, 1, &path);
> +		error = fs_lookup_param(fc, param, 1, LOOKUP_FOLLOW, &path);
>  		if (error) {
>  			ext4_msg(NULL, KERN_ERR, "error: could not find "
>  				 "journal device path");
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index ed40ce5742fd..edb3712dcfa5 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -138,15 +138,16 @@ EXPORT_SYMBOL(__fs_parse);
>   * @fc: The filesystem context to log errors through.
>   * @param: The parameter.
>   * @want_bdev: T if want a blockdev
> + * @flags: Pathwalk flags passed to filename_lookup()
>   * @_path: The result of the lookup
>   */
>  int fs_lookup_param(struct fs_context *fc,
>  		    struct fs_parameter *param,
>  		    bool want_bdev,
> +		    unsigned int flags,
>  		    struct path *_path)
>  {
>  	struct filename *f;
> -	unsigned int flags = 0;
>  	bool put_f;
>  	int ret;
>  
> diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> index f103c91139d4..01542c4b87a2 100644
> --- a/include/linux/fs_parser.h
> +++ b/include/linux/fs_parser.h
> @@ -76,6 +76,7 @@ static inline int fs_parse(struct fs_context *fc,
>  extern int fs_lookup_param(struct fs_context *fc,
>  			   struct fs_parameter *param,
>  			   bool want_bdev,
> +			   unsigned int flags,
>  			   struct path *_path);
>  
>  extern int lookup_constant(const struct constant_table tbl[], const char *name, int not_found);
> -- 
> 2.37.3
> 
