Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1432A71FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 19:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfICRyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 13:54:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbfICRyX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:54:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECF038AC6FF;
        Tue,  3 Sep 2019 17:54:22 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62F3B60C5E;
        Tue,  3 Sep 2019 17:54:22 +0000 (UTC)
Subject: Re: [PATCH v2] xfsprogs: io/copy_range: cover corner case (fd_in ==
 fd_out)
To:     "Jianhong.Yin" <yin-jianhong@163.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     lsahlber@redhat.com, alexander198961@gmail.com,
        fengxiaoli0714@gmail.com, dchinner@redhat.com
References: <20190903111903.12231-1-yin-jianhong@163.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <c2a1d20c-d6e9-1358-a189-a05a822cb22e@redhat.com>
Date:   Tue, 3 Sep 2019 12:54:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903111903.12231-1-yin-jianhong@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Tue, 03 Sep 2019 17:54:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/3/19 6:19 AM, Jianhong.Yin wrote:
> Related bug:
>   copy_file_range return "Invalid argument" when copy in the same file
>   https://bugzilla.kernel.org/show_bug.cgi?id=202935

that's a CIFS bug though, not related to how xfs_io operates, correct?

What is the failing xfs_io case?  Because this seems to work fine here:

# fallocate -l 128m testfile
# strace -eopen,copy_file_range xfs_io -c "copy_range -s 1m -d 8m -l 2m testfile" testfile
...
open("testfile", O_RDWR)                = 3
...
open("testfile", O_RDONLY)              = 4
copy_file_range(4, [1048576], 3, [8388608], 2097152, 0) = 2097152
+++ exited with 0 +++

this works too:

# strace -eopen,copy_file_range xfs_io -c "copy_range testfile" testfile
...
open("testfile", O_RDWR)                = 3
...
open("testfile", O_RDONLY)              = 4
copy_file_range(4, [0], 3, [0], 134217728, 0) = 0
+++ exited with 0 +++

so can you help me understand what bug you're fixing?

-Eric

> if argument of option -f is "-", use current file->fd as fd_in
> 
> Usage:
>   xfs_io -c 'copy_range -f -' some_file
> 
> Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
> ---
>  io/copy_file_range.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/io/copy_file_range.c b/io/copy_file_range.c
> index b7b9fd88..2dde8a31 100644
> --- a/io/copy_file_range.c
> +++ b/io/copy_file_range.c
> @@ -28,6 +28,7 @@ copy_range_help(void)
>                            at position 0\n\
>   'copy_range -f 2' - copies all bytes from open file 2 into the current open file\n\
>                            at position 0\n\
> + 'copy_range -f -' - copies all bytes from current open file append the current open file\n\
>  "));
>  }
>  
> @@ -114,11 +115,15 @@ copy_range_f(int argc, char **argv)
>  			}
>  			break;
>  		case 'f':
> -			src_file_nr = atoi(argv[1]);
> -			if (src_file_nr < 0 || src_file_nr >= filecount) {
> -				printf(_("file value %d is out of range (0-%d)\n"),
> -					src_file_nr, filecount - 1);
> -				return 0;
> +			if (strcmp(argv[1], "-") == 0)
> +				src_file_nr = (file - &filetable[0]) / sizeof(fileio_t);
> +			else {
> +				src_file_nr = atoi(argv[1]);
> +				if (src_file_nr < 0 || src_file_nr >= filecount) {
> +					printf(_("file value %d is out of range (0-%d)\n"),
> +						src_file_nr, filecount - 1);
> +					return 0;
> +				}
>  			}
>  			/* Expect no src_path arg */
>  			src_path_arg = 0;
> @@ -147,10 +152,14 @@ copy_range_f(int argc, char **argv)
>  		}
>  		len = sz;
>  
> -		ret = copy_dst_truncate();
> -		if (ret < 0) {
> -			ret = 1;
> -			goto out;
> +		if (fd != file->fd) {
> +			ret = copy_dst_truncate();
> +			if (ret < 0) {
> +				ret = 1;
> +				goto out;
> +			}
> +		} else {
> +			dst = sz;
>  		}
>  	}
>  
> 

