Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3270036FDAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhD3PZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 11:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhD3PZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619796252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AzrGB1ALtXj7yz0cHZYnCYBUe2dBhkVQC5T50nacLoo=;
        b=IBwi/Be4J8PLxMWTL+6oEtfH9raZZ0pfhM2JRAZ6phivrfuWr1YAUJ7pf8jhkNfovW/tq4
        TwNfj6RfOcepRN0N6vHYemPHcr6460F+g5oPQt5W8TvJDOatGJD6NvlB6vW0AotUx15APB
        Ir6Bir0dc4pEG+tBgvjSyRhYnIcJR6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-swIzQeHEMemNfLQSdjLySg-1; Fri, 30 Apr 2021 11:24:09 -0400
X-MC-Unique: swIzQeHEMemNfLQSdjLySg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE504107ACCA;
        Fri, 30 Apr 2021 15:24:07 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D72035D719;
        Fri, 30 Apr 2021 15:24:02 +0000 (UTC)
Date:   Fri, 30 Apr 2021 11:24:00 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 3/3] test: add openat2() test for invalid upper 32 bit
 flag value
Message-ID: <20210430152400.GY3141668@madcap2.tricolour.ca>
References: <20210423111037.3590242-1-brauner@kernel.org>
 <20210423111037.3590242-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423111037.3590242-3-brauner@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-04-23 13:10, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Test that openat2() rejects unknown flags in the upper 32 bit range.
> 
> Cc: Richard Guy Briggs <rgb@redhat.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  tools/testing/selftests/openat2/openat2_test.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
> index 381d874cce99..7379e082a994 100644
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
> +		/* Invalid flags in the upper 32 bits must be rejected. */
> +		{ .name = "invalid flags (1 << 63)",
> +		  .how.flags = O_RDONLY | (1ULL << 63),
> +		  .how.resolve = 0, .err = -EINVAL },

This doesn't appear to specifically test for flags over 32 bits.  It
appears to test for flags not included in VALID_OPEN_FLAGS.

"1ULL << 2" would accomplish the same thing, as would "1ULL << 31" due
to the unused flags in the bottom 32 bits.

The test appears to be useful, but misnamed.

If a new flag was added at 1ULL << 33, this test wouldn't notice and it
would still get dropped in build_open_flags() when flags gets assigned
to op->open_flags.

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

