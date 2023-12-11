Return-Path: <linux-fsdevel+bounces-5581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382580DD4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 22:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4441F214B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 21:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D0654F9E;
	Mon, 11 Dec 2023 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ7tAVmx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D428F91;
	Mon, 11 Dec 2023 13:38:16 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d05e4a94c3so43605795ad.1;
        Mon, 11 Dec 2023 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702330696; x=1702935496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVtx9y2RTaJccmfxnvmKnua87YHbBjEdXVF8LqTlRhs=;
        b=GQ7tAVmxkJhh9oQ39E4UPCE+ge5xUXk0jhloPOU1ICRgaKFJmf7smk+gWZA6hLfof2
         EeYyK+YHQrblp7sTu5jY+1X7WyprqoGWBPNcsOZPAdB29MHI0OpTmDx/ENyL7dWLKo4c
         PErJp1/lqXM8yC6o5punnI4Qj8Dh6O2KSdO5ghD5uPIweUPBUnHjtxcEYI1FeJUXBeqN
         tWK5IB7YpFdXV7aHquM0mz2xg5SaV0PmeH54PxwJ32P8EPzWGodZnCCiviPKNy4G4hmn
         K9UdeLePxIx8CTvZKXtY3i4vTIG+uNoDDJLSDX6jOTWweXkeCEkbmdsbemqJmyqBFFa7
         U/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330696; x=1702935496;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VVtx9y2RTaJccmfxnvmKnua87YHbBjEdXVF8LqTlRhs=;
        b=NL+UAAFNXmT5ey6vB6GqQCxNmeasPicp/SZq9iLJNZhij1NiU5eRAP5svnCA7bhJBU
         vwbt8gumuRy+HQulAyfYVQx2teFyh3bWXoXa5aCQUgfyzl+ZPPJp3aAKbdE8dhShx8tr
         528ddX5Vakayfe5V/nceEZEszSJON9tV0UAPh11DRQ2B/tM3sJLNV2+rRsiGTAFFDCjA
         0/BtcuIBAtP+NsrsSi73+T46DQfcGRAP4hJoIJL8tcXAVtEArLZOZmA//u8XuW9pMsH+
         CRP8u21NWC8ulkNrMJiGBiuARfcZBeFt3Fcd3RPGTSMBWeTHYm4dpqXIfHv6Y0WUSh+6
         S3ZQ==
X-Gm-Message-State: AOJu0YyRjFJtqKnp3GMFMVCb4Wc1S3tttViJSjRvGWvlLxiRR19di2M+
	uErkHbRxKgmidKhdBls8mKs=
X-Google-Smtp-Source: AGHT+IH1Nbm9Ee4uCAILOtli0VhSEai+sn2iECzFml5RnkKgGOH/Z1G6EQj7LNpxGp8G1ZgBH/SXnA==
X-Received: by 2002:a17:903:32d0:b0:1d0:8be8:bb6a with SMTP id i16-20020a17090332d000b001d08be8bb6amr5763861plr.67.1702330696209;
        Mon, 11 Dec 2023 13:38:16 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902d34900b001cc131c65besm7179721plk.168.2023.12.11.13.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:38:15 -0800 (PST)
Date: Mon, 11 Dec 2023 13:38:14 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 paul@paul-moore.com, 
 brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 keescook@chromium.org, 
 kernel-team@meta.com, 
 sargun@sargun.me
Message-ID: <6577814627500_edaa20817@john.notmuch>
In-Reply-To: <20231207185443.2297160-3-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
 <20231207185443.2297160-3-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 2/8] libbpf: split feature detectors definitions
 from cached results
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> Split a list of supported feature detectors with their corresponding
> callbacks from actual cached supported/missing values. This will allow
> to have more flexible per-token or per-object feature detectors in
> subsequent refactorings.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

