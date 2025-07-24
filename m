Return-Path: <linux-fsdevel+bounces-55945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF19B10A64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891204E7414
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5B2D3740;
	Thu, 24 Jul 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XOhmip1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA22D23A8;
	Thu, 24 Jul 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360707; cv=none; b=bAQXHy46eOSGykxCLHwRIumhCzT6kjHQFepmK9P16bFjaWcI0TlHp2+8/gchUxic4uxXi7mrn92AJy0WEKkRXMpcxP9v9AXjtN8tj68KPcEEhnGa1YMbByR4ht9iF/JIFFfyQJRseIaX6HnChzcwZeFG13mIPtbRjPeoLHCd0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360707; c=relaxed/simple;
	bh=oF1fjfkcVmB47jUFQZrbOFPuVcCIV0oFRtx6l9F7rNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6ZhqEvOfUmWBH9x4B/LFceyg0n5fKXVysaDw/trd2U6enzzKvywSPFdpFyz8Ccr22UYSlgB7OdAroKNOeGdwAxL8c5rK8hx3WNbliiyMwsFs70s2xgUn2x+szLQeRDa+SdeEFYIKdQh7WoCt1164o7HhK743QOU/gfTXzHTmVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XOhmip1v; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OpVluK64wbdpkdLsO7dOz1cGp/QvzyiM9Vm+tiWw0F0=; b=XOhmip1vJ7HCfZq/ITREXL45gG
	pvCRuaCPysU2hUV/3sUehtINSqAZG8zriQUe21ybHGtJuR6U40TwqytsHVuOom7ocx3cJRbeRkQbs
	iCNxhS2Z+aSAH2qEJ1D/s1z5x5JiXExEWyzW15xE9bglEx92reIjlH5dvgQATLbXeiFLcVY5TgBWE
	zwuG+P1xQuDzmtgPXUsJZ+87Wg9XMQA1Ebz19fnvSqYbpwkHtI4ZgoixG8KNMzEVK9lRB8PPZCxvw
	soXVwtmRVoYvFW2IzHim4lwZm8Uo0JA1+RUaSl1uXkmfQyhdkGXVJkpttmCb0vNkLy3uoOJSNVrqX
	BCbk9jzQ==;
Received: from [223.233.78.24] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uevDH-003BUG-5O; Thu, 24 Jul 2025 14:38:19 +0200
Message-ID: <6fec26c9-b240-6548-c970-882c0576ef33@igalia.com>
Date: Thu, 24 Jul 2025 18:08:10 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str
 which is 64 bytes long
To: Askar Safin <safinaskar@zohomail.com>, bhupesh@igalia.com
Cc: akpm@linux-foundation.org, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, arnaldo.melo@gmail.com, bpf@vger.kernel.org,
 brauner@kernel.org, bsegall@google.com, david@redhat.com,
 ebiederm@xmission.com, jack@suse.cz, juri.lelli@redhat.com, kees@kernel.org,
 keescook@chromium.org, kernel-dev@igalia.com, laoar.shao@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, lkp@intel.com,
 mathieu.desnoyers@efficios.com, mgorman@suse.de, mingo@redhat.com,
 mirq-linux@rere.qmqm.pl, oliver.sang@intel.com, peterz@infradead.org,
 pmladek@suse.com, rostedt@goodmis.org, torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk, vschneid@redhat.com, willy@infradead.org
References: <20250716123916.511889-4-bhupesh@igalia.com>
 <20250724091604.2336532-1-safinaskar@zohomail.com>
Content-Language: en-US
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <20250724091604.2336532-1-safinaskar@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/24/25 2:46 PM, Askar Safin wrote:
>> where TASK_COMM_EXT_LEN is 64-bytes.
> Why 64? As well as I understand, comm is initialized from executable file name by default. And it is usually limited by 256 (or 255?) bytes. So, please, make limit 256 bytes.
>
>
Check existing users like proc_task_name(), which use 64-byte comm names:

void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
{
        char tcomm[64];
        ....


Hence, it was decided not to change this and other similar existing 
users and cap tsk->comm to 64-bytes.

Thanks,
Bhupesh


