Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A66522050C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGOGe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgGOGe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:34:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA66AC061755;
        Tue, 14 Jul 2020 23:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uhPc2J6glGI+RDlliWDq3XWJeCjKpR3A1WQFVmhZIBw=; b=iqnWMJ1IUFJiYzarQTP0Rd49hG
        Q2CSm1hkwddUk1VLFftC4UznnibgkB1spxve3NbIp4pRHH3eOHfdbcV+6pt9ZWXLBVHDq/7cxOdUd
        cjSj2kYQwvl+YvWzkoBQu82Ujw1kmWPxiAMpZuBQJ7axxmppkEh2xRanLkr2w/CGYLX1GiX/8BKXz
        5gmjQmCsk3eUw4WTZosg5ZjBjcriJ72OKFrMcDoc4/sna9rNpvTmYO7GPSOZ0tHoRipjzxo3EGe0L
        +BJ/lPgu1bBtJV0IZEloy7GocgXDDrrDVbssaCcIBbYH3KBPSjBy0hxdhPdimTZdMGXRrZNZIGC95
        m5SF1n9A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvb0K-0000mc-IN; Wed, 15 Jul 2020 06:34:56 +0000
Date:   Wed, 15 Jul 2020 07:34:56 +0100
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
Subject: Re: [PATCH 3/7] exec: Move initialization of bprm->filename into
 alloc_bprm
Message-ID: <20200715063456.GC32470@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87k0z66x8f.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0z66x8f.fsf@x220.int.ebiederm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:29:36AM -0500, Eric W. Biederman wrote:
>  
> -static struct linux_binprm *alloc_bprm(void)
> +static struct linux_binprm *alloc_bprm(int fd, struct filename *filename)
>  {
>  	struct linux_binprm *bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
> +	int retval = -ENOMEM;
>  	if (!bprm)
> -		return ERR_PTR(-ENOMEM);
> +		goto out;
> +

Ok, so here we add to it.   Two nitpicks:

The abose is missing a blank line after the declarations, which really
makes things more readable.  Also no need for the goto there.

Otherwisel ooks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
