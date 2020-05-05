Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870931C6233
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 22:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgEEUlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 16:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEEUlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 16:41:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01EBC061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 13:41:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s18so1550205pgl.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 13:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TBeTodJwY1sbypPr0O4/M7Oc5AId4qrDzBRpp3D+bWw=;
        b=XU6X9GMe8j4wKq96hvrcdX1ByQHmmyBW7U6O/ETyAHaaOeuNGkQLdp5aHsi+ZYAg/n
         ToTVv9P6DfvsQWmACbq/7EkvxkgQBisVFC+Cuteh8eSBPa0l95XCST9S/53ATidKpelR
         BE5pJ6fNUlqYODQ8vfoK3eOaI1hndoAxJQXJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TBeTodJwY1sbypPr0O4/M7Oc5AId4qrDzBRpp3D+bWw=;
        b=nFYym0A0+4I3VNAubUWiO2dgGJ0Yy4vxiKU7CLT2mFSRNfDqnjEeRsqCnJiLOUx/Nn
         fG3wGBFYUYmt0I4zzmKwAuoTpga6AK/AUUqvp76MsRuA711G50W8r9XAngbVScqjAT/H
         sJMD5LdmXZBlPnfFMrTbCL0I9XJjhsjfvHIc5p3BlQHTuly5tbeg3x5IqTI6jPD3HY48
         +sE35Mz1XQvf98liHPakCjAK9+5hRDrFLFvn1BZZaaJ2Q9JMOiC9IRbvrPvepOzN5Vxw
         JMpLzyF1m8vKTR3c1ACJ3xRsGMoUrMml0j4VEQXPntELZv9Y7eN9HR/kTQjz524pi8wI
         AyUA==
X-Gm-Message-State: AGi0PubSMpqKVzfBbJ4Def5T+gBUed9mxxluxHvvtxffxcnfxLbKllIQ
        81yXdEf8PW9a+hf+hLzDf6rQQA==
X-Google-Smtp-Source: APiQypKneSUsTTVo+yZKgZiaXfs8Cdo88B6bTaJHGjy6DGrc5Y7iwWPQe9ZysHr3aN4qrrZAuhv8sQ==
X-Received: by 2002:a62:d005:: with SMTP id p5mr5183995pfg.156.1588711306249;
        Tue, 05 May 2020 13:41:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g16sm2726879pfq.203.2020.05.05.13.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:41:45 -0700 (PDT)
Date:   Tue, 5 May 2020 13:41:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Make sure proc handlers can't expose heap memory
Message-ID: <202005051339.5F1979C4DF@keescook>
References: <202005041205.C7AF4AF@keescook>
 <20200504195937.GS11244@42.do-not-panic.com>
 <202005041329.169799C65D@keescook>
 <20200504215903.GT11244@42.do-not-panic.com>
 <20200505063441.GA3877399@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505063441.GA3877399@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 08:34:41AM +0200, Greg KH wrote:
> On Mon, May 04, 2020 at 09:59:03PM +0000, Luis Chamberlain wrote:
> > On Mon, May 04, 2020 at 01:32:07PM -0700, Kees Cook wrote:
> > > On Mon, May 04, 2020 at 07:59:37PM +0000, Luis Chamberlain wrote:
> > > > On Mon, May 04, 2020 at 12:08:55PM -0700, Kees Cook wrote:
> > > > > Just as a precaution, make sure that proc handlers don't accidentally
> > > > > grow "count" beyond the allocated kbuf size.
> > > > > 
> > > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > > ---
> > > > > This applies to hch's sysctl cleanup tree...
> > > > > ---
> > > > >  fs/proc/proc_sysctl.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > > > > index 15030784566c..535ab26473af 100644
> > > > > --- a/fs/proc/proc_sysctl.c
> > > > > +++ b/fs/proc/proc_sysctl.c
> > > > > @@ -546,6 +546,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
> > > > >  	struct inode *inode = file_inode(filp);
> > > > >  	struct ctl_table_header *head = grab_header(inode);
> > > > >  	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> > > > > +	size_t count_max = count;
> > > > >  	void *kbuf;
> > > > >  	ssize_t error;
> > > > >  
> > > > > @@ -590,6 +591,8 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
> > > > >  
> > > > >  	if (!write) {
> > > > >  		error = -EFAULT;
> > > > > +		if (WARN_ON(count > count_max))
> > > > > +			count = count_max;
> > > > 
> > > > That would crash a system with panic-on-warn. I don't think we want that?
> > > 
> > > Eh? None of the handlers should be making this mistake currently and
> > > it's not a mistake that can be controlled from userspace. WARN() is
> > > absolutely what's wanted here: report an impossible situation (and
> > > handle it gracefully for the bulk of users that don't have
> > > panic_on_warn set).
> > 
> > Alrighty, Greg are you OK with this type of WARN_ON()? You recently
> > expressed concerns over its use due to panic-on-warn on another patch.
> 
> We should never call WARN() on any path that a user can trigger.
> 
> If it is just a "the developer called this api in a foolish way" then we
> could use a WARN_ON() to have them realize their mistake, but in my
> personal experience, foolish developers don't even notice that kind of
> mistake :(

Right -- while it'd be nice if the developer noticed it, it is _usually_
an unsuspecting end user (or fuzzer), in which case we absolutely want a
WARN (and not a BUG![1]) and have the situations handled gracefully, so
it can be reported and fixed.

-Kees

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

-- 
Kees Cook
