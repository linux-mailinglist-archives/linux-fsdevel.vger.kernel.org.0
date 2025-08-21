Return-Path: <linux-fsdevel+bounces-58598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C204AB2F561
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483731C84D28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D8630505C;
	Thu, 21 Aug 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtytdtCm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248B27815F;
	Thu, 21 Aug 2025 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772308; cv=none; b=JiCGuRVBZA8PXPqHZt0F7aqufiCz/kWov16V/QFe9sdcvg9vq/pOF0AfuKFXx5lqt/oqLafCmCHqj0ugMzJkETTXk4QpmqPvK728OwwzapVLlS2okYzMd5aHa1c3MLAw/nx1GEVDGykXGtvszsitLnza272JGuCeoMlXHbbaPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772308; c=relaxed/simple;
	bh=D+MQDeuGUXz+FTfr0de9kkuoW88p7ikUCgiDz+RsYic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=limE83WvMPv6jnZw6flcExIiUGl7oGfCI/ivnZoTj2fQJ574qVKttmHfepBIBoLFXmJeU1hcGdBX+DJe6dyALe0lmXG6ihHmnGHYfvGbzoPIb1VN6ysfP2hlYTjUvolXIT7TOXXwgiNeVfa38csXZecYOw0so2Tpc3g8Re5Mcts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtytdtCm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso840324b3a.2;
        Thu, 21 Aug 2025 03:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755772305; x=1756377105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+MQDeuGUXz+FTfr0de9kkuoW88p7ikUCgiDz+RsYic=;
        b=JtytdtCm1YWc2YYH8r86bF8XbctEgeVlAi+Z/ehO1j/puhQcY5RYwH/DZ/ZZUjFZ6e
         d1Vq24cltS/gvhu8C0maaYVGLmXYljEhMbqHzy/g/YYBIShF4nY+OH3Va0FdyYOZwwy8
         2I10Hx/6W2z+UpNIn9rwwLaSu1EVY4iAR/Y4XKyUJ6cJsU0oqXJ7c7A44waxawoZuLi5
         gMQSVaUjfUf7Wm8zcSS0hBeIqoQGkExOMOS4AKdNOK3GByOTT89/WadRUe1Yxqv8rnD9
         7w5ehnQtoLoJk6TXEZpd94l6a9kajJyab4BqZy3iJLPgABJei7od6TQVksl/E5c+yAKc
         R1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755772305; x=1756377105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+MQDeuGUXz+FTfr0de9kkuoW88p7ikUCgiDz+RsYic=;
        b=N9vNpcC4bOiV+8y2DRBFNYWLyJ9I+ZTPZolaON9Id+ONKRQcDrS5AdVGaaa85HdfAC
         4L8xdoPGC/ZEc+AUyqrZB5Do96YX1mPX/cABdpBh2WW3JqUUSz2MLl/rJcamP6+4lQs4
         JaWjKC8kLM956FUbnvcU+XSVKVt6hTJQFkbMkMbmTrnZwn0xwsavpftVsn79hNTe9woS
         VhSzZcgJwasV417fGpl5PlKfAb/7vqSISulfWNAc3MdNLBn+CTAyFAWrrKRPlUOZAQ97
         37mMlmRAGFQ3yuyR7l6TblY0XBTjIwxeD66CU8nLy5+E1aKabdKcXLcIcUWEWZTGapJ4
         +thg==
X-Forwarded-Encrypted: i=1; AJvYcCVX0eEv1Ve61F11Tmb1cS+Mn5luDhptR6SXKNFI4Dy/tsl1yKYEQ9Ujw/fPp3bcfT/N32zXCEBAhU4PJkgktg5R@vger.kernel.org, AJvYcCW7gN98zJqlaHieCxQhkrhuqLgZ3vEsCddMHY8dU/F7LEIDVRTHWtWMEiUEL+KNSS3KOE3Tj+GtPOLZ8mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc3Rv0SpjBr0TNy4pWUtAOpwel1XooChZfAs2rCdW7rv/KRcod
	zPbfez5UM6A7rqgAXYlEp2wh5MDMLvlJhun3ipA2wyMVQQXcGgmWaUD600VfGoeNSGs=
X-Gm-Gg: ASbGncs6TqwpiDBonWHBiA7kDme9CtKDcRDMPiMQ9nk2w+5LwU6/Uj/Ld57NM84oCIE
	b4jH3hQ/zWuK3u49XbaYQNbaIavMoNtsAoNpBYpIefZTD0iB6geuZ602JdB/dMQybxUSmtUX7IG
	YhpM9LT3hZcNHe/hpG07p+SJnEHKQmow5Y1QUDYE8ZBLahXq7Q16yLgBNKE1PCdAEBW/AOFQ8nW
	/785cDt+xRUlu29pFKxxnh06t/VtSIECNOBMr9vpBxnDlMfTSBBxIx/Fqc7VXFgWoSEIOVQnN3e
	D2KRGLwtL2SybjZOU9Bc2zFOM8rWz+rniH0lxI4IE+aLLsWkb+VF5rNr+qXOrHanJa7ql/SVBpB
	ILkjuofAiBy3Qj8VYZ91oW1h2KDSxElZ8NA==
X-Google-Smtp-Source: AGHT+IEtzUOLCMK5h6DyeoMF7OKkpgcvIbMKbLedXsYunfHMl4dYg4T5SZ69QlizjHs38NTW9w2KTQ==
X-Received: by 2002:a05:6a00:1399:b0:76b:f6ef:9729 with SMTP id d2e1a72fcca58-76ea3240a45mr2817610b3a.21.1755772305196;
        Thu, 21 Aug 2025 03:31:45 -0700 (PDT)
Received: from server.. ([103.250.145.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1314a4sm7883419b3a.41.2025.08.21.03.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:31:44 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	reddybalavignesh9979@gmail.com,
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com
Subject: Re: [PATCH] selftests: proc: mark vsyscall strings maybe-unused
Date: Thu, 21 Aug 2025 16:01:39 +0530
Message-ID: <20250821103139.2872-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820143954.33d95635e504e94df01930d0@linux-foundation.org>
References: <20250820143954.33d95635e504e94df01930d0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Thanks for your feedback, I didn't notice that __maybe_unused is
defined repeatedly in selftests directory.

Following your suggestions, I've submitted a cleanup patch that centralise
the __maybe_unused definition in tools/testing/selftests/kselftest.h and
removed the redundant copies across the selftests subdirectories.
I've tested it with gcc and clang, and it builds cleanly.

Patch Link:
https://lore.kernel.org/lkml/20250821101159.2238-1-reddybalavignesh9979@gmail.com/

Will also look into build system, to tackle including kselftest.h everywhere

Thanks,
Bala Vignesh

