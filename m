Return-Path: <linux-fsdevel+bounces-74002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7FAD28303
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 20:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B394330215EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6631A55B;
	Thu, 15 Jan 2026 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oasis-open-org.20230601.gappssmtp.com header.i=@oasis-open-org.20230601.gappssmtp.com header.b="cBa6cpUL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2A31A041
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506041; cv=none; b=RsvCLsngUXQSim2V7wYiHnTtkrY1qNY/0fgyq+OehioXf1X3I86rHPPAdvErfI7pdaIQarumtTjEvPZl5fSh6dtYVKAMEdQBSPOfKS/7aMhbloq1qyf4Z/68JBnxd/9tnOBDKoX9jFqbayVVmok/7rApk2YlXaQzgsi0FPPewVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506041; c=relaxed/simple;
	bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SSq0uz6tvsr8PiaYRi2YtCMWz4s2uMEN6+6M18IsF+03+bImMEoVsNWO7ekpGvkPdeDxip0IJX92/hqq8I3BbxnnXWp3jFoY9htDVNUa9pVfaTOJDXRWhv8kO+iid2ucDBxTXo8BuKxPMTEO7/KaEwc9TEB8Qlkq2kfLmhjYb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oasis-open.org; spf=pass smtp.mailfrom=oasis-open.org; dkim=pass (2048-bit key) header.d=oasis-open-org.20230601.gappssmtp.com header.i=@oasis-open-org.20230601.gappssmtp.com header.b=cBa6cpUL; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oasis-open.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oasis-open.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50146483bf9so19925361cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 11:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oasis-open-org.20230601.gappssmtp.com; s=20230601; t=1768506038; x=1769110838; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
        b=cBa6cpULbHFrO/0izDmT3TqDOsQkVfwOsLb9DD6CziTmK55gReuDfXT7yWaI2kcdNP
         COVpc8LfH9D/OXWdDPBmIxQ5CPYZlpgjaPY9Bbqo9v/++OaWb5o1sGd7RW6DdVlVeQpN
         ciwe/w08bjxz/bjXmyIVLn0CqWUpVLLiMdGZUCZ1XTWiADVCMgQ4+kOEx2yZoZfHjyEC
         navSSYrkzE/I7XonJe88KgtvMsxGspuKXDz7XbsiqIVgPWJicDhYRrtQf5gi34fE0C9v
         H2TmoLpCuLibIx9wQrawAlSClMUGk1rhEuxYdjnG51FfZRl97NyrCEjWWLOXZI39PlFb
         HDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768506038; x=1769110838;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
        b=tMWtvsL4wAmVKpTCEhrUY+I+dkrq/jUQg6V7VZpOm0SUXv4t8pm0W2YcoRhPca+BFs
         5RDEX5KUWbhN6pS+GgUZ5L9Xc6kHTdx0Z270hTX2Wps5L3V1LPwGeuFVgaqpuBf73+rr
         I8V68yGl10gnGJQNBD11/f/+3wLbn6i5e+LYLERXEVkhYNmUTB2CZbPIcQIcgMsPwAQv
         WaKDaxRutlWcDrEJedmpgyTEkDfcpImYtvJo3U+i8ey8Om0VPKm9fXopn8rSA9t+Lwxc
         Y3ZT6+dcDSC6ID4PGVuwCOHQniKAe235P8OFYK5Zk2DW4URwzKxR+t67Bi6BS2wT/m4g
         CDWw==
X-Gm-Message-State: AOJu0Yz1IqmFA3yc/toKKwZOXHlkdOrb/5SiCJ1wlicchQRsNp2xAV/m
	eDmCf03mF6sJ8YYroS4gY7OvNJtOnstsoch4IFOfkjik2RzGBbBv2NPNF+/bvcRYXco8wKQIivz
	gfwe9wSwVg7CNu5pDGjUQ6fWdLSZJPBWDM5zd/ZFRQBq9H4UCBE+09Ls=
X-Gm-Gg: AY/fxX6YW8WZfuasK1iM4CeOmcUeHn7ZHkTtYqmtPTrhTg/uhOfANBwxbrakKkhoU+q
	R2KETCltBrToTowRuLPq8QR/iCY+xeaFyxCV4US089fqLPFLNphapCeO757lWoeWE6xNEx4Wi36
	d6jfTbJeJ/mlq3XoUDZ1D/pCAUjWieyvDKeTB1xcDhAqhrXuiFHK+de2DC491im8BN/+SPZyE6f
	+YoNouoK2rGzjWTwq8BEjXpL0hnacibCku873NsfdcH8koz8bsxib234Ba/9TTVW9N5/luuIygA
	+KB3Wf1d+IFMTQA9mTOzd+KU+krTFWn8qTgFPjPcDtNK17SMEpgtHZjH41wB
X-Received: by 2002:ac8:7f56:0:b0:501:5184:4b64 with SMTP id
 d75a77b69052e-502a16b3088mr8412161cf.49.1768506038125; Thu, 15 Jan 2026
 11:40:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kelly Cullinane <kelly.cullinane@oasis-open.org>
Date: Thu, 15 Jan 2026 14:40:01 -0500
X-Gm-Features: AZwV_Qhxqx_5ROv9K9PsiovYrLYZMkOLkyk3WzE5Ry3lsxafg9alkrJOkt4pqAA
Message-ID: <CAAiF603Qdf+fdcLpiLUG4NqzVroOOtqZr3w5Kze0g5VpkRe-Yw@mail.gmail.com>
Subject: Invitation to comment on VIRTIO v1.4 CSD01
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OASIS members and other interested parties,

OASIS and the VIRTIO TC are pleased to announce that VIRTIO v1.4 CSD01
is now available for public review and comment.

VIRTIO TC aims to enhance the performance of virtual devices by
standardizing key features of the VIRTIO (Virtual I/O) Device
Specification.

Virtual I/O Device (VIRTIO) Version 1.4
Committee Specification Draft 01 / Public Review Draft 01
09 December 2025

TEX: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.html
(Authoritative)
HTML: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-cs=
prd01.html
PDF: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.pdf

The ZIP containing the complete files of this release is found in the direc=
tory:
https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csprd01.=
zip

How to Provide Feedback
OASIS and the VIRTIO TC value your feedback. We solicit input from
developers, users and others, whether OASIS members or not, for the
sake of improving the interoperability and quality of its technical
work.

The public review is now open and ends Friday, February 13 2026 at 23:59 UT=
C.

Comments may be submitted to the project=E2=80=99s comment mailing list at
virtio-comment@lists.linux.dev. You can subscribe to the list by
sending an email to
virtio-comment+subscribe@lists.linux.dev.

All comments submitted to OASIS are subject to the OASIS Feedback
License, which ensures that the feedback you provide carries the same
obligations at least as the obligations of the TC members. In
connection with this public review, we call your attention to the
OASIS IPR Policy applicable especially to the work of this technical
committee. All members of the TC should be familiar with this
document, which may create obligations regarding the disclosure and
availability of a member's patent, copyright, trademark and license
rights that read on an approved OASIS specification.

OASIS invites any persons who know of any such claims to disclose
these if they may be essential to the implementation of the above
specification, so that notice of them may be posted to the notice page
for this TC's work.

Additional information about the specification and the VIRTIO TC can
be found at the TC=E2=80=99s public homepage.

