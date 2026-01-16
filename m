Return-Path: <linux-fsdevel+bounces-74059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF4D2C373
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 06:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86C5E303804F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 05:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E20347FDE;
	Fri, 16 Jan 2026 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1NiH/rh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC53446C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542981; cv=pass; b=H623MpA/uEitqF5n6xRQ9B5dKAbWJGkVH3kRinvkdJP9lKIDcxYvnO6Nzc84On2xbY6iMVC4Rt2YbC85QcOsygA31yeHBK2rlweY1BeQHg5/wskW8ajk0P+T+Ng3ixMwn04wEmn+3jZD2oBf90ORg6hchUJ5BSK/5pyOI7wTpJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542981; c=relaxed/simple;
	bh=YQsSVIMXUNZhfAD04FpG0Sza5zF8N9xLqlEQFbU/UzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkL2qXXJc7lEtHvK3WCcRCgGr40ztNF84TYyxHVlS+UWa+HsmADMFR/d3FJdXN8BkW7JQ0lSrS7f+VuMbFD67EaxN18cOgxY11cWZS+yptHzO+MEDtfh5yH0HRdjb714tr5qA1/b85IoxBJ0SiKZa0UzSX+wScVALmfCsiaW2b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1NiH/rh; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-501511aa012so245161cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 21:56:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768542978; cv=none;
        d=google.com; s=arc-20240605;
        b=KtzPyVHtvQUaKTZu+zz4NULyi40N2JjcDm5a32NEgrUuTG0ZxCj7ln6JC506Y9w3wD
         4pg8ZC7vGOibMLFmL1zPeg8/rvK7sfCDSjJTAau03DUDPrQsGKH8s5jzIebFElrl1F+1
         Ef4QWHciaLPDsRdpwa1U6RjdXzVpZg30CbVI8ArZxMIaIiRBgxJ0ztHAdQZ8vmxIn9VA
         U878b0ahwk+bRXP/RRut4/aediqns2uRU0uUmDvY572MTNzWRrECCEnA2qKldNL4C65z
         Mt7qn54/e8bIT0YyU6ge1aWQ2vZw9E5z5KOydj8m4gwW2Kdpz1LPcnHsXfm8uvhsqpBf
         2TZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5xlLb/5unGqS8L62dmA75fvaFZKJI6VZqB5Ch1L+R8=;
        fh=jo0Lz5s8dKPw+/FqFg8P9vRogEaQqktq245t7uKTrv4=;
        b=BgrMZyzvuxS+11i/Z5gxRgIsIAwAgSqs/VSeHZ4DCJKlM75vGSwtih+QWSLjESEE9O
         wB6dOR5bU0SjbRZC9IUtjlyrN+JRDyOc29x104WaSA26FyQjMrL+2SYrlndyn2xpQjx8
         ltMIZjplGfXAMWT6U2FTRKO/B9plZz7lCL5v8wnXhG5g3N7NBYi5WN/FAKOtRrGP1idM
         PttG8XhurBsfrBaQ+E1i1RmT75wj3Sq238zLseY3YqhQSd5uka1L/cxtK7NUukNwt6Ls
         ugr3aelLnZyRdH3rL/tx6GZlhV7SdLkW4aeiNsAUrtjbHjER23qHxhoP38sMXTr3Y+Ua
         2emg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768542978; x=1769147778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5xlLb/5unGqS8L62dmA75fvaFZKJI6VZqB5Ch1L+R8=;
        b=h1NiH/rhUsevmi2vE6btaQYc5n+62epeZ3DpU/7iAfW4k1HTNpsbutEUjRoEwm6tEZ
         nrHVrBy2Cw6NGMoFlJh5MAoxTdRbPn7pCQWZ7clXDpWjuTv+KLvyY39h6Ok/5oC5LOaI
         siHpDaLf6yv3b2pkxsx74TQwK3lV+SyNkQKv2VLGuGY190qQ8ShAAjm9Wne+/eiNhuGo
         /K7rx9cBY5oF7U7pASSHqDLbiIeTOVcy8gYQa1c0DzF9cIRuFpQesykTyZTiqCAoCPem
         CI21HCLvLjs/W0N0weOYCRwIXzny9tth0ttAhCdRHqCWhfgNu+RLvHdf07E33esib33I
         EK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768542978; x=1769147778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N5xlLb/5unGqS8L62dmA75fvaFZKJI6VZqB5Ch1L+R8=;
        b=SYXiZ+f+oJ3G6f9XmWle013nMzx+4WMT+9MdkylRlkCc/CKZ73drxxCyW9ANz0G1jC
         JMv62Y7lBLkFyPdDabKP7/hRXm6PMxeNiP0Tc07kKpPaMy6PTrENqw2xmA76T4ckZTDA
         1aGKTayQQEo7S+ssNMZ7vz+C1rIu4yETlJRR+Z5ZBt7VQ7Y9AhPqgQ4iLozD2HWGvh9s
         FCr7rF1YA5CZ52smKUxE7RD7Dchrn+u1ADS/2+uhapemXh6JfZk0B3sHQi0qBw8kAnlx
         14q3x1qivMQF99bXCKDcdiVIVytRCWmcUTS2129QfHoS96U9RplpxUsoLqBn4w8ytqhV
         PVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4kU6zlZGK5i+prQ41lPVbsjM97fMbnvCIaALXLUiIttulDib5A8dwChGIy7YhlOLfc7ey4fbw2Az36O3B@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+rtNVrrMQd5cbC79PfYm71eYDHmtt/EgBv3SQOtCTfzJM6Zg
	rkl0rICK8TNHgq8UuUtyTiqcWqRd98S8Jqx0UYTdfUOGRhxoQQbc3+H1VHV4eS3pxpu1vhV1qX9
	vyoYRgOtC7ciyIkJDko5E9kGOnMbKMc1eZJ5Thq5+kzJharblkDAVXjhRHf0G2Q==
X-Gm-Gg: AY/fxX5JN59gOk4ZcQiBNBP613O8T/ZnrOPxpyiPy6zYkY2AOq7wxxmgtAzXsrrUOmS
	qhQkc1781KDR+h+FCpTyRXtiUHZd6MK7bwMPSxu0BH7DOmuky8QpGL7PfSfTamv+4FJmF9vFnAq
	AqdBcf/PWA7HFcOcve34jUiR5M8V2eti4UeUUX958GDqgyrWvDXBpqrRamF155rzS3T2AhHYHzm
	XIPWBxdya3NlUAmPsYBUiNDBv9SkYhaZAeKLDJpFyceZwmUQPXp89CoS4rU/ObGQT0KRjU=
X-Received: by 2002:ac8:5d08:0:b0:4ff:bf96:db86 with SMTP id
 d75a77b69052e-502a23dc15emr6960371cf.16.1768542977787; Thu, 15 Jan 2026
 21:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdxtTZ=SuV2GMPuqQJe6h-h-CDiG5yBW+07f1QYEw+kTA4-2w@mail.gmail.com>
 <CAOQ4uxggQekxqavkt+RiJd9s9cdDgXZuVfQrL_qNciBNf=4Lww@mail.gmail.com> <CAOdxtTaz7=TzQizrdMEhjgt7LpuuHWzTO80783RLcB_GP3nPdw@mail.gmail.com>
In-Reply-To: <CAOdxtTaz7=TzQizrdMEhjgt7LpuuHWzTO80783RLcB_GP3nPdw@mail.gmail.com>
From: Chenglong Tang <chenglongtang@google.com>
Date: Thu, 15 Jan 2026 21:56:06 -0800
X-Gm-Features: AZwV_Qjjf-yaiVxSFXqwMXpjNs6KyYup3iOIK6lxkARaDaaZaKfBZ2DPCOIGHJ0
Message-ID: <CAOdxtTZv_B_pE1d1vgaE8+ar58y7pTiw0bL-djB1rhE-5wu2zQ@mail.gmail.com>
Subject: Re: [Regression 6.12] NULL pointer dereference in submit_bio_noacct
 via backing_file_read_iter
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Follow Up] We have an important update regarding the
submit_bio_noacct panic we reported earlier.

To rule out the Integrity Measurement Architecture (IMA) as the root
cause, we disabled IMA verification in the workload configuration. The
kernel panic persisted with the exact same signature (RIP:
0010:submit_bio_noacct+0x21d), but the trigger path has changed.

New Stack Traces (Non-IMA) We are now observing the crash via two
standard filesystem paths.

Stack Trace:
Most failures are still similar:
I0115 20:30:23.535402    8496 vex_console.cc:116] (vex1): [
158.519909] BUG: kernel NULL pointer dereference, address:
0000000000000156
I0115 20:30:23.535483    8496 vex_console.cc:116] (vex1): [
158.542610] #PF: supervisor read access in kernel mode
I0115 20:30:23.585675    8496 vex_console.cc:116] (vex1): [
158.565011] #PF: error_code(0x0000) - not-present page
I0115 20:30:23.585702    8496 vex_console.cc:116] (vex1): [
158.583855] PGD 800000007c7da067 P4D 800000007c7da067 PUD 7c7db067 PMD
0
I0115 20:30:23.585709    8496 vex_console.cc:116] (vex1): [
158.590940] Oops: Oops: 0000 [#1] SMP PTI
I0115 20:30:23.636063    8496 vex_console.cc:116] (vex1): [
158.598950] CPU: 1 UID: 0 PID: 6717 Comm: agent_launcher Tainted: G
       O       6.12.55+ #1
I0115 20:30:23.636092    8496 vex_console.cc:116] (vex1): [
158.629624] Tainted: [O]=3DOOT_MODULE
I0115 20:30:23.694223    8496 vex_console.cc:116] (vex1): [
158.639965] Hardware name: Google Google Compute Engine/Google Compute
Engine, BIOS Google 01/01/2011
I0115 20:30:23.694252    8496 vex_console.cc:116] (vex1): [
158.684210] RIP: 0010:submit_bio_noacct+0x21d/0x470
I0115 20:30:23.738566    8496 vex_console.cc:116] (vex1): [
158.705662] Code: 8b 73 48 4d 85 f6 74 55 4c 63 25 46 af 89 01 49 83
fc 06 0f 83 44 02 00 00 4f 8b a4 e6 d0 00 00 00 83 3d 99 ca 7d 01 00
7e 3f <43> 80 bc 3c 56 01 00 00 00 0f 84 28 01 00 00 48 89 df e8 fc 9f
02
I0115 20:30:23.738598    8496 vex_console.cc:116] (vex1): [
158.765443] RSP: 0000:ffffa74c84d53a98 EFLAGS: 00010202
I0115 20:30:23.793126    8496 vex_console.cc:116] (vex1): [
158.771022] RAX: ffffa319b3d6b4f0 RBX: ffffa319bdc9a3c0 RCX:
00000000005e1070
I0115 20:30:23.793158    8496 vex_console.cc:116] (vex1): [
158.778730] RDX: 0000000010300001 RSI: ffffa319b3d6b4f0 RDI:
ffffa319bdc9a3c0
I0115 20:30:23.843309    8496 vex_console.cc:116] (vex1): [
158.802189] RBP: ffffa74c84d53ac8 R08: 0000000000001000 R09:
ffffa319bdc9a3c0
I0115 20:30:23.843336    8496 vex_console.cc:116] (vex1): [
158.846780] R10: 0000000000000000 R11: 0000000069a1b000 R12:
0000000000000000
I0115 20:30:23.889620    8484 vex_dns.cc:145] Returning NODATA for DNS
Query: type=3Da, name=3Dservicecontrol.googleapis.com.
I0115 20:30:23.898357    8496 vex_console.cc:116] (vex1): [
158.877737] R13: ffffa31941421f40 R14: ffffa31955419200 R15:
0000000000000000
I0115 20:30:23.948602    8496 vex_console.cc:116] (vex1): [
158.908715] FS:  00000000059efe28(0000) GS:ffffa319bdd00000(0000)
knlGS:0000000000000000
I0115 20:30:23.948640    8496 vex_console.cc:116] (vex1): [
158.937522] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
I0115 20:30:23.948645    8496 vex_console.cc:116] (vex1): [
158.958522] CR2: 0000000000000156 CR3: 000000006a20a003 CR4:
00000000003726f0
I0115 20:30:23.948650    8496 vex_console.cc:116] (vex1): [
158.968648] Call Trace:
I0115 20:30:23.948655    8496 vex_console.cc:116] (vex1): [  158.974419]  <=
TASK>
I0115 20:30:23.948659    8496 vex_console.cc:116] (vex1): [
158.978222]  ext4_mpage_readpages+0x75c/0x790
I0115 20:30:24.004540    8496 vex_console.cc:116] (vex1): [
158.983568]  read_pages+0x9d/0x250
I0115 20:30:24.004568    8496 vex_console.cc:116] (vex1): [
158.987263]  page_cache_ra_unbounded+0xa2/0x1c0
I0115 20:30:24.004573    8496 vex_console.cc:116] (vex1): [
158.992179]  filemap_fault+0x218/0x660
I0115 20:30:24.004576    8496 vex_console.cc:116] (vex1): [
158.996311]  __do_fault+0x4b/0x140
I0115 20:30:24.004580    8496 vex_console.cc:116] (vex1): [
159.000143]  do_pte_missing+0x14f/0x1050
I0115 20:30:24.054563    8496 vex_console.cc:116] (vex1): [
159.018505]  handle_mm_fault+0x886/0xb40
I0115 20:30:24.105692    8496 vex_console.cc:116] (vex1): [
159.063653]  do_user_addr_fault+0x1eb/0x730
I0115 20:30:24.105721    8496 vex_console.cc:116] (vex1): [
159.094465]  exc_page_fault+0x80/0x100
I0115 20:30:24.105726    8496 vex_console.cc:116] (vex1): [
159.116472]  asm_exc_page_fault+0x26/0x30

Though there is a different one:
I0115 20:31:14.891091    7372 vex_console.cc:116] (vex1): [
163.902122] BUG: kernel NULL pointer dereference, address:
0000000000000157
I0115 20:31:14.950131    7372 vex_console.cc:116] (vex1): [
163.955031] #PF: supervisor read access in kernel mode
I0115 20:31:15.057629    7372 vex_console.cc:116] (vex1): [
163.986899] #PF: error_code(0x0000) - not-present page
I0115 20:31:15.057665    7372 vex_console.cc:116] (vex1): [
164.075132] PGD 0 P4D 0
I0115 20:31:15.057670    7372 vex_console.cc:116] (vex1): [
164.085940] Oops: Oops: 0000 [#1] SMP PTI
I0115 20:31:15.108501    7372 vex_console.cc:116] (vex1): [
164.090592] CPU: 0 UID: 0 PID: 399 Comm: jbd2/nvme0n1p1- Tainted: G
       O       6.12.55+ #1
I0115 20:31:15.157731    7372 vex_console.cc:116] (vex1): [
164.146188] Tainted: [O]=3DOOT_MODULE
I0115 20:31:15.210631    7372 vex_console.cc:116] (vex1): [
164.172362] Hardware name: Google Google Compute Engine/Google Compute
Engine, BIOS Google 01/01/2011
I0115 20:31:15.266673    7372 vex_console.cc:116] (vex1): [
164.243113] RIP: 0010:submit_bio_noacct+0x21d/0x470
I0115 20:31:15.369886    7372 vex_console.cc:116] (vex1): [
164.276230] Code: 8b 73 48 4d 85 f6 74 55 4c 63 25 46 af 89 01 49 83
fc 06 0f 83 44 02 00 00 4f 8b a4 e6 d0 00 00 00 83 3d 99 ca 7d 01 00
7e 3f <43> 80 bc 3c 56 01 00 00 00 0f 84 28 01 00 00 48 89 df e8 fc 9f
02
I0115 20:31:15.369913    7372 vex_console.cc:116] (vex1): [
164.413258] RSP: 0000:ffffa674004ebc80 EFLAGS: 00010202
I0115 20:31:15.422131    7372 vex_console.cc:116] (vex1): [
164.420124] RAX: ffff9381c25d4790 RBX: ffff9381d0e5e540 RCX:
00000000000301c8
I0115 20:31:15.522750    7372 vex_console.cc:116] (vex1): [
164.464474] RDX: 0000000010300001 RSI: ffff9381c25d4790 RDI:
ffff9381d0e5e540
I0115 20:31:15.522784    7372 vex_console.cc:116] (vex1): [
164.542751] RBP: ffffa674004ebcb0 R08: 0000000000000000 R09:
0000000000000000
I0115 20:31:15.576921    7372 vex_console.cc:116] (vex1): [
164.578174] R10: 0000000000000000 R11: ffffffff8433e7a0 R12:
0000000000000000
I0115 20:31:15.577224    7372 vex_console.cc:116] (vex1): [
164.595801] R13: ffff9381c1425780 R14: ffff9381c196d400 R15:
0000000000000001
I0115 20:31:15.628049    7372 vex_console.cc:116] (vex1): [
164.626548] FS:  0000000000000000(0000) GS:ffff93823dc00000(0000)
knlGS:0000000000000000
I0115 20:31:15.732793    7372 vex_console.cc:116] (vex1): [
164.665104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
I0115 20:31:15.785564    7372 vex_console.cc:116] (vex1): [
164.757565] CR2: 0000000000000157 CR3: 000000007c678003 CR4:
00000000003726f0
I0115 20:31:15.843034    7372 vex_console.cc:116] (vex1): [
164.831021] Call Trace:
I0115 20:31:15.843065    7372 vex_console.cc:116] (vex1): [  164.851014]  <=
TASK>
I0115 20:31:15.900287    7372 vex_console.cc:116] (vex1): [
164.872000]  jbd2_journal_commit_transaction+0x612/0x17e0
I0115 20:31:15.900315    7372 vex_console.cc:116] (vex1): [
164.914012]  ? sched_clock+0xd/0x20
I0115 20:31:15.952673    7372 vex_console.cc:116] (vex1): [
164.963930]  ? _raw_spin_unlock_irqrestore+0x12/0x30
I0115 20:31:16.004440    7372 vex_console.cc:116] (vex1): [
164.989978]  ? __try_to_del_timer_sync+0x122/0x160
I0115 20:31:16.004471    7372 vex_console.cc:116] (vex1): [
165.029451]  kjournald2+0xb1/0x220
I0115 20:31:16.004477    7372 vex_console.cc:116] (vex1): [
165.033558]  ? __pfx_autoremove_wake_function+0x10/0x10
I0115 20:31:16.004481    7372 vex_console.cc:116] (vex1): [
165.044022]  kthread+0x122/0x140
I0115 20:31:16.004486    7372 vex_console.cc:116] (vex1): [
165.048012]  ? __pfx_kjournald2+0x10/0x10
I0115 20:31:16.004490    7372 vex_console.cc:116] (vex1): [
165.052944]  ? __pfx_kthread+0x10/0x10
I0115 20:31:16.004494    7372 vex_console.cc:116] (vex1): [
165.057597]  ret_from_fork+0x3f/0x50
I0115 20:31:16.057453    7372 vex_console.cc:116] (vex1): [
165.062127]  ? __pfx_kthread+0x10/0x10
I0115 20:31:16.057484    7372 vex_console.cc:116] (vex1): [
165.079674]  ret_from_fork_asm+0x1a/0x30
I0115 20:31:16.109674    7372 vex_console.cc:116] (vex1): [
165.113023]  </TASK>
I0115 20:31:16.212548    7372 vex_console.cc:116] (vex1): [
165.131001] Modules linked in: nft_chain_nat xt_MASQUERADE nf_nat
xt_addrtype nft_compat nf_tables kvm_intel kvm irqbypass crc32c_intel
aesni_intel crypto_simd cryptd loadpin_trigger(O) fuse
I0115 20:31:16.262933    7372 vex_console.cc:116] (vex1): [
165.269971] CR2: 0000000000000157
I0115 20:31:16.316433    7372 vex_console.cc:116] (vex1): [
165.306980] ---[ end trace 0000000000000000 ]---
I0115 20:31:16.365756    7372 vex_console.cc:116] (vex1): [
165.361889] RIP: 0010:submit_bio_noacct+0x21d/0x470
I0115 20:31:16.518250    7372 vex_console.cc:116] (vex1): [
165.406957] Code: 8b 73 48 4d 85 f6 74 55 4c 63 25 46 af 89 01 49 83
fc 06 0f 83 44 02 00 00 4f 8b a4 e6 d0 00 00 00 83 3d 99 ca 7d 01 00
7e 3f <43> 80 bc 3c 56 01 00 00 00 0f 84 28 01 00 00 48 89 df e8 fc 9f
02
I0115 20:31:16.518278    7372 vex_console.cc:116] (vex1): [
165.558880] RSP: 0000:ffffa674004ebc80 EFLAGS: 00010202
I0115 20:31:16.568463    7372 vex_console.cc:116] (vex1): [
165.575239] RAX: ffff9381c25d4790 RBX: ffff9381d0e5e540 RCX:
00000000000301c8
I0115 20:31:16.568490    7372 vex_console.cc:116] (vex1): [
165.590012] RDX: 0000000010300001 RSI: ffff9381c25d4790 RDI:
ffff9381d0e5e540
I0115 20:31:16.568495    7372 vex_console.cc:116] (vex1): [
165.597793] RBP: ffffa674004ebcb0 R08: 0000000000000000 R09:
0000000000000000
I0115 20:31:16.568499    7372 vex_console.cc:116] (vex1): [
165.608408] R10: 0000000000000000 R11: ffffffff8433e7a0 R12:
0000000000000000
I0115 20:31:16.568502    7372 vex_console.cc:116] (vex1): [
165.616602] R13: ffff9381c1425780 R14: ffff9381c196d400 R15:
0000000000000001
I0115 20:31:16.618734    7372 vex_console.cc:116] (vex1): [
165.631823] FS:  0000000000000000(0000) GS:ffff93823dc00000(0000)
knlGS:0000000000000000
I0115 20:31:16.618770    7372 vex_console.cc:116] (vex1): [
165.653088] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
W0115 20:31:16.649110    7355 pvpanic.cc:136] Guest kernel has panicked!
I0115 20:31:16.671568    7372 vex_console.cc:116] (vex1): [
165.668488] CR2: 0000000000000157 CR3: 000000007c678003 CR4:
00000000003726f0
I0115 20:31:16.671599    7372 vex_console.cc:116] (vex1): [
165.686744] Kernel panic - not syncing: Fatal exception

This confirms the issue is not specific to IMA, but is a fundamental
race condition in the Block I/O layer or Ext4 subsystem under high
concurrency.

Since the crash occurs at the exact same instruction offset in
submit_bio_noacct regardless of the caller (IMA, Page Fault, or JBD2),
we suspect a bio or request_queue structure is being corrupted or
hitting a NULL pointer dereference in the underlying block device
driver (NVMe) or Device Mapper.

Best,

Chenglong

On Thu, Jan 15, 2026 at 6:56=E2=80=AFPM Chenglong Tang <chenglongtang@googl=
e.com> wrote:
>
> Hi Amir,
>
> Thanks for the guidance. Using the specific order of the 8 commits
> (applying the ovl_real_fdget refactors before the fix consumers)
> resolved the boot-time NULL pointer panic. The system now boots
> successfully.
>
> However, we are still hitting the original kernel panic during runtime
> tests (specifically a CloudSQL workload).
>
> Current Commit Chain (Applied to 6.12):
>
> 76d83345a056 (HEAD -> main-R125-cos-6.12) ovl: convert
> ovl_real_fdget() callers to ovl_real_file()
> 740bdf920b15 ovl: convert ovl_real_fdget_path() callers to ovl_real_file_=
path()
> 100b71ecb237 fs/backing_file: fix wrong argument in callback
> b877bca6858d ovl: store upper real file in ovl_file struct
> 595aac630596 ovl: allocate a container struct ovl_file for ovl private co=
ntext
> 218ec543008d ovl: do not open non-data lower file for fsync
> 6def078942e2 ovl: use wrapper ovl_revert_creds()
> fe73aad71936 backing-file: clean up the API
>
> So it means none of these 8 commits were able to fix the problem. Let
> me explain what's going on here:
>
> We are reporting a rare but persistent kernel panic (~0.02% failure
> rate) occurring during container initialization on Linux 6.12.55+
> (x86_64). The 6.6.x is good. The panic is a NULL pointer dereference
> in submit_bio_noacct, triggered specifically when the Integrity
> Measurement Architecture (IMA) calculates a file hash during a runc
> create operation.
>
> We have isolated the crash to a specific container (ncsa) starting up
> during a high-concurrency boot sequence.
>
> Environment
> * Kernel: Linux 6.12.55+ (x86_64) / Container-Optimized OS
> * Workload: Cloud SQL instance initialization (heavy concurrent runc
> operations managed by systemd).
> * Filesystem: Ext4 backed by NVMe.
> * Security: AppArmor enabled, IMA (Integrity Measurement Architecture) ac=
tive.
>
> The Failure Pattern(In every crash instance, the sequence is identical):
> * systemd initiates the startup of the ncsainit container.
> * runc executes the create command:
> `Bash
> `runc --root /var/lib/cloudsql/runc/root create --bundle
> /var/lib/cloudsql/runc/bundles/ncsa ...
>
> Immediately after this command is logged, the kernel panics.
>
> Stacktrace:
> [  186.938290] BUG: kernel NULL pointer dereference, address: 00000000000=
00156
> [  186.952203] #PF: supervisor read access in kernel mode
> [  186.995248] Oops: Oops: 0000 [#1] SMP PTI
> [  187.035946] CPU: 1 UID: 0 PID: 6764 Comm: runc:[2:INIT] Tainted: G
>          O       6.12.55+ #1
> [  187.081681] RIP: 0010:submit_bio_noacct+0x21d/0x470
> [  187.412981] Call Trace:
> [  187.415751]  <TASK>
> [  187.418141]  ext4_mpage_readpages+0x75c/0x790
> [  187.429011]  read_pages+0x9d/0x250
> [  187.450963]  page_cache_ra_unbounded+0xa2/0x1c0
> [  187.466083]  filemap_get_pages+0x231/0x7a0
> [  187.474687]  filemap_read+0xf6/0x440
> [  187.532345]  integrity_kernel_read+0x34/0x60
> [  187.560740]  ima_calc_file_hash+0x1c1/0x9b0
> [  187.608175]  ima_collect_measurement+0x1b6/0x310
> [  187.613102]  process_measurement+0x4ea/0x850
> [  187.617788]  ima_bprm_check+0x5b/0xc0
> [  187.635403]  bprm_execve+0x203/0x560
> [  187.645058]  do_execveat_common+0x2fb/0x360
> [  187.649730]  __x64_sys_execve+0x3e/0x50
>
> Panic Analysis: The stack trace indicates a race condition where
> ima_bprm_check (triggered by executing the container binary) attempts
> to verify the file. This calls ima_calc_file_hash ->
> ext4_mpage_readpages, which submits a bio to the block layer.
>
> The crash occurs in submit_bio_noacct when it attempts to dereference
> a member of the bio structure (likely bio->bi_bdev or the request
> queue), suggesting the underlying device or queue structure is either
> uninitialized or has been torn down while the IMA check was still in
> flight.
>
> Context on Concurrency: This workload involves systemd starting
> multiple sidecar containers (logging, monitoring, coroner, etc.)
> simultaneously. We suspect this high-concurrency startup creates the
> IO/CPU contention required to hit this race window. However, the crash
> consistently happens only on the ncsa container, implying something
> specific about its launch configuration or timing makes it the
> reliable victim.
>
> Best,
>
> Chenglong
>
> On Wed, Jan 14, 2026 at 3:11=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Wed, Jan 14, 2026 at 1:53=E2=80=AFAM Chenglong Tang <chenglongtang@g=
oogle.com> wrote:
> > >
> > > Hi OverlayFS Maintainers,
> > >
> > > This is from Container Optimized OS in Google Cloud.
> > >
> > > We are reporting a reproducible kernel panic on Kernel 6.12 involving
> > > a NULL pointer dereference in submit_bio_noacct.
> > >
> > > The Issue: The panic occurs intermittently (approx. 5 failures in 100=
0
> > > runs) during a specific PostgreSQL client test
> > > (postgres_client_test_postgres15_ctrdncsa) on Google
> > > Container-Optimized OS. The stack trace shows the crash happens when
> > > IMA (ima_calc_file_hash) attempts to read a file from OverlayFS via
> > > the new-in-6.12 backing_file_read_iter helper.
> > >
> > > It appears to be a race condition where the underlying block device i=
s
> > > detached (becoming NULL) while the backing_file wrapper is still
> > > attempting to submit a read bio during container teardown.
> > >
> > > Stack Trace:
> > > [  OK  ] Started    75.793015] BUG: kernel NULL pointer dereference,
> > > address: 0000000000000156
> > > [   75.822539] #PF: supervisor read access in kernel mode
> > > [   75.849332] #PF: error_code(0x0000) - not-present page
> > > [   75.862775] PGD 7d012067 P4D 7d012067 PUD 7d013067 PMD 0
> > > [   75.884283] Oops: Oops: 0000 [#1] SMP NOPTI
> > > [   75.902274] CPU: 1 UID: 0 PID: 6476 Comm: helmd Tainted: G
> > >  O       6.12.55+ #1
> > > [   75.928903] Tainted: [O]=3DOOT_MODULE
> > > [   75.942484] Hardware name: Google Google Compute Engine/Google
> > > Compute Engine, BIOS Google 01/01/2011
> > > [   75.965868] RIP: 0010:submit_bio_noacct+0x21d/0x470
> > > [   75.978340] Code: 8b 73 48 4d 85 f6 74 55 4c 63 25 b6 ad 89 01 49
> > > 83 fc 06 0f 83 44 02 00 00 4f 8b a4 e6 d0 00 00 00 83 3d 09 c9 7d 01
> > > 00 7e 3f <43> 80 bc 3c 56 01 00 00 00 0f 84 28 01 00 00 48 89 df e8 4=
c
> > > a0 02
> > > [   76.035847] RSP: 0018:ffffa41183463880 EFLAGS: 00010202
> > > [   76.050141] RAX: ffff9d4ec1a81a78 RBX: ffff9d4f3811e6c0 RCX: 00000=
000009410a0
> > > [   76.065176] RDX: 0000000010300001 RSI: ffff9d4ec1a81a78 RDI: ffff9=
d4f3811e6c0
> > > [   76.089292] RBP: ffffa411834638b0 R08: 0000000000001000 R09: ffff9=
d4f3811e6c0
> > > [   76.110878] R10: 2000000000000000 R11: ffffffff8a33e700 R12: 00000=
00000000000
> > > [   76.139068] R13: ffff9d4ec1422bc0 R14: ffff9d4ec2507000 R15: 00000=
00000000000
> > > [   76.168391] FS:  0000000008df7f40(0000) GS:ffff9d4f3dd00000(0000)
> > > knlGS:0000000000000000
> > > [   76.179024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   76.184951] CR2: 0000000000000156 CR3: 000000007d01c006 CR4: 00000=
00000370ef0
> > > [   76.192352] Call Trace:
> > > [   76.194981]  <TASK>
> > > [   76.197257]  ext4_mpage_readpages+0x75c/0x790
> > > [   76.201794]  read_pages+0xa0/0x250
> > > [   76.205373]  page_cache_ra_unbounded+0xa2/0x1c0
> > > [   76.232608]  filemap_get_pages+0x16b/0x7a0
> > > [   76.254151]  ? srso_alias_return_thunk+0x5/0xfbef5
> > > [   76.260523]  filemap_read+0xf6/0x440
> > > [   76.264540]  do_iter_readv_writev+0x17e/0x1c0
> > > [   76.275427]  vfs_iter_read+0x8a/0x140
> > > [   76.279272]  backing_file_read_iter+0x155/0x250
> > > [   76.284425]  ovl_read_iter+0xd7/0x120
> > > [   76.288270]  ? __pfx_ovl_file_accessed+0x10/0x10
> > > [   76.293069]  vfs_read+0x2b1/0x300
> > > [   76.296835]  ksys_read+0x75/0xe0
> > > [   76.300246]  do_syscall_64+0x61/0x130
> > > [   76.304173]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > > Our Findings:
> > >
> > > Not an Ext4 regression: We verified that reverting "ext4: reduce stac=
k
> > > usage in ext4_mpage_readpages()" does not resolve the panic.
> > >
> > > Suspected Fix: We suspect upstream commit 18e48d0e2c7b ("ovl: store
> > > upper real file in ovl_file struct") is the correct fix. It seems to
> > > address this exact lifetime race by persistently pinning the
> > > underlying file.
> >
> > That sounds odd.
> > Using a persistent upper real file may be more efficient than opening
> > a temporary file for every read, but the temporary file is a legit open=
ed file,
> > so it looks like you would be averting the race rather than fixing it.
> >
> > Could you try to analyse the conditions that caused the race?
> >
> > >
> > > The Problem: We cannot apply 18e48d0e2c7b to 6.12 stable because it
> > > depends on the extensive ovl_real_file refactoring series (removing
> > > ovl_real_fdget family functions) that landed in 6.13.
> > >
> > > Is there a recommended way to backport the "persistent real file"
> > > logic to 6.12 without pulling in the entire refactor chain?
> > >
> >
> > These are the commits in overlayfs/file.c v6.12..v6.13:
> >
> > $ git log --oneline  v6.12..v6.13 -- fs/overlayfs/file.c
> > d66907b51ba07 ovl: convert ovl_real_fdget() callers to ovl_real_file()
> > 4333e42ed4444 ovl: convert ovl_real_fdget_path() callers to ovl_real_fi=
le_path()
> > 18e48d0e2c7b1 ovl: store upper real file in ovl_file struct
> > 87a8a76c34a2a ovl: allocate a container struct ovl_file for ovl private=
 context
> > c2c54b5f34f63 ovl: do not open non-data lower file for fsync
> > fc5a1d2287bf2 ovl: use wrapper ovl_revert_creds()
> > 48b50624aec45 backing-file: clean up the API
> >
> > Your claim that 18e48d0e2c7b depends on ovl_real_fdget() is incorrect.
> > You may safely cherry-pick the 4 commits above leading to 18e48d0e2c7b1=
.
> > They are all self contained changes that would be good to have in 6.12.=
y,
> > because they would make cherry-picking future fixes easier.
> >
> > Specifically, backing-file: clean up the API, it is better to have the =
same
> > API in upstream and stable kernels.
> >
> > Thanks,
> > Amir.

