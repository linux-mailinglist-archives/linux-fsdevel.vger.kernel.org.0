Return-Path: <linux-fsdevel+bounces-75701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOInKkjGeWl0zAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:18:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 065629E227
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AF57300C7D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE43382C4;
	Wed, 28 Jan 2026 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iazI3kXr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A742337694
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587849; cv=none; b=s34cSAXwIVyLnOaAdDOfVVjuk0pWSSjlTG4KLYR9FZImbqxaffaB939ca1W7V70THtHAVG8C7ktpCFM3cUbvWKh0TPLSJTlNHm4wz3GdnN6u8gMAQAID5ZrqhIKEXPDLTJprKtxJiCFWeQzu23rkufO8LnQuVWhQkOxb47SqRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587849; c=relaxed/simple;
	bh=VvaeVmuRI7CwYGqdVxKWNm5HmUN4mUtptE9EHW7ao6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2xvq/TARY20cI1zhCiAFMA3M/j+TvJ6mU7CEIxUtlP08kqNpz7CKDU9UR0lHMO+UbVCc8qeGTWqF0fI4lCU7bnU6JUJQWdcVCaLVV4zl1GcDr8ooa558UYWWMDtvVaeepaWedUY4nWopPDSNMbhg9CK23UpAr8NsYPkX008dX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iazI3kXr; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b714f30461so5831068eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 00:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769587847; x=1770192647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztBy2YnQIGFAzybi0JuQPxDYq2lTOWQlLD52L+pzkeo=;
        b=iazI3kXrYBArObOGxGmjhq+86n7ZKfKV2Ojgdq/brdYdMaJHuVfTjVsRFRlEtvlBBQ
         bZYd6OhEO7wjf6dDd4qmojHJ2ScYLO4lV4W140Z5d/9bE1DyAvVPjQma+t/35hGg/50N
         KVOeRCHT0fyGQ4L0ZS+NqPlrHr79biWAEiZz15wrMHngIzhjden6ZyKWgltxEhB5UJ9Q
         Xh6egIkvTOeU3v+Uauf8wcD04Rcs69AwZmK+vMpou/Tacb0DSgeSnCo7iWFD4uBY6Rsp
         zoNiClZWp5D+V9qXBO0TtlshaAxuuSujx71ErttsYVt+8IilzbtJf9z2qO+lSjEbn23J
         ynkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769587847; x=1770192647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztBy2YnQIGFAzybi0JuQPxDYq2lTOWQlLD52L+pzkeo=;
        b=aYsC/Ug84xMA4J3AdZTFRz32C1FcmbZcyQHbJ3eS1wUNq/oOUtlwB4cbqilyFfqg5b
         fYPnHgdi/3mjyMZxVAWQg6tI4ZMn3SHoV7072ML/iPYw/lOt2IqmQ6xImub0sSzJKvd5
         A1bWSQb0ExHl+B1ANRZfOcbGMh4PTAFoxFkBybcH96LdI9JQk6U0kIwwi+/embwUq8pQ
         YHF6zXzffCZHFCqA2tylZI8d0ZPjTsLORs07m7a7+l0Kf80GPUW8Se9PHWGmphH48MY3
         L3Ap8K+eHj5peYegqldazjY/JL29oQQfULtWpv1KI7d8s95QjkNj8DVe/6Y7xpQVQVhX
         g4vA==
X-Forwarded-Encrypted: i=1; AJvYcCVrOjDf0c5zf8IKIGu9HQydwgYGoq4GqKJLLZVrWqHR6t2Kqb407EF99zHqce8rJml8jVg8zSly1z+5Oc/8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51oWc+sZB6xZfY/ykUAQ/abuc5boD1YZ/TIqysyeKaAXhW+JY
	5xLhYGVpN3h4wcM5gkw3FKLWYEAeNxWMz2HZEG8evKwYNadsv67MuKp8
X-Gm-Gg: AZuq6aIRLdhTWvtTHnxIn+GLqGxOgS2OiREg4o3yRvCUld6qNL8bGXwU4hI3bNP2Z6g
	7sSaEeeq4XrdLRdC5rjw+MCqI3Rd6w04OHqIeEsGLn30SN22Ry/pvarpBeUEV7ydz3Vc5h4diWo
	houerf3QTMxkexsIBEJqCcfTel1604soNgXw/oXwlaiEHNQk/RPGS12wJ3SFWJ7VNxglUd8gCBz
	GgfR16cvrEVm9EQS8Nvw31zeoGdsFwgZRnGBvL67Bh97lJvSICgTNhxjO+sugeWSlR2DDR0Llof
	/jQVXoIq7ZCWFmZ99WEq4CXMTgx1Aw1yb73iQRNbM9viupOQx/oipQqichKvA9F7kUkUOf4+Flh
	W9iqt84LWpOIcSl/NBntkIMAFSNwLry8VaC2qgL25VqviZaYuRjycNIaBnOpFqWoOoYW2xrO4iy
	Pji2hE6ncZJoLpTwiFVWNeIEn0jBb0+sdgQA==
X-Received: by 2002:a05:7301:fa8b:b0:2ae:581f:ce5 with SMTP id 5a478bee46e88-2b78d8a8841mr2800563eec.7.1769587847034;
        Wed, 28 Jan 2026 00:10:47 -0800 (PST)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cfa25sm1642435eec.5.2026.01.28.00.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 00:10:46 -0800 (PST)
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
	mjguzik@gmail.com,
	ruippan@tencent.com,
	usamaarif642@gmail.com
Subject: Re: [PATCH] procfs: fix missing RCU protection when reading real_parent in do_task_stat()
Date: Wed, 28 Jan 2026 16:10:45 +0800
Message-ID: <20260128081045.2833487-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aXnCX7SmABmQJis3@redhat.com>
References: <aXnCX7SmABmQJis3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75701-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,tencent.com,kernel.org,vger.kernel.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 065629E227
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 09:01:35 +0100, oleg@redhat.com wrote:
> On 01/27, Mateusz Guzik wrote:
> >
> > On Tue, Jan 27, 2026 at 06:25:25PM +0100, Oleg Nesterov wrote:
> > > On 01/27, alexjlzheng@gmail.com wrote:
> > > > --- a/fs/proc/array.c
> > > > +++ b/fs/proc/array.c
> > > > @@ -528,7 +528,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
> > > >  		}
> > > >
> > > >  		sid = task_session_nr_ns(task, ns);
> > > > -		ppid = task_tgid_nr_ns(task->real_parent, ns);
> > > > +		rcu_read_lock();
> > > > +		ppid = task_tgid_nr_ns(rcu_dereference(task->real_parent), ns);
> > > > +		rcu_read_unlock();
> > >
> > > But this can't really help. If task->real_parent has already exited and
> > > it was reaped, then it is actually "Too late!" for rcu_read_lock().
> > >
> > > Please use task_ppid_nr_ns() which does the necessary pid_alive() check.
> 
> Ah, I was wrong, I forgot about lock_task_sighand(task). So in this case
> pid_alive() is not necessary, and the patch is fine.
> 
> But unless you have a strong opinion, I'd still suggest to use
> task_ppid_nr_ns(), see below.

I don't have a strong opinion on this. Your suggestion makes sense - task_ppid_nr_ns()
is more maintainable. I'm happy to update the patch as you recommend.

Thanks,
Jinliang Zheng. :)

> 
> > Suppose it fits the time window between the current parent exiting and
> > the task being reassigned to init. Then you transiently see 0 as the pid,
> > instead of 1 (or whatever). This reads like a bug to me.
> 
> But we can't avoid this. Without tasklist_lock even
> 
>  	task_tgid_nr_ns(current->real_parent, ns);
> 
> can return zero if we race with reparenting. If ->real_parent is reaped
> right after we read the ->real_parent pointer, it has no pids. See
> __unhash_process() -> detach_pid().
> 
> > It probably should do precisely the same thing proposed in this patch,
> > as in:
> > 	rcu_read_lock();
> > 	ppid = task_tgid_nr_ns(rcu_dereference(task->real_parent), ns);
> > 	rcu_read_unlock();
> 
> No, task_ppid_nr_ns(tsk) does need the pid_alive() check. If tsk exits,
> tsk->real_parent points to nowhere, rcu_read_lock() can't help.
> 
> This all needs cleanups. ->real_parent and ->group_leader need the helpers
> (probably with some CONFIG_PROVE_RCU checks) and they should be moved to
> signal_struct.
> 
> So far I have only sent some trivial initial cleanups/preparations, see
> https://lore.kernel.org/all/aXY_h8i78n6yD9JY@redhat.com/
> 
> I'll try to do the next step this week. If I have time ;) I am on a
> forced PTO caused by renovations in our apartment.
> 
> Oleg.

