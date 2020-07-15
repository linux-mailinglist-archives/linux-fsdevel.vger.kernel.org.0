Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C60220510
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGOGfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgGOGfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:35:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CACC061755;
        Tue, 14 Jul 2020 23:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qSg+PUUB7zK5a9dQGwJP247iiVUMgqkLMGBe7H5+8IA=; b=Hg0tU0+yfdK1zhN7ROWTj8tohj
        eB/xJBNswDsFwk5dn+wlkCV6rvCNV7E2VsACe+fx8KzGxvXPXZAeHkZ4bilECeZFumrz/zh6xB0jH
        FzItDU4fuuMkS0+i5VmBkEIGKyd79ePHlbcC5bc56Vn1GVFEy5nD8+LrK6Eif6rXZng9MoLAT+5l+
        z4uDj/4SJiQI4i3gH20Xr7TiV61oWc/MsVzWwU3PsVwKjIU5xSKTUJJenuRpscCOcGoQaF9NruPdk
        UO7Lqz5TR2vmrDxdA6UVTuZjrk4k4kxmmkAILKCZI8QRYfgYnZigkkQrtDRDnyc5eWBY+/kDriIEg
        mnJUc6Pw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvb0d-0000sE-OZ; Wed, 15 Jul 2020 06:35:15 +0000
Date:   Wed, 15 Jul 2020 07:35:15 +0100
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
Subject: Re: [PATCH 4/7] exec: Move bprm_mm_init into alloc_bprm
Message-ID: <20200715063515.GD32470@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87eepe6x7p.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eepe6x7p.fsf@x220.int.ebiederm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:30:02AM -0500, Eric W. Biederman wrote:
> 
> Currently it is necessary for the usermode helper code and the code that
> launches init to use set_fs so that pages coming from the kernel look like
> they are coming from userspace.
> 
> To allow that usage of set_fs to be removed cleanly the argument copying
> from userspace needs to happen earlier.  Move the allocation and
> initialization of bprm->mm into alloc_bprm so that the bprm->mm is
> available early to store the new user stack into.  This is a prerequisite
> for copying argv and envp into the new user stack early before ther rest of
> exec.
> 
> To keep the things consistent the cleanup of bprm->mm is moved into
> free_bprm.  So that bprm->mm will be cleaned up whenever bprm->mm is
> allocated and free_bprm are called.
> 
> Moving bprm_mm_init earlier is safe as it does not depend on any files,
> current->in_execve, current->fs->in_exec, bprm->unsafe, or the if the file
> table is shared. (AKA bprm_mm_init does not depend on any of the code that
> happens between alloc_bprm and where it was previously called.)
> 
> This moves bprm->mm cleanup after current->fs->in_exec is set to 0.  This
> is safe because current->fs->in_exec is only used to preventy taking an
> additional reference on the fs_struct.
> 
> This moves bprm->mm cleanup after current->in_execve is set to 0.  This is
> safe because current->in_execve is only used by the lsms (apparmor and
> tomoyou) and always for LSM specific functions, never for anything to do
> with the mm.
> 
> This adds bprm->mm cleanup into the successful return path.  This is safe
> because being on the successful return path implies that begin_new_exec
> succeeded and set brpm->mm to NULL.  As bprm->mm is NULL bprm cleanup I am
> moving into free_bprm will do nothing.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
