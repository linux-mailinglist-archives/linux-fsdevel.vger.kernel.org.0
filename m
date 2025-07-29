Return-Path: <linux-fsdevel+bounces-56268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D3EB15289
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 20:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE7B18A36F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 18:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D814235078;
	Tue, 29 Jul 2025 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2WKRWJs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239201361;
	Tue, 29 Jul 2025 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753812964; cv=none; b=AUAez9SAIChh1PjMwWaUODcly32tgrp7ApSbourVWeOSXq+emgcs2iZU1O2o0KKy8LeeatZaHHC7VeDrb2sHY9PVbFCbQeKIMyJpyBSWuESiKv44TjfVYiFQGsfZgsPGSYw2xZRsOmwOJdLgwXtNh1i8CYm/CK8NpYEXXWBJ93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753812964; c=relaxed/simple;
	bh=365pewIvt87QYMCUS9A/Pd+o5vLD9zdpOLuOBWPFhB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHfTlXR0eoeeiAQL/q38FXwkpJ+0eANt5pjSCA1TLD4OWH2aTeLHcNzr/GRtKNgWK0Tu+aDIUd9NdmC41XlAH4HoOUmfnd6cyQuntMVtWhcmTIL84BTZGOga1wUcnF2ovEyJZFbO+jhJFTfBWywlEDqmx2nuWL41p8WroAFWqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2WKRWJs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-240418cbb8bso15918485ad.2;
        Tue, 29 Jul 2025 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753812962; x=1754417762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/z7LPNCwwsOJ3iBUB9KzDeE9kAA1x0mxGQRzPSYd0wQ=;
        b=h2WKRWJsCN1VUp92mBkztApw7D5W/OtuQ+DfPYLI8hsvEqteVBUBCYheM8QFw8Y9hQ
         tjbtnIq/+m/g4LhaItucioLH9/NwuNP0MeU1ejwKd6bx9d1dIK7Wqen8qL1CM5XVfqNs
         gO6e+jp7B2H7mdJOlkwwLGvWc6CK8L0OQhbpa3WNUMp1Y+nDdQnn4S6wK9dYs59+ArmN
         6djy27tMHkNJrmRVgf42OaAG+0KT1SmXidP0W6ZX74Ivrf2fXazIiQJCpo7AnFz3Ubli
         COs4Qk1W27M+G5QirMLxDzAG5507qEh9dwsPFp+G3449x93yc1pzCs4gSecy5tBf2L7a
         omMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753812962; x=1754417762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z7LPNCwwsOJ3iBUB9KzDeE9kAA1x0mxGQRzPSYd0wQ=;
        b=TdUPuiMiV7WjflhZSlI/OPpeMnOODW/35HwEMm251K0hoppIBKEdu2TNbzxwwjwr6q
         H9GeQaoCisiVF4PwEBFMidAtfVfnJrk35qK7HivKE2+7yn17IH0LcPHpmniGSLQ6wr50
         Dix0sOPpf8SOMm3Bqsfz9arHgL/1QQs7La7ST1dLWDONIy5jsgfUMhVDdNmOxXsdzx3u
         Go48bMPgaU6zejxVKzmmGN7n3ER9oS2l0YbPlubAxsJaCZ0wLYYVm+yBpwTM3QvVyTsE
         lyAS+zK7cXzVw1qU9URijuq8ESqukEyjY4qg16koSeGT05gl8LVdxa+eJdQRxINq2cJ4
         koJA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Z3CHQ89HLjCP/cbaZyDTG819eGXh7OVnugGwVsa/kptCpyPBV2EewiCfX88ANuz50zxjswfflsXECYLv@vger.kernel.org, AJvYcCVhJn7kIObMPP1oym4SsihDIRLGYjdkT8ezKSQxiJlj+SrzvGxI0rhicpmmkxwtcQP1FMxzLZGsUZmzZPz+gQ==@vger.kernel.org, AJvYcCWGtMZvgf8u/7Wk9KmypRKth45DbTadmOkTORRFvFluuj/r747ahOvZ5NQpfK+Gq60SUuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPs6aaIjMFUWRzirVknH/LgzQqFR7rh4fmz1q393JoQPneu5tC
	E6HGUdOBpr/vLCWUhtGCcvu1vJM0t2Nk/xOf1Zb3LyZ+NOy9l0F081f27R9oyw==
X-Gm-Gg: ASbGncsmzfVWwStq4IJ46pPE7e1UNs7xPuxcHunhy1v8Ma2feQLUDcIYIaLrIV+Xrlf
	RyWoRz3BAkqsPOlMub2jPnFyhmG6QQZd/lxwJvfHOZwOkmtCfuWmnL0lBTOUmkz4SyxTULNF/c5
	u7h+IxcN8XR0LwYC0MmBwntvU2Rmy0GdqXPqtcJUQX4LAEsZBzEqp4Jeq4F87hirNot2lHZfurs
	InPo8GVJ/Le9/oT++FrUQP69m0xGXsWckksuo+dMO9awdoecwQ7e4ItHH1MLGxfbAChSJMhfLW+
	fCqPixrOUDRQJAMEIvrR+6M7GZUP7f5+P8urDrIHJCCMpeXI+X6GLBZVRt833V+xap8tfMK9phC
	a3Hi2/QhGozbwVAYkFdxX5UJQ2x4pTs8=
X-Google-Smtp-Source: AGHT+IFgBm6B7uA/Uy2PgQ5iCdT1OAAHW2+ZTGWnqQ6VzgoDUm2/6tn6iEPghhj1li3zgFPGLfTigA==
X-Received: by 2002:a17:903:903:b0:240:3e72:efb3 with SMTP id d9443c01a7336-24096b3cfcdmr4211875ad.43.1753812962180;
        Tue, 29 Jul 2025 11:16:02 -0700 (PDT)
Received: from ast-mac ([2620:10d:c090:500::7:669b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe536e6dsm83983525ad.171.2025.07.29.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:16:01 -0700 (PDT)
Date: Tue, 29 Jul 2025 11:15:56 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [GIT PULL 09/14 for v6.17] vfs bpf
Message-ID: <ysgjztjbsmjae3g4jybuzlmfljq5zog3eja7augtrjmji5pqw4@n3sc37ynny3t>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
 <20250725-vfs-bpf-a1ee4bf91435@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-vfs-bpf-a1ee4bf91435@brauner>

On Fri, Jul 25, 2025 at 01:27:15PM +0200, Christian Brauner wrote:
> Hey Linus,
> 
> /* Summary */
> These changes allow bpf to read extended attributes from cgroupfs.
> This is useful in redirecting AF_UNIX socket connections based on cgroup
> membership of the socket. One use-case is the ability to implement log
> namespaces in systemd so services and containers are redirected to
> different journals.
> 
> Please note that I plan on merging bpf changes related to the vfs
> exclusively via vfs trees.

That was not discussed and agreed upon.

> /* Testing */

The selftests/bpf had bugs flagged by BPF CI.

> /* Conflicts */
> 
> Merge conflicts with mainline
> =============================
> 
> No known conflicts.
> 
> Merge conflicts with other trees
> ================================
> 
> No known conflicts.

You were told a month ago that there are conflicts
and you were also told that the branch shouldn't be rebased,
yet you ignored it.

> Christian Brauner (3):
>       kernfs: remove iattr_mutex
>       Merge patch series "Introduce bpf_cgroup_read_xattr"
>       selftests/kernfs: test xattr retrieval
> 
> Song Liu (3):
>       bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
>       bpf: Mark cgroup_subsys_state->cgroup RCU safe
>       selftests/bpf: Add tests for bpf_cgroup_read_xattr
> 
>  fs/bpf_fs_kfuncs.c                                 |  34 +++++
>  fs/kernfs/inode.c                                  |  70 ++++-----
>  kernel/bpf/helpers.c                               |   3 +
>  kernel/bpf/verifier.c                              |   5 +
>  tools/testing/selftests/bpf/bpf_experimental.h     |   3 +
>  .../selftests/bpf/prog_tests/cgroup_xattr.c        | 145 +++++++++++++++++++
>  .../selftests/bpf/progs/cgroup_read_xattr.c        | 158 +++++++++++++++++++++
>  .../selftests/bpf/progs/read_cgroupfs_xattr.c      |  60 ++++++++

Now Linus needs to resolve the conflicts again.
More details in bpf-next PR:
https://lore.kernel.org/bpf/20250729180626.35057-1-alexei.starovoitov@gmail.com/


