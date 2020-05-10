Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40FC1CC5D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 02:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgEJAvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 20:51:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:65189 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgEJAvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 20:51:11 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04A0p77S032175;
        Sun, 10 May 2020 09:51:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Sun, 10 May 2020 09:51:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04A0p1V9031999
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 10 May 2020 09:51:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 05/20] tomoyo_write_control(): get rid of pointless
 access_ok()
To:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-5-viro@ZenIV.linux.org.uk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b67a5f6e-0192-f350-e797-455fe570ce93@i-love.sakura.ne.jp>
Date:   Sun, 10 May 2020 09:50:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200509234557.1124086-5-viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Al.

I think that this access_ok() check helps reducing partial writes (either
"whole amount was processed" or "not processed at all" unless -ENOMEM).
Do you think that such attempt is pointless? Then, please go ahead...

On 2020/05/10 8:45, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> address is passed only to get_user()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/tomoyo/common.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
> index 1b467381986f..f93f8acd05f7 100644
> --- a/security/tomoyo/common.c
> +++ b/security/tomoyo/common.c
> @@ -2662,8 +2662,6 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
>  
>  	if (!head->write)
>  		return -EINVAL;
> -	if (!access_ok(buffer, buffer_len))
> -		return -EFAULT;
>  	if (mutex_lock_interruptible(&head->io_sem))
>  		return -EINTR;
>  	head->read_user_buf_avail = 0;
> 

