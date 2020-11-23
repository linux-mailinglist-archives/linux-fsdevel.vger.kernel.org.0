Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90632C126C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 18:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390461AbgKWRwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 12:52:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgKWRwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606153929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcwBDkt/6ndC1qadY8x0l7MPyKKcaJEtF94aWvQSDKM=;
        b=eemGTm6m6VFd5STTe2fFEtTsjrongOdYsi4W4/HgCMje0Lla57zF5OgiiFaXaNdMwnGug+
        jlfg3Ud4dAVtsuw15B0QGz2l09+ksDRb+EorALa6Tah4fCIcywJa0uHw3X9EKLnvxuMp1E
        Zv00T5zdDZThsHNwO11lA2EMVC1eypE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-1MKVZVqrOMKyYKday_IbDw-1; Mon, 23 Nov 2020 12:51:04 -0500
X-MC-Unique: 1MKVZVqrOMKyYKday_IbDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B60AD8145E6;
        Mon, 23 Nov 2020 17:51:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.134])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9452C19D9F;
        Mon, 23 Nov 2020 17:50:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 23 Nov 2020 18:51:00 +0100 (CET)
Date:   Mon, 23 Nov 2020 18:50:53 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
Message-ID: <20201123175052.GA20279@redhat.com>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120231441.29911-2-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'll try to actually read this series tomorrow but I see nothing wrong
after the quick glance.

Just one off-topic question,

On 11/20, Eric W. Biederman wrote:
>
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -585,7 +585,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  	int ispipe;
>  	size_t *argv = NULL;
>  	int argc = 0;
> -	struct files_struct *displaced;
>  	/* require nonrelative corefile path and be extra careful */
>  	bool need_suid_safe = false;
>  	bool core_dumped = false;
> @@ -791,11 +790,9 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  	}
>
>  	/* get us an unshared descriptor table; almost always a no-op */
> -	retval = unshare_files(&displaced);
> +	retval = unshare_files();

Can anyone explain why does do_coredump() need unshare_files() at all?

Oleg.

