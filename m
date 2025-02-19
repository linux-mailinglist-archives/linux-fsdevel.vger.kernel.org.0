Return-Path: <linux-fsdevel+bounces-42118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE4A3C932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 20:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6053E1896256
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 19:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC8B22CBCC;
	Wed, 19 Feb 2025 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZR8MVlNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A221ADC86
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994844; cv=none; b=Qd95k3HCOTNcK/vABFtr0u4v6xF8thDuh5Pl87DyMAQ17FOAyBHE3h8zMHCebANYeqMjjV3mtshetOe+W7ff7NIoElKc4rzgxNRCa7T0HIis6yOyiY8ELdeCWEsLz2rEfGEfhAZY8h9srdOvm3oWNS/K7LVkp/aQky+fhWclnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994844; c=relaxed/simple;
	bh=Nw+MzwvSACP3Ajd13gcjHTu4UbzARKJwMTIS0ppUSh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RsHWojv5URHAodIG921Dnpg9V4VDqMRxob2z0XLne+CjIG2l8TROTBKhMG/+vvDuKeOHgEldSQaJ5d9f8F9xtt60XWZbhERsSRLQyhF7tYpL9YBAguh+8M4G7imRHEkSqvN3NLRE7yATySwEANXNhqoS0XTT9YDbUFiiIfUJn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samclewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZR8MVlNK; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samclewis.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c0bc004403so37858485a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 11:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739994842; x=1740599642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:tested-by
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw+MzwvSACP3Ajd13gcjHTu4UbzARKJwMTIS0ppUSh8=;
        b=ZR8MVlNKklknMB302NHfRd5xloYX1GgpKeYqiq9NWvaTFs40aUJ8fTTeoelEi9A5er
         kp1TJuj8mWODXtip9T6RqYLCw+k8TqhxRco/F+azcRusw7ZCMUbYFpDKPgShCOw5as/m
         Qd2rW9vxGETtmdrgpiQGuscbSiKzJNhoTntExjBGNO+MdzAW7XibdLFyzTS8nKpBQRsi
         6EYnSAuUOppKMvLPmpv9MrqsacoifcLNOpI9mpjxz2EbupBzaS6M6hnRiHXd43hHKREH
         2pa9mQ6fzGnDHQ3ahAwmn0bBW9ZaksLtOd9KVyxyA+DaC2yVg9hvLABR7m52cNHnmAel
         6h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739994842; x=1740599642;
        h=content-transfer-encoding:cc:to:from:subject:message-id:tested-by
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nw+MzwvSACP3Ajd13gcjHTu4UbzARKJwMTIS0ppUSh8=;
        b=ejpjYbC45gf49u8BaUHjaLC5rPfjSvhbhHZ05eYGykICzrwcb85bJF2zKrTPjzDsa1
         xEmKwQcqC3cXW7yMHygBy8NxZGjXRhqkm7zBIIL57urXlZzshvnwbvcv8Ydn4VAsfnME
         izNLBtmcrOoWFzJKJdPgc4OSvDO2DHniUpoAfKG2lWXlrIxqo2AWi0wUU64ExduTQrv7
         nnJB2u0jimxp3jb4wRE2uaya2lR2Qgqzfi4YOdq0HxXDeHDL554vvqeI334+qKGDKxuW
         NZAXZaeXlk2NZpHTGGRPzvsL8PELl7KEu5nH09K3Kuva4Q1yMXyZzsrSEUA6N5qEh/lT
         E3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXB6On7R+X9S/7WydCHTWaukStfecB/CUjYf9GcyNavc06chXtHyP/TKHXV+iNu+nT5AJj6HNNjuKD1fp8O@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdPuOSgsvChotJoA6mkYZYviy/4JgAXRfoBOZNJji/o3ttaWJ
	FYFmpLfQ3Y8w1yn2g6ynuOBPhe9xvuS/ZvTZv0KuvLk0d8RZPUy4zLC6oBNWbeRX7zY8SfiMkFd
	ljy56kz0e0VZwvw==
X-Google-Smtp-Source: AGHT+IFI5hAVN84Uzvg73SCYngBxNMJW6ZPSqb1Ym8tYhWvx7RgTSN+nkl9mSGn9/3MszitN1Y2CUidUNSFK/14=
X-Received: from qkoz24.prod.google.com ([2002:a05:620a:2618:b0:7c0:7693:5161])
 (user=samclewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4552:b0:7c0:c282:702d with SMTP id af79cd13be357-7c0c28270d9mr46134185a.39.1739994841937;
 Wed, 19 Feb 2025 11:54:01 -0800 (PST)
Date: Wed, 19 Feb 2025 19:54:00 +0000
In-Reply-To: <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com>
Tested-By: Sam Lewis <samclewis@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219195400.1700787-1-samclewis@google.com>
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
From: Sam Lewis <samclewis@google.com>
To: miklos@szeredi.hu
Cc: bernd.schubert@fastmail.fm, fuse-devel@lists.sourceforge.net, 
	laura.promberger@cern.ch, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miklos.

I work at Google on the Android team, and we have a build system that would=
 benefit greatly from the kernel symlink cache. In my testing, I can easily=
 reproduce the truncation using the steps outlined by Laura. I tested your =
patch and have confirmed it fixes the bug.

What steps need to be taken to merge your fix? Can I help in any way?

Thanks,
Sam Lewis

