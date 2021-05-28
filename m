Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C484C394415
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhE1OWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 10:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229599AbhE1OWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 10:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622211627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HpqTAULraOcV5QWJSEsl1JBwlj3qWFK3TdWqkFq/w+s=;
        b=CDQqmzI1VgQjcqe7BIgApdJKgk+BMZO19iYeIZufuh4QZzKkFCkixNmzXTfn5xIyUX4+QA
        dbCJSbWM34Nw4PTbuTWp211kHTO/bNar6bp2habf+Gc6tXXwh8bYdvCm8sAKo8lzQEq4RB
        /Tc0f/Nx9ndOKxoHVxz5LLr3OSTUVjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-_-0mG0LdOkmhcjoFFOz4bw-1; Fri, 28 May 2021 10:20:23 -0400
X-MC-Unique: _-0mG0LdOkmhcjoFFOz4bw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCC01801B16;
        Fri, 28 May 2021 14:20:22 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7A4F5D6A8;
        Fri, 28 May 2021 14:20:17 +0000 (UTC)
Date:   Fri, 28 May 2021 10:20:15 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 3/3] test: add openat2() test for invalid upper 32 bit
 flag value
Message-ID: <20210528142015.GK2268484@madcap2.tricolour.ca>
References: <20210528092417.3942079-1-brauner@kernel.org>
 <20210528092417.3942079-4-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528092417.3942079-4-brauner@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-05-28 11:24, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Test that openat2() rejects unknown flags in the upper 32 bit range.
> 
> Cc: Richard Guy Briggs <rgb@redhat.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
> /* v2 */
> - Richard Guy Briggs <rgb@redhat.com>:
>   - Rename test to clarify what it actually tests.
> ---
>  tools/testing/selftests/openat2/openat2_test.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
> index 381d874cce99..d7ec1e7da0d0 100644
> --- a/tools/testing/selftests/openat2/openat2_test.c
> +++ b/tools/testing/selftests/openat2/openat2_test.c
> @@ -155,7 +155,7 @@ struct flag_test {
>  	int err;
>  };
>  
> -#define NUM_OPENAT2_FLAG_TESTS 24
> +#define NUM_OPENAT2_FLAG_TESTS 25
>  
>  void test_openat2_flags(void)
>  {
> @@ -229,6 +229,11 @@ void test_openat2_flags(void)
>  		{ .name = "invalid how.resolve and O_PATH",
>  		  .how.flags = O_PATH,
>  		  .how.resolve = 0x1337, .err = -EINVAL },
> +
> +		/* currently unknown upper 32 bit rejected. */
> +		{ .name = "currently unknown bit (1 << 63)",
> +		  .how.flags = O_RDONLY | (1ULL << 63),
> +		  .how.resolve = 0, .err = -EINVAL },
>  	};
>  
>  	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_FLAG_TESTS);
> -- 
> 2.27.0
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

