Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE31B8332
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 04:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDYCMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 22:12:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35089 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDYCMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 22:12:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8so4445123plt.2;
        Fri, 24 Apr 2020 19:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VAwc1AKSp5B7UhF/0ecMczbgaQzkFJn5Nyd0M+l9aDw=;
        b=dYXnI45VAcpjeNM233aKG69gOsmF2zTlEKYC+KkYyoaQPlj0LU+uFLxFMScVP83PKZ
         vLLNyXHSp/0tXRs81lRDNoRsy/RcCQDcnxY2TGZaX6ZCA0sHM1U+mQ1wZ84ANUxyowOV
         UlxDsvUsdoLPyOL74sZ3qm76gPLOhdUgPpShPESi6IJpndqqq2yvfTJbKMVNiolmC5gL
         wP+O0+IRxRGlY4uOOdCt1cq2nJ4OCJV4dLvevsjzR7lsm5R+6/QrGMRNraiUBVvSZBUo
         M29KmjiGTeu6jYrh2FIEB5cR69oWoNNCruZmRIJmOu4HYnbMp7NNbzxXpFVNpq/2f2M4
         /OTQ==
X-Gm-Message-State: AGi0PuZJL1/f9io8Iki4o955oGR9C8Xrpd3kph8ebDBFrh1FcWGJLWkQ
        6avQM6pXuRTzyq1qy2NBfG4=
X-Google-Smtp-Source: APiQypJ6Xhv95ABdmHPLykZ9mxjB42z2LQ8WbeKbHCJrwPG+2THju9/ZzXNjNx28ihtiF5pgJ3dyIg==
X-Received: by 2002:a17:90a:3327:: with SMTP id m36mr9760022pjb.116.1587780767473;
        Fri, 24 Apr 2020 19:12:47 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x26sm6744265pfo.218.2020.04.24.19.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 19:12:46 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2E3E1403AB; Sat, 25 Apr 2020 02:12:45 +0000 (UTC)
Date:   Sat, 25 Apr 2020 02:12:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] block: put_device() if device_add() fails
Message-ID: <20200425021245.GF11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-11-mcgrof@kernel.org>
 <85a18bcf-4bd0-a529-6c3c-46fcd23a350e@acm.org>
 <20200424223210.GD11244@42.do-not-panic.com>
 <d8e01420-5a0a-3c60-0b8c-46465437e255@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8e01420-5a0a-3c60-0b8c-46465437e255@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 06:58:23PM -0700, Bart Van Assche wrote:
> On 2020-04-24 15:32, Luis Chamberlain wrote:
> > On Sun, Apr 19, 2020 at 04:40:45PM -0700, Bart Van Assche wrote:
> >> On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> >>> Through code inspection I've found that we don't put_device() if
> >>> device_add() fails, and this must be done to decrement its refcount.
> >>
> >> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > 
> > Turns out this is wrong, as bdi needs it still, we have can only remove
> > it once all users are done, which should be at the disk_release() path.
> > 
> > I've found this while adding the errors paths missing.
> 
> Hi Luis,
> 
> I had a look at the comments above device_add() before I added my
> Reviewed-by. Now that I've had another look at these comments and also
> at the device_add() implementation I agree that we don't need this patch.

Thanks for the confirmation. And just to note, we don't do then
put_device() because we don't handle error paths properly. Once we do,
we'll need to ensure we put_disk() just at the right place. I'm working
on putting some final brush strokes on that now.

   Luis
