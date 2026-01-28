Return-Path: <linux-fsdevel+bounces-75684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNNdAG1/eWmTxQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:15:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF109C8AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B49203007A74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28660315772;
	Wed, 28 Jan 2026 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGy5GGb/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490FF3148B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570150; cv=none; b=jwN2DRBDOaz0Uwnw5Dwrcxv9eUZcf3ouj1LFeox4ZILhQHCldvESapCsIFLEboUBaLI7MkQ+IhjZJu8Xilavvzd7OtQ0Gc+5Gb6spKJxuvoFFLsH3lHRosFEfNNefC/MoetUox4amzorcCxoBZha38GO+4TTol45CDVn2ncG1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570150; c=relaxed/simple;
	bh=vtF4E/mr/ie0MWPI23LtgUZNLkE6ErPj+Qkech8Mh9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4ASdIba7B6VZOzqpW0m43v6V7MU7xcPzx7qGZrt+pxYp5X+L1oKw4ryXVEAgJNHQBaAaLAZRtLJiM5otAzaKF34wj4q/IkLLhwH5+LPJ4eftNPr3w+b6HZceI0aWqJty0e2Ze8feJfX2fZmfqPE1EYNEY1gBsSISObb0uqx6Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGy5GGb/; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12460a7caa2so9468293c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 19:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769570148; x=1770174948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rmdqxq12jxkW5lopADlvoi+6VcXP8g+P7d73AjY9AO0=;
        b=bGy5GGb/7tUsqRE8FQeedPGA5M4EFwCoyyR3/D59zj4JD4I+yJCK29qiWYbAvXOYmc
         Xlm00l1PPooS/vJVREbcczRGDnVDCN4BUwFBbif4/XWXYTy5k5t1jPtPPpAIZspYFdNm
         BUC16q41r+gBOyRzz4NZPEAZ67ifmXXu/qJQidFWxPF52hMOIKowNXaB0vE50ECuQPag
         sXrp2lP/0g5v6nSylPxwiv0Xr2cnE5vnyanrJdiy1vLSKmO6EI6p2YVGuefzYaLZRwIs
         mbTKk2TDF9H1LY4mEqDRDyLQZ8ErM4PA2/6Wi3ohxufncQ51mrQ20mHUqFdiaAs+ry1k
         7jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769570148; x=1770174948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rmdqxq12jxkW5lopADlvoi+6VcXP8g+P7d73AjY9AO0=;
        b=GQqrpfOCCamxX6edxpduovR8alqo+1m+qZeq8oOtIQ0gCBZsQ5ZVVw739QXualgtk4
         c1MlYh94LXrlHlm03gY1hxXM0aU8mHGYnW0I85TUlK3fKXFA1PmG7djGVLVvnmhtx3r2
         7emxLOHH8DHB8y8WsIbhN9q21LrHz6T1fUMPTB4lJLsPum+yzGB7ZHeLLI1LyDSyPP6A
         7MhCZdxx+zoBMVMbDax5+348oIgZ90MH8oDl+zN6XHEBzMBT6qMc7kQt5MXagehwK449
         IMh94fmTAdjVHHX+ffdMWRgWE5NImmt8UigwuiTfj3Z9vff0XfN+nEqkfoNPtosNYspQ
         mxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCULsKPH/Zknf9kisOp9f26ScNPoS3vofK6Lj5/4Zwg6RJ6WvXW7fc9uFTCZx08MCRuukGEa6WzWnCHJg0nA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Sm822q1tWNsoWJUwW1p5SvJE74TGsMDZGjKubgVK1YI+Cz9u
	cJbChpJqteP5wC6EFE4XU9Cka3XzpQEl+qF+AabAIczQiuYo2qQXC2RD
X-Gm-Gg: AZuq6aI1IuB6ZGpq3sUpGK5IEJHWbKGfDCdA2zsKUEfdZHMUTNGFFUSnUgq+IPy0/QD
	EbAh50Vls9CnI31Le7hS77iBQN4vcKxR0saWVWpAsAHrfFubqe2D0MhBgIJdIk0Q6FeMHh7V2rx
	J9lCaE2wOf4DRHmC5KmtPUNyk8cVeNRrAhpr4hGxrUqNaHG67jM9wxD9065B/9XfdoakO6KRAMA
	wmdrvM7AZNRNXLMTkMy0rSk9LKvY9e3nfurD2I+nKOTtf7/kezX0i+POjqdAE6V1Baak9milc8T
	eP/LWMzzir/ORIBzP/hA/H16zcFZtZElrOxzQKEeWin8qoI15jPwwXJG0SvP7enElMD6dIRdM4z
	HSXfnpdk+ASOA6ikYnmeHcbaV71x1825fdZzR0K0qorN2CmtvE2wmzMfl9TYjhaMKNy8A50hOSv
	orhbYIYRMucUFIm4pHqhhxV6g=
X-Received: by 2002:a05:7022:608e:b0:11b:9386:8265 with SMTP id a92af1059eb24-124a00e4ef2mr2828262c88.42.1769570148211;
        Tue, 27 Jan 2026 19:15:48 -0800 (PST)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9de7febsm762478c88.10.2026.01.27.19.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 19:15:47 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: mjguzik@gmail.com
Cc: akpm@linux-foundation.org,
	alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	david@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mingo@kernel.org,
	oleg@redhat.com,
	ruippan@tencent.com,
	usamaarif642@gmail.com
Subject: Re: [PATCH] procfs: fix missing RCU protection when reading real_parent in do_task_stat()
Date: Wed, 28 Jan 2026 11:15:46 +0800
Message-ID: <20260128031546.2763743-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <zgqq2et7hf4fh3ggzvvcfmr5wkwoqjfzftxpdedinwinpr4xun@jrbtkbd5ig6n>
References: <zgqq2et7hf4fh3ggzvvcfmr5wkwoqjfzftxpdedinwinpr4xun@jrbtkbd5ig6n>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75684-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,tencent.com,kernel.org,vger.kernel.org,oracle.com,redhat.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,linux-fsdevel@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tencent.com:mid]
X-Rspamd-Queue-Id: 0EF109C8AC
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 19:49:11 +0100, mjguzik@gmail.com wrote:
> On Tue, Jan 27, 2026 at 06:25:25PM +0100, Oleg Nesterov wrote:
> > On 01/27, alexjlzheng@gmail.com wrote:
> > > --- a/fs/proc/array.c
> > > +++ b/fs/proc/array.c
> > > @@ -528,7 +528,9 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
> > >  		}
> > >
> > >  		sid = task_session_nr_ns(task, ns);
> > > -		ppid = task_tgid_nr_ns(task->real_parent, ns);
> > > +		rcu_read_lock();
> > > +		ppid = task_tgid_nr_ns(rcu_dereference(task->real_parent), ns);
> > > +		rcu_read_unlock();
> > 
> > But this can't really help. If task->real_parent has already exited and
> > it was reaped, then it is actually "Too late!" for rcu_read_lock().
> > 
> > Please use task_ppid_nr_ns() which does the necessary pid_alive() check.
> > 
> 
> That routine looks bogus in its own right though.
> 
> Suppose it fits the time window between the current parent exiting and
> the task being reassigned to init. Then you transiently see 0 as the pid,
> instead of 1 (or whatever). This reads like a bug to me.
> 
> But suppose task_ppid_nr_ns() managed to get the right value at the
> time. As per usual, such an exit + reaping could have happened before
> the caller even looks at the returned pid.
> 
> Or to put it differently, imo the check in the routine not only does not
> help, but introduces a corner case with a bogus result.
> 
> It probably should do precisely the same thing proposed in this patch,
> as in:
> 	rcu_read_lock();
> 	ppid = task_tgid_nr_ns(rcu_dereference(task->real_parent), ns);
> 	rcu_read_unlock();

I agree.

Thanks,
Jinliang Zheng. :)

