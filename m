Return-Path: <linux-fsdevel+bounces-60721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7B9B50904
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 00:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF825E7528
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 22:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151F927876A;
	Tue,  9 Sep 2025 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=databricks.com header.i=@databricks.com header.b="kQzEEnTW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81B31D389
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757458754; cv=none; b=X3P2djqBlyx1AsKbCtSAPNS2mAFDXe98JPQdfRDuqs+o+5gBOPtejLHajU6lN7kPlu/8YXFAEvh0KpSsMPkbaLrpqnU+r73LIH5r53jukTJyMTnq87IhthOlrnNoNSfUMk4Q1Acv6yrD11JpzDWFjzn6hfaAyLvWiHcV8bhkPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757458754; c=relaxed/simple;
	bh=fCSlnkhWdT+1aiLjI12KqM9ileGjNvLs5/zKsvNTwpU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hbe4Cb6bbZPDQMquHG9S4VAp4swWnGgx7LGneRuzBLCsqFTFR0S8DyFsyiUqw4Ihb0P/0KsnSJI1sVSsTdHvkyZ+Qhkx1+FdaJX1TKlLUsTW11R9/buSL5k9avj9i2h0j6VRtIj7PhIr9ucOgKlniaWMgBXX4PaSMWbhbis+wMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=databricks.com; spf=pass smtp.mailfrom=databricks.com; dkim=pass (2048-bit key) header.d=databricks.com header.i=@databricks.com header.b=kQzEEnTW; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=databricks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=databricks.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-544a2339775so2061460e0c.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=databricks.com; s=google; t=1757458751; x=1758063551; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCSlnkhWdT+1aiLjI12KqM9ileGjNvLs5/zKsvNTwpU=;
        b=kQzEEnTWgzTF1AKQeh+x1w6kSERjM+AvjaRZ138VnyMjNaena0RqLKsqlQpI4Wgle4
         rOwXtbHdHZM7fpspQzJUPscS168Du0dI+LAOK4XhkUPhYgsTJ9tpKCoueNfwSWEIEURX
         cfnOnd4IOHJjGPxeYzh0iTz9sSbJx+DvlGszvCCOVNUxXQARoMTFjkL4sUQ7wWm0o8GM
         02UXI98JcbGPggx7QHUbplJULb1NfgHNr5EzfX4tFN924U01HBk/CDprXaDu1OugJCj3
         l4FyMudiPFl+6oAg5/azOVnIuHFQDtokV/QtNTxPk27Qr1ydCPsnxnP2TDOPg71WZUAX
         7zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757458751; x=1758063551;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCSlnkhWdT+1aiLjI12KqM9ileGjNvLs5/zKsvNTwpU=;
        b=hXpcBdCl9cpUIL76gadW93OJk/phjHEb4Kuknvm4R+IjDlHFKuzbBIVmuFaZkl4oig
         EPxRdU5ZGNnBrz3IBEMxOK8x3SQ9gxzwBQpwjjVMoRz6cjodnpK8PThNbPvUXR/dyhIv
         85RWuDklBm0UxEuIOeD/mK++08y8kR+VsO9w3IlOXnY1AJOpg8gFpD9Sj2q+85PJgYAX
         aTBU2yyykoQO4DFRNR3UAHqaFrr7tdkcfxTQ5WCT+cJGhuhdOm/b2rao86RPl+Tas20y
         lcFd8Uzn63uD4bOGq+8LQF9ufc54tnnBbayDq9W0ZgfUXCgkvG0de/Adi79WtV3XtDAl
         uOgQ==
X-Gm-Message-State: AOJu0Yw0qBbb9A+a9jLwnjSnFuODWVP8IQL7cqzWYNAp5uEIzkDqOYbO
	6YZ3YXfivUdYa+VdtwR3IH/F1ci2WDlw2WaRl+O6S9EQrmFOwz1Ix6Ilk3qIJU3PjU7QOP0AMNu
	sz3xIFaPEI/vDjRDZ0AjYFagS2gzaomr6JTBZK+gJHhWk2r/C+bnFsyI=
X-Gm-Gg: ASbGncvijebtKe0BADx6ZpGskyqr/BJWwC/sIj4Sg0tDN4Yk/UeYRo3nRhyD0pyfPi2
	iIW88wFkBeG809J61q0vwNX8bulBKuhjr1LfMXKn4h1GUL6HeSiQE3BVmir/pInfRNbx67ekN7s
	SSy6bqsgiVXdsi2amBZUn12iKGdHbLktMh89JgEOX2/Czi5llYMk7+rUikgT2R19N+jyfx0KB9D
	wOiAiYmE8xZRSkC0n6mkQ==
X-Google-Smtp-Source: AGHT+IFGDfxiog0QOktNq0P8uhQFhCOHyfMAIfFZuneKg22LrSYn5r3VJqz1BRGe6FQsU4jl1SqWtRyUlxQR9OBLG0Q=
X-Received: by 2002:a05:6102:291f:b0:505:ff14:8e0 with SMTP id
 ada2fe7eead31-53d0dbe86a9mr4162510137.11.1757458751320; Tue, 09 Sep 2025
 15:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Scott Bauersfeld <scott.bauersfeld@databricks.com>
Date: Tue, 9 Sep 2025 18:59:00 -0400
X-Gm-Features: AS18NWChDsO0FcUZ2uGduc0HckiNQUNdtUkUAp9WJQWVo6DM9RYf2oHAXnH3YSI
Message-ID: <CAP9L_6Qxicq=hMy1B2gCGppyGtoXLQveY=xkxkknv2syS1dCQg@mail.gmail.com>
Subject: FUSE + Linux filesystem capabilities (2025)
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

We are running into performance bottlenecks in our FUSE system due to
the fact that we get GetXAttr lookups for "security.capabilities" for
every individual write. Even when writeback caching is enabled, the
kernel still sends FUSE this GetXAttr request for every individual
write.

I found this thread from 2009 that discussed the exact same issue:
https://fuse-devel.narkive.com/ZkJ00Lfr/fuse-linux-filesystem-capabilities

It seems that the only options are the time were either:
1. Return ENOSYS to disable all extended attributes for the filesystem
2. Disable CONFIG_SECURITY_FILE_CAPABILITIES (which no longer seems to
be an option?)

We can't make use of ENOSYS because we do actually need to support
some other extended attributes.

Questions:
1. Does anyone know if there is more recent discussion or any other
way to prevent these GetXAttr calls for every write?
2. Would we still see these GetXAttr calls even if we used the new
"passthrough" fuse option?

I guess one option is to submit a patch to the fuse kernel that allows
filesystems to specify that they do not support this security feature,
so the fuse kernel can always short circuit security.capability
lookups. Does this sound like a reasonable change?

I also asked in the fuse-devel mailing list but was advised to ask here as well.

Best,
Scott

