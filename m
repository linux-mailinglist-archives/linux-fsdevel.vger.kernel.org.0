Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8304E67C764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 10:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjAZJdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 04:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbjAZJc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562A822DD9
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 01:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674725530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wwdoVdvZ1FxySXHtS/y2n7jjp83gxbEJIMQ/l72KDiI=;
        b=iVtlOVJHJ+phV5pf989dn5C3e5xfbXeZFsoOIBVNwh7shkOKBypNI2RnvRNiSFqBlE4qDy
        bwZX+Qt9+H3PIjsrYIlUIJMMVFo0Y1oUrjrOpndBA8Z+Ehhz/1CvYn6aMFJmg2AITnLiWT
        m1GHSwOHsrnUgZ8SkINGlZNjSeKyDf4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-UPZtsSvaNMaBb2y4XDxGbA-1; Thu, 26 Jan 2023 04:32:08 -0500
X-MC-Unique: UPZtsSvaNMaBb2y4XDxGbA-1
Received: by mail-wm1-f69.google.com with SMTP id u12-20020a05600c210c00b003da1c092b83so272745wml.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 01:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwdoVdvZ1FxySXHtS/y2n7jjp83gxbEJIMQ/l72KDiI=;
        b=u2Mf5cv+RgAC25uvkkj2L7CMwEUSnxGgk7jnzSNPLdJvt01AHobZ83GI/UDoQO+PzK
         yfFEbQCgM47q0mqr36vG6pQj1GAVq4h+wVQHaK7F4LTz+3HYGCP4PfIK7flwtf0QVqmZ
         r4ECQuEsR9X7Usr7vi7CsQ4gSt6CZcqM88M6zK+xUWaW4wxum3wkpJLmrqcAV0DACRe0
         At3V7emcpk2lyk7KyzaUgvfxZ0UmMVEBFgivtXH0LHaUfEKZC6SZYmrUFCg/z3GsCcCS
         pEzSEpcWa0mILnMI8M6wXlY283RIowieV2B8bucYPgWOV74gjYwVLqUoZsjYJlwzQw5o
         dgIg==
X-Gm-Message-State: AFqh2kqbiDNLwtKGiyD0kyNhXKLFC83VhGq6xJmaIFBM3Kvuajedd/9W
        ER0BW3lbwk6q794lZtRWRDyCvlR53CR39cGwwbo6bAdhB+pCoWAGSmhjEw1Dg38latTP3k4XktS
        pqa18V9hm+sToPzjh6onUZ60tKQ==
X-Received: by 2002:a5d:4350:0:b0:2be:5366:8cdf with SMTP id u16-20020a5d4350000000b002be53668cdfmr19139275wrr.20.1674725527625;
        Thu, 26 Jan 2023 01:32:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvuEnatbeSNJHS0IKM41wypa1ffgMRJyS1j0d/4+OLyN2ZtqLoQlAGksy5c3U4wNl1YCZjPqQ==
X-Received: by 2002:a5d:4350:0:b0:2be:5366:8cdf with SMTP id u16-20020a5d4350000000b002be53668cdfmr19139245wrr.20.1674725527332;
        Thu, 26 Jan 2023 01:32:07 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id l13-20020adff48d000000b002366e3f1497sm784664wro.6.2023.01.26.01.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:32:06 -0800 (PST)
Message-ID: <f70c9b67-5284-cd6a-7360-92a883bf9bb5@redhat.com>
Date:   Thu, 26 Jan 2023 10:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 5/8] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-6-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230125210657.2335748-6-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25.01.23 22:06, David Howells wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Replace BIO_NO_PAGE_REF with a BIO_PAGE_REFFED flag that has the inverted
> meaning is only set when a page reference has been acquired that needs to
> be released by bio_release_pages().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jan Kara <jack@suse.cz>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: linux-block@vger.kernel.org
> ---

Oh, and I agree with a previous comment that this patch should also hold 
a Signed-off-by from Christoph above your Signed-off-by, if he is 
mentioned as the author via "From:".

I remember stumbling over that in submitting-patches.rst ...

-- 
Thanks,

David / dhildenb

