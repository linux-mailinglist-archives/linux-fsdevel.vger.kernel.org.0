Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9E49D66D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 00:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiAZX5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 18:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiAZX5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:57:38 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D61FC06173B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 15:57:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id p37so1109533pfh.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 15:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ohka9ylvwErx9g3m7SUbwTYWiZ3JYvdVBIeKBfo+8i0=;
        b=Fo3BfHkU4Bhk/n3uAwINnKCUL8bWPsJHCe4rvnKyepD/7j1Pk7QkRFXBh83I2ZwVvg
         bjNpktlScU1tCLFFpJxhpBxX99QBSrKywuixHTivmGrfbThXDOlGPRHxG5feyU6OY6vF
         3sxvofWqQQldelsTRGDu/XNhH7zFyD3hctGZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ohka9ylvwErx9g3m7SUbwTYWiZ3JYvdVBIeKBfo+8i0=;
        b=SvGYzmFPz0cLWj4AKUvPrxg0rv6N6thnzbY1BB6IIwZHDCbipIX6iFex6FM0pDWDgv
         oq3KD5HcDZtZ1el4rsnZZsjIwjN4rx8p612LeKBMbXzG7FHTmGc1pIOJIdN+ZrK+8gui
         A7Llkj2Abp4BiwhnFcl2Ul+GwdhDZWxtEyMl0whmRH0TfhF4w259kEeM5TtW9KTUpqc8
         27mj7T9m5EnVMubFbJp0QQKKfUxTwis+CAMtF5rWcP1apI9wUyfXiOKcdO+UYyXT/FxS
         KsGQJQu2+Z3jEIf2QQTJenkCHzED7w5i0nAPQihn7kiP07SwA2rj712wrIU3/V93KNZs
         58/w==
X-Gm-Message-State: AOAM530aySgz02hujcAlKXrOB/IQZYJ93tNohlGzIUok9TDOuFFR3FHE
        H27YaqjscysYnLFwzCxVZbEvLg==
X-Google-Smtp-Source: ABdhPJwDHqI4d1T0ybtln+8bfBZPLQu61TysFGOvgsM/oyuBAGRjMWxq0LywCgZLdZRJjy967VKozA==
X-Received: by 2002:a62:e304:: with SMTP id g4mr1118118pfh.61.1643241456977;
        Wed, 26 Jan 2022 15:57:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8sm584999pfv.24.2022.01.26.15.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 15:57:36 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:57:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Heikki Kallasjoki <heikki.kallasjoki@iki.fi>
Cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
Message-ID: <202201261545.D955A71E@keescook>
References: <20220126043947.10058-1-ariadne@dereferenced.org>
 <202201252241.7309AE568F@keescook>
 <39480927-B17F-4573-B335-7FCFD81AB997@chromium.org>
 <44b4472d-1d50-c43f-dbb1-953532339fb4@dereferenced.org>
 <YfE/owUY+gVnn2b/@selene.zem.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfE/owUY+gVnn2b/@selene.zem.fi>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:33:39PM +0000, Heikki Kallasjoki wrote:
> On Wed, Jan 26, 2022 at 05:18:58AM -0600, Ariadne Conill wrote:
> > On Tue, 25 Jan 2022, Kees Cook wrote:
> > > Lots of stuff likes to do:
> > > execve(path, NULL, NULL);
> > 
> > I looked at these, and these seem to basically be lazily-written test cases
> > which should be fixed.  I didn't see any example of real-world applications
> > doing this.  As noted in some of the test cases, there are comments like
> > "Solaris doesn't support this," etc.
> 
> See also the (small) handful of instances of `execlp(cmd, NULL);` out
> there, which I imagine would start to fail:
> https://codesearch.debian.net/search?q=execlp%3F%5Cs*%5C%28%5B%5E%2C%5D%2B%2C%5Cs*NULL&literal=0
> 
> Two of the hits (ispell, nauty) would seem to be non-test use cases.

Ah yeah, I've added this to the Issue tracker:
https://github.com/KSPP/linux/issues/176

-- 
Kees Cook
