Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B112C2204FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgGOGa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgGOGa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:30:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E1AC061755;
        Tue, 14 Jul 2020 23:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r0wE0kKISq3y6WdfQiUstnsJXuDxiAGovj0hASJMFfE=; b=N2d4js9JulVPjeClHP3KJx58DY
        aBkaV3x6UFK7ji0ycsQ9kqJ9NcrnHd7Rx0Uoxldq0PYPJz2egVCxR7944JXvPQxGgZZ5o+Rx4ENhm
        v6mi60kGO7JSiveVSTLX/CPqoMB2k2tt3OKvqZ1duK3FkmajIl3JY+XGFzzX7DyjscfLyb++pwcXi
        4pfxcAwesl2DTNeLX+bus33DYCNZ6u34aA5nQF8LjPbW/YpIzHE7LRdlt3rbTq2ATQJQdmB6o4pmf
        QECaEd8o9C6xgJGqwOAllKqkDDZG9uUapxtmLyma1K3+4sVZcuHK2xoX2vg6Ul3F+xtZSpr+YlvH8
        uz5JuCQA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvavx-0000gM-EZ; Wed, 15 Jul 2020 06:30:25 +0000
Date:   Wed, 15 Jul 2020 07:30:25 +0100
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
Subject: Re: [PATCH 2/7] exec: Factor out alloc_bprm
Message-ID: <20200715063025.GB32470@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87pn8y6x9a.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn8y6x9a.fsf@x220.int.ebiederm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:29:05AM -0500, Eric W. Biederman wrote:
> 
> Currently it is necessary for the usermode helper code and the code
> that launches init to use set_fs so that pages coming from the kernel
> look like they are coming from userspace.
> 
> To allow that usage of set_fs to be removed cleanly the argument
> copying from userspace needs to happen earlier.  Move the allocation
> of the bprm into it's own function (alloc_bprm) and move the call of
> alloc_bprm before unshare_files so that bprm can ultimately be
> allocated, the arguments can be placed on the new stack, and then the
> bprm can be passed into the core of exec.
> 
> Neither the allocation of struct binprm nor the unsharing depend upon each
> other so swapping the order in which they are called is trivially safe.
> 
> To keep things consistent the order of cleanup at the end of
> do_execve_common swapped to match the order of initialization.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/exec.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 23dfbb820626..526156d6461d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1560,6 +1560,14 @@ static void free_bprm(struct linux_binprm *bprm)
>  	kfree(bprm);
>  }
>  
> +static struct linux_binprm *alloc_bprm(void)
> +{
> +	struct linux_binprm *bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
> +	if (!bprm)
> +		return ERR_PTR(-ENOMEM);
> +	return bprm;

Unless this helper grows later I really don't see the point of it.
Also a NULL return vs ERR_PTR would simplify this a bit (again unless
this grows more code later with different return codes, but then again
it might make sense to only add the helper once it becomes useful).

The actual allocation order move looks fine, though.
