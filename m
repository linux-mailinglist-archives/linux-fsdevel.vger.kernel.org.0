Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6350D20F5DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 15:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgF3NiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 09:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgF3NiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:38:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079BAC061755;
        Tue, 30 Jun 2020 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=peNiu7obudJ+iIiHoebhj0Cx80UUqQKMz/3V6VsewcA=; b=OfGszqe3liARav2iSE515YirEx
        Rnqq9NA3fuI8sdsGAgobESsESiY51vgA7FJAtE7nA/mdf2yKvas0Wre3fDlcxa0AiDIRWiDQZ4/Le
        PPcntnez3mv8Otw7TG8VEuAHY7nKnbCiH13UrvVGGrnNYNdQIZxhscd/odT1lWDwV1aHMYRIoZ7wp
        EXVQA+L0Ai1FffXuWtoGkeISpyfPunrQcV1gy/602zLdFjQxzHGHK95DEs0Y+ZJ2foV0oRE8K2eki
        YL7fHzkJ9ZnyfXddig2AIiS5XQ2K0fp+mv6+0l4DFT+PGnICeJjFMwPARJldzwSa9tLr+wZNX7PQw
        142+hsbw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqGSY-0007s1-CQ; Tue, 30 Jun 2020 13:38:02 +0000
Date:   Tue, 30 Jun 2020 14:38:02 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 10/15] exec: Remove do_execve_file
Message-ID: <20200630133802.GA30093@infradead.org>
References: <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <87y2oac50p.fsf@x220.int.ebiederm.org>
 <87bll17ili.fsf_-_@x220.int.ebiederm.org>
 <87lfk54p0m.fsf_-_@x220.int.ebiederm.org>
 <20200630054313.GB27221@infradead.org>
 <87a70k21k0.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a70k21k0.fsf@x220.int.ebiederm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 30, 2020 at 07:14:23AM -0500, Eric W. Biederman wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > FYI, this clashes badly with my exec rework.  I'd suggest you
> > drop everything touching exec here for now, and I can then
> > add the final file based exec removal to the end of my series.
> 
> I have looked and I haven't even seen any exec work.  Where can it be
> found?
> 
> I have working and cleaning up exec for what 3 cycles now.  There is
> still quite a ways to go before it becomes possible to fix some of the
> deep problems in exec.  Removing all of these broken exec special cases
> is quite frankly the entire point of this patchset.
> 
> Sight unseen I suggest you send me your exec work and I can merge it
> into my branch if we are going to conflict badly.

https://lore.kernel.org/linux-fsdevel/20200627072704.2447163-1-hch@lst.de/T/#t
