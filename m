Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A242F271F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 05:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbhALEeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 23:34:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbhALEeW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 23:34:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D10022D2A;
        Tue, 12 Jan 2021 04:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610426021;
        bh=w/M12tdhcBmd54UikgcO72r4KlYDUVQ214IXwdAJU4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QkctXtZo5gSC/FMwQZuBGsoPav92UIYtbXIGCu3NUkNQBRJjWGCtpRvhobr2oW2XM
         HQpqgL20C1Ow3ucl6xfmKxQmvO0sMkqUJY9DV2b8hU2GS8y0UfOSbBCzPozRWIuc16
         aYCuIdyHf7tE0z6TJEsjANwU32lprMJFu7l5srTs=
Date:   Mon, 11 Jan 2021 20:33:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <linux-fsdevel@vger.kernel.org>,
        <vbabka@suse.cz>, <mhocko@suse.com>, <andy.shevchenko@gmail.com>,
        <wangle6@huawei.com>
Subject: Re: [PATCH v3] proc_sysctl: fix oops caused by incorrect command
 parameters.
Message-Id: <20210111203340.98dd3c8fa675b709bcf6d49e@linux-foundation.org>
In-Reply-To: <20210112033155.91502-1-nixiaoming@huawei.com>
References: <20210112033155.91502-1-nixiaoming@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 12 Jan 2021 11:31:55 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:

> The process_sysctl_arg() does not check whether val is empty before
>  invoking strlen(val). If the command line parameter () is incorrectly
>  configured and val is empty, oops is triggered.
> 
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1770,6 +1770,9 @@ static int process_sysctl_arg(char *param, char *val,
>  			return 0;
>  	}
>  
> +	if (!val)
> +		return -EINVAL;
> +

I think v2 (return 0) was preferable.  Because all the other error-out
cases in process_sysctl_arg() also do a `return 0'.

If we're going to do a separate "patch: make process_sysctl_arg()
return an errno instead of 0" then fine, we can discuss that.  But it's
conceptually a different work from fixing this situation.  
