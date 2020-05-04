Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD6F1C4855
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgEDUcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 16:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgEDUcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 16:32:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E9BC061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2020 13:32:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so490104pjh.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/vbL5b//yF/QRmFP+MoSE68BAHXcNHhnOpnaTu3IOJk=;
        b=a5TSD9pfl0Wo9vabYLrSXLxTVVKU66mKWR1tH0UvpYG1h/isiZjp2UEyo5ad63Um08
         h7U/FeUjdcQju5xb2dOuvC2a9NIkOwmo/5mWo2S4cXMs8Ofsfh40SfMzVwiu2+czcE22
         0qctPwe7ZHi0/GQOjEUxfg4fhXO1QPFCEBQUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/vbL5b//yF/QRmFP+MoSE68BAHXcNHhnOpnaTu3IOJk=;
        b=IJ2C/BS2DFUdRZ5Izwlz7KecJje9bdB2jkdLg1LRH7ttGxQOuMhCif02iyZXnkTcOg
         AE5vC5nUhl+dS5XV4HilYFzXv2ELiE12n9eQhEIeQDzv59SLckVYJuaBnWViFyXRa4ne
         BJcACyhClbKYj4h/tem0LguFhHpzBSbNYT29Qe2qE6pgwuKm5sw3at6eT0toB+XkkyT8
         MVIdYQUWK96TNyIAjYZYzg6Hb74vNk1fa3Nc1vqwjBpeXG+ssZgiuv01r0ahvppi07cv
         kJaHrJ3J3kfw4/hmGR8IvoHzyvkHBrD7piW8vXwEcjWtVQ5G6WAqUQhoupXdJ5msOMgh
         9zuA==
X-Gm-Message-State: AGi0PuZb/2W5mbyArti7Y7/e8l9t2YlO4Q/g9UryvIyy57nfBy6U5EXH
        hMB/VVdI4uwHeOEy1U/aM4Ih2A==
X-Google-Smtp-Source: APiQypJi2e/BGexLb329/SV08Hw+CjijJzLekv0lVmvaIk7rg1143PDSkgQrAePUi0XUCjRFMJ9ulQ==
X-Received: by 2002:a17:902:261:: with SMTP id 88mr972081plc.308.1588624329164;
        Mon, 04 May 2020 13:32:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w75sm9506390pfc.156.2020.05.04.13.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:32:08 -0700 (PDT)
Date:   Mon, 4 May 2020 13:32:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Make sure proc handlers can't expose heap memory
Message-ID: <202005041329.169799C65D@keescook>
References: <202005041205.C7AF4AF@keescook>
 <20200504195937.GS11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504195937.GS11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 07:59:37PM +0000, Luis Chamberlain wrote:
> On Mon, May 04, 2020 at 12:08:55PM -0700, Kees Cook wrote:
> > Just as a precaution, make sure that proc handlers don't accidentally
> > grow "count" beyond the allocated kbuf size.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > This applies to hch's sysctl cleanup tree...
> > ---
> >  fs/proc/proc_sysctl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index 15030784566c..535ab26473af 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -546,6 +546,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
> >  	struct inode *inode = file_inode(filp);
> >  	struct ctl_table_header *head = grab_header(inode);
> >  	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> > +	size_t count_max = count;
> >  	void *kbuf;
> >  	ssize_t error;
> >  
> > @@ -590,6 +591,8 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
> >  
> >  	if (!write) {
> >  		error = -EFAULT;
> > +		if (WARN_ON(count > count_max))
> > +			count = count_max;
> 
> That crash a system with panic-on-warn. I don't think we want that?

Eh? None of the handlers should be making this mistake currently and
it's not a mistake that can be controlled from userspace. WARN() is
absolutely what's wanted here: report an impossible situation (and
handle it gracefully for the bulk of users that don't have
panic_on_warn set).

-- 
Kees Cook
