Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECB252014F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 17:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbiEIPpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbiEIPoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 11:44:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380286321;
        Mon,  9 May 2022 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BWi0CMF33iSMPofX0Fh5cc+WLjna1ZWjd9XJJiUgbr8=; b=pU9OzLAJ0C18+Wp/OW1urFv7Ix
        bjs32y2b28IzDpQn93rbuwJ08wo6GMwvXe+1nbKpZU3NwGoo2r+tKQ+8Dk1LoBrHGYan/DfIl6uw8
        rTrwU+jryLWF69ku+7ZIYNsKLit4LUDne7J8CIPKprU7GXxe51wUe1ikuHC4azwgrZPvBBQ4ZPVSG
        25YQwLJ+ilH0TcCcfsufF+4kuMyde/D+OB5Put7w6TfjJ+OrCu6Bilhmv8ioHL4voXC52kn9AjOKF
        Rrq/l3EpicJG9yQ5KMEjiSJ7z3wtqxzalQ4bgbzdGuJMjSuWcI4i63Ba7NdEY3nrz9HnGpZ5PZhMn
        eudp3m1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1no5VC-003Zha-4f; Mon, 09 May 2022 15:40:50 +0000
Date:   Mon, 9 May 2022 16:40:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     CGEL <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
        zhang.yunkai@zte.com.cn
Subject: Re: [PATCH v5] mm/ksm: introduce ksm_force for each process
Message-ID: <Ynk2AsCEl1fk/WaS@casper.infradead.org>
References: <20220507105926.d4423601230f698b0f5228d1@linux-foundation.org>
 <20220508092710.930126-1-xu.xin16@zte.com.cn>
 <YngF+Lz01noCKRFc@casper.infradead.org>
 <6278bb5f.1c69fb81.e623f.215f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6278bb5f.1c69fb81.e623f.215f@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 06:57:33AM +0000, CGEL wrote:
> On Sun, May 08, 2022 at 07:03:36PM +0100, Matthew Wilcox wrote:
> > On Sun, May 08, 2022 at 09:27:10AM +0000, cgel.zte@gmail.com wrote:
> > > If ksm_force is set to 0, cancel the feature of ksm_force of this
> > > process and unmerge those merged pages belonging to VMAs which is not
> > > madvised as MADV_MERGEABLE of this process, but leave MADV_MERGEABLE
> > > areas merged.
> > 
> > Is that actually a useful feature?  Otherwise, we could simply turn
> > on/off the existing MMF_VM_MERGEABLE flag instead of introducing this
> > new bool.
> > 
> I think this will be very useful for those apps which are very likely to
> cause Same Pages in memory and users and operators are not willing to
> modified the source codes for any reasons.

No, you misunderstand.  Is it useful to have the "force KSM off"
functionality?  ie code which has been modified to allow KSM, but
then overridden by an admin?

> Besides, simply turning of/off the existing MMF_VM_MERGEABLE flag may be
> not feasible because madvise will also turn on the MMF_VM_MERGEABLE
> flag.
> 
> I think the following suggestions is good, and I will resend a patch.
> > > +Controlling KSM with procfs
> > > +===========================
> > > +
> > > +KSM can also operate on anonymous areas of address space of those processes's
> > > +knob ``/proc/<pid>/ksm_force`` is on, even if app codes doesn't call madvise()
> > > +explicitly to advise specific areas as MADV_MERGEABLE.
> > > +
> > > +You can set ksm_force to 1 to force all anonymous and qualified VMAs of
> > > +this process to be involved in KSM scanning. But It is effective only when the
> > > +klob of ``/sys/kernel/mm/ksm/run`` is set as 1.
> > 
> > I think that last sentence doesn't really add any value.
> > 
> > > +	memset(buffer, 0, sizeof(buffer));
> > > +	if (count > sizeof(buffer) - 1)
> > > +		count = sizeof(buffer) - 1;
> > > +	if (copy_from_user(buffer, buf, count)) {
> > > +		err = -EFAULT;
> > > +		goto out_return;
> > 
> > This feels a bit unnecessary.  Just 'return -EFAULT' here.
> > 
> > > +	}
> > > +
> > > +	err = kstrtoint(strstrip(buffer), 0, &force);
> > > +
> > > +	if (err)
> > > +		goto out_return;
> > 
> > 'return err'
> > 
> > > +	if (force != 0 && force != 1) {
> > > +		err = -EINVAL;
> > > +		goto out_return;
> > 
> > 'return -EINVAL'
> > 
> > > +	}
> > > +
> > > +	task = get_proc_task(file_inode(file));
> > > +	if (!task) {
> > > +		err = -ESRCH;
> > > +		goto out_return;
> > 
> > 'return -ESRCH'
