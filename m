Return-Path: <linux-fsdevel+bounces-75640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDvUL7sKeWnyugEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:58:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7418C997D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7949630EE0D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFE6365A19;
	Tue, 27 Jan 2026 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5cnXmGn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A7352923
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539761; cv=none; b=enFWavnl7dFJ/aTIS7ZHd1xcvCP5jDpOmFIEdHGGIRTMszVDTF5U5m7TFWJCq0Z1K4HaMduPK2S/MFepypKrQWhn9N9g9DuT1wIvoHU6HBukXp8ih4oRXz7j+WXRN0ljs7GihKdYX6wCT0WboNDuTDLnWGzLymnrKt0imH+gHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539761; c=relaxed/simple;
	bh=H/mUqj1MHym3h+xccswqiYBIcdRG1+8Acfn4Jr0zMSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNo4zXvAdMTZPmfp0cR980Wz9/ba+EMoGN/kkX3J8agRZT5SqLQWWN5Dxl0yQP3ydUSFCfX4NPZ7KhObeTtT3cLj/WBVKj3gcwav9jgBILE8TiwFFBkn6RXd1X2JwQINl2A7w4fSL0SC9XhTZ3VUNX/+FVg+mpEkl1d+TAADx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5cnXmGn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59deec3d8dcso4154750e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769539758; x=1770144558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anXGgOceECfQoLypx++H38it/s+nZ40qvJA23frVAZ0=;
        b=k5cnXmGnLS+O68gA8yv0cwthCOqxTsiGr3ROkTYBkrziEs+gej30AcFX3kXLSei2/U
         27YC0edI53VgeJa9pKBW3hc+rCJxgLBI4BBxTN2Po47luE38+SM3DuHTnUnhp/P/x3TE
         Esmeke7eIItb9kFS5oxL9buhQIO3UVH/I4pPoMnDdeRV39myqSOJBeCDfk1Z2q5vjpYH
         NRA3SUyiG4F6lHCd4r2FmTrna+3PtJ5jLX9J19G3uGNOJJTBMy96EW1j5D57job+Kkfv
         8yp99Eaxv7uK2dbW0T26ZaH+LN8Rj8qGh7vF3v94vrgFv9FBP4UsrSxa9b5r21oQfmZY
         Ylig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539758; x=1770144558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anXGgOceECfQoLypx++H38it/s+nZ40qvJA23frVAZ0=;
        b=fBDuQRQoti9q07Dga4szMIq93QOoL+g/b4E2AUhx8J12s9XwqM41/uhVJs8oDwCre1
         lbV7UXT0FBlZ0H12NjAXTUR0OAbVKeo57uoJXuVJwC+JJf933dUXrzI0Hf/60Sr9nZ8l
         8+MJ4v2J5AJEAYvodH1yHuzRBtlR5Cx+kfMI3lM1tQ5z6OHZ2rm70UtX35vRsKwYsGK+
         rM9glts/2Z0zTbAQBrycVejZndfVfaxdqtdgHMWThX9iwZMDtSh7x/abgHBwXqyWtBbd
         WBSXtrbUZa9owfqlxbC7CrNWymndPbI2Py4etqCKUOpV4KW4yPNJ1Aqmszx99GFi9RzK
         F4wA==
X-Forwarded-Encrypted: i=1; AJvYcCVM955BMImLIFw0adK0ByT7+I8fC1LL0W9i+tg1VhYd3btv9+Ttm7GZShFVqM/mzJn30unGyDtQAGOfwCP3@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKHS7PJMB6mB7RoWeJpQd8oY/AKQpEeEZ9lCzD52wKN38eKB4
	/0rfNpn9KYxs+cyLrrP17o1clVwVTHG57DvX1NOCt4O3vgMbDmmAoWI3
X-Gm-Gg: AZuq6aIoU4n3btBDiTmbhAMGnvre9SJtFLxWDxGP9tBbCNzckBPFPNT9cRIPA3xX8er
	unoqu/xKui1o6PRE0j+bNPJekoBPp/gnhYDBVeg2PdyssHpdEiWJ+YDWgmK6LzDhDWDBIksbyHJ
	CTpnCLXSLWVg8HzzRDFeZnveU2GbKmeax1TFy4dXMbcuH+g1p4sXjUUptEP1wak4Ajs38IoR3dr
	DQ/+6/wFPBQpCItNO6rBmgQYiUnKgS2TAiPcLgEmChjbevGkJ5XvbSa2BDREOs2FdUsbCKgbK9t
	bCtG+jajRKmTLMCHe0GjKxpK1pGu2VZLl18G0qfVwZ3+FWgqSKXfesv1igmf9mGsJK3WLVoThwu
	sB1W7P3zlIo+HNCpkSWcv3X1m+VbM6DOdhnSoqGGN55OQWtDKKY+DV3yGmuZSpS+9sbS0mqsqkC
	xwFBLUDobuIsTsULZ7mLMzBX7STe0tYfpduX19ASFZVNzIrnPQdlQIe3+4w763tT8IM3v0Sw==
X-Received: by 2002:a05:6512:3993:b0:59d:e5e0:3dee with SMTP id 2adb3069b0e04-59e0402535emr1412810e87.27.1769539757664;
        Tue, 27 Jan 2026 10:49:17 -0800 (PST)
Received: from f (cst-prg-85-136.cust.vodafone.cz. [46.135.85.136])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b98ebsm95376e87.80.2026.01.27.10.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:49:17 -0800 (PST)
Date: Tue, 27 Jan 2026 19:49:11 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: alexjlzheng@gmail.com, usamaarif642@gmail.com, david@kernel.org, 
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, alexjlzheng@tencent.com, 
	mingo@kernel.org, ruippan@tencent.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] procfs: fix missing RCU protection when reading
 real_parent in do_task_stat()
Message-ID: <zgqq2et7hf4fh3ggzvvcfmr5wkwoqjfzftxpdedinwinpr4xun@jrbtkbd5ig6n>
References: <20260127150450.2073236-1-alexjlzheng@tencent.com>
 <aXj1BZY0P_NQp0yI@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXj1BZY0P_NQp0yI@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75640-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux-foundation.org,oracle.com,tencent.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7418C997D6
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 06:25:25PM +0100, Oleg Nesterov wrote:
> On 01/27, alexjlzheng@gmail.com wrote:
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
> 
> Please use task_ppid_nr_ns() which does the necessary pid_alive() check.
> 

That routine looks bogus in its own right though.

Suppose it fits the time window between the current parent exiting and
the task being reassigned to init. Then you transiently see 0 as the pid,
instead of 1 (or whatever). This reads like a bug to me.

But suppose task_ppid_nr_ns() managed to get the right value at the
time. As per usual, such an exit + reaping could have happened before
the caller even looks at the returned pid.

Or to put it differently, imo the check in the routine not only does not
help, but introduces a corner case with a bogus result.

It probably should do precisely the same thing proposed in this patch,
as in:
	rcu_read_lock();
	ppid = task_tgid_nr_ns(rcu_dereference(task->real_parent), ns);
	rcu_read_unlock();

