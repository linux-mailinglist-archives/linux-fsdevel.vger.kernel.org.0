Return-Path: <linux-fsdevel+bounces-14806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C807787FB64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 11:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB90B22CB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 10:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9619F7D3F3;
	Tue, 19 Mar 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6U0A6PI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD07C6E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842365; cv=none; b=o1qra63aNubgVIF+H5QEXcbivynqTQtPX8MOCuMCGzlmCnHWrGHYgZtUr7VwAPOZOa/03xEDuV5DukyvCk4DpVc3Vuef3H8ZtGtQvygLyw7XTlo5NPQ4UYErp3FSHBvWfrVfcrtHOzpm82xSoDwPlkJXFNATV1calGdps1j/WH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842365; c=relaxed/simple;
	bh=kyuRV9x7mxJvNANj3YX2181UL/5wfq+xba4drEAgcPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaRwowpzlZGVkDYWRoYjVRoM9qjG9Jashf9+kRCAzRnmwCrFpRNDIm8wofvM1tbC+vU62qtqvN2orvIy+n5wRv1kvgO8II58mMT+AMFDZkh4DLdKzLo7JOxd4zr+yCT+DbXnXpB5ibsqcZPRKzcRxJVG+hGwYL3bb65DDK+fGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6U0A6PI; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789f00aba19so117814685a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710842362; x=1711447162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q43z3XsRBJB8FTsJO9MpwAVNnydTDZMLaFovr7lN+8E=;
        b=X6U0A6PIEhQaLxIXB6L3LmEBBvlTO+FHRY0X8krhw0wfV4d7+ZyHqrly7oFF2ZbznL
         thCm65Mbhch3Rv3mBijHCFNpZhOyzzZ2Km8ZFmGzBoN1RhyMM8NBOohvu0Ayib/K0UF/
         1GCBTEkCQJBauAylzlGtDNKpzb7cj+dV3hFiscVmzwuZzrpZsCrER+uhqPEv1lLY1ZuN
         0bbpuMTrevEzofI1eNwVHEcc0A+OPps/y9XytyoxariZNx/H2gJAu2x8t+7lKDkSj1Ud
         u5h8w/Qc8p71hN/H96/D8j+4Pyqt5S/YB64eChEmqSo8PZ94FnIFKuA+VPzN4Am3i8OB
         SoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710842362; x=1711447162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q43z3XsRBJB8FTsJO9MpwAVNnydTDZMLaFovr7lN+8E=;
        b=MC9ZBQWvI7c37/GvDoolhUwL6QMA0Ps8ogGOZbjeTD5fbnY3aShBUfEV5d0NwSLgaB
         tXWPyE+SNexAXY+bc5DvmPGKEvyG5ue3SL64vaukbBj2l/xcSVNuJqjvalAPB3Y058oz
         0q5I8Gri3O4n7Wgb8PjFQdWCABnv1U5UtlXg/h5EB5udpWgqgDoYVjDqojShazdNaNOx
         N51vvh3H0Db2czhqWbIqfEKS9IuND5Vrms0XbAYcwhRljHlyAlmBJiIupUKae9tcXBPJ
         LxRXBK2p+CHmX0Jb3jLuAKlG7yyzCRGs4XSSknMqbkGWKPuMZBHubUNoxGAxvNPbUuB2
         PGCg==
X-Forwarded-Encrypted: i=1; AJvYcCUmdABUrtA0ADjLXNfQjUwvun4EEXPMra0xEAOjGXJECG8ZHE/Xyhl8mbo2fhnipN3QokbNCt9vyuaaGaFGoTn75lVV18uiJZ5DvU4hGQ==
X-Gm-Message-State: AOJu0YzVVfCekTuS5Fb/7lkq3+V7X/+01J9PgLJN9SqlUyPCn1+Ewsrc
	Ga70e2/EYXtm1DOEpfzA4+MxQ0Ixr6NXHmzJ7wIKcgjvVQuVilY1Ms5Agmdqf9tz7YDvNWGlklE
	T2a87Ihz9qDgdcZXiHzpX8gym9LL5oyNs2mY=
X-Google-Smtp-Source: AGHT+IFglU2Xmje4EwgAKeicsXQOjn45rVjEQYJZpAXMDn0j9szP5fmCeCp/6OBuXiKujicHvdMd3oTWTQ0BhKSMu4s=
X-Received: by 2002:a0c:db06:0:b0:696:2539:da6b with SMTP id
 d6-20020a0cdb06000000b006962539da6bmr3714394qvk.53.1710842362597; Tue, 19 Mar
 2024 02:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317184154.1200192-1-amir73il@gmail.com>
In-Reply-To: <20240317184154.1200192-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Mar 2024 11:59:11 +0200
Message-ID: <CAOQ4uxgssYK=vL3=0af6gh+AgSPx__UR2cU6gAu_1a3nVdYKLA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Further reduce overhead of fsnotify permission hooks
To: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 8:42=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Jan,
>
> Commit 082fd1ea1f98 ("fsnotify: optimize the case of no parent watcher")
> has reduced the CPU overhead of fsnotify hooks, but we can further
> reduce the overhead of permission event hooks, by avoiding the call to
> fsnotify() and fsnotify_parent() altogether when there are no permission
> event watchers on the sb.
>
> The main motivation for this work was to avoid the overhead that was
> reported by kernel test robot on the patch that adds the upcoming
> per-content event hooks (i.e. FS_PRE_ACCESS/FS_PRE_MODIFY).
>
> Kernel test robot has confirmed that with this series, the addition of
> pre-conent fsnotify hooks does not result in any regression [1].
> Kernet test robot has also reported performance improvements in some
> workloads compared to upstream on an earlier version of this series, but
> still waiting for the final results.

FYI, the results are back [1] and they show clear improvement in two
workloads by this patch set as expected when the permission hooks
are practically being disabled:

---------------- ---------------------------
--------------------------- ---------------------------
         %stddev     %change         %stddev     %change
%stddev     %change         %stddev
             \          |                \          |                \
         |                \
 1.338e+08            +0.4%  1.344e+08            +0.3%  1.342e+08
       +5.8%  1.416e+08        unixbench.throughput
 5.759e+10            +0.4%  5.784e+10            +0.2%  5.772e+10
       +5.8%  6.094e+10        unixbench.workload

Thanks,
Amir.

[1] https://lore.kernel.org/all/Zfj3wxDHolB1qCGO@xsang-OptiPlex-9020/

