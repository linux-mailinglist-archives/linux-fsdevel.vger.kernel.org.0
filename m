Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D458E1C6399
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 00:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgEEWDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 18:03:31 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53243 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgEEWDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 18:03:31 -0400
Received: by mail-pj1-f65.google.com with SMTP id a5so222061pjh.2;
        Tue, 05 May 2020 15:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lpi8MZJNSPhbvdnHwiB6LcQYNoz5iZcaJ91eFfyKq3I=;
        b=geI9MTUj1lyPkZ6fBPt5FJYeshQsIPP/s+oHHztUNcJj7IdUqMo+evq4LFpdUQivEa
         lSRzjWEebJ/u1iWrI+1AsjhUNwYOaSDTiAbXF21NkuNX0q1iAWn1naq4U1+yaH1trPsf
         Hd5Hv58GIHH7+Y2Z2JROXAiCP62yt1RjcqsKfaRXtn1vh5Nx/iA8Vh66cJCgnkzNqomy
         VxDIIeaFEKuRtXrs6w4xx3BlI5/UNwjGee2LaY6j4ZHECp2vKu4XsbH7+bqPJvEeAAcC
         iFPbAmVIGtNAp8dbXOEE3oxc0woIneqcpg4i+qPcmTjcrmEjzbXEbDBMC7ocGs6gsHsf
         zaUA==
X-Gm-Message-State: AGi0PuaI+bfXcfyeEtAqflMDmrsiPPI//nVDfM0ejAvPB7zWVx8JGeDE
        NLGVNVrnNwy+9sv0aJp/B/A=
X-Google-Smtp-Source: APiQypIlQ7vp+PigyBUJjXs2IzjQDASyZB2j0a3df8Yc3dcT5dEuIN8kzQWJl3UYEKmIcOD1rDvh5g==
X-Received: by 2002:a17:90a:3ace:: with SMTP id b72mr5651418pjc.48.1588716209523;
        Tue, 05 May 2020 15:03:29 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b73sm9201pfb.52.2020.05.05.15.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 15:03:28 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5616C403EA; Tue,  5 May 2020 22:03:27 +0000 (UTC)
Date:   Tue, 5 May 2020 22:03:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Make sure proc handlers can't expose heap memory
Message-ID: <20200505220327.GV11244@42.do-not-panic.com>
References: <202005041205.C7AF4AF@keescook>
 <20200504195937.GS11244@42.do-not-panic.com>
 <202005041329.169799C65D@keescook>
 <20200504215903.GT11244@42.do-not-panic.com>
 <20200505063441.GA3877399@kroah.com>
 <202005051339.5F1979C4DF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005051339.5F1979C4DF@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 01:41:44PM -0700, Kees Cook wrote:
> On Tue, May 05, 2020 at 08:34:41AM +0200, Greg KH wrote:
> > On Mon, May 04, 2020 at 09:59:03PM +0000, Luis Chamberlain wrote:
> > > On Mon, May 04, 2020 at 01:32:07PM -0700, Kees Cook wrote:
> > > > On Mon, May 04, 2020 at 07:59:37PM +0000, Luis Chamberlain wrote:
> > > > > On Mon, May 04, 2020 at 12:08:55PM -0700, Kees Cook wrote:
> > > > > > Just as a precaution, make sure that proc handlers don't accidentally
> > > > > > grow "count" beyond the allocated kbuf size.
> > > > > > 
> > > > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > > > ---
> > > > > > This applies to hch's sysctl cleanup tree...
> > > > > > ---
> > > > > >  fs/proc/proc_sysctl.c | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > > 
> > > > > > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > > > > > index 15030784566c..535ab26473af 100644
> > > > > > --- a/fs/proc/proc_sysctl.c
> > > > > > +++ b/fs/proc/proc_sysctl.c
> > > > > > @@ -546,6 +546,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
> > > > > >  	struct inode *inode = file_inode(filp);
> > > > > >  	struct ctl_table_header *head = grab_header(inode);
> > > > > >  	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> > > > > > +	size_t count_max = count;
> > > > > >  	void *kbuf;
> > > > > >  	ssize_t error;
> > > > > >  
> > > > > > @@ -590,6 +591,8 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
> > > > > >  
> > > > > >  	if (!write) {
> > > > > >  		error = -EFAULT;
> > > > > > +		if (WARN_ON(count > count_max))
> > > > > > +			count = count_max;
> > > > > 
> > > > > That would crash a system with panic-on-warn. I don't think we want that?
> > > > 
> > > > Eh? None of the handlers should be making this mistake currently and
> > > > it's not a mistake that can be controlled from userspace. WARN() is
> > > > absolutely what's wanted here: report an impossible situation (and
> > > > handle it gracefully for the bulk of users that don't have
> > > > panic_on_warn set).
> > > 
> > > Alrighty, Greg are you OK with this type of WARN_ON()? You recently
> > > expressed concerns over its use due to panic-on-warn on another patch.
> > 
> > We should never call WARN() on any path that a user can trigger.
> > 
> > If it is just a "the developer called this api in a foolish way" then we
> > could use a WARN_ON() to have them realize their mistake, but in my
> > personal experience, foolish developers don't even notice that kind of
> > mistake :(
> 
> Right -- while it'd be nice if the developer noticed it, it is _usually_
> an unsuspecting end user (or fuzzer), in which case we absolutely want a
> WARN (and not a BUG![1]) and have the situations handled gracefully, so
> it can be reported and fixed.

I've been using WARN*() for this exact purpose before, so I am as
surprised as you are bout these concerns. However if we have folks
shipping with panic-on-warn this would be rather detrimental to our
goals.

Greg, are you aware of folks shipping with panic-on-warn on some products?

  Luis
