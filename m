Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871D3538665
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbiE3Qyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbiE3Qyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 12:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF027A7767
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653929669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/rqcKfY9mlwY6K/SoS0HIjpA/I/CVx5G0Qxm345iKE=;
        b=EbUbkwATow2KSitLf+AEBP+DAMJ5Zx5fmgP76EeY9JM8fXkAhIur19AHbrIlAVD1Jw3WI5
        I0cTFtcoPqR6DHybnHCVcy09V6CMkThqBJsPqdWiOpI9EKBftf0UBqhh2P7IDhTlyN54VG
        fINKxVegIMuaLkdcyXU8y4CGYl/vo2Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-PvZC9jUkPl6lxCraINri7Q-1; Mon, 30 May 2022 12:54:28 -0400
X-MC-Unique: PvZC9jUkPl6lxCraINri7Q-1
Received: by mail-wm1-f72.google.com with SMTP id bg40-20020a05600c3ca800b00394779649b1so10036773wmb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 09:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=f/rqcKfY9mlwY6K/SoS0HIjpA/I/CVx5G0Qxm345iKE=;
        b=NaVstSlsZ/SxDYkwc0lryoYYl8LsruNuoicF8kQZ/Z09+sQqGrsGp0p5dxfisV1wel
         V21EUSbaleXRD/A48aORcC1wK9X9/ecv8IRpt3eOUVxg0rJsbVWkQa76U/8HBlIoIhIu
         od1+1kpVJEXYztpmlp4PJfVuYpweXT/YoLcP80qCPyWJ2OuQ7yAqYsBCULoJ/PYMq543
         mTu/nE1/LZz3l8Ox0LR6XMdIKffVfe3r7bsq4bzwh+v1M/+Uj8RUsDt38GPf/F/u7s44
         4eJn2ibtdHWQCtruFO0JkttQp7OvYO6qbMw5oxOGPSHIZ1l2zamB1ej7Mb9DMwRX8MjW
         66tw==
X-Gm-Message-State: AOAM532gMb+tciMwZiy5z42UZMIB/NvdbIpdj+c5pHkzniK2Q1bWpLE3
        4pBlXup2SyYCrI9t30NZwgbj/UMKC2L84F5z2yFtIgqhJMcOptPr/OuBEjrNnYvhfrK3m7Kxohj
        DmcTE5cPcPrXJ65kTr0FrEeIXaw==
X-Received: by 2002:a5d:5105:0:b0:210:c28:276b with SMTP id s5-20020a5d5105000000b002100c28276bmr18002357wrt.293.1653929667153;
        Mon, 30 May 2022 09:54:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwiR6Ws+tjOsyLLTcX2kyq+dQP75SPERKcOptjxubE5UYoa+/VWGZl1JPaNIJYKywKJwAlOA==
X-Received: by 2002:a5d:5105:0:b0:210:c28:276b with SMTP id s5-20020a5d5105000000b002100c28276bmr18002344wrt.293.1653929666885;
        Mon, 30 May 2022 09:54:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736? (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de. [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c08a400b003942a244f48sm10240715wmp.33.2022.05.30.09.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 09:54:26 -0700 (PDT)
Message-ID: <df2c225e-6173-08c1-bdc8-69b37c91c01b@redhat.com>
Date:   Mon, 30 May 2022 18:54:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Freeing page flags
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.05.22 22:54, Matthew Wilcox wrote:
> The LWN writeup [1] on merging the MGLRU reminded me that I need to send
> out a plan for removing page flags that we can do without.
> 
> 1. PG_error.  It's basically useless.  If the page was read successfully,
> PG_uptodate is set.  If not, PG_uptodate is clear.  The page cache
> doesn't use PG_error.  Some filesystems do, and we need to transition
> them away from using it.
> 
> 2. PG_private.  This tells us whether we have anything stored at
> page->private.  We can just check if page->private is NULL or not.
> No need to have this extra bit.  Again, there may be some filesystems
> that are a bit wonky here, but I'm sure they're fixable.
> 
> 3. PG_mappedtodisk.  This is really only used by the buffer cache.
> Once the filesystems that use bufferheads have been converted, this can
> go away.

Nowadays (upstream) PG_anon_exclusive for anonymous memory.


-- 
Thanks,

David / dhildenb

