Return-Path: <linux-fsdevel+bounces-5591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCD180DF15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 00:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B6A1C215A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 23:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5623E5647A;
	Mon, 11 Dec 2023 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecrhLtxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C5CB;
	Mon, 11 Dec 2023 15:00:41 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-286e05d9408so3803417a91.1;
        Mon, 11 Dec 2023 15:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335641; x=1702940441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnPJ53wNJnF9n29am3WoIRSr/plouqkpdL9chGqwmx0=;
        b=ecrhLtxS58xexgjZnkoJOxlq/QTD/PCzSk0yUYCPbH618uqjUee5TX9b4aDKy4lRnZ
         Mt63Fw8brO9NfkPVI6LoF4x/7AsKNGCrEUZAVRMrNBQlyyNI2npop0UPep6JmI6L5c6p
         v2V44ps/kar+/Sql/uy0n34nm7S/8DZPV3i38A13bLTBXUqd8jrQ57H7/5E44uVAWJzb
         RoiINs3h/sUD8RR53g6dS72zVhRW0xwvmkkh6mQ99ja0jndfnMMLW0u0E5RhJ5sj11Gt
         7nrU6/CvE6F+qobBJXpqaQ4uOBjVfhWaGsMsnKJnUDokn8FrehkKXASchIjy4+MoVfhf
         C/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335641; x=1702940441;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qnPJ53wNJnF9n29am3WoIRSr/plouqkpdL9chGqwmx0=;
        b=VUk51OWODS7914svVkEvBsmgOgVDrwE7KlhED50SSr76tDDdmeEXitirm2BaPY83Lo
         CJ67D0EwFczO8UxGF3wH7s7dHc5q2SQxRkCen595VQ6tthlrM28yuJztyO6o058GPYKA
         NYvpX9uHhsqeWjLqF2pW4oZR+tZch9tpaXFBOZzlQErtyfOdl0jJ8dI610hxzfNAeDwU
         97SUb8O6NhbSVat7d1/T/csXT2ullzZuilnskQxo+2iuVHd9pB0bDvrDTQuAtqDz3iuC
         F/boAmz0sFS8YVnaPFFD4FFzIc600Z7xrHu40yG0sfFzYeT9pZiryfmQ/iDOVJH5V/kd
         D9bw==
X-Gm-Message-State: AOJu0YzT3xcQy8mwwYHhdAGUBLw4luDP31SIS6LCmspGaepv8Nh9gDe2
	xRSQQljqdKkbMrJmvyulaM8=
X-Google-Smtp-Source: AGHT+IEfIFvzB0EVGxve0iC+G9GU4cks+IPELe5rzRSvfmXkfh4cBXD2SCovB3eVHaAVQ8S8lBQiaQ==
X-Received: by 2002:a17:90a:708f:b0:286:8c4d:d237 with SMTP id g15-20020a17090a708f00b002868c4dd237mr5661165pjk.10.1702335640814;
        Mon, 11 Dec 2023 15:00:40 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b001d337b8c0b2sm7410plh.7.2023.12.11.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 15:00:40 -0800 (PST)
Date: Mon, 11 Dec 2023 15:00:39 -0800
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
Message-ID: <657794972e412_edaa20893@john.notmuch>
In-Reply-To: <20231207185443.2297160-9-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
 <20231207185443.2297160-9-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 8/8] selftests/bpf: add tests for BPF object load
 with implicit token
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
> Add a test to validate libbpf's implicit BPF token creation from default
> BPF FS location (/sys/fs/bpf). Also validate that disabling this
> implicit BPF token creation works.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

