Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD5D67494
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 19:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfGLRqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 13:46:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43181 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfGLRqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:46:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so10772354wru.10;
        Fri, 12 Jul 2019 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VnGi7SmrRgQ+WlkfWjtNW9trIO/foZCB9eqZJyvYBXY=;
        b=bgR/1MOCBglV8ju8A0TSc632QFLLjYW8p0VnNd9PAek5sXuIdXM5V2hh8TBrkfgdOy
         Dw8/WWEh/XAGtToU23dd6m3uiGQd+2q+5ldaWJVeVVVIY+XcSpCcSb1MeYCRnrEiA6Jq
         ZiEhpp0T9Cu2pgT07L4XJTYo+VLqeclH+FOwnq9GMOu9YDpLwzRJy3zQzpsxhAwvHRAA
         WgAED6zF107ZM7qm0wRE3uGFdq7ntKqaavbU+4Dwqw+TA0q3P+n0RZ15rvVtEwhsFmxi
         OiliIC9mpmGn/DQthcPU0rsjUOMIy3kkYgEyOh5XBOJafCtORoodjoHlki3450FY8F8d
         NKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VnGi7SmrRgQ+WlkfWjtNW9trIO/foZCB9eqZJyvYBXY=;
        b=rFWuO8P5bbpPFmQnZpnYE6S1yYG6ylaoYZUYawew9Edf4UQ3yVopO+M25xoFo3/C9v
         7vcrwvtg2zjemBtXgz00CnikOAerzcoI9Ao3gRl/yj7O8UCouwHgIMgsW31/JhTdu65U
         BBJCkp8umeEuQbrHYfKgp/uESvnemaz+gX8UwhFAAc7TEq9ZibaeOnD7T6rYbvrnfmHx
         ZPsKPSC3CTX4sj1Ad/3dbe7mF2nLTHpuwxOK5FrohNDP3IGaxnSbyWgcl4gaEw/RtZv/
         XPUfTPxPSrf/XsYbaLK5dDXr739xhKIPHBpDGkiLQF/A7IH7+XCrl3CMNYwf9nh8X3yU
         tDVQ==
X-Gm-Message-State: APjAAAXaab0J4cwPTb3OEsLk62wBaiMT0GMRmIyG0lDYEyXw1eA2aFub
        ucYbe3zOl8ibQyXuT87T5YhNIPs=
X-Google-Smtp-Source: APXvYqxacP3UsohCyxIK08EPGqyglIVucjQZw1CIretgNowBeRnYnnjnIbnm3UjWptmSDd49LC0vlA==
X-Received: by 2002:adf:ebcd:: with SMTP id v13mr12621145wrn.263.1562953595046;
        Fri, 12 Jul 2019 10:46:35 -0700 (PDT)
Received: from avx2 ([46.53.248.114])
        by smtp.gmail.com with ESMTPSA id c12sm14210038wrd.21.2019.07.12.10.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 10:46:34 -0700 (PDT)
Date:   Fri, 12 Jul 2019 20:46:32 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Alexey Izbyshev <izbyshev@ispras.ru>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] proc: Fix uninitialized byte read in get_mm_cmdline()
Message-ID: <20190712174632.GA3175@avx2>
References: <20190712160913.17727-1-izbyshev@ispras.ru>
 <20190712163625.GF21989@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190712163625.GF21989@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 06:36:26PM +0200, Oleg Nesterov wrote:
> On 07/12, Alexey Izbyshev wrote:
> >
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -275,6 +275,8 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
> >  		if (got <= offset)
> >  			break;
> >  		got -= offset;
> > +		if (got < size)
> > +			size = got;
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>

The proper fix to all /proc/*/cmdline problems is to revert

	f5b65348fd77839b50e79bc0a5e536832ea52d8d
	proc: fix missing final NUL in get_mm_cmdline() rewrite

	5ab8271899658042fabc5ae7e6a99066a210bc0e
	fs/proc: simplify and clarify get_mm_cmdline() function
