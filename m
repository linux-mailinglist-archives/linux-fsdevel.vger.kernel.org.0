Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC541535CEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 11:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiE0JGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351209AbiE0JGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 05:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EE21111BB0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653642173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VxSx5WHE/is7ha0Qn9ZHkh6x3/barWbE89a+k35Foho=;
        b=e4kxOsLL3jDrL7Iv5s9CIj87qlP/NqBLcYgJ/AeiG191IDB6/Dz0qDy/XOC2dnftAPdCJW
        1ghhuHOWm6XQnBpt0uBF43Ufh6X06wRqXasgMIx8OOPsYx1hvJMecbzHqxZ9sDgvGgTQSu
        Hgfp0O8VW2SlbNlCm/GheNqd+scG2wM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-NTi_t_sZMdal6y7vIU_a0A-1; Fri, 27 May 2022 05:02:51 -0400
X-MC-Unique: NTi_t_sZMdal6y7vIU_a0A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF12E858EEE;
        Fri, 27 May 2022 09:02:50 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64FE7492C3B;
        Fri, 27 May 2022 09:02:48 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH v2 1/7] statx: add I/O alignment information
References: <20220518235011.153058-1-ebiggers@kernel.org>
        <20220518235011.153058-2-ebiggers@kernel.org>
Date:   Fri, 27 May 2022 11:02:46 +0200
In-Reply-To: <20220518235011.153058-2-ebiggers@kernel.org> (Eric Biggers's
        message of "Wed, 18 May 2022 16:50:05 -0700")
Message-ID: <87r14ffivd.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Eric Biggers:

> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 1500a0f58041a..f822b23e81091 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -124,9 +124,13 @@ struct statx {
>  	__u32	stx_dev_minor;
>  	/* 0x90 */
>  	__u64	stx_mnt_id;
> -	__u64	__spare2;
> +	__u32	stx_mem_align_dio;	/* Memory buffer alignment for direct I/O */
> +	__u32	stx_offset_align_dio;	/* File offset alignment for direct I/O */
>  	/* 0xa0 */
> -	__u64	__spare3[12];	/* Spare space for future expansion */
> +	__u32	stx_offset_align_optimal; /* Optimal file offset alignment for I/O */
> +	__u32	__spare2;
> +	/* 0xa8 */
> +	__u64	__spare3[11];	/* Spare space for future expansion */
>  	/* 0x100 */
>  };

Are 32 bits enough?  Would it make sense to store the base-2 logarithm
instead?

Thanks,
Florian

