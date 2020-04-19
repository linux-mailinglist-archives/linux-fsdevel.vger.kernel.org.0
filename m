Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD71AFEC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 00:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDSW6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 18:58:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46210 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgDSW6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 18:58:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id 145so1758256pfw.13;
        Sun, 19 Apr 2020 15:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WeNfqqul/V3m4dCr3fDBJiD7q3+RqFqQXCZmIH0aZiQ=;
        b=tv5JLAx0VCXAi0ifH8sG2FHEYgWtRe1O2w6Lke82AG99YHOgS/FR+NEcoE5qhXxXhU
         STcjUgOKMlaoRdGNr479iNkIICQg+SBb7UWqj1g1Sby4nH79qSE5uHipeaN+ZxS5WZTB
         5XfgDUwGtzHEhHhqU4DU9LeXk1SCbPbnYtuyAMjg1jrxp2ngpOzD/Ms/MyHmG/wKUelU
         CML+nNPnZWm/85XOCwe9rPGKVyrW1swvQaioSXrMhbU+LnNssdwVXzj+C7tJgMZ8pbL5
         MNZNcjKHjEIzf617IHYqS/F/n/Y1h4HF5quOcH//ZFsagSzQ7pYeSNZnSiVXhOoh4pr0
         NMFA==
X-Gm-Message-State: AGi0PuZ+yUD4lBSycEebRcDnLwI0cN8hF3cfiXwSG1xgmJEBJQ2H2A3E
        aRj18RLYEuiu2gJQuAXXlsGP458TifA=
X-Google-Smtp-Source: APiQypK3Dfc0+33A+/ZdM0DiJzbhdXOT2T6zI92OuybLuYpFMQsRiH8HjeTGYxZmN/hnAY3YB78k3g==
X-Received: by 2002:a63:d90c:: with SMTP id r12mr13564924pgg.158.1587337081070;
        Sun, 19 Apr 2020 15:58:01 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.198.64])
        by smtp.gmail.com with ESMTPSA id l15sm24246102pgk.59.2020.04.19.15.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 15:58:00 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] blktrace: add checks for created debugfs files
 on setup
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-9-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <38240225-e48e-3035-0baa-4929948b23a3@acm.org>
Date:   Sun, 19 Apr 2020 15:57:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419194529.4872-9-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> Even though debugfs can be disabled, enabling BLK_DEV_IO_TRACE will
> select DEBUG_FS, and blktrace exposes an API which userspace uses
> relying on certain files created in debugfs. If files are not created
> blktrace will not work correctly, so we do want to ensure that a
> blktrace setup creates these files properly, and otherwise inform
> userspace.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   kernel/trace/blktrace.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 9cc0153849c3..fc32a8665ce8 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -552,17 +552,19 @@ static int blk_trace_create_debugfs_files(struct blk_user_trace_setup *buts,
>   					  struct dentry *dir,
>   					  struct blk_trace *bt)
>   {
> -	int ret = -EIO;
> -
>   	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
>   					       &blk_dropped_fops);
> +	if (!bt->dropped_file)
> +		return -ENOMEM;
>   
>   	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
> +	if (!bt->msg_file)
> +		return -ENOMEM;
>   
>   	bt->rchan = relay_open("trace", dir, buts->buf_size,
>   				buts->buf_nr, &blk_relay_callbacks, bt);
>   	if (!bt->rchan)
> -		return ret;
> +		return -EIO;
>   
>   	return 0;
>   }

I should have had a look at this patch before I replied to the previous 
patch.

Do you agree that the following code can be triggered by 
debugfs_create_file() and also that debugfs_create_file() never returns 
NULL?

static struct dentry *failed_creating(struct dentry *dentry)
{
	inode_unlock(d_inode(dentry->d_parent));
	dput(dentry);
	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
	return ERR_PTR(-ENOMEM);
}

Thanks,

Bart.
