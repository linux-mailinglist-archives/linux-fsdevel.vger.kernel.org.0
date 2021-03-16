Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE6933D46D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 13:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhCPM4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 08:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233443AbhCPM4M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:56:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DF036504F;
        Tue, 16 Mar 2021 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615899371;
        bh=NUrWK1ohdGJAi0VWxxv0wY1aIMFLzvvTPrxsPTaMPN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXLxYIFHbmMoGLWMNSZ/WgJY84MJ9Y3/BU63digCWppmet+iBQw0iS2baMk2GcoML
         W6xAwjqX3x0lhTQyDj3w+8og9DgswCH/O295wE+DGPUejiPmixCJy5XP+72MDg6NPK
         oKQyORJVSFAMwxq4vIBbQ/pJZD4d/EJuu8X+RdTo=
Date:   Tue, 16 Mar 2021 13:55:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YFCq2TeHAl1s8/TX@kroah.com>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YE+oZkSVNyaONMd9@zeniv-ca.linux.org.uk>
 <202103151336.78360DB34D@keescook>
 <YFBdQmT64c+2uBRI@kroah.com>
 <YFCn4ERBMGoqxvUU@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFCn4ERBMGoqxvUU@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:43:12PM +0000, Al Viro wrote:
> On Tue, Mar 16, 2021 at 08:24:50AM +0100, Greg Kroah-Hartman wrote:
> 
> > > Completely agreed. seq_get_buf() should be totally ripped out.
> > > Unfortunately, this is going to be a long road because of sysfs's ATTR
> > > stuff, there are something like 5000 callers, and the entire API was
> > > designed to avoid refactoring all those callers from
> > > sysfs_kf_seq_show().
> > 
> > What is wrong with the sysfs ATTR stuff?  That should make it so that we
> > do not have to change any caller for any specific change like this, why
> > can't sysfs or kernfs handle it automatically?
> 
> Hard to tell, since that would require _finding_ the sodding ->show()
> instances first.  Good luck with that, seeing that most of those appear
> to come from templates-done-with-cpp...

Sure, auditing all of this is a pain, but the numbers that take a string
are low if someone wants to do that and convert them all to sysfs_emit()
today.

> AFAICS, Kees wants to protect against ->show() instances stomping beyond
> the page size.  What I don't get is what do you get from using seq_file
> if you insist on doing raw access to the buffer rather than using
> seq_printf() and friends.  What's the point?

I don't understand as I didn't switch kernfs to this api at all anyway,
as it seems to have come from the original sysfs code moving to kernfs
way back in 2013 with the work that Tejun did.  So I can't remember any
of that...

thanks,

greg k-h
