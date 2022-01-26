Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23BC49CC87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 15:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242264AbiAZOk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 09:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242259AbiAZOk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:40:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B92C06161C;
        Wed, 26 Jan 2022 06:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CFtOi7chIbKkPpzpTyQNMjLSqIWvdOnoFw9tu2h2FwM=; b=FJayuleENqPAYh6qPPQIDr12gd
        cnkhWyeLZQtLieqUfbB0oOTkM9ItxqVnFWRKeAAmJ86m3rK1xuPSjVcDYYzwYXLHjyv0am6KS+uiW
        Tl3/zFHo6Pke/Qd4QOtPr+TywIwtBduBdT+cuRsbO7UTWQKyM0Txn7RrDuVCSpmS5MaGeQGZz0El2
        MJkWdw83v2Bpq48HZLzWUGvD56h8J0q6HLpTO0yR1mKwPc/NN5F/DY9nRNWqJoXi24d+kklNQ0WMN
        at4eoZCpUgRELl+xwehk18Aco/VHy9RgZoaB0bWzjBTR+5eo0rlrxzx2pLHAJD2SoOAJacm85O4a5
        wuGexQSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCjTh-00486l-HZ; Wed, 26 Jan 2022 14:40:53 +0000
Date:   Wed, 26 Jan 2022 14:40:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
Message-ID: <YfFddcQyHHofTwgg@casper.infradead.org>
References: <20220126114447.25776-1-ariadne@dereferenced.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126114447.25776-1-ariadne@dereferenced.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
> In several other operating systems, it is a hard requirement that the
> first argument to execve(2) be the name of a program, thus prohibiting
> a scenario where argc < 1.  POSIX 2017 also recommends this behaviour,
> but it is not an explicit requirement[0]:
> 
>     The argument arg0 should point to a filename string that is
>     associated with the process being started by one of the exec
>     functions.
> 
> To ensure that execve(2) with argc < 1 is not a useful gadget for
> shellcode to use, we can validate this in do_execveat_common() and
> fail for this scenario, effectively blocking successful exploitation
> of CVE-2021-4034 and similar bugs which depend on this gadget.
> 
> The use of -EFAULT for this case is similar to other systems, such
> as FreeBSD, OpenBSD and Solaris.  QNX uses -EINVAL for this case.
> 
> Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
> but there was no consensus to support fixing this issue then.
> Hopefully now that CVE-2021-4034 shows practical exploitative use
> of this bug in a shellcode, we can reconsider.
> 
> [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408
> 
> Changes from v1:
> - Rework commit message significantly.
> - Make the argv[0] check explicit rather than hijacking the error-check
>   for count().
> 
> Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
> ---
>  fs/exec.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 79f2c9483302..e52c41991aab 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1899,6 +1899,10 @@ static int do_execveat_common(int fd, struct filename *filename,
>  	retval = count(argv, MAX_ARG_STRINGS);
>  	if (retval < 0)
>  		goto out_free;
> +	if (retval == 0) {
> +		retval = -EFAULT;
> +		goto out_free;
> +	}

I don't object to the concept, but it's a more common pattern in Linux
to do this:

	retval = count(argv, MAX_ARG_STRINGS);
+	if (retval == 0)
+		retval = -EFAULT;
	if (retval < 0)
		goto out_free;

(aka I like my bikesheds painted in Toasty Eggshell)
