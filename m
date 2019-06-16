Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043AB47364
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2019 08:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfFPGur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jun 2019 02:50:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64573 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfFPGur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jun 2019 02:50:47 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5G6n5Zc025385;
        Sun, 16 Jun 2019 15:49:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Sun, 16 Jun 2019 15:49:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5G6n04R025248
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 16 Jun 2019 15:49:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] tomoyo: Don't check open/getattr permission on sockets.
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        "David S. Miller" <davem@davemloft.net>
References: <0000000000004f43fa058a97f4d3@google.com>
 <201906060520.x565Kd8j017983@www262.sakura.ne.jp>
 <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp>
Date:   Sun, 16 Jun 2019 15:49:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Al.

Q1: Do you agree that we should fix TOMOYO side rather than SOCKET_I()->sk
    management.

Q2: Do you see any problem with using f->f_path.dentry->d_inode ?
    Do we need to use d_backing_inode() or d_inode() ?

Regards.

On 2019/06/09 15:41, Tetsuo Handa wrote:
> syzbot is reporting that use of SOCKET_I()->sk from open() can result in
> use after free problem [1], for socket's inode is still reachable via
> /proc/pid/fd/n despite destruction of SOCKET_I()->sk already completed.
> 
> But there is no point with calling security_file_open() on sockets
> because open("/proc/pid/fd/n", !O_PATH) on sockets fails with -ENXIO.
> 
> There is some point with calling security_inode_getattr() on sockets
> because stat("/proc/pid/fd/n") and fstat(open("/proc/pid/fd/n", O_PATH))
> are valid. If we want to access "struct sock"->sk_{family,type,protocol}
> fields, we will need to use security_socket_post_create() hook and
> security_inode_free() hook in order to remember these fields because
> security_sk_free() hook is called before the inode is destructed. But
> since information which can be protected by checking
> security_inode_getattr() on sockets is trivial, let's not be bothered by
> "struct inode"->i_security management.
> 
> There is point with calling security_file_ioctl() on sockets. Since
> ioctl(open("/proc/pid/fd/n", O_PATH)) is invalid, security_file_ioctl()
> on sockets should remain safe.
> 
> [1] https://syzkaller.appspot.com/bug?id=73d590010454403d55164cca23bd0565b1eb3b74
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>
> ---
>  security/tomoyo/tomoyo.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 716c92e..9661b86 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -126,6 +126,9 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
>   */
>  static int tomoyo_inode_getattr(const struct path *path)
>  {
> +	/* It is not safe to call tomoyo_get_socket_name(). */
> +	if (path->dentry->d_inode && S_ISSOCK(path->dentry->d_inode->i_mode))
> +		return 0;
>  	return tomoyo_path_perm(TOMOYO_TYPE_GETATTR, path, NULL);
>  }
>  
> @@ -316,6 +319,10 @@ static int tomoyo_file_open(struct file *f)
>  	/* Don't check read permission here if called from do_execve(). */
>  	if (current->in_execve)
>  		return 0;
> +	/* Sockets can't be opened by open(). */
> +	if (f->f_path.dentry->d_inode &&
> +	    S_ISSOCK(f->f_path.dentry->d_inode->i_mode))
> +		return 0;
>  	return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path,
>  					    f->f_flags);
>  }
> 

