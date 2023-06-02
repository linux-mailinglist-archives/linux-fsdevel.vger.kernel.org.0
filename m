Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B567B71F7ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 03:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjFBBbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 21:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjFBBbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8962D199
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 18:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685669446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/cMHIbrTWtgBUsYlhuC2ZhD157W4Z46c619IAlhaVOY=;
        b=b1iDfAMJiI7544cv6P8+/ob0/fVsS7mNbJ19KyvUH4PQZdohoeEL0uee4oj64UDBihwrio
        /tfcGbi9KwRNJaeG9LbCxkxuCZ7bCsI/q1oocmS5Zbg8U0rBupiv4WPrq9hjGRd7eFi97P
        IwPwS5v12WsQnqU4/VFEjm5unRQ/L3g=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-RsHNdWfDMFyjmnHCAQxkMQ-1; Thu, 01 Jun 2023 21:30:45 -0400
X-MC-Unique: RsHNdWfDMFyjmnHCAQxkMQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b024ab0c28so14192085ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 18:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685669444; x=1688261444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cMHIbrTWtgBUsYlhuC2ZhD157W4Z46c619IAlhaVOY=;
        b=ZnlnujnrnWBhV66oajHBNwrLlHZyY70mMNGeTK/jfRALZ3+ZG3QSB88B2loNGxjQ5m
         DCR106q3KXWrF2aJ/AaumQwGJsPFd2TZius3AFmkN+Wg9NrK029OGIPbb/T+HNwXTw+t
         uVCivj6dUu7JSXrgapww4CIqFe8ixeVk3Ek8f/opqN7POrWnn0yB/+qh+RLCoORkPDcm
         ThfOHqJcaD4hmCJV/r45tiZx/KrrxBYY2GprMr+pbYxW61vCWLXEbKdn+FhUsgk3USuU
         qGWvlH1fGvxgrtduW+vuJERtPcusWIkkvYzeN2y8W7cXdZ1PDdFcRCxvE0VoiAOvDeJ3
         f99Q==
X-Gm-Message-State: AC+VfDzyvkpW88oVWs81P/R49WbAbnTCAVXSfSR7ewama5cd7S3k1+lG
        fs+qtHglQ3TPA2kQ673rzlR0R2MSMb/H62GUhJtYrbwHwsoPzyIbHfszkEjLVrlYMlL9foSYZRd
        mnliJOOKOCRG3TfUja2DqIj9BpQ==
X-Received: by 2002:a17:902:e851:b0:1ae:6a3:d058 with SMTP id t17-20020a170902e85100b001ae06a3d058mr1297442plg.36.1685669444422;
        Thu, 01 Jun 2023 18:30:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lg4pocoaH90MQ7MXLHYzdEIFqSltD2WuDyfdDq9fVk8AnZlltHqWPspRnTIxhIO54fNxuYA==
X-Received: by 2002:a17:902:e851:b0:1ae:6a3:d058 with SMTP id t17-20020a170902e85100b001ae06a3d058mr1297430plg.36.1685669444141;
        Thu, 01 Jun 2023 18:30:44 -0700 (PDT)
Received: from [10.72.12.188] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902860700b001acad86ebc5sm47952plo.33.2023.06.01.18.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 18:30:43 -0700 (PDT)
Message-ID: <b3b1b8dc-9903-c4ff-0a63-9a31a311ff0b@redhat.com>
Date:   Fri, 2 Jun 2023 09:30:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 10/13] ceph: allow idmapped setattr inode op
Content-Language: en-US
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-11-aleksandr.mikhalitsyn@canonical.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230524153316.476973-11-aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/24/23 23:33, Alexander Mikhalitsyn wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Enable __ceph_setattr() to handle idmapped mounts. This is just a matter
> of passing down the mount's idmapping.
>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>   fs/ceph/inode.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 37e1cbfc7c89..f1f934439be0 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2050,6 +2050,13 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
>   
>   	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
>   
> +	/*
> +	 * The attr->ia_{g,u}id members contain the target {g,u}id we're
> +	 * sending over the wire. The mount idmapping only matters when we
> +	 * create new filesystem objects based on the caller's mapped
> +	 * fs{g,u}id.
> +	 */
> +	req->r_mnt_idmap = &nop_mnt_idmap;

For example with an idmapping 1000:0 and in the /mnt/idmapped_ceph/.

This means the "__ceph_setattr()" will always use UID 0 to set the 
caller_uid, right ? If it is then the client auth checking for the 
setattr requests in cephfs MDS will succeed, since the UID 0 is root. 
But if you use a different idmapping, such as 1000:2000, it will fail.

So here IMO we should set it to 'idmap' too ?

Thanks

- Xiubo

>   	if (ia_valid & ATTR_UID) {
>   		dout("setattr %p uid %d -> %d\n", inode,
>   		     from_kuid(&init_user_ns, inode->i_uid),
> @@ -2240,7 +2247,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	if (ceph_inode_is_shutdown(inode))
>   		return -ESTALE;
>   
> -	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
> +	err = setattr_prepare(idmap, dentry, attr);
>   	if (err != 0)
>   		return err;
>   
> @@ -2255,7 +2262,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	err = __ceph_setattr(inode, attr);
>   
>   	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
> -		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
> +		err = posix_acl_chmod(idmap, dentry, attr->ia_mode);
>   
>   	return err;
>   }

