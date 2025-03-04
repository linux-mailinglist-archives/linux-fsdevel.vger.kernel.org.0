Return-Path: <linux-fsdevel+bounces-43143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C470A4EA3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4E4189B92A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9026293B41;
	Tue,  4 Mar 2025 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGTKEe++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F824C08C
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109743; cv=none; b=EYM3jNBjg0KGJDQ9KXD2DuPvhqkk6Fp7bKPkXTlcRWVVZBTO7yHWJpCmiISFPz1zgyqd3I3lGsiScJk244kHZi1MTgb0hetAEQjMp4ecK1s4s117fthPVsmTWRTVqH4f1/7Y7vEfu0oKXRQpKA02KfvxqTXYud8Zfqde/K7jyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109743; c=relaxed/simple;
	bh=usKsu7+WE7BqiJ2OWeRhlH57VUySppT4T4UXrsoEnVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRnthZRkqutJC4YDuVWVXy/XrKEn/tmRDVJ6NPGYhViWdTVoibVTGmMmGGZiQPTAilRN80CHTnioLaYi7zq2DzXLXJypkNk/HTTSQrHvVl5SreBBTSvToBP4cbs+FBA/hqYhHKUCUne7xGFOG5KHm0ZZkcsBT9VZtzF9kH3Zvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGTKEe++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741109740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G4kE6EqeWGEKJmAIRBFVAhSj80uLB8Hnn8Sd9xGooOs=;
	b=BGTKEe++TUgiKwXdxrTbUtIDoj16oCgiKsvr+WeorxlforfiUWGvFTHgj4FALouwSMH6OA
	mHN8ugE15dx12/Spw+7E3zukDVhfdfoZfZG4x9G/0TNEqm9BkwbLRoNwFDD16yOhtt+1Ah
	7kGzDdp0VRktr397OmxvXbWhO9IoC54=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-LhYvDVvCPmWC_5ScJbqTWA-1; Tue,
 04 Mar 2025 12:35:32 -0500
X-MC-Unique: LhYvDVvCPmWC_5ScJbqTWA-1
X-Mimecast-MFC-AGG-ID: LhYvDVvCPmWC_5ScJbqTWA_1741109730
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2087180087F;
	Tue,  4 Mar 2025 17:35:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.246])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2DF62180035E;
	Tue,  4 Mar 2025 17:35:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 18:35:00 +0100 (CET)
Date: Tue, 4 Mar 2025 18:34:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v2 06/15] pidfs: allow to retrieve exit information
Message-ID: <20250304173456.GD5756@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/04, Christian Brauner wrote:
>
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task) {
> +		if (!(mask & PIDFD_INFO_EXIT))
> +			return -ESRCH;
> +
> +		if (!current_in_pidns(pid))
> +			return -ESRCH;

Damn ;) could you explain the current_in_pidns() check to me ?
I am puzzled...

Oleg.


