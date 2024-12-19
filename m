Return-Path: <linux-fsdevel+bounces-37801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A75C9F7D3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309FB188F08F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0B4224B1F;
	Thu, 19 Dec 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pLRca11p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9417C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619015; cv=none; b=huaax5s2ebfahFBUvzKToo8lFIx1CZ8H59iI2WWeZ25IkdvPHsva5nqB7TZ47NfU8zwhNDogJylkMzRLoHswKshctloXGHWfFh6/eUhUV8vEiEHt9s0Cho0NzpXPHGWjuoFOE/FHAysAPo0ai5jEYvSOVMaTco9kAxZDCS0qpXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619015; c=relaxed/simple;
	bh=j88rkHsI+3sLk9TlsEMzi2RDdwyUO7qf0DKhCaXND4E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L0VH8LFTiWN22Hl3lQS9VXz1lmpHo+ReRPT9cHhikZ5/qVUJ0/PRXfQXpcOthMOzb6YNRfHvObuCYU7GuGJviB7TjG8ZQArzTAME8it7oUjG134JrFfepCXKK/6Cmyi1QUISdGhIay58V+pVMTH2Vx/2WHFCUFzohTQ/4x1hnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pLRca11p; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46677ef6920so7229981cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 06:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1734619011; x=1735223811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j88rkHsI+3sLk9TlsEMzi2RDdwyUO7qf0DKhCaXND4E=;
        b=pLRca11pM0n5FgO1uK+0+d6lrfKqZeUKx5gc5Xq01RSiG9xyLzLylqcS97FvEdj1Vg
         RrLyHRVgl9GQO6zgjRE/73kzgsMiKm77R5MUU6BocOpJgFt03oNQ5eHJaqD7gPLpPZBP
         oAErIjITjrSAtdOQddc1q9hMswc6a5M2tcA/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619011; x=1735223811;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j88rkHsI+3sLk9TlsEMzi2RDdwyUO7qf0DKhCaXND4E=;
        b=mpYomjMu0Kqun8/pwy1DMJMQWl0EEZg36YggDzVQsYRcYBb9U/+wIRgXRsb7ZMWj81
         OFwHZrLH2iw9v6eh0Q1X0HqYDgL67lQdJC2qOQtuItHzTPGQu+mel0bcwzQLTyrXMEqa
         Dc+pDbze29FZ6Jyi2pM3jWVsoannZzL80s3tLxMJO3ri52JalnQJxnUHx5+JlQlHXon3
         lHbDjJ0mztlTf/gM+F5K+q9KoEUEvlZ5wg7D/jHQDnkgn05oC+bwAAgnLEzkK3qq7H/s
         LUf3oPVyZQFv0935A9/YbZ0WSkqfu1yfg5I9ygFuqaf8o0dMrD9NPy7bzjZ+01h4ExNX
         rGMw==
X-Gm-Message-State: AOJu0Yw3K78cNN1EIcQ7Bew0X7p3tvwFp6+0SQfRTCy0s+OtmVH7gpPU
	PS7KRmoEfJrug0Ao/JqN6ZekPpuuss9Xw6rXgciy6ya0pSLeobu0TN1KGT+9fEana2WuJtapuW/
	RWkIQXCx8tgRLaBZNvP9YSJzpQTE1tKDo/T/enA==
X-Gm-Gg: ASbGncvNi1HHyB1rTJfEZMSbQ+QIF2e7tVTgOhvZ2Hz+hubb/C5mrOTUH2YvnN5vnq3
	ewADyc9AFq+XQwN9ztAvY6M3pam/ePEzWt+JgK3Y=
X-Google-Smtp-Source: AGHT+IH0XwE1rDoHQM4+grkTs0zkOSXDaCiho52/97hojN1kMhof6pHF9rwyrTX9QYrjfTcO128+i8Y9/iumlTmkexo=
X-Received: by 2002:ac8:5d13:0:b0:467:603d:1cd5 with SMTP id
 d75a77b69052e-46a3b0796bfmr56457311cf.26.1734619011139; Thu, 19 Dec 2024
 06:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 19 Dec 2024 15:36:39 +0100
Message-ID: <CAJfpegt1Z3RLGT_hozYp96+rxB8dsmJ_jUU3cUBnfqSGAR3MKA@mail.gmail.com>
Subject: PR aggregation for fuse
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

Would you be willing to take fuse PR's and send them with other
changes to Linus?

I think this would make sense especially for small pulls, like the
current one which has just two commits.

Thanks,
Miklos

