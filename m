Return-Path: <linux-fsdevel+bounces-44364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8158AA67EFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 22:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB89D1899339
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 21:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004D32063C0;
	Tue, 18 Mar 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4frTxwpf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC3B205E18
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334093; cv=none; b=AkXSvubLW2gUx+J8lPfO1o/x/FrKAe9zgOXOk0xev3aYK4Vu9Mbvb5K6pFM01xredSVb4YpaQg/uqNSQLdd+dxI0HsnKvTr4xvUBtBm9sY+6TALNRuNXlJ9MI4Lxt3gaTO9JmYrVZcFHQPR2ESRKX7PZMXqGZZwI1j0tYz09aOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334093; c=relaxed/simple;
	bh=ikVSyIcDjEAbw/xIoxMzWfbS6Uydb28wDt5nD4ZIUd4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cqgfjZaHRELzNB4gmO3pXZgbIy2KqmNdWLWvx4PitX/+rjf4y4Vgf9xFmNeQDnU9xpikLNIx+Xu74/uq90JkmfGnASSg7yVWs6IWFAJWa7K0CUxDhhnggv88lQjwdvyQneUPQdK4U1NoAYt98o5WGnl6KoUxDb7EsXDvlbBYuf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4frTxwpf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so10274416a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742334091; x=1742938891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UnIVkMBpPNHpHkzRiOFkBTXk7lARMRWDLlaFgNuX0xs=;
        b=4frTxwpfBkUdDd66o6UISQEQ7LC0N+ECOF8tYiqW7ZhsJmJdRuyBePeLQfGa8IUNPe
         d3GUlCExrNbMOXV7UR5uOlDsp8HZdNAxm6AWJhMwBJuem50E2dZNjDV8mGEzjNkncsLV
         xULCUjBmysEA/zNPz4jWLePtZHURg4Z5I3GrYiQeQdoFDXVhVe9B7O4JvqIFqQ3ZU0RW
         7Ac/pjVEypZT3M9NHfQXg8qh4HisZxYlxCElSexetCwNaNEufiomoKPXh/zWTg/l/4SY
         h2nSjeNdcy7q1Gm5SGtbtjKMTgDbqWsKALObr3NeGY/klWbq8JjNiXG47Hege4oHBuUC
         0Xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334091; x=1742938891;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnIVkMBpPNHpHkzRiOFkBTXk7lARMRWDLlaFgNuX0xs=;
        b=t1DY45ACKwRe8yDoLE+mVdnMXwlN/fmnGKMG0GDdBQ6T+UIVFjPRDu7BuZ9okejIGM
         g+S1bWn2sPx4/sGlJ2QvaUSHkCvLX1sEtHzprh7q9vbuBXJiDRyR3a9ouEFmIsuQymea
         KY1rneVdT3H7gAUfMgdg9NHm80WJwd8S0udOrm0sWuyBy1Oa8zMBKyjyLndvsF5xUL2Y
         0E78pQX9m4tKX0cnU20DKyqkEnEW56tt9RbI9c/xn2mAL0Ak4fkZxp2Rsz1Q+eiWuk89
         MdNZlWqn5vOzR6NYs4yD2q9GQCIy+isFEpkU3lkcZhdIjbT3S21Kwfq59iEF5ChB0SxR
         gztw==
X-Forwarded-Encrypted: i=1; AJvYcCUozIXYohaVsUq2iC4Aa0zLq7FfnEee43Um1Nf313lE6LwjHIzlmZQlfvKc6KByHL89zR+dcfNPDiysjza9@vger.kernel.org
X-Gm-Message-State: AOJu0YxrsSWTDUyoOwg5SZ7yLV7qUkKUDFOpdDV/anoQrpOrJE9RyOoh
	FNBKXmapil3JzsK9V5niXHfZf/CVQzSWJcG2De5n8KirMCE054zEIERieq82+irn2A==
X-Google-Smtp-Source: AGHT+IH5g0RwWRqxELrdXfaTvTVYsLQLg1QItq6jladHXzNeggEyGQsVp5rE0/DCSbV4ptgpJfGrPOk=
X-Received: from pjbsc2.prod.google.com ([2002:a17:90b:5102:b0:2ff:611c:bae8])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b4b:b0:2f6:be57:49d2
 with SMTP id 98e67ed59e1d1-301bdf714e4mr366009a91.17.1742334091291; Tue, 18
 Mar 2025 14:41:31 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:40:31 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250318214035.481950-1-pcc@google.com>
Subject: [PATCH v2 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This series fixes an issue where strscpy() would sometimes trigger
a false positive KASAN report with MTE.

Peter Collingbourne (1):
  string: Add load_unaligned_zeropad() code path to sized_strscpy()

Vincenzo Frascino (1):
  kasan: Add strscpy() test to trigger tag fault on arm64

 lib/string.c            | 13 ++++++++++---
 mm/kasan/kasan_test_c.c | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


