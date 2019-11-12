Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7FC2F9DF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 00:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKLXPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 18:15:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40744 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKLXPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:15:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so181628pfl.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 15:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q/7zKomDvwvoQVmplaYbzXQkEiXPJRscqerdxI0XpvE=;
        b=gMuZpNu2ZWWW1U1Djp24A57ML3WMX9pxLpjzy9vcatjVYek6YJx07FQmY8w0YIjtWk
         npdddXUg54q759/2mZ1xUDLqAY/tN+mCvK2bLXfWZscdZbUFsmPrJ8mGS42dXbUexSqn
         FLkNDOuNubyqmyvpl7RPVvVrXPThIpjdJPxl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/7zKomDvwvoQVmplaYbzXQkEiXPJRscqerdxI0XpvE=;
        b=Tydsex7Y+iM4S822ZTPmIqigB1M9RPmbsQgz8Hzcj/tok4C5rkMMltRJRwro3McQze
         hgO22y2dTaKHh0CPRtkE/9O2bid3I9sgv5DJRp5z127ywmismq0tHLnPNrNz6D6qhWRB
         eMEDUygcsNv6JGrEhBYalb/BqmNgYKplR2NpGvAMDLsiD95PfqaJWfNEUGfZntC7Y1Ld
         DG3II4rUdABydY9pUop8bw9vcu6i7jRF1qO1zde8Cswa7AfeT1z5YQxmD8e4ZqXfjtYB
         MZdmJVaRuY5l5dj0dIR8n1Vnw4GQbZTaLMEQPPDL/i4q04mCjVRQOnTnbXPqtIHQz36j
         FeAQ==
X-Gm-Message-State: APjAAAV0jVvOzrgMjjUprD8RsEO2AVCWs4pS1ZpMYa3TbnAbnScCinMk
        xGWFnNovLbnFmt4eVySCJGWgVxSAmfM=
X-Google-Smtp-Source: APXvYqy+Au3kYLmA11xfFKoZBV6/GOO9I8Z5Zy4Zp4gEbzdOoKsHxdFIrmkacipgx8+7hy/Mu8ANxw==
X-Received: by 2002:a17:90a:3b0d:: with SMTP id d13mr473073pjc.86.1573600517339;
        Tue, 12 Nov 2019 15:15:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l74sm172205pje.29.2019.11.12.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:15:16 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:15:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
Message-ID: <201911121514.DA3BEED0@keescook>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <20191103175648.GA4603@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103175648.GA4603@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 03, 2019 at 12:56:48PM -0500, Theodore Y. Ts'o wrote:
> On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
> > Several items in /proc/sys need not be accessible to unprivileged
> > tasks. Let the system administrator change the permissions, but only
> > to more restrictive modes than what the sysctl tables allow.
> > 
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> 
> Why should restruct the system administrator from changing the
> permissions to one which is more lax than what the sysctl tables?
> 
> The system administrator is already very much trusted.  Why should we
> take that discretion away from the system administrator?

Generally speaking, they're there to provide some sense of boundary
between uid 0 and the kernel proper. I think it's correct to not allow
weakening of these permissions (which is the current state: no change at
all).

-- 
Kees Cook
