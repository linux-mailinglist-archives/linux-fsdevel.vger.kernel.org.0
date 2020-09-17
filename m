Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6514226E6A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 22:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgIQUWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 16:22:01 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:17068 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIQUWB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:22:01 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 16:22:00 EDT
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4BspKL2xv0z5tl9;
        Thu, 17 Sep 2020 22:21:58 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E3EB92100;
        Thu, 17 Sep 2020 22:21:57 +0200 (CEST)
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     tytso@mit.edu, Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
 <20200917112830.26606-2-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <64358b70-4fff-5dc8-6e63-2fc916bea6af@kdbg.org>
Date:   Thu, 17 Sep 2020 22:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917112830.26606-2-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 17.09.20 um 13:28 schrieb Ævar Arnfjörð Bjarmason:
> Change the behavior of core.fsyncObjectFiles to also sync the
> directory entry. I don't have a case where this broke, just going by
> paranoia and the fsync(2) manual page's guarantees about its behavior.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  sha1-file.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/sha1-file.c b/sha1-file.c
> index dd65bd5c68..d286346921 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -1784,10 +1784,14 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
>  }
>  
>  /* Finalize a file on disk, and close it. */
> -static void close_loose_object(int fd)
> +static void close_loose_object(int fd, const struct strbuf *dirname)
>  {
> -	if (fsync_object_files)
> +	int dirfd;
> +	if (fsync_object_files) {
>  		fsync_or_die(fd, "loose object file");
> +		dirfd = xopen(dirname->buf, O_RDONLY);
> +		fsync_or_die(dirfd, "loose object directory");

Did you have the opportunity to verify that this works on Windows?
Opening a directory with open(2), I mean: It's disallowed according to
the docs:
https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/open-wopen?view=vs-2019#return-value

> +	}
>  	if (close(fd) != 0)
>  		die_errno(_("error when closing loose object file"));
>  }

-- Hannes
