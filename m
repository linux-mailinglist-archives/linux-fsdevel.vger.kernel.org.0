Return-Path: <linux-fsdevel+bounces-79133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFm2DP+xpmn9SgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:03:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A60121EC437
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E20F305D49E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552C38F646;
	Tue,  3 Mar 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2jteI5+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC5342CB1
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532213; cv=none; b=RkrBlKUvtIf/J27eM42AuqB8nTSs/O/HzEuyCedDTVy9d95FEv6+pLLD7KUENUIfyZY+mD6yAsGBQkR7qKXBT4CGj+vA2i94JLdbtVb86TzNAjwpogWBKPy2WLMlsM/cbk8RLQ77jGlDBXj2WDrYjRT1DNXWTSyq/9/H5DhZ1Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532213; c=relaxed/simple;
	bh=Ri37r6lRKI7G97uvFg7gwfrqJ3Arh5NFP7hfQncx8u4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OkM6NHHzEVjwLp0/mDghjkLjZarM6QvmCOU8yO6lccJQQaGtjpj+es4HIfs+TBcYX2oYGFROvzG9sR+2dDI1RbV4oyVMuNeb990/CmTq49SskRRB0+XEqE04mR7cGzv4GH9smElbIirObbSfMYxwn8qWUxqU2lnuSyG8f4prIXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2jteI5+y; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837c597cd5so33411425e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 02:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772532211; x=1773137011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uo0BvlSCCQO1H56qeOpP1FHOwzHeeIJR1gsWs48q5kE=;
        b=2jteI5+yLg81kTDUldCYghQXsmm2KxPnQTNK/MYU86//q7bOtgJK1201MD28cmE0Ap
         Boi37LVu4LDzUxYKLJedDJKu6m7gWpVPfbwLphWmH4TDduK8PwHPCf0lZIS9dF6lFr+e
         QVgJvPAZMuPmyiJraPt/2QA05pH+AOWQUECGAgmj+HMjW8/us9r19MCdLI9LR/3WR7oi
         IV/T1zK5J5zSvHq2njTfX+2sTNhXGReSo5LCUDgymWnqdipyTbIcDMGCNbciba1SO4Mq
         l68qEtSxYn4FlfUAzi8DyVMEWcB55ScJmvYXogMlbAwp31D6lOGuw7PcvWEtWZqjYgde
         cT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772532211; x=1773137011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uo0BvlSCCQO1H56qeOpP1FHOwzHeeIJR1gsWs48q5kE=;
        b=W64ZiuY5jpDH20b0W7GkL/cBm0BTCxwzCIRt7OBKNHEFvkjQk5o/dXzdV0SiZX9gc0
         KXLJTfTXcIuR0o7MwI2dNtKImOtwDpZTxlR/56Dd0cRFZxcWkrL4u3yKJfHFbsoCtlc8
         U9x+/9bLEkNBq71z3aBqec5eqRSxtldTR8n4l8QNyzpwBT0E0uXxk6elZaCCTDuErecG
         6GhN8nFz5YUbuOGufnTGLYLDUb0MED1N1c5DiWLL7qqYAWaG1jHNp3uTq7+rsoryHkVi
         LSmpRNvm1mN7LENESfTaFgy5H9dC23vT2Bzz4zWHB8Ieo/fuKie4vt8UJPcbfKK3tI2G
         Mhig==
X-Forwarded-Encrypted: i=1; AJvYcCXtAXpS+VTESHASn4RxcYA/eY6MUvWs977208nEfoFKbu5h00Y/4/3LJ0KzrSXYwRMsQh0r9SVUKY/kDO0t@vger.kernel.org
X-Gm-Message-State: AOJu0YwlN9i9Not2+E5sf1PMzflmnOKfcVKI5MM5prMrL3AfRihAOCnI
	acSrVeuD9GgPE5y0RtjMnLkGcERg5kfdz3U8hLDmC1G+7A4c7rcouhQJzW1vhqqwk1FZI1N9GWB
	ll7iMvUDKofe9DtMMMA==
X-Received: from wmxb5-n2.prod.google.com ([2002:a05:600d:8445:20b0:47d:5bef:a379])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3106:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-483c9ba610fmr254853465e9.3.1772532210581;
 Tue, 03 Mar 2026 02:03:30 -0800 (PST)
Date: Tue,  3 Mar 2026 10:03:28 +0000
In-Reply-To: <20260226-ungeziefer-erzfeind-13425179c7b2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226-ungeziefer-erzfeind-13425179c7b2@brauner>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303100328.1378655-1-aliceryhl@google.com>
Subject: Re: make_task_dead() & kthread_exit()
From: Alice Ryhl <aliceryhl@google.com>
To: brauner@kernel.org
Cc: broonie@kernel.org, davidgow@google.com, gtucker@gtucker.io, jack@suse.cz, 
	kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org, mjguzik@gmail.com, 
	tj@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: A60121EC437
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79133-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gtucker.io,suse.cz,googlegroups.com,vger.kernel.org,gmail.com,linux-foundation.org,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Christian Brauner <brauner@kernel.org> writes:
> Oh nice.
> I was kinda hoping Tejun would jump on this one and so just pointed to
> one potential way to fix it but didn't really spend time on it.
> 
> Anyway, let's just take what you proposed and slap a commit message on
> it. Fwiw, init_task does have ->worker_private it just gets set later
> during sched_init():
> 
>           /*
>            * The idle task doesn't need the kthread struct to function, but it
>            * is dressed up as a per-CPU kthread and thus needs to play the part
>            * if we want to avoid special-casing it in code that deals with per-CPU
>            * kthreads.
>            */
>           WARN_ON(!set_kthread_struct(current));
> 
> I think that @current here is misleading. When sched_init() runs it
> should be single-threaded still and current == &init_task. So that
> set_kthread_struct(current) call sets @init_task's worker_private iiuc.
> 
> Patch appended. I'll stuff it into vfs.fixes.

welp, I guess you get another one here:

Tested-by: Alice Ryhl <aliceryhl@google.com>

from:
https://lore.kernel.org/all/aaaxK5gFWN70WmMn@google.com/

Alice

