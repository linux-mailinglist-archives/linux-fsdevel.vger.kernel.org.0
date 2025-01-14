Return-Path: <linux-fsdevel+bounces-39174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2946A1114A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 20:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CBB3A415F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7402066DC;
	Tue, 14 Jan 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZydFt4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ED01F9F66;
	Tue, 14 Jan 2025 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883680; cv=none; b=ZICjgsTrSfz7Uz3Ohjbq6U6XajhH2bVpRQtl3XVyLB9Yo74TzuOnDnxz2ZnGp2eFbRlmVv65zjshnPL586eA8tqutJPCiHIILxcJBSkOy2V/NMKWeXZcRu9hzR2aCfxmpI46d9Umh3V0TTt2KANbyamya5XThYRgN9P5YmdYacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883680; c=relaxed/simple;
	bh=b46wwKHdtn2d8R/Y3HJovXqBmFkvR6voco2WrSLLd7A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lvY8nmrbg6oXfVFXdvNBZg63qYKh/H3tkRLYVHSSF33c6UNTt5bVkRK69SXO/v7TaAv4ZtfMtspL1vQmirDYA2C2FZhG05ey2FrnTsMxzjAU9OIvcjdNFo4QvdBJd5zuCRyGhvAtzVqnf2WS5xIEk80nSth9oULmA9aUVozBW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZydFt4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF32C4CEDD;
	Tue, 14 Jan 2025 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736883677;
	bh=b46wwKHdtn2d8R/Y3HJovXqBmFkvR6voco2WrSLLd7A=;
	h=From:Date:Subject:To:From;
	b=fZydFt4o4yuTtPuGLKdbG+H0bOUEL2K6/CbPvcB+t6w+gDvhYZLr6zEfl03I4xs50
	 P0nFE8zkyW2VpAB0EAxJ0MbHiCqEpkvWLqVe3w2naQg53Kl0Inyd/kSZ/nqOXJ9KHm
	 Hbif2Ow7+yaW2t8X4+HjwOoW8fsFRKEirRg8+SlJ+OIZ1OKFFkhdO2vubbjVgQzQfL
	 DZKaGWekIH47TmscgL7qJuURnkVtaP3G1QO5rBzrLqoBG8otC4F5O6eesBKZxSDuvF
	 fxLIgKqp/om8GpAfHPXu8AaS6Ycu7HUeWPwQl3GeNuDzR36/GQ8XAo99JKBxudd1k/
	 MNXFhZL+2j/gg==
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so450505739f.0;
        Tue, 14 Jan 2025 11:41:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgWpik9xWdn8l2DU6sabxoHchjC6cF/KPQjRqdkFOZ6jbYTbby/tF4e1oZak/aCveye5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmlVKme2b4aokkr8oAfbB+/93A+WAeswqagKtQ2qfeRHskh4cR
	gmyKsTShMOMGpM4F8AHilCw11Lu7yv/HwWZkll+vr7Wt5IszIP+COdiSAWClxlqWdPTSNw0mMPP
	SLp/dqvgF0v+iaPaB+sFAP8cMnzM=
X-Google-Smtp-Source: AGHT+IGP62JJXF//2GOW4SvYTmFvhsRafhXNBuFxPRKZdP0Qrv2j0n9y25oMjBnJS9vMd9HJG2V/Gp0jxTaf8B8jqxA=
X-Received: by 2002:a05:6e02:1c8e:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3ce3a8882famr202504455ab.13.1736883677196; Tue, 14 Jan 2025
 11:41:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Song Liu <song@kernel.org>
Date: Tue, 14 Jan 2025 11:41:06 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4psFtCVqHe2wK4RO2boCbcyPtfsGzHzzNU_1D0gsVoaA@mail.gmail.com>
X-Gm-Features: AbW1kvYnGSEoGjtTLy0SrEYxhlBuwPj8kC1B2rRS8gEFM4cUznQm8kf8CrJBE1w
Message-ID: <CAPhsuW4psFtCVqHe2wK4RO2boCbcyPtfsGzHzzNU_1D0gsVoaA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] fanotify filter
To: Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

At LSF/MM/BPF 2025, I would like to continue the discussion on enabling
in-kernel fanotify filter, with kernel modules or BPF programs.There are a
few rounds of RFC/PATCH for this work:[1][2][3].


=============== Motivation =================

Currently, fanotify sends all events to user space, which is expensive. If the
in-kernel filter can handle some events, it will be a clear win.

Tracing and LSM BPF programs are always global. For systems that use
different rules on different files/directories, the complexity and overhead
of these tracing/LSM programs may grow linearly with the number of
rules. fanotify, on the other hand, only enters the actual handlers for
matching fanotify marks. Therefore, fanotify-bpf has the potential to be a
more scalable alternative to tracing/LSM BPF programs.

Monitoring of a sub-tree in the VFS has been a challenge for both fanotify
[4] and BPF LSM [5]. One of the key motivations of this work is to provide a
more efficient solution for sub-tree monitoring.


=============== Challenge =================

The latest proposal for sub-tree monitoring is to have a per filesystem
fanotify mark and use the filter function (in a kernel module or a BPF
program) to filter events for the target sub-tree. This approach is not
scalable for multiple rules within the same file system, and thus has
little benefit over existing tracing/LSM BPF programs. A better approach
would be use per directory fanotify marks. However, it is not yet clear
how to manage these marks. A naive approach for this is to employ
some directory walking mechanism to populate the marks to all sub
directories in the sub-tree at the beginning; and then on mkdir, the
child directory needs to inherit marks from the parent directory. I hope
we can discuss the best solution for this in LSF/MM/BPF.

Thanks,
Song

[1] v3: https://lore.kernel.org/bpf/20241122225958.1775625-1-song@kernel.org/
[2] v2: https://lore.kernel.org/bpf/20241114084345.1564165-1-song@kernel.org/
[3] v1: https://lore.kernel.org/bpf/20241029231244.2834368-1-song@kernel.org/
[4] https://lpc.events/event/18/contributions/1717/
[5] https://lpc.events/event/18/contributions/1940/

