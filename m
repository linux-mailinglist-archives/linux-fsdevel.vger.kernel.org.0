Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900BA3BE37C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 09:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhGGHXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 03:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230341AbhGGHXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625642460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVItEaca5YaB0eGRbcAWbtm7kkQ+4ze3OhCdChVWAKo=;
        b=WbT6LXOoY16OHDInL/ojbbl5Vt9Wa0/hc2vd6Z9utuvgWbs/s45gMXE4cl3PN+JMp4Ql6U
        BExqTfaBYXlB8WmDlFFo8MBFDvTBj6ZYTiyuWQOzYqHhXaumlW+2irlXG+SMqpSO8M0OIQ
        lywZ+58nMFscj+MBZsAKPyoDdWqTNvM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-dmj3qrLvMNSsM_1PQJaYGQ-1; Wed, 07 Jul 2021 03:20:59 -0400
X-MC-Unique: dmj3qrLvMNSsM_1PQJaYGQ-1
Received: by mail-pg1-f200.google.com with SMTP id h5-20020a6357450000b02902275ef514faso1101487pgm.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 00:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JVItEaca5YaB0eGRbcAWbtm7kkQ+4ze3OhCdChVWAKo=;
        b=j6qEh3vbO0+bTX8An5ECm0ngKdQx1lLDHqiH4XJE92X51LxxOzUsxFcqqsnDEjnQfK
         LSvrHqfdhlgxNh5pNNuJvKXMq6spvowvX+7JOyiQT0VkNii2GvbU8axQ4lYZxAw8eUzN
         COXXkNwJSGewLysTkY+nTk4BO010WENkqZqf2dPuWLc7qc3LEZ41L7HfqwpTPmBQ75++
         lWcak5SmImj1JRJEqQLsPB+wIqWKXEx6FHQObQ0OihaSOjqaOgp7Aoj5gqxRCetMwfNP
         NWuPZOtNIR2JAuPpWUCF5m+yrAjLagWU8amdE7cJ6bhsXnkudG6ddN6UyDw12qfYxsqE
         Vb5w==
X-Gm-Message-State: AOAM5305bsQNI/jYkxNM41HELKhh/PsrXseKh6OXEOfZoi0K5BSb2NTY
        lo5hqYHu4WXeN30Xv+K7W+BMrnI8SvRYLETjM50h8xW03Z3201IbiU5AkdIV2vOmrQxydyC6wa8
        D+fz44a4lyQJyi209TAbHUm/FeQ==
X-Received: by 2002:a63:ed0a:: with SMTP id d10mr25094232pgi.82.1625642457964;
        Wed, 07 Jul 2021 00:20:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym9qzlVOMlWeGQxXTNPsvP16/7VTMX+07vEjASq04q0/gub3/eK04T09UQp9dw+mBrCmoLWg==
X-Received: by 2002:a63:ed0a:: with SMTP id d10mr25094214pgi.82.1625642457686;
        Wed, 07 Jul 2021 00:20:57 -0700 (PDT)
Received: from [10.72.12.117] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w123sm19561385pff.152.2021.07.07.00.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 00:20:57 -0700 (PDT)
Subject: Re: [RFC PATCH v7 07/24] ceph: add fscrypt_* handling to caps.c
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-8-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <f8c7dc0f-49ee-2c25-8e41-e47557db80e4@redhat.com>
Date:   Wed, 7 Jul 2021 15:20:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210625135834.12934-8-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

There has some following patches in your "fscrypt" branch, which is not 
posted yet, the commit is:

"3161d2f549db ceph: size handling for encrypted inodes in cap updates"

It seems buggy.

In the encode_cap_msg() you have removed the 'fscrypt_file_len' and and 
added a new 8 bytes' data encoding:

         ceph_encode_32(&p, arg->fscrypt_auth_len);
         ceph_encode_copy(&p, arg->fscrypt_auth, arg->fscrypt_auth_len);
-       ceph_encode_32(&p, arg->fscrypt_file_len);
-       ceph_encode_copy(&p, arg->fscrypt_file, arg->fscrypt_file_len);
+       ceph_encode_32(&p, sizeof(__le64));
+       ceph_encode_64(&p, fc->size);

That means no matter the 'arg->encrypted' is true or not, here it will 
always encode extra 8 bytes' data ?


But in cap_msg_size(), you are making it optional:


  static inline int cap_msg_size(struct cap_msg_args *arg)
  {
         return CAP_MSG_FIXED_FIELDS + arg->fscrypt_auth_len +
-                       arg->fscrypt_file_len;
+                       arg->encrypted ? sizeof(__le64) : 0;
  }


Have I missed something important here ?

Thanks


On 6/25/21 9:58 PM, Jeff Layton wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/caps.c | 62 +++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 49 insertions(+), 13 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 038f59cc4250..1be6c5148700 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -13,6 +13,7 @@
>   #include "super.h"
>   #include "mds_client.h"
>   #include "cache.h"
> +#include "crypto.h"
>   #include <linux/ceph/decode.h>
>   #include <linux/ceph/messenger.h>
>   
> @@ -1229,15 +1230,12 @@ struct cap_msg_args {
>   	umode_t			mode;
>   	bool			inline_data;
>   	bool			wake;
> +	u32			fscrypt_auth_len;
> +	u32			fscrypt_file_len;
> +	u8			fscrypt_auth[sizeof(struct ceph_fscrypt_auth)]; // for context
> +	u8			fscrypt_file[sizeof(u64)]; // for size
>   };
>   
> -/*
> - * cap struct size + flock buffer size + inline version + inline data size +
> - * osd_epoch_barrier + oldest_flush_tid
> - */
> -#define CAP_MSG_SIZE (sizeof(struct ceph_mds_caps) + \
> -		      4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4)
> -
>   /* Marshal up the cap msg to the MDS */
>   static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
>   {
> @@ -1253,7 +1251,7 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
>   	     arg->size, arg->max_size, arg->xattr_version,
>   	     arg->xattr_buf ? (int)arg->xattr_buf->vec.iov_len : 0);
>   
> -	msg->hdr.version = cpu_to_le16(10);
> +	msg->hdr.version = cpu_to_le16(12);
>   	msg->hdr.tid = cpu_to_le64(arg->flush_tid);
>   
>   	fc = msg->front.iov_base;
> @@ -1324,6 +1322,16 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
>   
>   	/* Advisory flags (version 10) */
>   	ceph_encode_32(&p, arg->flags);
> +
> +	/* dirstats (version 11) - these are r/o on the client */
> +	ceph_encode_64(&p, 0);
> +	ceph_encode_64(&p, 0);
> +
> +	/* fscrypt_auth and fscrypt_file (version 12) */
> +	ceph_encode_32(&p, arg->fscrypt_auth_len);
> +	ceph_encode_copy(&p, arg->fscrypt_auth, arg->fscrypt_auth_len);
> +	ceph_encode_32(&p, arg->fscrypt_file_len);
> +	ceph_encode_copy(&p, arg->fscrypt_file, arg->fscrypt_file_len);
>   }
>   
>   /*
> @@ -1445,6 +1453,26 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
>   		}
>   	}
>   	arg->flags = flags;
> +	if (ci->fscrypt_auth_len &&
> +	    WARN_ON_ONCE(ci->fscrypt_auth_len != sizeof(struct ceph_fscrypt_auth))) {
> +		/* Don't set this if it isn't right size */
> +		arg->fscrypt_auth_len = 0;
> +	} else {
> +		arg->fscrypt_auth_len = ci->fscrypt_auth_len;
> +		memcpy(arg->fscrypt_auth, ci->fscrypt_auth,
> +			min_t(size_t, ci->fscrypt_auth_len, sizeof(arg->fscrypt_auth)));
> +	}
> +	/* FIXME: use this to track "real" size */
> +	arg->fscrypt_file_len = 0;
> +}
> +
> +#define CAP_MSG_FIXED_FIELDS (sizeof(struct ceph_mds_caps) + \
> +		      4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4 + 8 + 8 + 4 + 4)
> +
> +static inline int cap_msg_size(struct cap_msg_args *arg)
> +{
> +	return CAP_MSG_FIXED_FIELDS + arg->fscrypt_auth_len +
> +			arg->fscrypt_file_len;
>   }
>   
>   /*
> @@ -1457,7 +1485,7 @@ static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
>   	struct ceph_msg *msg;
>   	struct inode *inode = &ci->vfs_inode;
>   
> -	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, CAP_MSG_SIZE, GFP_NOFS, false);
> +	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, cap_msg_size(arg), GFP_NOFS, false);
>   	if (!msg) {
>   		pr_err("error allocating cap msg: ino (%llx.%llx) flushing %s tid %llu, requeuing cap.\n",
>   		       ceph_vinop(inode), ceph_cap_string(arg->dirty),
> @@ -1483,10 +1511,6 @@ static inline int __send_flush_snap(struct inode *inode,
>   	struct cap_msg_args	arg;
>   	struct ceph_msg		*msg;
>   
> -	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, CAP_MSG_SIZE, GFP_NOFS, false);
> -	if (!msg)
> -		return -ENOMEM;
> -
>   	arg.session = session;
>   	arg.ino = ceph_vino(inode).ino;
>   	arg.cid = 0;
> @@ -1524,6 +1548,18 @@ static inline int __send_flush_snap(struct inode *inode,
>   	arg.flags = 0;
>   	arg.wake = false;
>   
> +	/*
> +	 * No fscrypt_auth changes from a capsnap. It will need
> +	 * to update fscrypt_file on size changes (TODO).
> +	 */
> +	arg.fscrypt_auth_len = 0;
> +	arg.fscrypt_file_len = 0;
> +
> +	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, cap_msg_size(&arg),
> +			   GFP_NOFS, false);
> +	if (!msg)
> +		return -ENOMEM;
> +
>   	encode_cap_msg(msg, &arg);
>   	ceph_con_send(&arg.session->s_con, msg);
>   	return 0;

