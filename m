Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD951F51A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiEIHEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 03:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiEIHBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 03:01:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4DA17EC22;
        Sun,  8 May 2022 23:57:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e5so11255747pgc.5;
        Sun, 08 May 2022 23:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=i42mRfc6plgwDr9xKkcbZKYxsl3MvEdsg2vyK92DFBY=;
        b=DwZe/s3uWRJgcaeMctfYp2UapVP0ZJbieh0Cf0MMg+Xm9N/zvZko2LVRzEPTr41dkL
         ueFUwuj3igd/tk9ZyDmud1M4mLC5em43QBFALnEhPQxvWejUlyoWonEFzHcjquCGvzd3
         AhJcXBIxHkuVUEJh60tO2d/BOc0Jn2tXToGtulzMmF4CjmkxMDr1GHNjueaDwbXT2EjD
         9bPJw82HWTKbdSObcRRiICsowqse3RUVFW4unbx26/od3QXMU1++SXiWXHwnQto5e+2n
         TbkryukAUxE8a6t8Rh8JCFkgqMZwCsO7bhio9UrXPl6WTcafpBBa9Wdhi6y8uZRIHnM/
         Ct3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=i42mRfc6plgwDr9xKkcbZKYxsl3MvEdsg2vyK92DFBY=;
        b=wP1QFYHp32GcF9mM5gAwkOYqCvUX3L87Ldoa0fVbQHI53YeSMENh89VrI46Rr/CP5h
         acCn217MiOvDFULh8cX4S5OcWAjueizobljc0UQ/T8I84pY25vxQaD/h20dim9xy34mg
         V199vaupcPz+CY/AVvk8Z5VsFmVRxkHJ0Cxxg/vfStmqoQe24agXCk8udDa9rqcdAfjh
         KZR7gRcLIW3rnABBivoXGmGcNjNHuoVaYjOZTfnJ3zyHl0AI8LNh2TBHPwmhJj4kJHhn
         yESxjlIto8dSbBFjhFqb09bffssm0T4DZvofM57Wfwh0UPz98mgHo6NGW0K2NTJ5ED57
         vq+g==
X-Gm-Message-State: AOAM532V5/hUNOkIM71FRfpw5W8HtldCID4CfOcAUbvIvNN3WvNQYx2h
        f7/2IxF0XtOPVualzkyUqwQ=
X-Google-Smtp-Source: ABdhPJyd2/9ww/c4Z2dEtoofDbc8dDsoh6d7YAJU7ovdjn12+kfHvrJl5xpUxH8nUsxkHai99UxerQ==
X-Received: by 2002:a63:531c:0:b0:3c6:a5d7:8bae with SMTP id h28-20020a63531c000000b003c6a5d78baemr4931710pgb.505.1652079456203;
        Sun, 08 May 2022 23:57:36 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t15-20020a6549cf000000b003c14af50621sm7770378pgs.57.2022.05.08.23.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 23:57:35 -0700 (PDT)
Message-ID: <6278bb5f.1c69fb81.e623f.215f@mx.google.com>
X-Google-Original-Message-ID: <20220509065733.GB1109788@cgel.zte@gmail.com>
Date:   Mon, 9 May 2022 06:57:33 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
        zhang.yunkai@zte.com.cn
Subject: Re: [PATCH v5] mm/ksm: introduce ksm_force for each process
References: <20220507105926.d4423601230f698b0f5228d1@linux-foundation.org>
 <20220508092710.930126-1-xu.xin16@zte.com.cn>
 <YngF+Lz01noCKRFc@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YngF+Lz01noCKRFc@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 08, 2022 at 07:03:36PM +0100, Matthew Wilcox wrote:
> On Sun, May 08, 2022 at 09:27:10AM +0000, cgel.zte@gmail.com wrote:
> > If ksm_force is set to 0, cancel the feature of ksm_force of this
> > process and unmerge those merged pages belonging to VMAs which is not
> > madvised as MADV_MERGEABLE of this process, but leave MADV_MERGEABLE
> > areas merged.
> 
> Is that actually a useful feature?  Otherwise, we could simply turn
> on/off the existing MMF_VM_MERGEABLE flag instead of introducing this
> new bool.
> 
I think this will be very useful for those apps which are very likely to
cause Same Pages in memory and users and operators are not willing to
modified the source codes for any reasons.

Besides, simply turning of/off the existing MMF_VM_MERGEABLE flag may be
not feasible because madvise will also turn on the MMF_VM_MERGEABLE
flag.

I think the following suggestions is good, and I will resend a patch.
> > +Controlling KSM with procfs
> > +===========================
> > +
> > +KSM can also operate on anonymous areas of address space of those processes's
> > +knob ``/proc/<pid>/ksm_force`` is on, even if app codes doesn't call madvise()
> > +explicitly to advise specific areas as MADV_MERGEABLE.
> > +
> > +You can set ksm_force to 1 to force all anonymous and qualified VMAs of
> > +this process to be involved in KSM scanning. But It is effective only when the
> > +klob of ``/sys/kernel/mm/ksm/run`` is set as 1.
> 
> I think that last sentence doesn't really add any value.
> 
> > +	memset(buffer, 0, sizeof(buffer));
> > +	if (count > sizeof(buffer) - 1)
> > +		count = sizeof(buffer) - 1;
> > +	if (copy_from_user(buffer, buf, count)) {
> > +		err = -EFAULT;
> > +		goto out_return;
> 
> This feels a bit unnecessary.  Just 'return -EFAULT' here.
> 
> > +	}
> > +
> > +	err = kstrtoint(strstrip(buffer), 0, &force);
> > +
> > +	if (err)
> > +		goto out_return;
> 
> 'return err'
> 
> > +	if (force != 0 && force != 1) {
> > +		err = -EINVAL;
> > +		goto out_return;
> 
> 'return -EINVAL'
> 
> > +	}
> > +
> > +	task = get_proc_task(file_inode(file));
> > +	if (!task) {
> > +		err = -ESRCH;
> > +		goto out_return;
> 
> 'return -ESRCH'
