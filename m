Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C572F6EC7F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2019 00:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfGSWZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 18:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfGSWZx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 18:25:53 -0400
Received: from [172.20.8.67] (fs96f9c61d.tkyc509.ap.nuro.jp [150.249.198.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F662089C;
        Fri, 19 Jul 2019 22:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563575151;
        bh=8BWoO3DvmgmHko8VDYdzETwa/D8Uvwa79H4eUTG3YyA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=2d21roDptAiEMN+/t1Tn1VqLwtXAzfhagrwnPWLFbYgAsIvJrwHrLthScReql/x37
         AR35y/eDLcde0w6tvfWPiYxJdZI5Xmb/Wqr3rItqjuiTHCL3Wa/X60g/Pf/v1glDZV
         /OWIM04HKP6cE2E1wkO2gqhjsIBpm7gFFRxIlREI=
Subject: Re: [PATCH v10 8/9] kselftest: save-and-restore errno to allow for %m
 formatting
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190719164225.27083-1-cyphar@cyphar.com>
 <20190719164225.27083-9-cyphar@cyphar.com>
From:   shuah <shuah@kernel.org>
Message-ID: <b32d95a1-8a49-65ef-4ddd-fe86a7ca01d5@kernel.org>
Date:   Fri, 19 Jul 2019 16:25:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190719164225.27083-9-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/19/19 10:42 AM, Aleksa Sarai wrote:
> Previously, using "%m" in a ksft_* format string can result in strange
> output because the errno value wasn't saved before calling other libc
> functions. The solution is to simply save and restore the errno before
> we format the user-supplied format string.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>   tools/testing/selftests/kselftest.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index ec15c4f6af55..0ac49d91a260 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -10,6 +10,7 @@
>   #ifndef __KSELFTEST_H
>   #define __KSELFTEST_H
>   
> +#include <errno.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <stdarg.h>
> @@ -81,58 +82,68 @@ static inline void ksft_print_cnts(void)
>   
>   static inline void ksft_print_msg(const char *msg, ...)
>   {
> +	int saved_errno = errno;
>   	va_list args;
>   
>   	va_start(args, msg);
>   	printf("# ");
> +	errno = saved_errno;
>   	vprintf(msg, args);
>   	va_end(args);
>   }
>   
>   static inline void ksft_test_result_pass(const char *msg, ...)
>   {
> +	int saved_errno = errno;
>   	va_list args;
>   
>   	ksft_cnt.ksft_pass++;
>   
>   	va_start(args, msg);
>   	printf("ok %d ", ksft_test_num());
> +	errno = saved_errno;
>   	vprintf(msg, args);
>   	va_end(args);
>   }
>   
>   static inline void ksft_test_result_fail(const char *msg, ...)
>   {
> +	int saved_errno = errno;
>   	va_list args;
>   
>   	ksft_cnt.ksft_fail++;
>   
>   	va_start(args, msg);
>   	printf("not ok %d ", ksft_test_num());
> +	errno = saved_errno;
>   	vprintf(msg, args);
>   	va_end(args);
>   }
>   
>   static inline void ksft_test_result_skip(const char *msg, ...)
>   {
> +	int saved_errno = errno;
>   	va_list args;
>   
>   	ksft_cnt.ksft_xskip++;
>   
>   	va_start(args, msg);
>   	printf("not ok %d # SKIP ", ksft_test_num());
> +	errno = saved_errno;
>   	vprintf(msg, args);
>   	va_end(args);
>   }
>   
>   static inline void ksft_test_result_error(const char *msg, ...)
>   {
> +	int saved_errno = errno;
>   	va_list args;
>   
>   	ksft_cnt.ksft_error++;
>   
>   	va_start(args, msg);
>   	printf("not ok %d # error ", ksft_test_num());
> +	errno = saved_errno;
>   	vprintf(msg, args);
>   	va_end(args);
>   }
> @@ -152,10 +163,12 @@ static inline int ksft_exit_fail(void)
>   
>   static inline int ksft_exit_fail_msg(const char *msg, ...)
>   {
> +	int saved_errno = errno;
>   	va_list args;
>   
>   	va_start(args, msg);
>   	printf("Bail out! ");
> +	errno = saved_errno;
>   	vprintf(msg, args);
>   	va_end(args);
>   
> @@ -178,10 +191,12 @@ static inline int ksft_exit_xpass(void)
>   static inline int ksft_exit_skip(const char *msg, ...)
>   {
>   	if (msg) {
> +		int saved_errno = errno;
>   		va_list args;
>   
>   		va_start(args, msg);
>   		printf("not ok %d # SKIP ", 1 + ksft_test_num());
> +		errno = saved_errno;
>   		vprintf(msg, args);
>   		va_end(args);
>   	} else {
> 

Hi Aleksa,

Can you send this patch separate from the patch series. I will apply
this as bug fix to 5.3-rc2 or rc3.

This isn't part of this series anyway and I would like to get this in
right away.

thanks,
-- Shuah
