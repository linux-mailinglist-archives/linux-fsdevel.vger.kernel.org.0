Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F6E7040B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 00:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245655AbjEOWIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 18:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245535AbjEOWIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 18:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCD56E96
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684188362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mJEVFLdRPcjN80hZWVkTiTXZUJ1+07IKEu73jeobqWc=;
        b=NImH5B95IcBEkws7RSsRXojLU+AOvgXv+yg254jeX5sQMjrBBzjefwznKckrpfhvd44eLt
        xVi5ULjFzS4ndW0lLIhPqM1Ax56pME5clq2hTNPqyMIhNvf6FJBKeEkqfY6nCnUxkiyZ6+
        En5ADmPqqQ7re06D95t+5txQSsqlTI0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-cbmx26AYP_O8u9xhg4GWdw-1; Mon, 15 May 2023 18:06:01 -0400
X-MC-Unique: cbmx26AYP_O8u9xhg4GWdw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ea572ef499so20939906d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 15:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684188361; x=1686780361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJEVFLdRPcjN80hZWVkTiTXZUJ1+07IKEu73jeobqWc=;
        b=Yt2LkgFgvDFUmRZeGdbEH85fRHhgqU8FGoGIm2E0GPztKJDtzuvKicM2SPcmON2xyQ
         TKp1VcrhJVfq36BLBH4bu1iGsJ3mCF5Z7fgAEA812KkG3yQPZnuFMuganNgSUeiQ2r5y
         rHmuQ4dRM4jLrTeIThRQdENwTMEmYU6+WBwZL7u7d3vw8zaOLtfKOLHCO0Owm7GDqsZg
         NcQpkPLw85N6ujNo+xlITcNFxQCfZDse1HWf0yPxhYJc1/+TADCmP2GXERV2dDWB8RQe
         8bsbNbhsTyOmuTL5d3D789psm8ZA4sin2RNa9SWbI4ohwAZlBcRdpWLROSMNkPCsn5a0
         dqtQ==
X-Gm-Message-State: AC+VfDw7pLO38TfgZfi/TP8JAfJP+ZHR+IYPadpzjL0Sw6PD2i0C9+bF
        NogqQT8+eMefQmgEjAXdRWuRDBUMivUYl3RtsBKxm2chSv2GUBiz6gVwH76O33GQHChP2aKn7PC
        uao/JvXRSkWGE47Cyqzpb0NCIcQ==
X-Received: by 2002:a05:6214:519a:b0:61b:76dd:b643 with SMTP id kl26-20020a056214519a00b0061b76ddb643mr16092579qvb.4.1684188361049;
        Mon, 15 May 2023 15:06:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76teqgNwGIs5CbjCMoSR//D+TAlaJxOvBjU3cu/IszWhxC8gqE0TLwrF6d15B3gUYbHtIY/A==
X-Received: by 2002:a05:6214:519a:b0:61b:76dd:b643 with SMTP id kl26-20020a056214519a00b0061b76ddb643mr16092547qvb.4.1684188360785;
        Mon, 15 May 2023 15:06:00 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id i7-20020a056214030700b006215f334a18sm3542109qvu.28.2023.05.15.15.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 15:06:00 -0700 (PDT)
Date:   Mon, 15 May 2023 18:05:58 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: pagemap: restrict pagewalk to the requested range
Message-ID: <ZGKsxlVpcTRUFT6N@x1n>
References: <20230515172608.3558391-1-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515172608.3558391-1-yuanchu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 01:26:08AM +0800, Yuanchu Xie wrote:
> The pagewalk in pagemap_read reads one PTE past the end of the requested
> range, and stops when the buffer runs out of space. While it produces
> the right result, the extra read is unnecessary and less performant.
> 
> I timed the following command before and after this patch:
> 	dd count=100000 if=/proc/self/pagemap of=/dev/null
> The results are consistently within 0.001s across 5 runs.
> 
> Before:
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB) copied, 0.0763159 s, 671 MB/s
> 
> real    0m0.078s
> user    0m0.012s
> sys     0m0.065s
> 
> After:
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB) copied, 0.0487928 s, 1.0 GB/s
> 
> real    0m0.050s
> user    0m0.011s
> sys     0m0.039s
> 
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

