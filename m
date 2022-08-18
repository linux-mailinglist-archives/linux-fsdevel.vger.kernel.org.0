Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3577E599124
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 01:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiHRX1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 19:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiHRX07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:26:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E32D758F;
        Thu, 18 Aug 2022 16:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB27C61701;
        Thu, 18 Aug 2022 23:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7BDC433C1;
        Thu, 18 Aug 2022 23:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660865217;
        bh=gZgBPW61TBJ2Ot43zC9FdlpHSeteHeF8IwtKZ9jm7m8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=gjg5J/6TIYsYsHsV8CaVUSv1+hW3RQlbxTfu8rRxi3SRskXUUUJMBnjI2bHeVmqBW
         WfcRs6tIOlsGCiBgD9JfwisM4jlefyL6Za7zhhJKg3y4Y+RYpRxNgORrQz+IyHE5cv
         LiSWNkVxa5npvjh9q9BUAqmlgTga+UTnYl0cT6ILEiAhDHqNQLOvpSdtWSWovGTCmT
         G0EagtnPIkvH8W1DH12NzQcmLQT62oOsGqRXPQUnXBcsrEaxJGJhkK0/fmPR1lCqB9
         G8945tT88KMTjQf88X/8eXzqISo82AgEKvm5yDULsWh+CAv1pNeAvzgsYL4xkj+KOq
         5P5N16o1MQ6AQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11cc7698a18so454919fac.4;
        Thu, 18 Aug 2022 16:26:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo3RIE7X62HEphbL3yLiIGyuIxke58G6rpKR1ykubDJ21cUM9OsK
        S8BWEwBcpE04ke6jRx/lX3lAgnGQEFpAC2YT+Lc=
X-Google-Smtp-Source: AA6agR5Q9/tNFJCIePNKcBLmFFr4N+oPIg2BFG7h0whQAVZ7K3GeWKtNi73Zc2oIYIbUL/t5F1dodbVWrEi2pKb6ChU=
X-Received: by 2002:a05:6870:f69d:b0:10d:81ea:3540 with SMTP id
 el29-20020a056870f69d00b0010d81ea3540mr2594259oab.257.1660865216257; Thu, 18
 Aug 2022 16:26:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:27c7:0:0:0:0 with HTTP; Thu, 18 Aug 2022 16:26:55
 -0700 (PDT)
In-Reply-To: <Yv6igFDtDa0vmq6H@ZenIV>
References: <Yv2qoNQg48rtymGE@ZenIV> <Yv2rCqD7M8fAhq5v@ZenIV>
 <CAKYAXd-Xsih1TKTbM0kTGmjQfpkbpp7d3u9E7USuwmiSXLVvBw@mail.gmail.com> <Yv6igFDtDa0vmq6H@ZenIV>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 19 Aug 2022 08:26:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-6fT5qG2VmVG6Q51Z8-_79cjKhERHDatR_z62w19+p1Q@mail.gmail.com>
Message-ID: <CAKYAXd-6fT5qG2VmVG6Q51Z8-_79cjKhERHDatR_z62w19+p1Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] ksmbd: don't open-code %pf
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-08-19 5:35 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> On Thu, Aug 18, 2022 at 03:08:36PM +0900, Namjae Jeon wrote:
>> 2022-08-18 11:59 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
>> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>> > ---
>> >  fs/ksmbd/vfs.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
>> > index 78d01033604c..a0fafba8b5d0 100644
>> > --- a/fs/ksmbd/vfs.c
>> > +++ b/fs/ksmbd/vfs.c
>> > @@ -1743,11 +1743,11 @@ int ksmbd_vfs_copy_file_ranges(struct
>> > ksmbd_work
>> > *work,
>> >  	*total_size_written = 0;
>> >
>> >  	if (!(src_fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
>> > -		pr_err("no right to read(%pd)\n", src_fp->filp->f_path.dentry);
>> > +		pr_err("no right to read(%pf)\n", src_fp->filp);
>> Isn't this probably %pD?
>
> *blink*
>
> It certainly is; thanks for catching that braino...  While we are at it,
> there's several more places of the same form these days, so fixed and
> updated variant follows:
Thanks for updating the patch!
>
> ksmbd: don't open-code %pD
>
> a bunch of places used %pd with file->f_path.dentry; shorter (and saner)
> way to spell that is %pD with file...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
> ---
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 0e1924a6476d..bed670410c37 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -3897,8 +3897,7 @@ int smb2_query_dir(struct ksmbd_work *work)
>  	    inode_permission(file_mnt_user_ns(dir_fp->filp),
>  			     file_inode(dir_fp->filp),
>  			     MAY_READ | MAY_EXEC)) {
> -		pr_err("no right to enumerate directory (%pd)\n",
> -		       dir_fp->filp->f_path.dentry);
> +		pr_err("no right to enumerate directory (%pD)\n", dir_fp->filp);
>  		rc = -EACCES;
>  		goto err_out2;
>  	}
> @@ -6269,8 +6268,8 @@ int smb2_read(struct ksmbd_work *work)
>  		goto out;
>  	}
>
> -	ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
> -		    fp->filp->f_path.dentry, offset, length);
> +	ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
> +		    fp->filp, offset, length);
>
>  	work->aux_payload_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
>  	if (!work->aux_payload_buf) {
> @@ -6534,8 +6533,8 @@ int smb2_write(struct ksmbd_work *work)
>  		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
>  				    le16_to_cpu(req->DataOffset));
>
> -		ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
> -			    fp->filp->f_path.dentry, offset, length);
> +		ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
> +			    fp->filp, offset, length);
>  		err = ksmbd_vfs_write(work, fp, data_buf, length, &offset,
>  				      writethrough, &nbytes);
>  		if (err < 0)
> diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> index 78d01033604c..0c04a59cbe60 100644
> --- a/fs/ksmbd/vfs.c
> +++ b/fs/ksmbd/vfs.c
> @@ -377,8 +377,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct
> ksmbd_file *fp, size_t count,
>
>  	if (work->conn->connection_type) {
>  		if (!(fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
> -			pr_err("no right to read(%pd)\n",
> -			       fp->filp->f_path.dentry);
> +			pr_err("no right to read(%pD)\n", fp->filp);
>  			return -EACCES;
>  		}
>  	}
> @@ -487,8 +486,7 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct
> ksmbd_file *fp,
>
>  	if (work->conn->connection_type) {
>  		if (!(fp->daccess & FILE_WRITE_DATA_LE)) {
> -			pr_err("no right to write(%pd)\n",
> -			       fp->filp->f_path.dentry);
> +			pr_err("no right to write(%pD)\n", fp->filp);
>  			err = -EACCES;
>  			goto out;
>  		}
> @@ -527,8 +525,8 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct
> ksmbd_file *fp,
>  	if (sync) {
>  		err = vfs_fsync_range(filp, offset, offset + *written, 0);
>  		if (err < 0)
> -			pr_err("fsync failed for filename = %pd, err = %d\n",
> -			       fp->filp->f_path.dentry, err);
> +			pr_err("fsync failed for filename = %pD, err = %d\n",
> +			       fp->filp, err);
>  	}
>
>  out:
> @@ -1743,11 +1741,11 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work
> *work,
>  	*total_size_written = 0;
>
>  	if (!(src_fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
> -		pr_err("no right to read(%pd)\n", src_fp->filp->f_path.dentry);
> +		pr_err("no right to read(%pD)\n", src_fp->filp);
>  		return -EACCES;
>  	}
>  	if (!(dst_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE))) {
> -		pr_err("no right to write(%pd)\n", dst_fp->filp->f_path.dentry);
> +		pr_err("no right to write(%pD)\n", dst_fp->filp);
>  		return -EACCES;
>  	}
>
>
