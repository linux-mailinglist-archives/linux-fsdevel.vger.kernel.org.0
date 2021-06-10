Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC243A2A1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 13:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFJLZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 07:25:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59668 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJLZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:25:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1117B1FD37;
        Thu, 10 Jun 2021 11:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623324212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+OvVDRQ37X8R8Qps6Cttkx0IVB3/nWaCl0kX6EmRKgY=;
        b=DhS4c3faSae/jep7ZN8hl4JQg9csW5T5XjqwiMIJ9niypSclXhI6MUIFmLAi801p8qg6G4
        jd4d4ZqwgRkhoj3f1VG7E+4kHEMQQmaU0wiHB+0WddMS/kAakjoKdZjeODtmkImbvNlal6
        UPMcQaNLYxHeYWITuMM9UAWWTRMLQYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623324212;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+OvVDRQ37X8R8Qps6Cttkx0IVB3/nWaCl0kX6EmRKgY=;
        b=HNCNO58+VvoasDNnWqcILIZ4kqFbRi6uriiLPSQhVbd/WgGQ0fT7umG0MCkzBZrCSQS6co
        Hw6CD690onxeAWCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id F0AC5A3B91;
        Thu, 10 Jun 2021 11:23:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D47531F2CAB; Thu, 10 Jun 2021 13:23:31 +0200 (CEST)
Date:   Thu, 10 Jun 2021 13:23:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <20210610112331.GB23539@quack2.suse.cz>
References: <cover.1623282854.git.repnop@google.com>
 <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew!

On Thu 10-06-21 10:21:50, Matthew Bobrowski wrote:
> Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> allows userspace applications to control whether a pidfd info record
> containing a pidfd is to be returned with each event.
> 
> If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> struct fanotify_event_info_pidfd object will be supplied alongside the
> generic struct fanotify_event_metadata within a single event. This
> functionality is analogous to that of FAN_REPORT_FID in terms of how
> the event structure is supplied to the userspace application. Usage of
> FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> permitted, and in this case a struct fanotify_event_info_pidfd object
> will follow any struct fanotify_event_info_fid object.
> 
> Currently, the usage of FAN_REPORT_TID is not permitted along with
> FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
> for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
> limited to privileged processes only i.e. listeners that are running
> with the CAP_SYS_ADMIN capability. Attempting to supply either of
> these initialisation flags with FAN_REPORT_PIDFD will result with
> EINVAL being returned to the caller.
> 
> In the event of a pidfd creation error, there are two types of error
> values that can be reported back to the listener. There is
> FAN_NOPIDFD, which will be reported in cases where the process
> responsible for generating the event has terminated prior to fanotify
> being able to create pidfd for event->pid via pidfd_create(). The
> there is FAN_EPIDFD, which will be reported if a more generic pidfd
> creation error occurred when calling pidfd_create().
> 
> Signed-off-by: Matthew Bobrowski <repnop@google.com>

A few comments in addition to what Amir wrote:

> @@ -524,6 +561,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	}
>  	metadata.fd = fd;
>  
> +	/*
> +	 * Currently, reporting a pidfd to an unprivileged listener is not
> +	 * supported. The FANOTIFY_UNPRIV flag is to be kept here so that a
> +	 * pidfd is not accidentally leaked to an unprivileged listener.
> +	 */
> +	if (pidfd_mode && !FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) {

Hum, you've added FAN_REPORT_PIDFD to FANOTIFY_ADMIN_INIT_FLAGS so this
condition should be always true? I don't think we need to be that much
defensive and would just drop the check here.

> +		/*
> +		 * The PIDTYPE_TGID check for an event->pid is performed
> +		 * preemptively in attempt to catch those rare instances
> +		 * where the process responsible for generating the event has
> +		 * terminated prior to calling into pidfd_create() and
> +		 * acquiring a valid pidfd. Report FAN_NOPIDFD to the listener
> +		 * in those cases.
> +		 */
> +		if (metadata.pid == 0 ||
> +		    !pid_has_task(event->pid, PIDTYPE_TGID)) {
> +			pidfd = FAN_NOPIDFD;
> +		} else {
> +			pidfd = pidfd_create(event->pid, 0);
> +			if (pidfd < 0)
> +				/*
> +				 * All other pidfd creation errors are reported
> +				 * as FAN_EPIDFD to the listener.
> +				 */
> +				pidfd = FAN_EPIDFD;
> +		}
> +	}
> +
>  	ret = -EFAULT;
>  	/*
>  	 * Sanity check copy size in case get_one_event() and
...

> @@ -558,6 +632,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  		put_unused_fd(fd);
>  		fput(f);
>  	}
> +
> +	if (pidfd < 0)
> +		put_unused_fd(pidfd);
> +

put_unused_fd() is not enough to destroy the pidfd you have. That will just
mark 'pidfd' as free in the fd table. You rather need to call close_fd()
here to fully close open file.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
