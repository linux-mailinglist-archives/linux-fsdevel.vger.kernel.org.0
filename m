Return-Path: <linux-fsdevel+bounces-65197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065B1BFDC8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816263A2CB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C72EC08F;
	Wed, 22 Oct 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0Sy0WMG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9A2E1C63
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156761; cv=none; b=oH+qt8SwdDVPyvye0i8rgE2o7Vz/8AjSZU4K3zmSNqQI60HD1sJFtsDTWDhs8LVimW1rlv+lrbqkxZvcMcrG1faMefXZ4Pn6zHw0cH8DC0Pn+bNthobDmwUs1+GkMaHUK4WDsIR1RHDiT3Ld83HEA34kkm6lkpZdwIlAWoXkdTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156761; c=relaxed/simple;
	bh=L3H3gsvk+jEZsW0PrATObZIO7dMoEWR3ceyCKKKxT6o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rT24npPkeRc/TAOmYco6BCJJz2bcAm4QQHHXyuIPUmxhjyN3kctmsVyYalYPDGwa/E4lOCWYTr9yYm671iYdCLvTGNonbu+quGOHv4e/iC/esE4fOQXTKuC36F4uuqpoU/pQLjK0ldpQQCkXbQAbswvuycprXeWmMcfXZm46CmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0Sy0WMG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f67ba775aso9207943b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761156760; x=1761761560; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3H3gsvk+jEZsW0PrATObZIO7dMoEWR3ceyCKKKxT6o=;
        b=G0Sy0WMGaVhEyLNLbZrQbxDy1xD4EKYWgQu3CrW2I87O3DqmKrvJFReLJe47r7GsVA
         SJhtkmx92BYSi+Ft46QxG1u2IYkd0u6G6yBA3nHX95fJD2+vy7WAjxfw6oPUaJUhIcGC
         l7EUmc3deb1qapLgdkCzheRoDBdQBFR1ClyFDHBkVBd7wW5gxDnWCM/IqJ250YfoHX9k
         DfGz5bvw34FP2x2//qkrYpiId4PTfGmm02UDT+rqiwd89jEUXYldHkjeEIHcQ6TZVmHk
         KHGT/5AApvR6sParWYnOLtvgBv6kGai1Jg1i/zNI3q6DIOAXfmsjsklO1ooX8E5PdRsG
         zEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761156760; x=1761761560;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L3H3gsvk+jEZsW0PrATObZIO7dMoEWR3ceyCKKKxT6o=;
        b=VL0Nd6463Aoc4cvZYu47DAPa2xT+PRUzeUCGdcxzZt2ju3/gqjb1+ZEeEXF067U95V
         4lzu57QbYOtQCFwkoD6llcbrr0K00YmzlTatxZFwvisvXzZ/9vLQbbrkoaFZFbYYJeWY
         h2jwjR1m5/FId/cR3JJ+ZtmA4nmbQd8UuyaJqlWb4UUPF/tmPIdI1uzN5wPBgMZ3sYCv
         sP2PgXQVZpfTMAHDQDbVTiQ58pkidpU47JaHPjmW/MtdcSyEgXtVZgLGLUBjdcKv5KaG
         lStOHBkP8RqQbb52LG0JIImcLktU6joTSDH81ic9Dt9Gnr2uUBusFXz7JL3HIml0vpov
         a5ew==
X-Forwarded-Encrypted: i=1; AJvYcCW+PwbitQA/+02QreN0CdlzS/Mxk1PvgwMGrE/gVPVc/vbTzhroFrMT2TJXtQGU5ggqEkmH658OmRIoh9wB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4catVanhOOloOLwl096snQ4VRrjWsGtNeOLlCSMu+K4W6BHe0
	D7c+l94T6Dnv8bpiHmEoPbFkHPA9L/+CuDyjc3Lg2L7ihu+tmC0nVrUS
X-Gm-Gg: ASbGncviGM1l5msPS82m31V2b1UQYmPmcqSvs8m1NHoHNt1IEaSldPSXOXFs+nDGszg
	rZ08O+6nuLKu+nnioG+kjuu9ksAR3EacemyU9ghxbTAggHap/qFzKXxPAKo+E5lxFWj2pYIAgT4
	kf0VgbAQL+Chnz6aibRz5HTyuRpYhZJi+8KcfHTfkbcWxexVtaNNxN95a59SjzazYqKvnLN7GWv
	jvisvPa8NH2VMnipxdM9/BQ+eN6u9pUsTBQhHLH/q36oTdLeBCPaThm2gqtbBfgZe4ZIk18kzZK
	Ox+flcOUPUK72zche8ta8qGe/GzbVTYOKn7AGHCBDLevv9bbmI1rQWn6yo/XkiiMpTK8K2VDzU1
	66Zu06aLWBLHhC14KDHdr6YI6jqdc7jaBr6aO8NLv3yOkKssChVP22j0ObWYJVLJ3vvpXOn1HSa
	jQGf04
X-Google-Smtp-Source: AGHT+IE9ukly3OsSJtf/F5Pi5q/3u1rh2/j7Gpz3fL8FIoDXhYOFoguBVAVtJ0gXkaH9zj9KjLEqdQ==
X-Received: by 2002:a05:6a21:328a:b0:248:86a1:a253 with SMTP id adf61e73a8af0-334a8564096mr29786646637.15.1761156759601;
        Wed, 22 Oct 2025 11:12:39 -0700 (PDT)
Received: from localhost ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff158bdsm15487022b3a.16.2025.10.22.11.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 11:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 23:42:32 +0530
Message-Id: <DDP1YQXWXDVQ.FGRPSKHQ26HZ@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Aleksa Sarai" <cyphar@cyphar.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Jan Kara" <jack@suse.cz>, "John
 Garry" <john.g.garry@oracle.com>, "Arnaldo Carvalho de Melo"
 <acme@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, "Namhyung Kim"
 <namhyung@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, "Andrei Vagin"
 <avagin@gmail.com>, "Alexander Mikhalitsyn" <alexander@mihalicyn.com>
Subject: Re: [PATCH v2 1/1] statmount: accept fd as a parameter
From: "Bhavik Sachdev" <b.sachdev1904@gmail.com>
To: "Miklos Szeredi" <miklos@szeredi.hu>
X-Mailer: aerc 0.20.1
References: <20251011124753.1820802-1-b.sachdev1904@gmail.com>
 <20251011124753.1820802-2-b.sachdev1904@gmail.com>
 <CAJfpegtW_qR2+5hKPoaQnPRPixFUnL3t8XpcByKxLRJvkroP5w@mail.gmail.com>
In-Reply-To: <CAJfpegtW_qR2+5hKPoaQnPRPixFUnL3t8XpcByKxLRJvkroP5w@mail.gmail.com>

On Wed Oct 22, 2025 at 10:02 PM IST, Miklos Szeredi wrote:
> What's wrong with statx + statmount?

We would like to get mountinfo for "unmounted" mounts i.e we have an fd
on a mount that has been unmounted with MNT_DETACH. statmount() does not
work on such mounts (with the mnt_id_unique from statx), since they have
no mount namespace. These mounts also don't show up in proc.

v1 of this patch tried a different approach by introducing a new mount
namespace for "unmounted" mounts, which had a bunch of complications
[1]. The cover letter for this patch also has more information [2].

We want to support checkpoint/restore of such fds with CRIU [3].

[1]: https://lore.kernel.org/all/20251006-erlesen-anlagen-9af59899a969@brau=
ner/
[2]: https://lore.kernel.org/all/20251011124753.1820802-1-b.sachdev1904@gma=
il.com/
[3]: https://github.com/checkpoint-restore/criu/pull/2754

Kind regards,
Bhavik

