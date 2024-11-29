Return-Path: <linux-fsdevel+bounces-36167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC59DED3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 23:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF30B20E31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 22:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16121A76D1;
	Fri, 29 Nov 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cYEAoFVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2719F40B
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732919405; cv=none; b=ZbFvQs1z9DEeMBTEblWgMTOmVQZFKHdaAXSZRCcBQFHIBFP+n0Jd9iLV/q3gQM332Wvn6OWfJAsgNsJ7n9mH4A8HvHNd6uCXxFVkK/3iesJIuA0zJ3TrXu0u7Ynn+Je+5cVdp07IMGZdENfsEzES6HpgXthayOEyc6tcFbWmAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732919405; c=relaxed/simple;
	bh=US4amykFr5ddVKxjiqf9qV7P1EFpR8NMhdlERjZso+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAv46HfrfSWgiFodZ7Y18zPqI2CoL/8SrphNQ0JdwLsyNRSLm57466gjnmFSbUzCJgg94IrIy1vnx/XJO/kmAdqbSt2RDlviGSx/d3yh1qkcv1QSn4nlEa50UcKyJ+2G9/jV/fLfFN9DqtRD65PVcP2+8Psund4rVcqthF8wmtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cYEAoFVA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso443093866b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 14:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732919400; x=1733524200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hqk8vkSIGyKesedtaum1t29b3vRP4R5QQLHeiE2zpek=;
        b=cYEAoFVAoqxdiCPSyhaqHPdnB3i2AHNJAhHmgMK23K+lENosGfFjRnFF8S1Dm3kY18
         hq3VWUCiiZ+PsE6/rdL9vRZRqio1chzabuUFl7SfY2MCe/vpu4r5GXBBa48NOflbMzqE
         8J/at3EN44E8LcasKrpuf9Nzr6HGNYSR3P2V1HroGkcnSO3yjQRgVce7h9B+Gg/I8+CY
         Xcn5ntftO1ReNVjoeczMvvPd+hcvfBLIBZ0ucAd2TBmdMPTqEQ7gtipuOBazEZwyyiEE
         5Zv/O6z/YUJqo5U5Ja08ZC+jen910T3k0xVT0cq9ckLQUsgLZjm/Re1ACkmGoaSeXlYp
         n5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732919400; x=1733524200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hqk8vkSIGyKesedtaum1t29b3vRP4R5QQLHeiE2zpek=;
        b=AmGvUxBes/k+dkGMRqTWcibAMeaAMJqMN1cRvVPIOc/8Lb/XuhIJzDKZzr9kawnbk6
         K+ByzjSH4k8Y3sV7EkGDStHfOBhbjbcS1IozE9U7cNuV3ulnhQpq5ei5y9okwmfgQ8oh
         CWFMI9tz8yy7z++d3yl54beq4H7tlKyaj0wf+nlYqabync7QzCn50QGexn3YEaZmLoEe
         RUsUiEHPSLh4dUB4rjZm/iUHD0YiUGl0r+/WJpKbqQ0fKOcC1FY4C+a8BkbAsVFTkl6Q
         8JeAiTCCW+riPDbRKM6+v+8CgAB5bFN289vVv99rbl/oL1+jkrKFMJHnvfoTNTOn+Ip1
         GPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuz5W1PgoGSh6lG/grZg07RDXPhhqReIgVN1UeJqBXw9R8fXCGsYxf8AHMshcVXTL59ytW6kASnckJtBbA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4/o4JTz17QOAy8sH3p7spSotD/pjJMgqZyZ1jRlpl3ItV23o
	O3Ozfx3X+w27Vu7HEi9zQrnS/lhqcHR82JBjYzNOuN7nMIOjq1ML0X5hB3YU9Z8Y/GX7krHae5x
	HkZKcJ11UTK1kQY5bCobFrThHpVNt6Vd2e9oRSA==
X-Gm-Gg: ASbGncvHHWC84leDhKEY3+kiVq80hbLRDVI76tkklhtFg9ZHpzUkbItXsJJi4wZPSxe
	S0be3JOCCFBPWDzg6qAcDUri7z9R8nlMJTXt3ann0muBCiQWYZ8US9YvVA3xj
X-Google-Smtp-Source: AGHT+IGD6U3oaxtSMZQVfdy9TFXf1JM6pq//zBUlUW4tdizRmZ1hS6c7zHoDGfiwaAYKXgF9d5AcGO7Xuq+LWbOYwC4=
X-Received: by 2002:a17:906:4c2:b0:aa2:c98:a078 with SMTP id
 a640c23a62f3a-aa581076b06mr1442894966b.57.1732919400359; Fri, 29 Nov 2024
 14:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk>
In-Reply-To: <3990750.1732884087@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 29 Nov 2024 23:29:49 +0100
Message-ID: <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 1:41=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Could you try:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dnetfs-writeback
>
> I think the patches there should fix it.

I have encountered multiple hangs with that branch; for example:

 [<0>] folio_wait_private_2_killable+0xfb/0x180
 [<0>] netfs_write_begin+0xe0/0x450
 [<0>] ceph_write_begin+0x27/0x50
 [<0>] generic_perform_write+0xcd/0x280
 [<0>] ceph_write_iter+0x4d9/0x640
 [<0>] iter_file_splice_write+0x308/0x550
 [<0>] splice_file_range_actor+0x29/0x40
 [<0>] splice_direct_to_actor+0xee/0x270
 [<0>] splice_file_range+0x80/0xc0
 [<0>] ceph_copy_file_range+0xb5/0x5b0
 [<0>] vfs_copy_file_range+0x320/0x5b0
 [<0>] __x64_sys_copy_file_range+0xef/0x200
 [<0>] do_syscall_64+0x64/0x100
 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

I can't be 100% sure if this was caused by your branch or if this is
just another 6.12 regression, but I haven't seen this with 6.11.

