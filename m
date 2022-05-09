Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4385651FCA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 14:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiEIM2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiEIM2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 08:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A844C1FB2D8
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652099061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0sshnHkSs7DyfPFcub+CVU712bGnqV4YP2xqLyKzHDo=;
        b=Oao7zdXrf0vojMSQGLHXQXWB1iLqfc7bB+GPODp9A4igt7PV+xTpLqYuPQj+uXIr+3KkvZ
        Aw+dKiIUOFfnQkU5YxcR1ADCo9vWgVAvwc7VzgA+GzItbvnRhnMlfAMyMasFdX0fZ3vO8u
        z2eDbo8dUz7JYOwm0GPLJ3aQ9vSFVvI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-BMWXFC4_NNms-WicxXMoQA-1; Mon, 09 May 2022 08:24:20 -0400
X-MC-Unique: BMWXFC4_NNms-WicxXMoQA-1
Received: by mail-il1-f198.google.com with SMTP id v11-20020a056e0213cb00b002cbcd972206so7462231ilj.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 May 2022 05:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0sshnHkSs7DyfPFcub+CVU712bGnqV4YP2xqLyKzHDo=;
        b=VBMUzNnap+3Pula6oF9GSce+L4kn/xz4X8hLHmeNN59S43vC12KHEjskBFo4f7jgvU
         lQZfe7v8ILz9+Fb+zx8zGbYm537LtIX1YFNckolkg6c5BeQSvIPAdGF9lKm4qz1Pg2HO
         41ExnT/QJq/DZ179Ky1MtlldRiiNLHKG8ba4JZnIDQhKZLkMWPlOfrwFNC/b/myr3JVn
         +GlOq3iEfsuhowFd8SJuOTKHsJI4me24+MW+if8sCN8Spn0PdG5w4cso0wn1LibJRoKn
         ABr60Sd8CtJo0Drh3++yFA/OBEOncN3nCdyxDbiyhQbR3djqMUWRIlY1FRgmZc+GCgCN
         DsmA==
X-Gm-Message-State: AOAM532PfsNuD/oIdL3NskouBvzP/9I1J98jHKQ5loVwgvQxpJrstyxo
        qPqlw1z1lL5hkW0SfUu/cPberLeGEtUOD31uYBMSQxVtUeOQ3y7TV4JnUOyQPsh3dqDuPV4re1p
        P67v5LSdJO3KgLKCWJ2xU9Z67iA==
X-Received: by 2002:a05:6e02:1aa9:b0:2cf:36b5:4b97 with SMTP id l9-20020a056e021aa900b002cf36b54b97mr6846316ilv.218.1652099059525;
        Mon, 09 May 2022 05:24:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXEucCvFkAd8o0V8V3s/Ty97Qu8GTSDjztoSHdJlqNlcgyXbTUBE+L2UwHPU2R5CKWOg7ztw==
X-Received: by 2002:a05:6e02:1aa9:b0:2cf:36b5:4b97 with SMTP id l9-20020a056e021aa900b002cf36b54b97mr6846296ilv.218.1652099058953;
        Mon, 09 May 2022 05:24:18 -0700 (PDT)
Received: from [172.16.0.5] (64-90-88-129.brainerd.net. [64.90.88.129])
        by smtp.gmail.com with ESMTPSA id p2-20020a92b302000000b002cf8521f8fcsm1976800ilh.28.2022.05.09.05.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 05:24:18 -0700 (PDT)
Message-ID: <40ecd87b-4c81-9fa9-17e7-68c23f5816a1@redhat.com>
Date:   Mon, 9 May 2022 07:24:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 11/26] gfs2: Convert to release_folio
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
 <20220508203247.668791-12-willy@infradead.org>
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <20220508203247.668791-12-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/8/22 3:32 PM, Matthew Wilcox (Oracle) wrote:
> Use a folio throughout gfs2_release_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
The gfs2 portion looks good to me.

Reviewed-by: Bob Peterson <rpeterso@redhat.com>

Regards,

Bob Peterson

