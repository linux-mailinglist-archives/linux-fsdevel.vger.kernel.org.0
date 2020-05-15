Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D91D54DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgEOPhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 11:37:13 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56988 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOPhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 11:37:12 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04FFaX5p011041;
        Sat, 16 May 2020 00:36:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Sat, 16 May 2020 00:36:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04FFaXJU011017
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 16 May 2020 00:36:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: linux-next boot error: general protection fault in
 tomoyo_get_local_path
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0000000000002f0c7505a5b0e04c@google.com>
 <c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp>
Message-ID: <72cb7aea-92bd-d71b-2f8a-63881a35fad8@i-love.sakura.ne.jp>
Date:   Sat, 16 May 2020 00:36:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/05/16 0:18, Tetsuo Handa wrote:
> This is
> 
>         if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
>                 char *ep;
>                 const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
>                 struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry)); // <= here
> 
>                 if (*ep == '/' && pid && pid ==
>                     task_tgid_nr_ns(current, proc_pidns)) {
> 
> which was added by commit c59f415a7cb6e1e1 ("Use proc_pid_ns() to get pid_namespace from the proc superblock").
> 
> @@ -161,9 +162,10 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
>         if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
>                 char *ep;
>                 const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);
> +               struct pid_namespace *proc_pidns = proc_pid_ns(d_inode(dentry));
> 
>                 if (*ep == '/' && pid && pid ==
> -                   task_tgid_nr_ns(current, sb->s_fs_info)) {
> +                   task_tgid_nr_ns(current, proc_pidns)) {
>                         pos = ep - 5;
>                         if (pos < buffer)
>                                 goto out;
> 
> Alexey and Eric, any clue?
> 

A similar bug (racing inode destruction with open() on proc filesystem) was fixed as
commit 6f7c41374b62fd80 ("tomoyo: Don't use nifty names on sockets."). Then, it might
not be safe to replace dentry->d_sb->s_fs_info with dentry->d_inode->i_sb->s_fs_info .
