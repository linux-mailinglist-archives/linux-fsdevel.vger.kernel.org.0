Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2C93FA7EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 00:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhH1WYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 18:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhH1WYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 18:24:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF473C061756;
        Sat, 28 Aug 2021 15:23:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630189426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5baxkRt6FRyNR9NaORfg0w1u2EC3Afc4IwvC+mzssI=;
        b=ya9EcwyYkE0CPACg9mqhH69MrCoxvtcfYUqNOVM5q3ehhgRT3td05EBy3ZMp+PuTVhWJ40
        rpBKMkXq8TOmt8hAhbT9I474UC9yxt8ZXBNTulUXkY6MMAI7yUNjYmhVDjm4x4n3Gkc92H
        RPnf0SXPrlkAATkwqwysNabdzj4SD4bb/xR63ZXeenc4qyrxnoX2V4GXGpoja2q879+xvc
        gxD4bhWix+AZYVS0Bc450GsWtEJckAKsZphfE5giSRbgSlSXT6d5+ZeeDC8rw+pVAbfunX
        zmjdEFurBUUmQDqirdvPzSCKutMacgLTmoJpBeKM/YYOAxUUOvw9ApnnnSMzKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630189426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5baxkRt6FRyNR9NaORfg0w1u2EC3Afc4IwvC+mzssI=;
        b=qq8/oe9XX24Pwfmj4Nd8xIS/Zne8QvcBxBVYjviiFrqkveI5UkPagjOqx75vs02MlVC/pz
        L1isaALRXnikNZAA==
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
In-Reply-To: <YSqy+U/3lnF6K0ia@zeniv-ca.linux.org.uk>
References: <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
 <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
 <87r1edgs2w.ffs@tglx> <YSqy+U/3lnF6K0ia@zeniv-ca.linux.org.uk>
Date:   Sun, 29 Aug 2021 00:23:45 +0200
Message-ID: <87o89hgqdq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 28 2021 at 22:04, Al Viro wrote:

> On Sat, Aug 28, 2021 at 11:47:03PM +0200, Thomas Gleixner wrote:
>
>>   /* Try to handle #PF, but anything else is fatal. */
>>   if (ret != -EFAULT)
>>      return -EINVAL;
>
>> which all end up in user_insn(). user_insn() returns 0 or the negated
>> trap number, which results in -EFAULT for #PF, but for #MC the negated
>> trap number is -18 i.e. != -EFAULT. IOW, there is no endless loop.
>> 
>> This used to be a problem before commit:
>> 
>>   aee8c67a4faa ("x86/fpu: Return proper error codes from user access functions")
>> 
>> and as the changelog says the initial reason for this was #GP going into
>> the fault path, but I'm pretty sure that I also discussed the #MC angle with
>> Borislav back then. Should have added some more comments there
>> obviously.
>
> ... or at least have that check spelled
>
> 	if (ret != -X86_TRAP_PF)
> 		return -EINVAL;
>
> Unless I'm misreading your explanation, that is...

Yes, that makes a lot of sense.
