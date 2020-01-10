Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24F51378D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 23:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgAJWBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 17:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbgAJWBl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:01:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B632082E;
        Fri, 10 Jan 2020 22:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578693700;
        bh=y78F7EkDKzvyrK1oupSN61NtpNTuyNmqqSBPHBi1g3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPNE2zb4PFZ3Oz35DFjfUZHw66krtBSRqkiXSrtRCySb4LNDj7j1hCiI1xArS2IAh
         WPzWViMtDrZTMRInb2MLD9dROprtUUmI1YyOwkT5npDNQZ+xv+r54p95aHDozjPpg7
         j5fVEpiM88yQKvc5Drcc19e80+XtryFrjqV+mCFg=
Date:   Fri, 10 Jan 2020 23:01:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH-next 2/3] sysctl/sysrq: Remove __sysrq_enabled copy
Message-ID: <20200110220137.GA9387@kroah.com>
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-3-dima@arista.com>
 <20200110164035.GA1822445@kroah.com>
 <04436968-5e89-0286-81e5-61acbe583f73@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04436968-5e89-0286-81e5-61acbe583f73@arista.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 10, 2020 at 09:45:30PM +0000, Dmitry Safonov wrote:
> Hi Greg,
> 
> On 1/10/20 4:40 PM, Greg Kroah-Hartman wrote:
> > On Thu, Jan 09, 2020 at 09:54:43PM +0000, Dmitry Safonov wrote:
> [..]
> >> @@ -2844,6 +2827,26 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
> >>  }
> >>  #endif
> >>  
> >> +#ifdef CONFIG_MAGIC_SYSRQ
> >> +static int sysrq_sysctl_handler(struct ctl_table *table, int write,
> >> +				void __user *buffer, size_t *lenp, loff_t *ppos)
> >> +{
> >> +	int tmp, ret;
> >> +
> >> +	tmp = sysrq_get_mask();
> >> +
> >> +	ret = __do_proc_dointvec(&tmp, table, write, buffer,
> >> +			       lenp, ppos, NULL, NULL);
> >> +	if (ret || !write)
> >> +		return ret;
> >> +
> >> +	if (write)
> >> +		sysrq_toggle_support(tmp);
> >> +
> >> +	return 0;
> >> +}
> >> +#endif
> > 
> > Why did you move this function down here?  Can't it stay where it is and
> > you can just fix the logic there?  Now you have two different #ifdef
> > blocks intead of just one :(
> 
> Yeah, well __do_proc_dointvec() made me do it.
> 
> sysrq_sysctl_handler() declaration should be before ctl_table array of
> sysctls, so I couldn't remove the forward-declaration.
> 
> So, I could forward-declare __do_proc_dointvec() instead, but looking at
> the neighborhood, I decided to follow the file-style (there is a couple
> of forward-declarations before the sysctl array, some under ifdefs).
> 
> I admit that the result is imperfect and can put __do_proc_dointvec()
> definition before instead, no hard feelings.

Ah, no, nevermind, I missed that reason, sorry about that.  Moving it is
fine.

greg k-h
