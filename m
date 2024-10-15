Return-Path: <linux-fsdevel+bounces-32022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931F599F529
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 20:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D0D283F22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B7C20B1F5;
	Tue, 15 Oct 2024 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6lH2Jpw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074A11F9ED1;
	Tue, 15 Oct 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016704; cv=none; b=O5Y93TjV5v1NKizzV6xOpHOtUOVJph4IL4pIKPmGrpJLKAIwNYDpHnUqgeIwO7LQIv5/Fu+SAgcPWgs4R7x60VWwvLjI/9Cxck0FAiwGgLd4CEFkH0TlAggUDP4ofYCCx0pYMT4PgPBXLu7zt9Ws6siQTyPODYiKAVw4ZsVux/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016704; c=relaxed/simple;
	bh=MHfDhPw3x+eqogNdMWlOEjEMcbzb70Y543iyq242vuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRckyOUy3hHVo3IoZYc9TWyuad24sFSdTr2JVdBGp35RFI2VLMxjZ1WBqaKbu66gPmW/nJsLvlTGgYmGnsJkVBDLENQ5TIN6KUrdpxJ/ANDFmp1GTS9ms7+ah/MB2p6Dpll5pfAQQxjATB/Q3lEVJoCLJcLTieCC1VpItP0TVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6lH2Jpw; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbcc2bd7fcso36430836d6.1;
        Tue, 15 Oct 2024 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729016702; x=1729621502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tcyge6OIeXu/wRZZVMsNbQ6waba0dvaHmzi9agE6E4=;
        b=j6lH2Jpwx+sc8ai+FwkMY8eF11EPCHREgEUn1p9GATDEhKn7M3UQ4rLxShGBLJXvdU
         TXJH38xfESNDjI59MSQjbxRdKX5LatO84e8rIzoQoMrssmABfoiR0EroPgVcLvOY8iu4
         Khaz6AXboyXkO3CM8V/4/O5k8xvPkOqimgIyS0fO/73XpjeR4T6DalKhqnf+XeqV+9bJ
         D4clsk/Rx8E+VOTS9vyRW8Cc7zzIiGa79N2PIS/lBee+kdIYFeGa7lEt49b857lj2pjl
         VgC1tMlTjrPml3Y5xlIeotgEp4M6ziDrTVtj8J1++ay1crTIZAoQrd2tC/1oEn9FSTBO
         6qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016702; x=1729621502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tcyge6OIeXu/wRZZVMsNbQ6waba0dvaHmzi9agE6E4=;
        b=fTFxMLZacNR97NUA95TQvoAXSNRbw1U8lw5pLCvkiGx4SL5Fgo5+xg2kyfuwEOFpQb
         fYC2rNJxaonG2wueN9zS5mBqG0C0+WwKjogSykd3myQ+uoVxQdSAfoXATgg//65lxBX+
         NwDJKO30FvX1HcrHekYsdKlUoRtDMBp4OX3mZwYA6VoCCpHTEug9XSCp7syOTMNolzJ0
         ukFPxphHy9BPJVkuJxfSmU5EIiNA0mSTsvENl3MhFiSG8cBVZpzVbj6hWeNf/6TEZcSY
         I6WULrxttoFf8uagc8Ls/D94h48fAHjFEyYIL1sVrXIlM5aM6xqAUmpw5lSVMyhK9dl6
         nApw==
X-Forwarded-Encrypted: i=1; AJvYcCU4vpR2HBNvGRmbCmSMaGnjFKxGx9gUbL+vyOWUHDwKdCfJT7FucIVvPfIwYMMtvhIlpQGYXkmJ2tz6/rBd@vger.kernel.org, AJvYcCUGjfy/evBXu4zX52GvJMjMnwyBuEhZtFq+Q2Cr9Ygdr+DpkxoVIRtOXFCU7pS145XCvzY8aKcP7O5S+1dIZX4=@vger.kernel.org, AJvYcCW5U7Tw0iu+yT65FfHr3/j97siY53T9ytdUI3z0MzhgNkUEh1BXIBcFX3Xecwpo4NIPuM5KwNpBu52ff+nG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4I2csU4aTsGU4Y/EXMZhANSO1YBWyVUI25YM+zs0QhYioQyA
	/CkI8AqIyl6pm8vspMi/k4nxDA69lsd7WDfyyFlLeT5rmqxvBsbQ
X-Google-Smtp-Source: AGHT+IFXLH+1m4nMK8l1UUao6Y6fnQb8jyKmsdLjUAcQyV3jd78eMa2Phpz5Dwm0AITrVDZ1BPMezw==
X-Received: by 2002:ad4:42c5:0:b0:6cb:f7dd:b6a8 with SMTP id 6a1803df08f44-6cbf7ddb70amr188637736d6.26.1729016701664;
        Tue, 15 Oct 2024 11:25:01 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc229698bcsm9395756d6.107.2024.10.15.11.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:25:01 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id E95B81200043;
	Tue, 15 Oct 2024 14:25:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Oct 2024 14:25:00 -0400
X-ME-Sender: <xms:fLMOZzmaqeWVmPzK2aU3lhc8rzAa3WQC4lDBVoONcx5NSpVRxGUtVg>
    <xme:fLMOZ238RwyF-_aChyxMAR5W9grzs9D2S97fACEi7XwMWfASIxwAtMKNwWID9OmnQ
    aUi2RCXK0PjmzF8mA>
X-ME-Received: <xmr:fLMOZ5rATBk0ntxsRT4HVumDqX2_eAmLTMP0MmkK7984tILPbcs17dWSgL7PJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephffhkeehffefkefhteeifefggeejhfevieeh
    ffetuedufffhuddvveefkeevheelnecuffhomhgrihhnpehgvghtrdhgrhhouhhppdgrsh
    gpphhtrhdrghhrohhuphdpghgvthdrphhiugdprghspghpthhrrdhpihgunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghl
    ihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtg
    hpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthht
    ohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:fLMOZ7nJkxmifaa8u9DObC9NCqW-gQF7NziH41u0DlA_QYUIoXzBig>
    <xmx:fLMOZx3e-Ev6wTzSDlL5ipX1gI0Ioqga8p9F6aecASFLfE6c-yJFqA>
    <xmx:fLMOZ6s8J1r0G16KmsdEuQ1HPoH5Rn6TRXZcdeI7n8vkIjszLesuow>
    <xmx:fLMOZ1UIeE2UqSG77VADbQdnmr5NzW3oAvYwSjoGqBQY8JTbmGjrrw>
    <xmx:fLMOZw23pEDyAAbn-WE3BG_5GmTBSfj3gDB5xGvgF1jgGyVWe0UQ8TQq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 14:25:00 -0400 (EDT)
Date: Tue, 15 Oct 2024 11:24:39 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: task: adjust safety comments in Task methods
Message-ID: <Zw6zZ00LOa1fkTTF@boqun-archlinux>
References: <20241015-task-safety-cmnts-v1-1-46ee92c82768@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-task-safety-cmnts-v1-1-46ee92c82768@google.com>

On Tue, Oct 15, 2024 at 02:02:12PM +0000, Alice Ryhl wrote:
> The `Task` struct has several safety comments that aren't so great. For
> example, the reason that it's okay to read the `pid` is that the field
> is immutable, so there is no data race, which is not what the safety
> comment says.
> 
> Thus, improve the safety comments. Also add an `as_ptr` helper. This
> makes it easier to read the various accessors on Task, as `self.0` may
> be confusing syntax for new Rust users.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This is based on top of vfs.rust.file as the file series adds some new
> task methods. Christian, can you take this through that tree?
> ---
>  rust/kernel/task.rs | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 1a36a9f19368..080599075875 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -145,11 +145,17 @@ fn deref(&self) -> &Self::Target {
>          }
>      }
>  
> +    /// Returns a raw pointer to the task.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *mut bindings::task_struct {

FWIW, I think the name convention is `as_raw()` for a wrapper type of
`Opaque<T>` to return `*mut T`, e.g. `kernel::device::Device`.

Otherwise this looks good to me.

Regards,
Boqun

> +        self.0.get()
> +    }
> +
>      /// Returns the group leader of the given task.
>      pub fn group_leader(&self) -> &Task {
> -        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> -        // have a valid `group_leader`.
> -        let ptr = unsafe { *ptr::addr_of!((*self.0.get()).group_leader) };
> +        // SAFETY: The group leader of a task never changes after initialization, so reading this
> +        // field is not a data race.
> +        let ptr = unsafe { *ptr::addr_of!((*self.as_ptr()).group_leader) };
>  
>          // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
>          // and given that a task has a reference to its group leader, we know it must be valid for
> @@ -159,42 +165,41 @@ pub fn group_leader(&self) -> &Task {
>  
>      /// Returns the PID of the given task.
>      pub fn pid(&self) -> Pid {
> -        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> -        // have a valid pid.
> -        unsafe { *ptr::addr_of!((*self.0.get()).pid) }
> +        // SAFETY: The pid of a task never changes after initialization, so reading this field is
> +        // not a data race.
> +        unsafe { *ptr::addr_of!((*self.as_ptr()).pid) }
>      }
>  
>      /// Returns the UID of the given task.
>      pub fn uid(&self) -> Kuid {
> -        // SAFETY: By the type invariant, we know that `self.0` is valid.
> -        Kuid::from_raw(unsafe { bindings::task_uid(self.0.get()) })
> +        // SAFETY: It's always safe to call `task_uid` on a valid task.
> +        Kuid::from_raw(unsafe { bindings::task_uid(self.as_ptr()) })
>      }
>  
>      /// Returns the effective UID of the given task.
>      pub fn euid(&self) -> Kuid {
> -        // SAFETY: By the type invariant, we know that `self.0` is valid.
> -        Kuid::from_raw(unsafe { bindings::task_euid(self.0.get()) })
> +        // SAFETY: It's always safe to call `task_euid` on a valid task.
> +        Kuid::from_raw(unsafe { bindings::task_euid(self.as_ptr()) })
>      }
>  
>      /// Determines whether the given task has pending signals.
>      pub fn signal_pending(&self) -> bool {
> -        // SAFETY: By the type invariant, we know that `self.0` is valid.
> -        unsafe { bindings::signal_pending(self.0.get()) != 0 }
> +        // SAFETY: It's always safe to call `signal_pending` on a valid task.
> +        unsafe { bindings::signal_pending(self.as_ptr()) != 0 }
>      }
>  
>      /// Returns the given task's pid in the current pid namespace.
>      pub fn pid_in_current_ns(&self) -> Pid {
> -        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and passing a null
> -        // pointer as the namespace is correct for using the current namespace.
> -        unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }
> +        // SAFETY: It's valid to pass a null pointer as the namespace (defaults to current
> +        // namespace). The task pointer is also valid.
> +        unsafe { bindings::task_tgid_nr_ns(self.as_ptr(), ptr::null_mut()) }
>      }
>  
>      /// Wakes up the task.
>      pub fn wake_up(&self) {
> -        // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
> -        // And `wake_up_process` is safe to be called for any valid task, even if the task is
> +        // SAFETY: It's always safe to call `signal_pending` on a valid task, even if the task
>          // running.
> -        unsafe { bindings::wake_up_process(self.0.get()) };
> +        unsafe { bindings::wake_up_process(self.as_ptr()) };
>      }
>  }
>  
> @@ -202,7 +207,7 @@ pub fn wake_up(&self) {
>  unsafe impl crate::types::AlwaysRefCounted for Task {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> -        unsafe { bindings::get_task_struct(self.0.get()) };
> +        unsafe { bindings::get_task_struct(self.as_ptr()) };
>      }
>  
>      unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> 
> ---
> base-commit: 22018a5a54a3d353bf0fee7364b2b8018ed4c5a6
> change-id: 20241015-task-safety-cmnts-a7cfe4b2c470
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

