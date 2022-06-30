Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF756256B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 23:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiF3Vhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 17:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbiF3Vhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:37:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB84A53D0B;
        Thu, 30 Jun 2022 14:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8529AB82D62;
        Thu, 30 Jun 2022 21:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0CAC341C8;
        Thu, 30 Jun 2022 21:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656625066;
        bh=/1mPg+HnK95Yhfa0x9xppZXAMpxCw2yRXLpQyUsVUs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okEDMuKgkx85z8wootjkayGx5wpPaISbSuvv2iz+k60DQnfW4MphYuCxOU9S+PM04
         dKH+ZsGnlHJg6R+ydb0rmea9sbOcUNgNHvSMJwxknZkitlb6mOx8PeaY80hPWYU0YY
         v4FnFJj4ogxdv/ask676u11UFy1N9XJoICUtAFIGqoQrrBWM+H5sezK7bBEleXOl3q
         fwagwQYhsTRFZ9TqoB/hs8y8qAerOt/QwwVhe3OJKYnh1m7/RhdE0/Taas957m8GjA
         xtzc+HcsRKg3UneQB0DvMA3+LqH/J2B1MyytK1Kj9I5Aj0MFrYzb04sALfWxVvo/Ul
         H6E6oBx+2QCxw==
Date:   Thu, 30 Jun 2022 14:37:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: Re: [PATCH v2 2/9] mm/mshare: pre-populate msharefs with information
 file
Message-ID: <Yr4Xqe22CI/ff0ge@magnolia>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <34e2eabbef5916c784dc16856ce25b3967f9b405.1656531090.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34e2eabbef5916c784dc16856ce25b3967f9b405.1656531090.git.khalid.aziz@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:53:53PM -0600, Khalid Aziz wrote:
> Users of mshare feature to share page tables need to know the size
> and alignment requirement for shared regions. Pre-populate msharefs
> with a file, mshare_info, that provides this information.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  mm/mshare.c | 62 +++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/mshare.c b/mm/mshare.c
> index c8fab3869bab..3e448e11c742 100644
> --- a/mm/mshare.c
> +++ b/mm/mshare.c
> @@ -25,8 +25,8 @@
>  static struct super_block *msharefs_sb;
>  
>  static const struct file_operations msharefs_file_operations = {
> -	.open	= simple_open,
> -	.llseek	= no_llseek,
> +	.open		= simple_open,
> +	.llseek		= no_llseek,

I feel like there's a lot of churn between the previous patch and this
one that could have been in the previous patch.

>  };
>  
>  static int
> @@ -42,23 +42,52 @@ msharefs_d_hash(const struct dentry *dentry, struct qstr *qstr)
>  	return 0;
>  }
>  
> +static void
> +mshare_evict_inode(struct inode *inode)
> +{
> +	clear_inode(inode);
> +}
> +
>  static const struct dentry_operations msharefs_d_ops = {
>  	.d_hash = msharefs_d_hash,
>  };
>  
> +static ssize_t
> +mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
> +		loff_t *ppos)
> +{
> +	char s[80];
> +
> +	sprintf(s, "%ld", PGDIR_SIZE);

SO what is this "mshare_info" file supposed to reveal?  Hugepage size?
I wonder why this isn't exported in struct mshare_info?

> +	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
> +}
> +
> +static const struct file_operations mshare_info_ops = {
> +	.read   = mshare_info_read,
> +	.llseek	= noop_llseek,
> +};
> +
> +static const struct super_operations mshare_s_ops = {
> +	.statfs	     = simple_statfs,
> +	.evict_inode = mshare_evict_inode,
> +};
> +
>  static int
>  msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
> -	static const struct tree_descr empty_descr = {""};
> +	static const struct tree_descr mshare_files[] = {
> +		[2] = { "mshare_info", &mshare_info_ops, 0444},
> +		{""},
> +	};
>  	int err;
>  
> -	sb->s_d_op = &msharefs_d_ops;
> -	err = simple_fill_super(sb, MSHARE_MAGIC, &empty_descr);
> -	if (err)
> -		return err;
> -
> -	msharefs_sb = sb;
> -	return 0;
> +	err = simple_fill_super(sb, MSHARE_MAGIC, mshare_files);
> +	if (!err) {
> +		msharefs_sb = sb;
> +		sb->s_d_op = &msharefs_d_ops;
> +		sb->s_op = &mshare_s_ops;
> +	}
> +	return err;
>  }
>  
>  static int
> @@ -84,20 +113,25 @@ static struct file_system_type mshare_fs = {
>  	.kill_sb		= kill_litter_super,
>  };
>  
> -static int
> +static int __init
>  mshare_init(void)
>  {
>  	int ret = 0;
>  
>  	ret = sysfs_create_mount_point(fs_kobj, "mshare");
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	ret = register_filesystem(&mshare_fs);
> -	if (ret)
> +	if (ret) {
>  		sysfs_remove_mount_point(fs_kobj, "mshare");
> +		goto out;
> +	}
> +
> +	return 0;
>  
> +out:
>  	return ret;
>  }
>  
> -fs_initcall(mshare_init);
> +core_initcall(mshare_init);
> -- 
> 2.32.0
> 
