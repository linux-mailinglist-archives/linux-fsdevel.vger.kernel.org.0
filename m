Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A5075884F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 00:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjGRWOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 18:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjGRWOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E30198E
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 15:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689718398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WwuWVUhQyLpqyuy0dr6uUxzbIrG4zTsvTGA2l0E3O54=;
        b=cucwT7aQd+NsyF8a/xd35gPKAqG8tEbh7RNBUWdJGcE3fQmx83LMuQXrCXih/U7ATe4qSo
        MZu1FLWZdXCd1/Sdg1a2uFiryNXeifwXGtCYqS1IYSwhgKgEI/tNYBRrpRw1jiP+NeMpTA
        MHH9yC4N8gPeW3GdSoSNQYwnBLEQAhc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-KXs-HZI6OICyYPAqRTHL9g-1; Tue, 18 Jul 2023 18:13:09 -0400
X-MC-Unique: KXs-HZI6OICyYPAqRTHL9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDB0186F124;
        Tue, 18 Jul 2023 22:13:08 +0000 (UTC)
Received: from redhat.com (unknown [10.22.16.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 523431121314;
        Tue, 18 Jul 2023 22:13:08 +0000 (UTC)
Date:   Tue, 18 Jul 2023 17:13:06 -0500
From:   Bill O'Donnell <billodo@redhat.com>
To:     Rob Barnes <robbarnes@google.com>
Cc:     bleung@chromium.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: export emergency_sync
Message-ID: <ZLcOcr6N+Ty59rBD@redhat.com>
References: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:45:40PM +0000, Rob Barnes wrote:
> emergency_sync forces a filesystem sync in emergency situations.
> Export this function so it can be used by modules.
> 
> Signed-off-by: Rob Barnes <robbarnes@google.com>

Example of an emergency situation?
Thanks-
Bill


> ---
> 
>  fs/sync.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/sync.c b/fs/sync.c
> index dc725914e1edb..b313db0ebb5ee 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -142,6 +142,7 @@ void emergency_sync(void)
>  		schedule_work(work);
>  	}
>  }
> +EXPORT_SYMBOL(emergency_sync);
>  
>  /*
>   * sync a single super
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 

