Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FDD1C494C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 23:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgEDV7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 17:59:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38037 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgEDV7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 17:59:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id l25so52208pgc.5;
        Mon, 04 May 2020 14:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9oGAxfJ31YDqUrHQ7flisYymPnWje1IHIwZimDQO4UU=;
        b=BETCIwURUHvzkVZMhsGh6wpEr34Nu8OYLBlk1xGNxsDo5sqtkHVG3751LGGFLu+PEz
         uoqV1mxWzn6QShu3Lw/WxT8jdcF7fDERA9M+4r+Dpl/8sUc2A7ezhd1rvGXwyN0hV15x
         wc8LoYzyjENd9Dwkjhqz8XzgzDpiot7ybuh/6gr3wuL14Ucvx8qbJRbi/fJqkPO6fFW6
         Dx3l7oL+C4nf/069afxir669xBPLEr/poKxbXLPbmnxKulMBzth8NgaK4DOpnyzqE7F3
         3gA9jPxt0jJg/9U/sF50O31d5xczi+wzjLXC7A1mP3x6G22/8Kbgce0LJpKpqK22IqZR
         DFlg==
X-Gm-Message-State: AGi0PuYWmalnLmqKNICZLQCI3LtejTDijEm8biSmQOGk6ym3GbxPT3TR
        zhUunZThxExCIOrlAzlz81o=
X-Google-Smtp-Source: APiQypLULqzB9DO3Xon+UOV9dq9Wzzr80GGKDKMfMwtr6KGaykpNjr9vUL3nYX52F6TTo7p4VCsCFg==
X-Received: by 2002:a63:6747:: with SMTP id b68mr319344pgc.142.1588629545107;
        Mon, 04 May 2020 14:59:05 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r128sm50579pfc.141.2020.05.04.14.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 14:59:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 43401403EA; Mon,  4 May 2020 21:59:03 +0000 (UTC)
Date:   Mon, 4 May 2020 21:59:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Make sure proc handlers can't expose heap memory
Message-ID: <20200504215903.GT11244@42.do-not-panic.com>
References: <202005041205.C7AF4AF@keescook>
 <20200504195937.GS11244@42.do-not-panic.com>
 <202005041329.169799C65D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005041329.169799C65D@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 01:32:07PM -0700, Kees Cook wrote:
> On Mon, May 04, 2020 at 07:59:37PM +0000, Luis Chamberlain wrote:
> > On Mon, May 04, 2020 at 12:08:55PM -0700, Kees Cook wrote:
> > > Just as a precaution, make sure that proc handlers don't accidentally
> > > grow "count" beyond the allocated kbuf size.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > This applies to hch's sysctl cleanup tree...
> > > ---
> > >  fs/proc/proc_sysctl.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > > index 15030784566c..535ab26473af 100644
> > > --- a/fs/proc/proc_sysctl.c
> > > +++ b/fs/proc/proc_sysctl.c
> > > @@ -546,6 +546,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
> > >  	struct inode *inode = file_inode(filp);
> > >  	struct ctl_table_header *head = grab_header(inode);
> > >  	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> > > +	size_t count_max = count;
> > >  	void *kbuf;
> > >  	ssize_t error;
> > >  
> > > @@ -590,6 +591,8 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
> > >  
> > >  	if (!write) {
> > >  		error = -EFAULT;
> > > +		if (WARN_ON(count > count_max))
> > > +			count = count_max;
> > 
> > That would crash a system with panic-on-warn. I don't think we want that?
> 
> Eh? None of the handlers should be making this mistake currently and
> it's not a mistake that can be controlled from userspace. WARN() is
> absolutely what's wanted here: report an impossible situation (and
> handle it gracefully for the bulk of users that don't have
> panic_on_warn set).

Alrighty, Greg are you OK with this type of WARN_ON()? You recently
expressed concerns over its use due to panic-on-warn on another patch.

  LUis
