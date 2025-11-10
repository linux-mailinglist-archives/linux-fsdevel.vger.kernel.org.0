Return-Path: <linux-fsdevel+bounces-67705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0887CC47700
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FD918928F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE531A051;
	Mon, 10 Nov 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FA4YPBK3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75FB315769
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787359; cv=none; b=CN0SibwOlEIItKNc1SrAbatlPyWyb4+EI96W3yn1YfkqBcjx495csP4KTeIUnjnomXRYmeX4j2RuvXWSsLG4Ks/KBCT5Ylex5g3607E3ac3+i+asIjqTUPhk3AftoiDJl8zEIueBVqwbBBHHqTQl+/30n6FRI+jU4TgpB7Dtk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787359; c=relaxed/simple;
	bh=qnxD5yqdHCGfNv6Q9JjQaq1bz41qRKrFjjBvpZZcU4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhnB/I4RykNnUd7/p59bHAMBs8Rmcjpm9z83/ceagAmajvxjKx3TgR+ZrY8XBDqQ6zreofYYlO3+WIWK42UaRn3yz2bTUsHlexG1aOlsHHtUHjSdagAnoI72xveMcVg6D9GS7QpV7t/ggSK4/S9ah7DZwxQNJw1G1OETeH6grrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FA4YPBK3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762787356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGjo2w5ITfWj64+3hzmyM5KO59pK1AXWwf9AfiwSZdk=;
	b=FA4YPBK3yBsZaADyM6NM+l5io5YsGBIYG48u5ZLMF2eMkVLUFFy1gyIkC8t0M8eRF/wTHs
	Ou04uiwbMWEL3947EjsOwwD3OA6xe70bHMQByrOQS4BT6NVsqkNGUUdgh+YfmBeqB5d3NV
	JnPkIB77HIIakV57lesSDvOIQrxaCbw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-qUFs8U_0NA-Z5BLaeSXOpA-1; Mon,
 10 Nov 2025 10:09:13 -0500
X-MC-Unique: qUFs8U_0NA-Z5BLaeSXOpA-1
X-Mimecast-MFC-AGG-ID: qUFs8U_0NA-Z5BLaeSXOpA_1762787352
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0959E180067A;
	Mon, 10 Nov 2025 15:09:10 +0000 (UTC)
Received: from fedora (unknown [10.44.33.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 96D4E30044E1;
	Mon, 10 Nov 2025 15:09:07 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Nov 2025 16:09:09 +0100 (CET)
Date: Mon, 10 Nov 2025 16:09:05 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] exec: don't wait for zombie threads with
 cred_guard_mutex held
Message-ID: <aRIAEYH2iLLN-Fjg@redhat.com>
References: <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRDL3HOB21pMVMWC@redhat.com>
 <aRDMNWx-69fL_gf-@redhat.com>
 <aRHFSrTxYSOkFic7@grain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRHFSrTxYSOkFic7@grain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Cyrill,

On 11/10, Cyrill Gorcunov wrote:
>
> On Sun, Nov 09, 2025 at 06:15:33PM +0100, Oleg Nesterov wrote:
> ..
> > static int kill_sub_threads(struct task_struct *tsk)
> > {
> >  	struct signal_struct *sig = tsk->signal;
> > 	int err = -EINTR;
> >
> > 	read_lock(&tasklist_lock);
> > 	spin_lock_irq(&tsk->sighand->siglock);
> > 	if (!((sig->flags & SIGNAL_GROUP_EXIT) || sig->group_exec_task)) {
> > 		sig->group_exec_task = tsk;
> > 		sig->notify_count = -zap_other_threads(tsk);
>
> Hi Oleg! I somehow manage to miss a moment -- why negative result here?

You know, initially I wrote

		sig->notify_count = 0 - zap_other_threads(tsk);

to make it clear that this is not a typo ;)


This is for exit_notify() which does

	/* mt-exec, de_thread() -> wait_for_notify_count() */
	if (tsk->signal->notify_count < 0 && !++tsk->signal->notify_count)
		wake_up_process(tsk->signal->group_exec_task);

Then setup_new_exec() sets notify_count > 0 for __exit_signal() which does

	/* mt-exec, setup_new_exec() -> wait_for_notify_count() */
	if (sig->notify_count > 0 && !--sig->notify_count)
		wake_up_process(sig->group_exec_task);

Yes this needs more comments and (with or without this patch) cleanups.
Note that exit_notify() and __exit_signal() already (before this patch)
use ->notify_count almost the same way, just exit_notify() assumes that
notify_count < 0 means the !thread_group_leader() case in de_thread().

Oleg.


