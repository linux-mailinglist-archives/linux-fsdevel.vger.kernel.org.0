Return-Path: <linux-fsdevel+bounces-60701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D545B50290
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE1E16AAE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614CB352FEC;
	Tue,  9 Sep 2025 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LMOUVrwI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4733EB14
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435246; cv=none; b=GWK38FJPkMFnBOW1uTeuESgQFQ8xAEXehbZuCO1IWd/jkHWqh8StvZKqkiZw77rycy5ZLvAWlxJUlflevs6RB1cdEi9rSAQnqR57slBmMlB6nwnR/3pYAXLem6fjZcab9MBzto0A6Oy+Anj67nJCpn5I/VyJSTiqjPNdNQxaqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435246; c=relaxed/simple;
	bh=iGkK0GZV0QqwpOYApQ22IsNCF1IiazNEA6d4iqI+BXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZkznYKB661PyItoUlEy8aUc5NkNieAIEq+uyUoYwWVKDmeO0GEl31cCnK6wxGqOsOeMWnd4A2+/2D/izehRgnabBkpoi8mHzSrjHl7neer1PALA8Wip/KhdUrO+9r5LX2w4I7L5H88NJJt3beyQVzHt4slZksyevEoYk9DXJeOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LMOUVrwI; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-887764c2834so262711139f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757435243; x=1758040043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU5+1dfVb+0Q/QuEy8gW99WTOyajIvbAEwb6qaOWAkg=;
        b=LMOUVrwIKMmIZiL8VlEZdfg0wkzl8kehGhgg1JrkVkMcBfRwYnOyzgUBLBK+upWnYa
         30TKuHXeEn8OEeC7r+0cK6BhWWZIRv1fFEsrWCCQ6FepkfGkqnBu7zZdjBNj7VTDfEkd
         Epm0AlGkPbevVyL7ZChfIIRVpoTRZuR3xZS+g+/jU5whtvGaBReO894upp0jCpaBstV5
         vsqlI9UjH9FiBRhvBdrm6hJ/DaewVEXsx5CHRbMtU4bXCXIotuZnzweu9Ud0N1y2aGdC
         g878RgQUp2fddiJ6DpUYq/O29J95y6vXFKQiJszOg0/HneBPVcRVbBSBhgmi5iEKCUpA
         Fpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435243; x=1758040043;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tU5+1dfVb+0Q/QuEy8gW99WTOyajIvbAEwb6qaOWAkg=;
        b=too2w3+dPS/WSmxEK14P4OOLRYSHXxK3i0HXshJI08F+fcJGBXo+uNEmoMpeXolSW1
         tkj+jtRZLTvIUByO2XRCSX1LVgxLlkr+Jwc2iBF4Nu6L9oy1Ki4iea95nziUBcV1aida
         FPFKV7CCdNiYAn11YojkHUtoNEvJEoc56VxNKZOn+qUi+0fk/azXU21Z7d3v5+r/iuUU
         Zad75qtEfT9znexVQJlQySU5tfxDhXReYSq6u3VHlv671Y/5km6o1BCuDvsp9mYV9AJm
         4+yD61HWh+wtVDjewJD/8ISr/ejixcT8ukG+gEGu9xfbVLha8XOfjzdmscLe54gmBYGl
         s4tw==
X-Forwarded-Encrypted: i=1; AJvYcCUzRygCrtNk9QcaV4TiUbyMCC/oerNLRF2VbOP4Bm3nUZ07RdLwJ6huZoorKFlFiN/eraTpRppiqY012U7W@vger.kernel.org
X-Gm-Message-State: AOJu0YyYd1wINwdNUth6gw4ZS7fm3vgbx+u2c+UuC5F1WgufzRr2iNzj
	YpjmzYAe44LuMGPBXgS98fXZUF6LnmDfLTbGuL28N2gTaebz9hGclpPb+jgYuJvnRBI=
X-Gm-Gg: ASbGnctUbeSsj7nmwv5AgHUO4foqKn5z19cYAADucAjN1JDJc8J4zWN4deZk7+vLRWz
	pGkZgDlEHknGk0nqEiPeToIjfJFmhGOG9bm3J4uzzNjx5VWNJqiwntDSIWZdZsBnx3l7NMuHos/
	zNl9dCztd3CGd1qhL4/oxycGqNT6t1kXo48ngmM68n25BuhwaH7hwevhpuuL/lbrc9qZIUSNmgK
	q+kWphrKFeOQ82wT3ee+NeQr+X6vRP70jZ7Q6E5m//ESXdKKF8yD+O3leYPQMNU+IRCf4lImwUF
	eQBNy49UApAbqeqH20Dx6ggQ37uryzAOJD+ADULGeuL3zYNvhqaYhwA4OtF7SFIv5lV/Qc6OIaJ
	BG1m8eq7UUm1Hlg==
X-Google-Smtp-Source: AGHT+IGYb7REoxLIudhiD+LK09+Jxda+ni01YckmiZbSg941A5eJBO8ul/BNPsA8WuRBKs9N3iVw+A==
X-Received: by 2002:a05:6602:2cc1:b0:887:5799:7ab0 with SMTP id ca18e2360f4ac-887776aff72mr1950935739f.16.1757435243017;
        Tue, 09 Sep 2025 09:27:23 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31c66asm9636034173.44.2025.09.09.09.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:27:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Keith Busch <kbusch@meta.com>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250827141258.63501-1-kbusch@meta.com>
References: <20250827141258.63501-1-kbusch@meta.com>
Subject: Re: [PATCHv4 0/8]
Message-Id: <175743524234.117585.13836043498265714409.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 10:27:22 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 27 Aug 2025 07:12:50 -0700, Keith Busch wrote:
> Previous version:
> 
>   https://lore.kernel.org/linux-block/20250819164922.640964-1-kbusch@meta.com/
> 
> This series removes the direct io requirement that io vector lengths
> align to the logical block size. There are two primary benefits from
> doing this:
> 
> [...]

Applied, thanks!

[1/8] block: check for valid bio while splitting
      commit: fec2e705729dc93de5399d8b139e4746805c3d81
[2/8] block: add size alignment to bio_iov_iter_get_pages
      commit: 743bf2e0c49c835cb7c4e4ac7d5a2610587047be
[3/8] block: align the bio after building it
      commit: 20a0e6276edba4318c13486df02c31e5f3c09431
[4/8] block: simplify direct io validity check
      commit: 5ff3f74e145adc79b49668adb8de276446acf6be
[5/8] iomap: simplify direct io validity check
      commit: 7eac331869575d81eaa2dd68b19e7468f8fa93cb
[6/8] block: remove bdev_iter_is_aligned
      commit: 9eab1d4e0d15b633adc170c458c51e8be3b1c553
[7/8] blk-integrity: use simpler alignment check
      commit: 69d7ed5b9ef661230264bfa0db4c96fa25b8efa4
[8/8] iov_iter: remove iov_iter_is_aligned
      commit: b475272f03ca5d0c437c8f899ff229b21010ec83

Best regards,
-- 
Jens Axboe




