Return-Path: <linux-fsdevel+bounces-10373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267AE84A941
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F921F293D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084651AB7E4;
	Mon,  5 Feb 2024 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="MfEUDI+t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0149C1AB7FE;
	Mon,  5 Feb 2024 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171778; cv=none; b=lGgJVBfNHzdW49TLhKWBx/TUf+mUCPqcE/ImrtukJ7XDL8QGYjyRTdlXP9bZgAU666Ru8pTc+gxkXywISgd4PZEpF4P/R6IDxKRjs2VbA3NcONHOyo8vTzNK9tHGm895DtUngUKmWRsCsUdgyFlnZkNZsGT5ydrnSRP3EotVpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171778; c=relaxed/simple;
	bh=muqtPUPHvvXmhJhkEjtUSypRs2rrWoAXgqJbMgvloKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7pFKiBX4mxGdLzqGToGZE9HWji88XUn1j062A7K6qRlEceW1AzeoJBJQO8JjlvB+3k1o6j5kWQnmzpMnOd92+UqZLM0Va5J8z9rUPNirSOsKmV1jX3dCrh8rHg7XcEX6FmNDTKxEZFDdyTxRB578fCELT8Mgs4iSFM9J4260dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=MfEUDI+t; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1707171771; x=1707776571; i=kernel@valentinobst.de;
	bh=muqtPUPHvvXmhJhkEjtUSypRs2rrWoAXgqJbMgvloKU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=MfEUDI+tedvVkV2+7d9CJadW+qzPgqIG5/g/WcVYxlHTflbYlP62+8jl/dlZbUtP
	 1+4g/QhHLOMnrR67/Q1besxsJBROpeNMus+M1IQzysM8bxS1Km7Bnlcv+ES3D4qi0
	 DSmoEMQTTXl9yKrm9giXZuY7nozd8lyh9vQQRjAzgHNvZAgjGX3UNuRyIUIf/aHb2
	 Uj5wsmUL2OcnYfFm4G8jIQrtm4hCAHhloh8FJYQThHXemE2Nb1eW0+i+oUufLX1zB
	 Q/kxyPQOoxbx/p7a2C0yqNGRMWkCcPwf/6r41jDyQt72RXBSu6iufyKoiYdiigQNl
	 FjnhC0Njyu08Zk+1LQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from archbook.speedport.ip ([80.133.138.203]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mq2vS-1rBp4N0nas-00n96M; Mon, 05 Feb 2024 23:06:57 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: gregkh@linuxfoundation.org
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	arve@android.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	cmllamas@google.com,
	dan.j.williams@intel.com,
	dxu@dxuuu.xyz,
	gary@garyguo.net,
	joel@joelfernandes.org,
	keescook@chromium.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maco@android.com,
	ojeda@kernel.org,
	peterz@infradead.org,
	rust-for-linux@vger.kernel.org,
	surenb@google.com,
	tglx@linutronix.de,
	tkjos@android.com,
	viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com,
	willy@infradead.org,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v4 7/9] rust: file: add `Kuid` wrapper
Date: Mon,  5 Feb 2024 23:06:30 +0100
Message-ID: <20240205220630.16170-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024020214-concierge-rework-2ac5@gregkh>
References: <2024020214-concierge-rework-2ac5@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:KB3tLHQa3vQv2/DLartIejVa0cU+hTc6E5RUHRtAqgYyIZtjvgI
 WN48fwaBZ89dgQPCEoKgD/XplUPhBrF09KkBJPvksKI4+VToktCejRNa5L/hyr5CbyZuoAd
 ka/h+K5JUca7ViXw/bfX7FBkLh9zouinvs2dH5v+6TFBFNL3vIlfysmCu3ow8/Hc2EcJxNR
 k4PpwNuYxXusbKq4LkHrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RMvkSGwKUzo=;tyOEVgAKLOaDrnCdu4yT369T2Bm
 SpuPO8flQUVlLZeAgr+mv4wCHAsdhVJY03l8PvneEeKEGlwn6CN0MHQBJwbAGabIqgetLzaVB
 RnqiCZc57DYcIJ8RSKNJqelSequ7IDC/jwqIk7mt4h5nF7aYFmme8nWvh4mKsCb6bAFy1kgnI
 iBLhLFOiLknuKZMObcK+pG7uxNuZ/g4URQq+619gDh1Q7MPY+8kyzPb9IFGOWDqxHWdZ+6GmJ
 xXkGb+ihpW7YxNzWyL1Sa/AQUIt5Pknom86T8tL64UOTgd717V9lwj2noa3g78lB6373RZDZv
 0Bzmh0im/EqZyP02bueNIkqJ6HwT4i3qzjOR581AlQV5I0NlbuvsiuC6x/7KgmWoYQIf4+uql
 TGvF9E7Dm/tDEpOMcNJAGHfFuUujJHRjx4l/A+9TVJY566REVyVkEM8OHsJFmJ02nJKaPQZ02
 leC8G8nrnUquS4xEpEBpaTZX1WB5/rtBGrUcEHud5KwqENFr52+s2BpZZbufNkFZSbeRZ8ScI
 rbXvOURaOmEYsqpre9MEBWxGutfZ0plxvtWtiFP1eDOtsgyG7SG0IFb/Xymszerm7mTHDs4xu
 N7Ft1AT5ylZPWyg7hRmSA++Vv4kR2QaN0NrBcvB2SFfsVQR7tGamrOagWCK4EZAUYdZNZvR/2
 uYetrIXGQPjVQPBfUYs3p3pv+/uqrENnbRjK8Z9bpIRdkbi3WAKYhUJJr+wN3vpuAeEJTyGhX
 RKvZeZ5J1Rib1XLz9wCZlCugG/wg4m4h5oGp/JLJBsyhWadqyrW3eA=

> > +    /// Returns the given task's pid in the current pid namespace.
> > +    pub fn pid_in_current_ns(&self) -> Pid {
> > +        let current = Task::current_raw();
> > +        // SAFETY: Calling `task_active_pid_ns` with the current task is always safe.
> > +        let namespace = unsafe { bindings::task_active_pid_ns(current) };
> > +        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and the namespace
> > +        // pointer is not dangling since it points at this task's namespace.
> > +        unsafe { bindings::task_tgid_nr_ns(self.0.get(), namespace) }
> > +    }
>
> pids are reference counted in the kernel, how does this deal with that?
> Are they just ignored somehow?  Where is the reference count given back?
>
> thanks,
>
> greg k-h

As far as I can see, neither `task_active_pid_ns` nor `task_active_pid_ns`
return with an incremented refcount. However, looking at the above code,
it looks like it could be simplified to:

```rust
pub fn pid_in_current_ns(&self) -> Pid {
    // SAFETY: We know that `self.0.get()` is valid by the type invariant.
    // Passing a null pointer in the second argument defaults to the current ns.
    unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }
}
```

Since:

```C
static inline pid_t task_tgid_nr_ns(struct task_struct *tsk, struct pid_namespace *ns)
{
	return __task_pid_nr_ns(tsk, PIDTYPE_TGID, ns);
}
...
pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
			struct pid_namespace *ns)
{
	pid_t nr = 0;

	rcu_read_lock();
	if (!ns)
		ns = task_active_pid_ns(current);
	nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
	rcu_read_unlock();

	return nr;
}
EXPORT_SYMBOL(__task_pid_nr_ns);
```

anyway defaults to current's pid ns (plus some RCU lock protection, not sure if
that is relevant here).

	- Best Valentin

