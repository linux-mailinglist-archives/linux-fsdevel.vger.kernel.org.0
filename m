Return-Path: <linux-fsdevel+bounces-75683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGBDB25+eWmIxQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:11:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741DE9C86B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B4530209C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8092FBDE0;
	Wed, 28 Jan 2026 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6dwva0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928952FBE02
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769569866; cv=none; b=nBXMY1uXz3WZWyr0X0USUVmzSNLp2HEqrelVW4xKHdOKhfY2XuweyRbKqweGX7sVsCaIEUrf39Vt2uvJl3ApEOfcsCHzXHi3frlcitK2dgQIywdwVnY9ZyNRTWQ8BkqUYSFl6I2uqqyZnmAx4+uZKwRisIbxNJvym/Q1YkddpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769569866; c=relaxed/simple;
	bh=7s3ZPWD7L/hxVtH81vzKlYQvIHiVdDU71Ms3su09RyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFXb+kWQGNqN/izNJuwb37FHwi73fV+CDsibGEx3qsmcGF0dOlkikLGkb29mnO+pgK+ZrNg/8PZlQy+m3s2kHlhQmn2aa6nq5N1t3jwPNpvPYhV9SIxly4YMTBhMaSQnorzW5vOw37GvpYBFzWqvvXg5GlIvb5QG5k8IWFqMI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6dwva0K; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1248d27f293so2403624c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 19:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769569861; x=1770174661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8aE4fJ3sPMbiTvaUSBnTb2V/aV6aI6bDnZe8VbiSww=;
        b=G6dwva0K7E4XFKGAPRljQRdGGbuT4SRfjDznfAMwd48r23dV+BX0DLJQO+KFKazOR6
         7wX3+zJDDAgQEdjtfO49+sNAwUP7hYkSGEwFYlzDSZEYc6+/u3Khd2mRVjiSvTAX3EtS
         gsK0LbvzPpSAFRfQluyaCvkMLk6Fnk1jAIPud05r5+lgp1Pnz/xg53X1JUd+V0T8F2DX
         dSExYEjEKblFwxwgt6RFoY7S2LBeJG6lA2tweJbVzm8lAtiC35BF445xbpYx3TG83h7M
         f0ndcwe2x69p5ujGEMymgDVENKyNdIeFGocafQCcacesyOLbI4Ok2ajDc4vYccTAk52D
         KfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769569861; x=1770174661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J8aE4fJ3sPMbiTvaUSBnTb2V/aV6aI6bDnZe8VbiSww=;
        b=cDtDOQzzWXKPO0BYDkrw/j79I8Lm+NlKpC9hTitK3mpJJjlHYeHKhPp6xi1AkyJjpm
         gfDQP8QyNTlxC4k1OTqF/XJGnMtJlVJZqNoUqMVX3vP1eJMTgTF39K91BPJVdd7mLsaU
         uGCAORjMLcffJN9yNPRbPRj1FRB/SD7kIwuGX/hKthQEJLntyJTeI+2kjHeMs9wER1O3
         o7Hjkxnm7EU7HzCYQAyX8MoXQtMTDT6niKjXhCtctETuhAWmbEpbwAT6J0+KuttsCnh4
         4CATdXCCsg55VXv0ikvxx4NtWXREW8etQhNYZoMszRny8bqowsI/zcKQIWtFZI9vumR1
         jIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2BELQn80NhuE2Dw7R7wuJ85s4ZxVEHKODpBDLYt5eU7y9Cp/lDYq3+GB8ki62GJITIgWgMcxT5yEVDLPR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FylsqD+R3MQSN/oDVFE9NMBvzn8RqlGvtnHUVbx3EmaJxKkQ
	CsSu35vqk2d+hTddud0rffLwUGpPJo1cG2vVU/2yr/EdeuRQE8/tU3B9
X-Gm-Gg: AZuq6aJlBlt+eQiQY6OutXNIbnkH2a94U8tfws08Qed+FIQMAv3cc5ksxfmQQ5CfEoq
	drVMRxiHnXDLu6nHNPfQseSF5u5ziZ2Rb7eFeefYbUVbyZQhk/Zc20l5/gQ5dHg4y1haqmbJKaC
	PkhMka6gl3pt7mUBFqOb9JzCS8tBZHU8MibTOuyO9lA2I4DTsdHvyks6P4A10XbMKoz5cFbguSK
	dq87GZeWGusbmnQxLWyiwY8Hb8pZG9a2vUiUvunX+Y97S+cSFjPYQcVxJAV/yySE+lk8XWH0Zn5
	h+pY6e+3y+0J0siXU1h+Iz1QgjI020qKSQx/SoAt8s8/cJqvRF6mMptm50PQHVzMW8URC2VmQam
	9O5EmeCI6HB9b/GKURvLDWVQa/fhHEwNdKQxfFSqgyCrSVA8XrdkBS1+6Q7qSRF8i7JEZRUTQGf
	Pw0hWiplIIPivC7WNLw8eGsyk=
X-Received: by 2002:a05:7300:bc8e:b0:2b0:1607:6d02 with SMTP id 5a478bee46e88-2b78da0f5b7mr2592634eec.31.1769569861112;
        Tue, 27 Jan 2026 19:11:01 -0800 (PST)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe57csm1077430eec.22.2026.01.27.19.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 19:11:00 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: oleg@redhat.com
Cc: akpm@linux-foundation.org,
	alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	david@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mingo@kernel.org,
	ruippan@tencent.com,
	usamaarif642@gmail.com
Subject: Re: [PATCH] procfs: fix missing RCU protection when reading real_parent in do_task_stat()
Date: Wed, 28 Jan 2026 11:10:57 +0800
Message-ID: <20260128031059.2762637-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aXj1BZY0P_NQp0yI@redhat.com>
References: <aXj1BZY0P_NQp0yI@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,tencent.com,kernel.org,vger.kernel.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75683-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 741DE9C86B
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 18:25:25 +0100, oleg@redhat.com wrote:
> On 02/27, alexjlzheng@gmail.com wrote:
> >
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> >
> > When reading /proc/[pid]/stat, do_task_stat() accesses task->real_parent
> > without proper RCU protection, which leads:
> 
> Thanks for the patch...
> 
> >   cpu 0                               cpu 1
> >   -----                               -----
> >   do_task_stat
> >     var = task->real_parent
> >                                       release_task
> >                                         call_rcu(delayed_put_task_struct)
> >     task_tgid_nr_ns(var)
> >       rcu_read_lock   <--- Too late!
> 
> Almost off-topic, but I can't resist. This looks confusing to me.
> It is not "Too late", this rcu_read_lock() protects another thing.
> Nevermind.

Yes, and would "Too late to protect task->real_parent!" be better?

> 
> I think that the changelog could be more clear. It should probably
> mention that forget_original_parent() doesn't take child->signal->siglock
> and thus we have a race... I dunno.
> 
> > --- a/fs/proc/array.c
> > +++ b/fs/proc/array.c
> > @@ -528,7 +528,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
> >  		}
> >
> >  		sid = task_session_nr_ns(task, ns);
> > -		ppid = task_tgid_nr_ns(task->real_parent, ns);
> > +		rcu_read_lock();
> > +		ppid = task_tgid_nr_ns(rcu_dereference(task->real_parent), ns);
> > +		rcu_read_unlock();
> 
> But this can't really help. If task->real_parent has already exited and
> it was reaped, then it is actually "Too late!" for rcu_read_lock().

I think this is acceptable, because we tolerate obtaining a stale value as
long as it doesn’t lead to a Use-After-Free (UAF) bug. This is similar to
the comments in the syscall getppid().

With the protection of rcu_read_lock()/rcu_read_unlock() for loading
task->real_parent, we can guarantee that the task_struct of real_parent
itself will not be freed.

Or, do I miss something?

Thanks,
Jinliang Zheng. :)

> 
> Please use task_ppid_nr_ns() which does the necessary pid_alive() check.



> 
> Oleg.

