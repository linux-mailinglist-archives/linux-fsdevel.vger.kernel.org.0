Return-Path: <linux-fsdevel+bounces-43210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100ECA4F638
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 05:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B775188F407
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 04:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351FF1C7006;
	Wed,  5 Mar 2025 04:57:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914B1C6FE5
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741150638; cv=none; b=YMvJcDZz44jmsq822obFMIJ7OEkKKTTyoQaIYkeNNH6+VcB2Bmy5X4SsDuLL7T7vNbrc7ZYxyrCIjBXXfl8O+1oLm9ilxISWkMev8VUfB+uLGaJfE2XjuG7oQNmRgMDgk7DANcWGBIPhPoRr1Ux/NTu0DGEn8OWvAB9OG8jgHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741150638; c=relaxed/simple;
	bh=lx9JQ9iInq+eLSKfXchpe7VsIW5kZCiAzJbLsIeSWLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5GyffHNO52lsDUOmmAg4z5AJV0x/xHnwotPe8g2Lrek0x6N2xoHlnGHnrqip3iMtWeORNVZswjvAp32XC0PFjoVhV4pLDw+r17vzzBnUpTyWng01HYwCCbkQ7cleHkBXLDmGz/u36sOz0PsFN+XjYFdXh1inJ+Up833b6+nMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.118])
	by sina.com (10.185.250.21) with ESMTP
	id 67C7D97900006B8A; Wed, 5 Mar 2025 12:56:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8233233408524
X-SMAIL-UIID: 433835C6842641ECA1204EE37E41343C-20250305-125628-1
From: Hillf Danton <hdanton@sina.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Date: Wed,  5 Mar 2025 12:56:16 +0800
Message-ID: <20250305045617.3038-1-hdanton@sina.com>
In-Reply-To: <20250304234908.GH5756@redhat.com>
References: <20250224142329.GA19016@redhat.com> <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt> <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com> <20250227211229.GD25639@redhat.com> <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com> <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com> <20250304050644.2983-1-hdanton@sina.com> <20250304102934.2999-1-hdanton@sina.com> <20250304233501.3019-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Mar 2025 00:49:09 +0100 Oleg Nesterov <oleg@redhat.com>
> 
> Of course! Again, whatever the woken writer checks in pipe_writable()
> lockless, another writer can make pipe_full() true again.
> 
> But why do we care? Why do you think that the change you propose makes

Because of the hang reported.

> more sense than the fix from Prateek or the (already merged) Linus's fix?
> 
See the loop in  ___wait_event(),

	for (;;) {
		prepare_to_wait_event();

		// flip
		if (condition)
			break;

		schedule();
	}

After wakeup, waiter will sleep again if condition flips false on the waker
side before waiter checks condition, even if condition is atomic, no?


