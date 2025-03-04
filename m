Return-Path: <linux-fsdevel+bounces-43141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E21A4E9F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B716319C0BEE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565C429C34A;
	Tue,  4 Mar 2025 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfUFMIpY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F212C2CBE
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109015; cv=none; b=XXi96Fky1ZIMkpP2pcNoQ5fl+f//MA3nfLpszgZBYICzaqYUsPDyb8RB1cYZjmDUszm+jwNi/tXlw3Q0Mw8DLGROzB7sp+3LwFTbf441I+W+C6/tTHh3RPs3eb7vrWgxwSgJjupbsXcUjQwv8oHywMjBm3GmpK/q3yygENY667E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109015; c=relaxed/simple;
	bh=NGuNOA+dOUWPnA/uOLmFOg1ZdSd2qtUEZjZLEWXf9Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoNW47X6cHYFUmkh9Risn4av8TEqizU3mvZzNU7Bs6abRVWCdAswiCWalL26zQQGAcNY/oooZYW/ct+To67GAcw8/nKAaiv/0dBefkXZV/vlzDB57WscZWY956vQiZIwweNjrKxVHE3fX7yoblOJz5ewb8sun5sE7n0km8Ebn+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CfUFMIpY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741109012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MFNLRK8HOOeHp4byVOx0A3cGM3GmhIMPPGYScJHlHww=;
	b=CfUFMIpY+kfWW3hYwtGkK2N0MsbwB++l9QUwubSmlACN/qgenSLaN1eeyTCfXAl3Y5VH/7
	mtr1/uX7QqgVmhLpGL9oNudK2pSBB9oH2XV/VU2ZOQ+SzGCb1TM062ld0lyvqxLo9oRVS7
	zMtAxG/1AbtvQifcNrLZZscakmielXA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-SBCCIG39NO-fncSNwP7BXw-1; Tue,
 04 Mar 2025 12:23:31 -0500
X-MC-Unique: SBCCIG39NO-fncSNwP7BXw-1
X-Mimecast-MFC-AGG-ID: SBCCIG39NO-fncSNwP7BXw_1741109009
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E9BA18EB2D3;
	Tue,  4 Mar 2025 17:23:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.246])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EFE2319560A3;
	Tue,  4 Mar 2025 17:23:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 18:22:59 +0100 (CET)
Date: Tue, 4 Mar 2025 18:22:55 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v2 06/15] pidfs: allow to retrieve exit information
Message-ID: <20250304172255.GC5756@redhat.com>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
 <20250304-work-pidfs-kill_on_last_close-v2-6-44fdacfaa7b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-6-44fdacfaa7b7@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 03/04, Christian Brauner wrote:
>
> @@ -248,6 +260,37 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
>  	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
>  		return -EFAULT;
>
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task) {
> +		if (!(mask & PIDFD_INFO_EXIT))
> +			return -ESRCH;
> +
> +		if (!current_in_pidns(pid))
> +			return -ESRCH;
> +	}
> +
> +	if (mask & PIDFD_INFO_EXIT) {
> +		exit_info = READ_ONCE(pidfs_i(inode)->exit_info);
> +		if (exit_info) {
> +#ifdef CONFIG_CGROUPS
> +			kinfo.cgroupid = exit_info->cgroupid;
> +			kinfo.mask |= PIDFD_INFO_EXIT | PIDFD_INFO_CGROUPID;
> +#endif
> +			kinfo.exit_code = exit_info->exit_code;
> +		}

Confused... so, without CONFIG_CGROUPS pidfd_info() will never report
PIDFD_INFO_EXIT in kinfo.mask ?

> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -20,6 +20,7 @@
>  #define PIDFD_INFO_PID			(1UL << 0) /* Always returned, even if not requested */
>  #define PIDFD_INFO_CREDS		(1UL << 1) /* Always returned, even if not requested */
>  #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
> +#define PIDFD_INFO_EXIT			(1UL << 3) /* Always returned if available, even if not requested */
                                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The comment doesn't match the "if (mask & PIDFD_INFO_EXIT)" check above...

Oleg.


