Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AAA220517
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgGOGgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgGOGgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:36:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B982C061755;
        Tue, 14 Jul 2020 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=STmyOs89LxpHb0F5OSNudUiRFW9c2EcqkeFgYnLnB1A=; b=ENl0X2JwlMxf23fbyDEM8eNMYl
        Vk2BFPtR9vmA8sWddmuCAh/dj5rGn9JNsJMBuePy5Jq/lOv9bVylQ6Dq2oZmcJmB0SnBvnsD0AfOk
        0SSABCGaK8C0cnVVm+TldlGJ6+Bf9WU83lrUF3lnZ0BT+uHQoRG5Xb/0X2PflbRBTo2PKs2Rycd8I
        /v0ECpj4mYRV994DI6S5LWNETsQGCij1SZ53AedFAD9LOQtMdjwxFobBX3D8OuuheiwYXY/TTSVMK
        18Lc0Mzaz4fbO63clZiaHN8Q3yTHROV94rMOMjic5FYBMF80UyodcWHrmGudf3d6WYxJd3OCtWbek
        JIJNhETQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvb1p-0000vA-Id; Wed, 15 Jul 2020 06:36:29 +0000
Date:   Wed, 15 Jul 2020 07:36:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/7] exec: Factor bprm_execve out of do_execve_common
Message-ID: <20200715063629.GE32470@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <878sfm6x6x.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sfm6x6x.fsf@x220.int.ebiederm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:30:30AM -0500, Eric W. Biederman wrote:
> 
> Currently it is necessary for the usermode helper code and the code
> that launches init to use set_fs so that pages coming from the kernel
> look like they are coming from userspace.
> 
> To allow that usage of set_fs to be removed cleanly the argument
> copying from userspace needs to happen earlier.  Factor bprm_execve
> out of do_execve_common to separate out the copying of arguments
> to the newe stack, and the rest of exec.
> 
> In separating bprm_execve from do_execve_common the copying
> of the arguments onto the new stack happens earlier.
> 
> As the copying of the arguments does not depend any security hooks,
> files, the file table, current->in_execve, current->fs->in_exec,
> bprm->unsafe, or creds this is safe.
> 
> Likewise the security hook security_creds_for_exec does not depend upon
> preventing the argument copying from happening.
> 
> In addition to making it possible to implement kernel_execve that
> performs the copying differently, this separation of bprm_execve from
> do_execve_common makes for a nice separation of responsibilities making
> the exec code easier to navigate.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/exec.c | 108 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 58 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index afb168bf5e23..50508892fa71 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1856,44 +1856,16 @@ static int exec_binprm(struct linux_binprm *bprm)
>  /*
>   * sys_execve() executes a new program.
>   */
> -static int do_execveat_common(int fd, struct filename *filename,
> -			      struct user_arg_ptr argv,
> -			      struct user_arg_ptr envp,
> -			      int flags)
> +static int bprm_execve(struct linux_binprm *bprm,
> +		       int fd, struct filename *filename, int flags)

int fd easily fits onto the previous line.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
