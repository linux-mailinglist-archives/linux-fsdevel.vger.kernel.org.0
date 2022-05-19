Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00BE52DF8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 23:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245245AbiESVrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 17:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiESVrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 17:47:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DB1972AE;
        Thu, 19 May 2022 14:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=kTddhtx7FQlXKvG8iI5sagS7X5egDOVIA77mbT4W6bA=; b=oMaSk+Uu2RoMnHq5DGwlyqG2Xe
        E4kWL9Gmeh5HBYegQnrYD8SoQBpxcIZstIvLeERvMwCevBHlzUi+NCA14TbscbWqIDtB95VBtDqZt
        hT3zM8lFz4qAossLjEzSG8icKJXESPuVbtGoZ7PKVQx8JMmzizOiUxnX6wzXe1kQowXwzIADQulh9
        tt02U1ClXGfONZjyuY2+HnYbha7f/j2KfyKnU4peXdXFtYpUN3pWJeC7CMMaiN6LauQS/MiIgDv90
        xD4ReAlBTvEqyetUqtx5f50XAxGOWufktAP9ufITPlC/ngRVfObRHOoaEPg4IJHhcMZ/jIMwvQTVs
        wc1L47Bw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrnz0-00D7iA-0T; Thu, 19 May 2022 21:46:58 +0000
Message-ID: <01c1e280-eec4-4f04-553b-670ae1376c33@infradead.org>
Date:   Thu, 19 May 2022 14:46:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH] procfs: Add file path and size to /proc/<pid>/fdinfo
Content-Language: en-US
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     ilkos@google.com, tjmercier@google.com, surenb@google.com,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Colin Cross <ccross@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
References: <20220519214021.3572840-1-kaleshsingh@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220519214021.3572840-1-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 5/19/22 14:40, Kalesh Singh wrote:
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 061744c436d9..ad66d78aca51 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1922,13 +1922,16 @@ if precise results are needed.
>  3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
>  ---------------------------------------------------------------
>  This file provides information associated with an opened file. The regular
> -files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'ino'.
> +files have at least six fields -- 'pos', 'flags', 'mnt_id', 'ino', 'size',
> +and 'path'.
> +
>  The 'pos' represents the current offset of the opened file in decimal
>  form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
>  file has been created with [see open(2) for details] and 'mnt_id' represents
>  mount ID of the file system containing the opened file [see 3.5
>  /proc/<pid>/mountinfo for details]. 'ino' represents the inode number of
> -the file.
> +the file, 'size' represents the size of the file in bytes, and 'path'
> +represents the file path.
>  
>  A typical output is::
>  
> @@ -1936,6 +1939,8 @@ A typical output is::
>  	flags:	0100002
>  	mnt_id:	19
>  	ino:	63107
> +        size:   0
> +        path:   /dev/null
>  
>  All locks associated with a file descriptor are shown in its fdinfo too::
>  
> @@ -1953,6 +1958,8 @@ Eventfd files
>  	flags:	04002
>  	mnt_id:	9
>  	ino:	63107
> +        size:   0
> +        path:   anon_inode:[eventfd]
>  	eventfd-count:	5a
>  
>  where 'eventfd-count' is hex value of a counter.
> @@ -1966,6 +1973,8 @@ Signalfd files
>  	flags:	04002
>  	mnt_id:	9
>  	ino:	63107
> +        size:   0
> +        path:   anon_inode:[signalfd]
>  	sigmask:	0000000000000200
>  
>  where 'sigmask' is hex value of the signal mask associated
> @@ -1980,6 +1989,8 @@ Epoll files
>  	flags:	02
>  	mnt_id:	9
>  	ino:	63107
> +        size:   0
> +        path:   anon_inode:[eventpoll]
>  	tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
>  
>  where 'tfd' is a target file descriptor number in decimal form,
> @@ -1998,6 +2009,8 @@ For inotify files the format is the following::
>  	flags:	02000000
>  	mnt_id:	9
>  	ino:	63107
> +        size:   0
> +        path:   anon_inode:inotify
>  	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
>  
>  where 'wd' is a watch descriptor in decimal form, i.e. a target file
> @@ -2021,6 +2034,8 @@ For fanotify files the format is::
>  	flags:	02
>  	mnt_id:	9
>  	ino:	63107
> +        size:   0
> +        path:   anon_inode:[fanotify]
>  	fanotify flags:10 event-flags:0
>  	fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
>  	fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
> @@ -2046,6 +2061,8 @@ Timerfd files
>  	flags:	02
>  	mnt_id:	9
>  	ino:	63107
> +        size:   0
> +        path:   anon_inode:[timerfd]
>  	clockid: 0
>  	ticks: 0
>  	settime flags: 01
> @@ -2070,6 +2087,7 @@ DMA Buffer files
>  	mnt_id:	9
>  	ino:	63107
>  	size:   32768
> +        path:   /dmabuf:
>  	count:  2
>  	exp_name:  system-heap

All of these added lines should be indented with a tab instead of spaces.

thanks.
-- 
~Randy
