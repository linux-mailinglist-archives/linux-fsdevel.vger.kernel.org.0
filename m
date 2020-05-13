Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56B01D06A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 07:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgEMFqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 01:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728131AbgEMFqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 01:46:18 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9FC061A0C;
        Tue, 12 May 2020 22:46:18 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYkDZ-007EO7-Jb; Wed, 13 May 2020 05:46:09 +0000
Date:   Wed, 13 May 2020 06:46:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     axboe@kernel.dk, zohar@linux.vnet.ibm.com, mcgrof@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs: avoid fdput() after failed fdget() in
 ksys_sync_file_range()
Message-ID: <20200513054609.GS23230@ZenIV.linux.org.uk>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
 <71cc3966f60f884924f9dff8875ed478e858dca1.1589311577.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71cc3966f60f884924f9dff8875ed478e858dca1.1589311577.git.skhan@linuxfoundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 01:43:04PM -0600, Shuah Khan wrote:

> @@ -364,15 +364,15 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
>  int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
>  			 unsigned int flags)
>  {
> -	int ret;
> -	struct fd f;
> +	int ret = -EBADF;
> +	struct fd f = fdget(fd);
>  
> -	ret = -EBADF;
> -	f = fdget(fd);
> -	if (f.file)
> -		ret = sync_file_range(f.file, offset, nbytes, flags);
> +	if (!f.file)
> +		goto out;
>  
> +	ret = sync_file_range(f.file, offset, nbytes, flags);
>  	fdput(f);
> +out:
>  	return ret;

IDGI...  What's the point of that goto out, when it leads straight to return?
