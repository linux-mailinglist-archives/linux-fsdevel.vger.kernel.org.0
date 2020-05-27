Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93F81E42CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 14:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgE0M6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 08:58:09 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51774 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbgE0M6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 08:58:08 -0400
Received: by mail-pj1-f68.google.com with SMTP id cx22so1522112pjb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 05:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s1a9q/tUyEJC4vi7UuAcJUjs5V+FO8eu3jIO/70mpPU=;
        b=ApWNY953h24p+X5gdnuiHkNRt21U01I1YHx2mEWhc9Pa41SHwJVveHlmYvMM6Ts+0+
         G2Xf3W6tLlrFBmuB8gVAPCtT4d9satO0balZXb/nDlklr+jgc3OXczvT50lXiMJ94UA5
         x8TJmWSdUKKu3H9NEsXS2QTLgxZyCowWV36bRKPXXtOldFrhyqCYCXiEQTaY6lT16pqr
         SmCBRf99JMfu3qIoIVgHduaqG7L81iZbih3TSSqWn8GwlLE9RvxKvvQrg6At1lDqTafc
         wpx5S9rIJ0iCTCZNhdXjsLrV9d2KQYV1DZxEFlWCViO4kc0hDKYmZmAznodhWMlFO13+
         z8EQ==
X-Gm-Message-State: AOAM533XAoKeO7hpYTibkk9MD6tPhVZ2ZW3Vwmp2FAvDdBMn1+9BH3+t
        BhNtsXq+i4KCH9hbLjzbWi8=
X-Google-Smtp-Source: ABdhPJx1hX7YxfmHw2CQgfaPwXlObO8H2ouRQ7lPjOW6sf/cXg8vawwyKKT+PmfqJjbfTKzAMYAZIQ==
X-Received: by 2002:a17:902:b904:: with SMTP id bf4mr5759779plb.89.1590584287804;
        Wed, 27 May 2020 05:58:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i17sm2130357pfq.197.2020.05.27.05.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 05:58:06 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E965F40605; Wed, 27 May 2020 12:58:05 +0000 (UTC)
Date:   Wed, 27 May 2020 12:58:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Boris Sukholitko <boris.sukholitko@broadcom.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
Subject: Re: [PATCH] __register_sysctl_table: do not drop subdir
Message-ID: <20200527125805.GI11244@42.do-not-panic.com>
References: <20200527104848.GA7914@nixbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527104848.GA7914@nixbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric since you authored the code which this code claism to fix, your
review would be appreciated.

On Wed, May 27, 2020 at 01:48:48PM +0300, Boris Sukholitko wrote:
> Successful get_subdir returns dir with its header.nreg properly
> adjusted. No need to drop the dir in that case.

This commit log is not that clear to me, can you explain what happens
without this patch, and how critical it is to fix it. How did you
notice this issue? If you don't apply this patch what issue do you
see?

Do we test for it? Can we?

  Luis

> 
> Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
> Fixes: 7ec66d06362d (sysctl: Stop requiring explicit management of sysctl directories)
> ---
>  fs/proc/proc_sysctl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index b6f5d459b087..6f237f0eb531 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1286,8 +1286,8 @@ struct ctl_table_header *__register_sysctl_table(
>  {
>  	struct ctl_table_root *root = set->dir.header.root;
>  	struct ctl_table_header *header;
> +	struct ctl_dir *dir, *start_dir;
>  	const char *name, *nextname;
> -	struct ctl_dir *dir;
>  	struct ctl_table *entry;
>  	struct ctl_node *node;
>  	int nr_entries = 0;
> @@ -1307,6 +1307,7 @@ struct ctl_table_header *__register_sysctl_table(
>  
>  	spin_lock(&sysctl_lock);
>  	dir = &set->dir;
> +	start_dir = dir;
>  	/* Reference moved down the diretory tree get_subdir */
>  	dir->header.nreg++;
>  	spin_unlock(&sysctl_lock);
> @@ -1333,7 +1334,8 @@ struct ctl_table_header *__register_sysctl_table(
>  	if (insert_header(dir, header))
>  		goto fail_put_dir_locked;
>  
> -	drop_sysctl_table(&dir->header);
> +	if (start_dir == dir)
> +		drop_sysctl_table(&dir->header);
>  	spin_unlock(&sysctl_lock);
>  
>  	return header;
> -- 
> 2.23.1
> 
