Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63564BB49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiLMRol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbiLMRod (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:44:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB3513F25
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670953425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hq1k1DYaSlNwrW9zUpeSaQNVENAlTPEkQgzrv3qXyjs=;
        b=MEKPzPgIeTkFNUNNdNADj010rv/vfne6Xr8i+adZ5VkJ9DEO7UQE/pVC2eGRDjKJ1yx27G
        FQuTvrHEbxd8y95OoHfRkdFEifD/0Il08PLGuqCmDPWU/vimWxtjUtXeWR8K9h+3AFTCot
        NWohZVnCe6v67PKCaErr/lsY1KOE084=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-53-3wI24GJBPqOeH_DehLf8aw-1; Tue, 13 Dec 2022 12:43:44 -0500
X-MC-Unique: 3wI24GJBPqOeH_DehLf8aw-1
Received: by mail-il1-f200.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so7957379ilj.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hq1k1DYaSlNwrW9zUpeSaQNVENAlTPEkQgzrv3qXyjs=;
        b=Tjz7Nl3IuiKWzAag+wDIoLoKiwYJVNk5RKzQiUp8dh04SK6d551RYCDTEJ818iIAPM
         1Q1VNg1DwTdaG/Z47M3I2zyfHZ8+FvJpjZCD9oATfYiWj9+1UJ/UoOn9hUjSWgokCU00
         YX7mdRMwN7BPiO6Sndt9aRww315tZlmLe+m64pJ4IhtHuwj3lD+837t1FhPlNcJfzD5C
         kfI2oj9IzB1/iDEIzcf/sDUpfQPSQ/XkGOasNpVR6MXDmd4p8OE59ku8GEPLmDmJjrAm
         F9cnJsnlpRxgHZkomydFBbLep+kSnTFaDkr1HXETAYP369gm+GYqf1GeffKZuDbaZ4mq
         GWCA==
X-Gm-Message-State: ANoB5plQZu/kh5xsKMFjxFStImpYFQIOShARsmAsq1qjFIOtokFzr9MN
        RxcalRK/jMt05KLxkOBuIfPXvGR4oP9LtDhU4vcKiC4VpCXsGV9ngNymf3bTv500B/wrAhVFF9P
        Vx3T1faKB60EAEN9BYsT1LzZyPA==
X-Received: by 2002:a6b:4e0e:0:b0:6ca:d145:9e with SMTP id c14-20020a6b4e0e000000b006cad145009emr11512664iob.14.1670953423868;
        Tue, 13 Dec 2022 09:43:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7jwqunq+jXYvfeI1EBTbH77VZw3KgSksjImP+PYOQQp2A2JolwObRQQo3oDc6GvazHHd0Pww==
X-Received: by 2002:a6b:4e0e:0:b0:6ca:d145:9e with SMTP id c14-20020a6b4e0e000000b006cad145009emr11512654iob.14.1670953423571;
        Tue, 13 Dec 2022 09:43:43 -0800 (PST)
Received: from [10.0.0.146] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id l20-20020a0566022dd400b006dfbfec899esm583737iow.28.2022.12.13.09.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:43:43 -0800 (PST)
Message-ID: <733b882c-30fc-eea0-db01-55d25f272d92@redhat.com>
Date:   Tue, 13 Dec 2022 11:43:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 03/11] xfs: add attribute type for fs-verity
Content-Language: en-US
To:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-4-aalbersh@redhat.com>
From:   Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20221213172935.680971-4-aalbersh@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/22 11:29 AM, Andrey Albershteyn wrote:
> The Merkle tree pages and descriptor are stored in the extended
> attributes of the inode. Add new attribute type for fs-verity
> metadata. Skip fs-verity attributes for getfattr as it can not parse
> binary page names.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>


>  DECLARE_EVENT_CLASS(xfs_attr_list_class,
> diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
> index 5b57f6348d630..acbfa29d04af0 100644
> --- a/fs/xfs/xfs_xattr.c
> +++ b/fs/xfs/xfs_xattr.c
> @@ -237,6 +237,9 @@ xfs_xattr_put_listent(
>  	if (flags & XFS_ATTR_PARENT)
>  		return;
>  
> +	if (flags & XFS_ATTR_VERITY)
> +		return;
> +

Just a nitpick, but now that there are already 2 cases like this, I wonder
if it would be wise to #define something like an XFS_ATTR_VISIBLE_MASK
(or maybe XFS_ATTR_INTERNAL_MASK) and use that to decide, rather than
testing each one individually?

Thanks,
-Eric

