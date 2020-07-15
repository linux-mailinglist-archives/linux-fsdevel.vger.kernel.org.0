Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22D220547
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgGOGmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgGOGmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:42:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6767CC061755;
        Tue, 14 Jul 2020 23:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kz6Ak33oyFzyD23XorNXlpEv5q052OBbABEdxzvwO+Q=; b=n6VpENxN5faEQqQNSiErYDeQ6c
        l4eMYJXTm1vJ2IuMWv1S5IetbsVQCSJ66TCyW0ZhhDVaegB+CkMF48SSW20QCRMTy8tWZk4jZKfbp
        KIDXEjO/QsZAMXoGak1csvjhqTWc6ZF0rJ4iVCqjRi8TKDPjhRE67+6cmLIZ9ucAtsMPXLvJ3EioJ
        hcmQYotgCoH5DmaPIB+mnAQ4Ul2AuBqbhGwTKOBCQKl08f70g5ePEYZ+0u3uAWBVFmLd/W/1y9Q2D
        83mYzpgK0jzhMQQlCEQ77wzb/bxyDqq5p0+pBsRVupAOOMhq4vOdPivK8VparG8FYz4xRQACzEzcB
        lzN8jZTQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvb7U-00019G-Pb; Wed, 15 Jul 2020 06:42:20 +0000
Date:   Wed, 15 Jul 2020 07:42:20 +0100
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
Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
Message-ID: <20200715064220.GG32470@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87wo365ikj.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo365ikj.fsf@x220.int.ebiederm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static int count_strings_kernel(const char *const *argv)
> +{
> +	int i;
> +
> +	if (!argv)
> +		return 0;
> +
> +	for (i = 0; argv[i]; ++i) {
> +		if (i >= MAX_ARG_STRINGS)
> +			return -E2BIG;
> +		if (fatal_signal_pending(current))
> +			return -ERESTARTNOHAND;
> +		cond_resched();

I don't think we need a fatal_signal_pending and cond_resched() is
needed in each step given that we don't actually do anything.
