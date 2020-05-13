Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86CB1D0908
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgEMGvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 02:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbgEMGvg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 02:51:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C200120708;
        Wed, 13 May 2020 06:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589352695;
        bh=1qCCaoL90dc2Pbll3pbUgayrYdx2p3xBrdsudFye97I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUObQxdCqiKC50wbixd8dCuSEVwdylTYNMtCxinCVQJCukVAHoic+oS5YXnWAYnoC
         AY+ftw6Nt583iXFll4aTCRIQjp+3yfPSYlve5MQ5n+xRBF+gYurnu52FGB5/Ez/gky
         IJi3NqGiRY2Cs39SpeeHFF6tuWa2ruyVhg5iKYZ0=
Date:   Wed, 13 May 2020 08:51:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
Message-ID: <20200513065133.GB764247@kroah.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-2-scott.branden@broadcom.com>
 <20200513002741.GG11244@42.do-not-panic.com>
 <2e4bc125-5fe5-e3e5-4881-29374da942aa@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e4bc125-5fe5-e3e5-4881-29374da942aa@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 11:23:27PM -0700, Scott Branden wrote:
> Hi Luis,
> 
> A few comments inline before I cleanup.
> 
> On 2020-05-12 5:27 p.m., Luis Chamberlain wrote:
> > On Thu, May 07, 2020 at 05:27:33PM -0700, Scott Branden wrote:
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index 06b4c550af5d..cfab212fab9d 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -896,10 +896,14 @@ struct file *open_exec(const char *name)
> > >   }
> > >   EXPORT_SYMBOL(open_exec);
> > > -int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > > -		     loff_t max_size, enum kernel_read_file_id id)
> > > -{
> > > -	loff_t i_size, pos;
> > > +int kernel_pread_file(struct file *file, void **buf, loff_t *size,
> > > +		      loff_t pos, loff_t max_size, unsigned int flags,
> > You use int flags, but.. these are mutually exclusive operations, and
> > so flags is a misnomer. Just use an enum instead of a define, that way
> > we can use kdoc for documentation.
> OK, flags could be used to expand with additional flag options in the future
> (without change to function prototype, but will change to enum if that is
> what is desired.
> > > +EXPORT_SYMBOL_GPL(kernel_pread_file);
> > > +EXPORT_SYMBOL_GPL(kernel_pread_file_from_path);
> > > +EXPORT_SYMBOL_GPL(kernel_pread_file_from_path_initns);
> > > +EXPORT_SYMBOL_GPL(kernel_pread_file_from_fd);
> > If no one is using these don't export them. I think you only use one of
> > these. In fact just remove the code from the ones which are not used.
> I do not use them but added them to provide consistent api with
> kernel_read_file_* functions.  That way someone can take advantage of the
> _from_path and from_fd variants in the future if desired. But if you want
> them removed it is simple to drop the EXPORT_SYMBOL_GPL and then add that
> back when first driver that calls them needs them in the future.

We do not export symbols when there are no in-kernel users.

> Note: Existing kernel_read_file_from_path_initns is not used in the kernel. 
> Should we delete that as well?

Probably, yes.

thanks,

greg k-h
