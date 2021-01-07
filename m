Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36C2EE771
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 22:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbhAGVI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 16:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbhAGVI4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:08:56 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E063BC0612F8
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 13:08:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y8so4341118plp.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RPSS4+wIGvp/3YQYbCUE3lZcjQcE7GevEzI6hP5X/bw=;
        b=QcHURJUskZnmGtmirPpDXam1+nD3tS58vO+VwHrt5QfpZAT7OkPqMK1Z5s4W/HNPmf
         7ddcAQFcWD8RlCEXgL5kPn7aJq51foNk1f1ewKIh2dAdzREaU0UWbMRUfCZjWMIa97OP
         VuvgVhCAg18OWqacs6ABqF8JJ1a4cjtiqQUl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RPSS4+wIGvp/3YQYbCUE3lZcjQcE7GevEzI6hP5X/bw=;
        b=PZGt/yI0Af6p2W2dJ4IU7eetdpSC3Q9mRkb06gE0IzbfZYA1XUQEHG4AtOLMX9veK9
         gG/IGDIqrPfQqzVEAqA0zEroyJzwKFfenun0aCYyGnDSHKi2VDFUcsiJH+uuALO/Uv/H
         1GjMOQGXVJK6iNbgHXMNvwZK9EQcxfGYc64iZ4B+4tBjiyEyqg1Y+4O52nMpQg9VXEZB
         /Pth1NfHDEFtFDsDuoAJcVzpNm1Ic5voq+Fy8jEpotU/n7TjGTr7mESgNd305VVpr/nr
         0o9poHwRwFBx8feYFFTvZU3M3kGqAG6VAz38KSNYP4pnchBdbfoAlndkz13DECwHu2CJ
         W2kg==
X-Gm-Message-State: AOAM531ARUIIQswq3vADeju18oyzd03gthfCUI70zpCNDAZjnb9yd+4G
        mioPaT0D3EGysmdoYBCBS6th9iJ1reDZWQ==
X-Google-Smtp-Source: ABdhPJyNhZorRAZXybiTjz8m9XRI5n8wBsWWi8f4w0GjKoH//cf7R8VzKbRIfqr+XwNPjJh7ntRq3A==
X-Received: by 2002:a17:90b:283:: with SMTP id az3mr367695pjb.84.1610053695540;
        Thu, 07 Jan 2021 13:08:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c18sm6473506pfj.200.2021.01.07.13.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:08:14 -0800 (PST)
Date:   Thu, 7 Jan 2021 13:08:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        yzaikin@google.com, adobriyan@gmail.com, vbabka@suse.cz,
        linux-fsdevel@vger.kernel.org, mhocko@suse.com,
        mhiramat@kernel.org, wangle6@huawei.com
Subject: Re: [PATCH] proc_sysclt: fix oops caused by incorrect command
 parameters.
Message-ID: <202101071307.6E0CF2FCA@keescook>
References: <20201224074256.117413-1-nixiaoming@huawei.com>
 <202101061539.966EBB293@keescook>
 <5ad6d160-3a4e-28bd-4e89-cb01a1815861@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ad6d160-3a4e-28bd-4e89-cb01a1815861@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 02:14:18PM +0800, Xiaoming Ni wrote:
> On 2021/1/7 7:46, Kees Cook wrote:
> > subject typo: "sysclt" -> "sysctl"
> > 
> > On Thu, Dec 24, 2020 at 03:42:56PM +0800, Xiaoming Ni wrote:
> > > [...]
> > > +	if (!val)
> > > +		return 0;
> > > +
> > >   	if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
> > >   		param += sizeof("sysctl") - 1;
> > 
> > Otherwise, yeah, this is a good test to add. I would make it more
> > verbose, though:
> > 
> > 	if (!val) {
> > 		pr_err("Missing param value! Expected '%s=...value...'\n", param);
> > 		return 0;
> > 	}
> > 
> Yes, it's better to add log output.
> Thank you for your review.
> Do I need to send V2 patch based on review comments?

Yes please. :)

-- 
Kees Cook
