Return-Path: <linux-fsdevel+bounces-69672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F289C80D35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB4F5345783
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08974307ADD;
	Mon, 24 Nov 2025 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G84ohSJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759BC306D52
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991699; cv=none; b=VVaGf5L4AwFlQ5G6uYjzhwPn2rY9pHbeUuDT7oQn3Ck/q91yQ6+NC8fRp9xmlK3JReVvyLFE1BTGDz44I4R4E9gfuU7A6zEqpeaAw9DfHiQfYCiALV5nQo92ORvmoeRJOZRsuFZK5UfWzzTXLPtYYj7WjbJWzeBKry2NzMK2UrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991699; c=relaxed/simple;
	bh=9WiU+fUOoaOr/u86tVujVIv6iGVYl9gAhlsoumb2r9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6yjtvnuu6I6i/5esuMT5nugNoVZ6iNaObEhmIHCCML6l5d6jaZZ8tpcZtL5ZgOEZKaRRHKq069BX4atu/VlLbhFqW1F2wnCgD1qAJxmeMyS/PQmmQF27JITJZJvw8ng6nAnkiKf5lCqWv88Z3lzK5gCpva6nSI82/wica7qErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G84ohSJ9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso203502a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 05:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763991696; x=1764596496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9WiU+fUOoaOr/u86tVujVIv6iGVYl9gAhlsoumb2r9I=;
        b=G84ohSJ9uqlCBpS7MBbqr/YL36fjhY1ZyjWDCD6dh2h/UEv0o/yfBYjoNDx+C2uxqy
         +bzkC6NOiQ7LVTn91GiNSTWjt9yYvDOEvYYXjVHaznESOx+LkzPN/VToc4QRGBUfgHVL
         +pnwJCxSU4MctdYhAKY+yQM/VHx80d/6JXFZKOs5clJTjBZPrF7fUzpyY6wvImtb8T4n
         BhLPHeAV9DVmzZn8KswxgJFLOu706/wJ8Qb1sKx6QV9WXlMt7Nd/JErThmj+/c1KNzYx
         bsr8IvFJ9pon9vZh+NJuiyCulL3XXQ9TbPR46uzATV/yUDCrQPnXqr+amjvOjU5UFw1g
         tqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763991696; x=1764596496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WiU+fUOoaOr/u86tVujVIv6iGVYl9gAhlsoumb2r9I=;
        b=HX7C/XThaPMX2VlmfRMnnUa01wwnV7zIJ9Q70gjpp/onMfu8YQBEuWWBG2B0SGCkvz
         dCIh0Wdc81cFdD1YwxR8eFPAdGnR26tS3CYBq2MtzztGo6oMmQ714KVSYCj26d9okS9z
         u3823meGVXN6B8ukv/nrVjFYSo4HHy5ATQIOyLovx33KJiznhBALZgaAi5DFmzWSCpcg
         geQAGTzux1IvvdoCPFFHXAadgJDJiUyltSwTG2xxzboxCCaJ7159/pfuTjX7VPM7De3+
         /3Jokghj7KHNVb759pFg3tJcEJAVjhjY+DFbAuhbOGAE4U3fVR4GUPNlkNe7pUMJjINM
         5ISA==
X-Forwarded-Encrypted: i=1; AJvYcCXokuGs2Q/DN6V+zgI+9l716UvyFa4k4KUnm/3jbvf4gQX/tNehbeoBTwYL1c1Zq5Oerom/LvU993yGRg7G@vger.kernel.org
X-Gm-Message-State: AOJu0YwujIa1TNjUzMHI7Wj/CXRMnPrTXul7Y0AHKt0xdDqfkm/bvekt
	89DnV0LVEJfw3yRnU1M/x7La3CYSPeMBTjlRp7fknysniZ2R8nvDLaYHqWOsR+q5qs7TzbvNhb6
	+EmyoHeRenjjU8hPKnT14rHYQB4x5bA==
X-Gm-Gg: ASbGncsiwH7oW1kEUY3jke4IIphbvIxg7Z1raF3vckOv62+UNLQEaCAV/XbiHyNREQs
	e/rLk+GLrIT/gu45ylN36Ys1zRTz2kSaNRCxbKN6emDtT3hSnJ7z9yowq7R8sZ+Kr1Ill/TUOpH
	d0j8tRa0uS5xnMLVrO5n40DMqlTZE7yVouVitsiynFzT0R0v+Xjs/wKb/h7QGOoQfa/wScFBxnp
	/o8f3atXD/E9vQ+Fjwoj4ezFkl0oS8rN2A2Ive6ijv1XOjF2dCiqWFa2XlDmNyal25hz773b51J
	TNzQ6fAnG6KopdPp32EErS+oRXzzmKKC//zBWc1qAGU/zQkHPRFIWZ1p
X-Google-Smtp-Source: AGHT+IGfVsoGjX5Sxy1dySCnIJESUxRCyabV8O63iUc1Le7y4o1Ai34RI3broPwT+Hj5nWquSwgUdOuJhlEdpZCZaGc=
X-Received: by 2002:a05:6402:40c1:b0:640:ef03:82de with SMTP id
 4fb4d7f45d1cf-645550809a7mr11399195a12.4.1763991695708; Mon, 24 Nov 2025
 05:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <9bc25f46d2116436d73140cd8e8554576de2caca.1763725388.git.asml.silence@gmail.com>
In-Reply-To: <9bc25f46d2116436d73140cd8e8554576de2caca.1763725388.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 24 Nov 2025 19:10:59 +0530
X-Gm-Features: AWmQ_blM0KWu7aUv8ArY5r4a9fsKMGwJG-SFJqiYxWiv8fYwoMfNFeWPT1HOzl8
Message-ID: <CACzX3AsXD_C50CY0KYNjt5yMY4hm-ZDLQU5dQSJAmP3Duerauw@mail.gmail.com>
Subject: Re: [RFC v2 06/11] nvme-pci: add support for dmabuf reggistration
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

nit:
s/reggistration/registration/ in subject

Also a MODULE_IMPORT_NS("DMA_BUF") needs to be added, since it now uses
symbols from the DMA_BUF namespace, otherwise we got a build error

