Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9066B1F84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCIJLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjCIJLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:11:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D385DE1EA;
        Thu,  9 Mar 2023 01:10:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7B4261AB6;
        Thu,  9 Mar 2023 09:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EDEC433EF;
        Thu,  9 Mar 2023 09:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678353058;
        bh=JjxLR1+avtcuU4KUyJgBQZFgh1Cf7A5zbpgdMrdZvVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIx5PMn30TNo8a8IuyvEKukqRXpKoZayeXcBCbC0BwmnoZdX0q7qqg5BHT/oAdy7s
         p1L+KaEdsP3DUMY6Lv3IaMYlRG8UzjzLxgqqO2gA803JWhxbrPOX+idFSKFVX8aiYw
         GLDB1k9jX+JpzErr7EqylDoGxMXYZ7MlkAoX0pFpMJ9nllobadjP5TH0dOp29xkBhE
         T2xluqTlLlODlXyIeTsmQDsnhTOihkvryBAkeO4W9KkLEPDRZ5skU1j8S1BQUn1+C3
         lq+CIRCH8cMJ5j8yya5ZA3f5yxRIyvYEdOMB9CqPaikcCnB8aik2aleoHIe+MV7j4I
         iwZpjc5fFsOyA==
Date:   Thu, 9 Mar 2023 11:10:42 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 4/4] mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to
 install WP PTEs
Message-ID: <ZAmikuHeF3hhqZlD@kernel.org>
References: <20230308221932.1548827-1-axelrasmussen@google.com>
 <20230308221932.1548827-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308221932.1548827-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 08, 2023 at 02:19:32PM -0800, Axel Rasmussen wrote:
> UFFDIO_COPY already has UFFDIO_COPY_MODE_WP, so when installing a new
> PTE to resolve a missing fault, one can install a write-protected one.
> This is useful when using UFFDIO_REGISTER_MODE_{MISSING,WP} in
> combination.
> 
> This was motivated by testing HugeTLB HGM [1], and in particular its
> interaction with userfaultfd features. Existing userfaultfd code
> supports using WP and MINOR modes together (i.e. you can register an
> area with both enabled), but without this CONTINUE flag the combination
> is in practice unusable.
> 
> So, add an analogous UFFDIO_CONTINUE_MODE_WP, which does the same thing
> as UFFDIO_COPY_MODE_WP, but for *minor* faults.
> 
> Update the selftest to do some very basic exercising of the new flag.
> 
> [1]: https://patchwork.kernel.org/project/linux-mm/cover/20230218002819.1486479-1-jthoughton@google.com/
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  fs/userfaultfd.c                         | 8 ++++++--
>  include/linux/userfaultfd_k.h            | 3 ++-
>  include/uapi/linux/userfaultfd.h         | 7 +++++++
>  mm/userfaultfd.c                         | 5 +++--
>  tools/testing/selftests/mm/userfaultfd.c | 4 ++++
>  5 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 005e5e306266..14059a0861bf 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -297,6 +297,13 @@ struct uffdio_writeprotect {
>  struct uffdio_continue {
>  	struct uffdio_range range;
>  #define UFFDIO_CONTINUE_MODE_DONTWAKE		((__u64)1<<0)
> +	/*
> +	 * UFFDIO_CONTINUE_MODE_WP will map the page write protected on
> +	 * the fly.  UFFDIO_CONTINUE_MODE_WP is available only if the
> +	 * write protected ioctl is implemented for the range
> +	 * according to the uffdio_register.ioctls.
> +	 */
> +#define UFFDIO_CONTINUE_MODE_WP			((__u64)1<<1)

Please add the description of the new flag to Documentation/ and to the
userfaultfd man pages.

>  	__u64 mode;
>  
>  	/*

-- 
Sincerely yours,
Mike.
