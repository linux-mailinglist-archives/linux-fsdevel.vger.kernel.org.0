Return-Path: <linux-fsdevel+bounces-37001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72A09EBF8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 00:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA05A1671F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 23:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4C922C361;
	Tue, 10 Dec 2024 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLp230wc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262C22C34F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733874394; cv=none; b=f2mShLd18U3fDiCF4VfAtIAtrVt4EgJiCeJojWDj9Cqx29HfDncIWFMKjtgFJu0EOh7cwic27oQBjzDrnocaHO2UKzRJgGGJzm3v6T2+EKsjT00Jq97C9bOplabV/8GuZ+0/OWrj2AOVjnUKe8Gvc7ddS8m71s6YsOZpQCOTmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733874394; c=relaxed/simple;
	bh=cdhhYiPoVL7OooUYyQInCbBhAyPZFJwzOwfZi47pw9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAOEmvkcoq3hkHTzWfE1VfsN1phuH44VO/Tm/t3UFaG2f9sBrpjcDivfKNDCePDrh++NupYNKFH6eH+gZgz3dstUZtsSJGXrMRmrRGqioBQ833aERqRy9ff4UyV+V9WEJUk8f2GRgmtX0AAL2WZRT/Nf8xWorqhCaTb9l2MuFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLp230wc; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46788c32a69so3343141cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 15:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733874392; x=1734479192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZXVj+liKx8DyWCFaC+lNOCDmnnkD4lNP8fZX7K0a6M=;
        b=GLp230wciAZbP/gnt6ggLiZ+poVjThTIRiHe7B2AkiqlXpkrmFIm0tu6YzX/2tkV1w
         2vd+Cr8QtxrPBF/KcuNO6iU8S5kUNWfb4LVZRbV/NzPg2ZK9s+jshT3Z7eHc3p0BU6t3
         S/+BEjO1itcNx8um6VzQNG1oneMlmmDSxkKtbWbAZukQRPgBgiXX8VB6Jp8PdYsSbGxc
         1cKXxbfGAOYi63ZKinb3BuHVbGL2DCz6x0SFlxy6XbaAnVWzT2io5tk7MQq/u8miwIZ9
         9rcu3nR0X9LFkcEBZmVRsDxSyfL+8RVwAcNxn/oKLbjXQ8aHmiqFO0bbsQ/KaDuhBu+5
         1HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733874392; x=1734479192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZXVj+liKx8DyWCFaC+lNOCDmnnkD4lNP8fZX7K0a6M=;
        b=UnJfjIa2hXov39c9UoaIn5YKly9CEEtMBKPlcrMxJDqll+krO1PmVKq9QfzC9bSpxB
         +L+RAE1W6BbfuYca93WIsHSJmGi0gtZOwouTCsq9FCtFuI4HhBBedck3rEnMjQ8vbgqd
         1bn9SZTS26wIdfAks9GfrNUEMew2kLT49EEs1WTNDTMdBKBCWJrx8HQbbVZrt/O7jLJ2
         94ZRHVEoYub3RUXUQ8souoG56nqKMoPjZtjL6sUN1LtwRkx+B+ZocE8bBrUCn/YvRbWC
         NxtVIJqZwKhUXE65rkaCEyy++xECIrbG88sXgXCZ+qusaboit4tX9ioxwZtLmdKKqMYQ
         YH7Q==
X-Gm-Message-State: AOJu0YyiiL3gwJ4V1J2BovZotCn8d8Cs+QGD6B2d/EeVpW4SMrNfHeD/
	MgjyuVfaoIeDl1j078qCZyxB0sG8ryZAthB3FiSRv6BzXRrHNXwZfh90m/At3qdObtVGHMwqJAH
	5zK+I039Bu+3vF+nqmwBaEgX/BJbhm6wc
X-Gm-Gg: ASbGnctNXxiQNbYZhPFI1yq/H/iwpBSgd3FE9g+rgrx5WDqMtprbu7W2EF26WbCA3GC
	mtCULYhYZnGYTADeTqR3V87ERWieJzZ9nWGrp
X-Google-Smtp-Source: AGHT+IEEUcivZd0rU8nOuIPCrWnp/93OdRJ+LIwPYGG9qmI42MA8a3V73Kf5zr0Sr3AGkYpwupGiTIQnuxQ5ST0Dwts=
X-Received: by 2002:a05:622a:198f:b0:467:5836:a9b with SMTP id
 d75a77b69052e-467892afe9amr14635101cf.15.1733874392224; Tue, 10 Dec 2024
 15:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210171621.64645-1-etmartin4313@gmail.com> <4f524025-e64e-4d67-a0f3-20f0fa21ca1a@fastmail.fm>
In-Reply-To: <4f524025-e64e-4d67-a0f3-20f0fa21ca1a@fastmail.fm>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Tue, 10 Dec 2024 18:46:20 -0500
Message-ID: <CAMHPp_T34qXFYhBcrpdSqURrFjSLo02p_xFhUxUzqWTW-YY3vA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Abort connection if FUSE server get stuck
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, laoar.shao@gmail.com, 
	etmartin@cisco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:07=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 12/10/24 18:16, etmartin4313@gmail.com wrote:
> > From: Etienne Martineau <etmartin4313@gmail.com>
> >
> > This patch abort connection if HUNG_TASK_PANIC is set and a FUSE server
> > is getting stuck for too long.
> >
> > Without this patch, an unresponsive / buggy / malicious FUSE server can
> > leave the clients in D state for a long period of time and on system wh=
ere
> > HUNG_TASK_PANIC is set, trigger a catastrophic reload.
> >
> > So, if HUNG_TASK_PANIC checking is enabled, we should wake up periodica=
lly
> > to abort connections that exceed the timeout value which is define to b=
e
> > half the HUNG_TASK_TIMEOUT period, which keeps overhead low.
> >
> > This patch introduce a list of request waiting for answer that is time
> > sorted to minimize the overhead.
> >
> > When HUNG_TASK_PANIC is enable there is a timeout check per connection
> > that is running at low frequency only if there are active FUSE request
> > pending.
> >
> > A FUSE client can get into D state as such ( see below Scenario #1 / #2=
 )
> >  1) request_wait_answer() -> wait_event() is UNINTERRUPTIBLE
> >     OR
> >  2) request_wait_answer() -> wait_event_(interruptible / killable) is h=
ead
> >     of line blocking for subsequent clients accessing the same file
>
>
> I don't think that will help you for fuse background requests.
>
> [422820.431981] INFO: task dd:1590644 blocked for more than 120 seconds.
> [422820.436556]       Not tainted 6.13.0-rc1+ #92
> [422820.439189] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disabl=
es this message.
> [422820.446822] task:dd              state:D stack:27440 pid:1590644 tgid=
:1590644 ppid:1590478 flags:0x00000002
> [422820.456782] Call Trace:
> [422820.459467]  <TASK>
> [422820.461667]  __schedule+0x1b42/0x25b0
> [422820.465312]  schedule+0xb5/0x260
> [422820.468568]  schedule_preempt_disabled+0x19/0x30
> [422820.473033]  rwsem_down_write_slowpath+0x8a6/0x12b0
> [422820.477644]  ? generic_file_write_iter+0x82/0x240
> [422820.481774]  down_write+0x16f/0x1a0
> [422820.486756]  generic_file_write_iter+0x82/0x240
> [422820.490412]  ? fuse_file_read_iter+0x490/0x490 [fuse]
> [422820.493021]  vfs_write+0x7c8/0xb70
> [422820.494389]  ? fuse_file_read_iter+0x490/0x490 [fuse]
> [422820.497003]  ksys_write+0xce/0x170
> [422820.500110]  do_syscall_64+0x81/0x120
> [422820.502941]  ? irqentry_exit_to_user_mode+0x133/0x180
> [422820.505504]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>
> Joannes timeout patches are more generic and handle these as well.
>
>
> Thanks,
> Bernd

Thanks for pointing out this scenario.
Looks like similar logic can be applied for all request including bg reques=
t
Something like
   fuse_request_init() /* Start the timer if fc->num_waiting =3D=3D 1 */
   fuse_put_request() /* Stop the timer if fc->num_waiting =3D=3D 0 */
I'll experiment some more on that angle and come back
Thanks,
Etienne

