Return-Path: <linux-fsdevel+bounces-78439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CIkFmLHn2k8dwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:09:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA74F1A0C73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D05DA3054215
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 04:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325C738551E;
	Thu, 26 Feb 2026 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="XRrj5ONf";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="ImSWCFp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490563115B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 04:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078941; cv=none; b=jxCE/QryAu/5Ga0Y7xkex+UHV6yirjQK2q6RaDk5am3jto4CTeIizvbt2F1nvYVN/r7ZAW3VLBDuhP5M/7A0k06o2IkHwpRUblvfpewUltxrVYHNb6Dty+PbR96dCIVyn4kzncjEgyXYmadpqL45H8Eg//bzpQhCMcwIIIkhJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078941; c=relaxed/simple;
	bh=bWEgrwGMxeI+UgEb4w4gxFZtIHH35PKqIs9TkbXytGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+iTd3QE9/FpdvQHtzDufEoyy6bbtu73QszF1oBNkFKIt/ivs2M/FZFvVyi26CdzO5d6lKSlNHlbVjA9mhPA8uenlFfPPWMIzvepbQosSpEjCO6hGhC8vCGNOT+AQZe2Gz368NYf5zzb1JD5P26HjOzQ67ip3Bk9+v4bsjHUwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=XRrj5ONf; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=ImSWCFp9; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1772078937;
	bh=bWEgrwGMxeI+UgEb4w4gxFZtIHH35PKqIs9TkbXytGU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XRrj5ONfuvy5duMBZU6U4+PWXPWoiyOYCgz61scSCAo44mEZpeO7LUc5X5i0KmTjj
	 Nt1U0dQvLGbzGS2xtXN9wh4DnpeZgmGkYXF0VYIXM3o6kI5oC5EymJnrakGdyTmGDm
	 cwvjJxs/sK49ibdfFGrQo3crWApS9oz78Pr3CvWRKYNGw4SWr2WbHX+N0qiEXnt8N1
	 hyyqtNx9rncorX1XhRztLhOrNhkOJ9gsYmy6aFQ7iD0HJ9RvqiV5JEh+oxtfBN4Igx
	 X+M6I98LHTd6sODwRRmScQR9KaQLDmP0WlmbgspPpK4gEjUhzgokwvwWBieoNba5Ma
	 LN0U0AsqYtqHU9n5Iebrpl36QwMG0p++nEc1UevfeHMRxG6JnhcfQVdsVsKUNElIoX
	 cFTe2FHAYVXIWzkZRcdjpDLefdXkRFygYa+1nGz8kGv+9iIvUI9bavKFtxxfLHWQvh
	 qkcYm6NM33lM3SzeK8RQkH2oO5iiOwj4KsmPoPvY9mWifteOFLMUY4u7FCunWt9bWM
	 KJ9QvF3NmNzCbgCkxcARYpiK02OcVgS20cGAzHZaN3QnsOw/Ppq0S/czZKjxagi/j4
	 WCiJavcT4NoeOuWbACzGpib0V8mHls4MXSa+xpdbyDIKqMstRTlcHwtu6jpKXtxLxw
	 Wn5j9iPgU6wUc2VBlviXSdmg=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id BEFA91E79A4; Thu, 26 Feb 2026 12:08:57 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1772078936;
	bh=bWEgrwGMxeI+UgEb4w4gxFZtIHH35PKqIs9TkbXytGU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ImSWCFp9Kpl/TpO8fVU3gmIewWT9dO3qf6bHOuQTtZQCQ+OiGhSxUTK9oUPO9bKFe
	 vPFVGhNDACJ3KEOzIA/3/ajqWlfU25DUjeW3oqk9DMG/EO2E8/NbLKUeNG1cRSH93r
	 SsPHaVsUKV71ollxgwGnIgnzNXxKhmuM8fdRZFf01S7ODmeIaibdUXb5UsEAFs/tA5
	 8IOrUzM70SE5uDTk4wPkgdEkfqRSxGfhIpB8siuyFP1dPasEshHoJ8gQYOyseMaDnj
	 WrqhVknh96ilQtwGRuss9m94LFOy7K2V4yEzscQq1UXVC3zKgV5sZQuzvkSQtSumOY
	 tbeI+ElCWhDZU2CCOwP4JRcmgdMLE5oNAiyCVoKlbNJ64lmC/tARMR6D1dqlMWlYFc
	 zXqTKNseHSuuRUwSFVfb1M/QRu5AE8fZmqaW7nfZFJXavGzmLYZSzeWKpkSyMw5HFM
	 ID+aqUdqiOuE8CB/htZdELtkxhsrRuVMkF54zq2WaxCiZxyUASieq5SxGgzp7R5jkM
	 3dXjDrrzd7F/xm/sUa0L61J+2vXZ9oWY1j/ZwI72RJzyOu7FO1rWl3HOuVATXx+lvO
	 7IZlZIKb7gjDfKUgn1JT6E378XUZg+KBNwqZb8pOImEc8G/faU/0wKg5m58UvrOAAj
	 roa4PAu7+xERccVBrbH6dP6s=
Received: from [IPV6:2001:8003:8824:9e00:6d16:7ef9:c827:387c] (unknown [IPv6:2001:8003:8824:9e00:6d16:7ef9:c827:387c])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 507021E799A;
	Thu, 26 Feb 2026 12:08:56 +0800 (AWST)
Message-ID: <7170a7bb-c157-4e3c-ab7d-1d5b22a6bb0f@davidgow.net>
Date: Thu, 26 Feb 2026 12:08:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make_task_dead() & kthread_exit()
To: Christian Brauner <brauner@kernel.org>,
 Guillaume Tucker <gtucker@gtucker.io>, Tejun Heo <tj@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 kunit-dev@googlegroups.com, Linus Torvalds <torvalds@linux-foundation.org>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io>
 <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
 <20260224-mittlerweile-besessen-2738831ae7f6@brauner>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260224-mittlerweile-besessen-2738831ae7f6@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[davidgow.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[davidgow.net:s=201606];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[davidgow.net:+];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kernel.org,googlegroups.com,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78439-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@davidgow.net,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA74F1A0C73
X-Rspamd-Action: no action

Le 25/02/2026 à 12:25 AM, Christian Brauner a écrit :
> On Tue, Feb 24, 2026 at 02:22:31PM +0100, Christian Brauner wrote:

(...snip...)

> 
> Ugh, yuck squared.
> 
> IIUC, the bug is a UAF in free_kthread_struct(). It wasn't easy
> detectable until the pidfs rhashtable conversion changed struct pid's
> size and field layout.
> 
> The rhashtable conversion replaced struct pid's struct rb_node of 24
> bytes with struct rhash_head of 8 bytes, shrinking struct pid by 16
> bytes bringing it to 144 bytes. This means it's now the same size as
> struct kthread (without CONFIG_BLK_CGROUP). Both structs use
> SLAB_HWCACHE_ALIGN bringing it to 192. KUnit sets
> CONFIG_SLAB_MERGE_DEFAULT=y. So now struct pid and struct kthread share
> slab caches. First part of the puzzle.
> 
> struct pid.rcu.func is at offset 0x78 and struct kthread.affinity node
> at offset 0x78. I'm I'm right then we can already see where this is
> going.
> 
> So free_kthread_struct() calls kfree(kthread) without checking whether
> the kthread's affinity_node is still linked in kthread_affinity_list.
> 
> If a kthread exits via a path that bypasses kthread_exit() (e.g.,
> make_task_dead() after an oops -- which calls do_exit() directly),
> the affinity_node remains in the global kthread_affinity_list. When
> free_kthread_struct() later frees the kthread struct, the linked list
> still references the freed memory. Any subsequent list_del() by another
> kthread in kthread_exit() writes to the freed memory:
> 
>      list_del(&kthread->affinity_node):
>      entry->prev->next = entry->next   // writes to freed predecessor's offset 0x78
> 
> With cache merging, this freed kthread memory may have been reused for a
> struct pid. The write corrupts pid.rcu.func at the same offset 0x78,
> replacing delayed_put_pid with &kthread_affinity_list. The next RCU
> callback invocation is fscked.
> 

Aha... that makes sense. What a mess!

> 
> Fix should be something like
> 
>      void free_kthread_struct(struct task_struct *k)
>      {
>          struct kthread *kthread;
> 
>          kthread = to_kthread(k);
>          if (!kthread)
>              return;
> 
>      +   if (!list_empty(&kthread->affinity_node)) {
>      +       mutex_lock(&kthread_affinity_lock);
>      +       list_del(&kthread->affinity_node);
>      +       mutex_unlock(&kthread_affinity_lock);
>      +   }
>      +   if (kthread->preferred_affinity)
>      +       kfree(kthread->preferred_affinity);
> 
>      #ifdef CONFIG_BLK_CGROUP
>          WARN_ON_ONCE(kthread->blkcg_css);
>      #endif
>          k->worker_private = NULL;
>          kfree(kthread->full_name);
>          kfree(kthread);
>      }
> 

This fixes the KUnit issues for me, too, so:

Tested-by: David Gow <david@davidgow.net>

(But so does Linus' patch, which is probably the nicer long-term solution.)

Cheers,
-- David

