Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA18311969
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 04:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhBFDEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 22:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhBFCyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:54:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5D8C08EE7C;
        Fri,  5 Feb 2021 16:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+8+c6e2MXDrIRynamuIEcXTAJuyCmgpjsez/l/OAdUE=; b=M93kocYSsm7VHSI27ipgq83m4X
        5Bm2dri1chpJof5Msn5PyZzvfhUOwpQPRW5zcAgbgVHJkN9BjnuDjYmwzrG52A0rvcoiyeT0wiWqo
        HfFiGOPupsKDFz//dZsW6uH9lyB/XvsItdtQNN0IItQylnPu4DrIzzbyIRnwGA66owR6RfIjUbOfi
        O7M9lphz2K44Tv0/Ck+CCLfWXhzCS5cWpR6nOfKr3k8V+uOmChh03hBkfzk2B73g3Ke4nohk48hON
        HtkTiEtLFnXzY+bjaitQ9FE1xVfPeNI2hZTi2wZdhSPzPnDBfYA4tTepbCa0T2Ha+FYBSfB+PDS6h
        odT1F7Ew==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l8Bdp-0004ne-EB; Sat, 06 Feb 2021 00:40:01 +0000
Subject: Re: [PATCH v4 2/2] dmabuf: Add dmabuf inode number to /proc/*/fdinfo
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        christian.koenig@amd.com, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        NeilBrown <neilb@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20210205213353.669122-1-kaleshsingh@google.com>
 <20210205213353.669122-2-kaleshsingh@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <753e0a3b-ce7c-5518-65b1-f743dd370b76@infradead.org>
Date:   Fri, 5 Feb 2021 16:39:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210205213353.669122-2-kaleshsingh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/5/21 1:33 PM, Kalesh Singh wrote:
> And 'inode_no' field to /proc/<pid>/fdinfo/<FD> and
> /proc/<pid>/task/<tid>/fdinfo/<FD>.
> 
> The inode numbers can be used to uniquely identify DMA buffers
> in user space and avoids a dependency on /proc/<pid>/fd/* when
> accounting per-process DMA buffer sizes.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
> Changes in v4:
>   - Add inode number as common field in fdinfo, per Christian
> Changes in v3:
>   - Add documentation in proc.rst, per Randy
> Changes in v2:
>   - Update patch description
> 
>  Documentation/filesystems/proc.rst | 37 +++++++++++++++++++++++++-----
>  fs/proc/fd.c                       |  5 ++--
>  2 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2fa69f710e2a..db46da32230c 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1902,18 +1902,20 @@ if precise results are needed.
>  3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
>  ---------------------------------------------------------------
>  This file provides information associated with an opened file. The regular
> -files have at least three fields -- 'pos', 'flags' and 'mnt_id'. The 'pos'
> -represents the current offset of the opened file in decimal form [see lseek(2)
> -for details], 'flags' denotes the octal O_xxx mask the file has been
> -created with [see open(2) for details] and 'mnt_id' represents mount ID of
> -the file system containing the opened file [see 3.5 /proc/<pid>/mountinfo
> -for details].
> +files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'inode_no'.
> +The 'pos' represents the current offset of the opened file in decimal
> +form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
> +file has been created with [see open(2) for details] and 'mnt_id' represents
> +mount ID of the file system containing the opened file [see 3.5
> +/proc/<pid>/mountinfo for details]. 'inode_no' represents the inode number
> +of the file.
>  
>  A typical output is::
>  
>  	pos:	0
>  	flags:	0100002
>  	mnt_id:	19
> +	inode_no:       63107
>  
>  All locks associated with a file descriptor are shown in its fdinfo too::
>  
> @@ -1930,6 +1932,7 @@ Eventfd files
>  	pos:	0
>  	flags:	04002
>  	mnt_id:	9
> +	inode_no:       63107
>  	eventfd-count:	5a
>  
>  where 'eventfd-count' is hex value of a counter.
> @@ -1942,6 +1945,7 @@ Signalfd files
>  	pos:	0
>  	flags:	04002
>  	mnt_id:	9
> +	inode_no:       63107
>  	sigmask:	0000000000000200
>  
>  where 'sigmask' is hex value of the signal mask associated
> @@ -1955,6 +1959,7 @@ Epoll files
>  	pos:	0
>  	flags:	02
>  	mnt_id:	9
> +	inode_no:       63107
>  	tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
>  
>  where 'tfd' is a target file descriptor number in decimal form,
> @@ -1971,6 +1976,8 @@ For inotify files the format is the following::
>  
>  	pos:	0
>  	flags:	02000000
> +	mnt_id:	9
> +	inode_no:       63107
>  	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
>  
>  where 'wd' is a watch descriptor in decimal form, i.e. a target file
> @@ -1993,6 +2000,7 @@ For fanotify files the format is::
>  	pos:	0
>  	flags:	02
>  	mnt_id:	9
> +	inode_no:       63107
>  	fanotify flags:10 event-flags:0
>  	fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
>  	fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
> @@ -2017,6 +2025,7 @@ Timerfd files
>  	pos:	0
>  	flags:	02
>  	mnt_id:	9
> +	inode_no:       63107
>  	clockid: 0
>  	ticks: 0
>  	settime flags: 01
> @@ -2031,6 +2040,22 @@ details]. 'it_value' is remaining time until the timer expiration.
>  with TIMER_ABSTIME option which will be shown in 'settime flags', but 'it_value'
>  still exhibits timer's remaining time.
>  
> +DMA Buffer files
> +~~~~~~~~~~~~~~~~
> +
> +::
> +
> +	pos:	0
> +	flags:	04002
> +	mnt_id:	9
> +	inode_no:       63107

Hi,

Why do all of the examples have so many spaces between inode_no:
and the number?

Ah, it's a \t in the output along with the length of the "inode_no:"
string. OK.

Next question: why are there spaces instead of a tab between
"inode_no": and the number? All of the other fields that are
preceded by a \t in the seq_printf() call have tabs in the output.

Except for the tabs vs. spaces, the Documentation change is:
Acked-by: Randy Dunlap <rdunlap@infradead.org>



> +	size:   32768
> +	count:  2
> +	exp_name:  system-heap
> +
> +where 'size' is the size of the DMA buffer in bytes. 'count' is the file count of
> +the DMA buffer file. 'exp_name' is the name of the DMA buffer exporter.
> +
>  3.9	/proc/<pid>/map_files - Information about memory mapped files
>  ---------------------------------------------------------------------
>  This directory contains symbolic links which represent memory mapped files
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 585e213301f9..2c25909bf9d1 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -54,9 +54,10 @@ static int seq_show(struct seq_file *m, void *v)
>  	if (ret)
>  		return ret;
>  
> -	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\n",
> +	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\ninode_no:\t%lu\n",
>  		   (long long)file->f_pos, f_flags,
> -		   real_mount(file->f_path.mnt)->mnt_id);
> +		   real_mount(file->f_path.mnt)->mnt_id,
> +		   file_inode(file)->i_ino);
>  
>  	/* show_fd_locks() never deferences files so a stale value is safe */
>  	show_fd_locks(m, file, files);
> 

thanks.
-- 
~Randy

