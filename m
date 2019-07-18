Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49B06D758
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 01:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGRXn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 19:43:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44218 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGRXnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:43:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so13589904pgl.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MQwS96V3LHC/Rllb6kfS8urt8Dwxl4rqynJ2jowTCiU=;
        b=CbKqei8CHSTARxahiWTl1FNQCrYm6g/pivGuc6BHyoNtkefajUa5vaq98Ltbgg5oxs
         1JpjsDap9F5JWR+W3YAdGvvK6FJhByZfrrb2Bx9j947sJQg6HoFNYJhRuNH7wR6PqeaK
         3Hq7SW/khR68/fak2pme92Si/S8q94ZaUWGRQDIt8/Xcy6WzQdTk2haBDcUFslzRTIzg
         plFUbL7NRAO2G1hnMye5xRiJbk3Jr6HJTkCYK3KY/ghz3Sbvuu0/LfZgtprRmRrYLJ43
         r66L/8sYbUtlbXwNQcLT1hK6zStKv9lu3TuE5TF6WPH0pUqIczffKZTZ0RvkvBcIA2zS
         bi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MQwS96V3LHC/Rllb6kfS8urt8Dwxl4rqynJ2jowTCiU=;
        b=gZgjO3V5x4blK9OvTj4ZFTnVWMbvcY/cImP4QhzTtXnjiVXC/zRx3HNreaqFnQHVL0
         rKQH1TcRnf3YImbrbiH3lhQhc2qEVmcUlhF8CanPaonCWC0b8caH/NkFCpLnElBAvVEw
         pomi2d6JLsUNMbv0Kh0eDGstuAc++j4QBI55HcC58kWCQfj/V42NblIhPA8t666vP/w2
         4tSf+6gY/FnTx5w4WpeNb5be67kDvpj0kSrM6LYSqRmediehtdjCo25QCJ8s+ZXmmSiE
         13UbeqBe/+zt6ye2uGzM3JOy3bdllLaI63ttnR2j/WKSkcQmZbL8sHrnXPpzBjKOYvfu
         sLBQ==
X-Gm-Message-State: APjAAAXrCjvk3XkuWWb/w+NTTHg5+Bc9fvLWjHv3rHygvMyb772c9667
        d0xXz5uCqAvgbcJwp7Boq37cRx1iUSQ=
X-Google-Smtp-Source: APXvYqwHkjOWTjO83aPwBiWV00djXldoneDG1ERTJDHEsy/WGnatPttuvjK+Q2+igzdU4zEhqa03Ag==
X-Received: by 2002:a17:90a:db42:: with SMTP id u2mr54275822pjx.48.1563493435068;
        Thu, 18 Jul 2019 16:43:55 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h6sm26955305pfb.20.2019.07.18.16.43.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 16:43:54 -0700 (PDT)
Date:   Thu, 18 Jul 2019 16:43:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Benjamin LaHaise <bcrl@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Support read/write with non-iter file-ops
Message-ID: <20190718234352.GN30636@minitux>
References: <20190718231054.8175-1-bjorn.andersson@linaro.org>
 <20190718231751.GV17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718231751.GV17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18 Jul 16:17 PDT 2019, Al Viro wrote:

> On Thu, Jul 18, 2019 at 04:10:54PM -0700, Bjorn Andersson wrote:
> > Implement a wrapper for aio_read()/write() to allow async IO on files
> > not implementing the iter version of read/write, such as sysfs. This
> > mimics how readv/writev uses non-iter ops in do_loop_readv_writev().
> 
> IDGI.  How would that IO manage to be async?  And what's the point
> using aio in such situations in the first place?

The point is that an application using aio to submit io operations on a
set of files, can use the same mechanism to read/write files that
happens to be implemented by driver only implementing read/write (not
read_iter/write_iter) in the registered file_operations struct, such as
kernfs.

In this particular case I have a sysfs file that is accessing hardware
and hence will block for a while and using this patch I can io_submit()
a write and handle the completion of this in my normal event loop.


Each individual io operation will be just as synchronous as the current
iter-based mechanism - for the drivers that implement that.

Regards,
Bjorn
