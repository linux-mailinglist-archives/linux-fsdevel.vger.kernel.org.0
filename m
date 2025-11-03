Return-Path: <linux-fsdevel+bounces-66827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B0AC2CFC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FF81895A69
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AF2314B97;
	Mon,  3 Nov 2025 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erqQzFya"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CC313E1F
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185665; cv=none; b=M+WaZwThKjQuVnXRRzZSu4RCjuvCmyk3Hp0RzhH9XS8vu75/zNz+LcOPdZ+viLFE9FBBYO0147xBL2FNTh+vsFY3p/O0RVwahCjBrPOL5B83HfoLRIle9GfXoqknx/JimBrXhW6zD5GYtBG2sDeJAFE0dzKoS44CIYQ3xRBuyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185665; c=relaxed/simple;
	bh=oausMmPsZ+dnjkMLaZyQvuVYUCi3K7LrgIJK0YnBvWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZguLFuUSCHKR5fZQWGNu8XGX9r/8nmJ6nvsYPAtBblg14P4ERiApPuTOFORrlVNZsBffrbK2OP3LNimGPkVVlXh/rKFKchaL1hPG5VZlVKb7LumHTn6pvMHCE6QdbICmqYDon3O4SwIhrUdUHwDKvdlbx4JHr1vmgYfGu5ygVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erqQzFya; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475dbb524e4so27742165e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 08:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762185662; x=1762790462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqvWytGZ2s4a9qUQN0oYT7joij1/BdFZNGcsK+FMm5Q=;
        b=erqQzFya1RXGkUFjRlxZLbawcMyCLY1zQd+fuObmG/MV2Hr894nh8khvfwyrg20rAd
         5PyPZGxfUec3QnKVAsU8YLQflG3rwabmWJXUHyQuv6SjRaltFA01WoEZR3kopA+4iO7h
         Q9BbyTVGcyjCfjIm+NR7d2XRppTrlWA4N0fkzRCy36GTsXaqlzII8n2QkgkBX/asKwp1
         yWF6VHc3jnQlO/Z+U2oP2k6/htgJdxcSrYQ7K1LeXX5TOi8MsqV2d88Sp8Jq2AOqO9tD
         frGkjKrxntqqenLj0bBPm5zx61KWec3j67lEnOds/WghpSNmhYjmE/ZDWXwLKtRyaEv+
         CXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185662; x=1762790462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqvWytGZ2s4a9qUQN0oYT7joij1/BdFZNGcsK+FMm5Q=;
        b=d8Q4Tar3nCDEBsDEEnZmATQTK4PNHwJwp/UKnWIp0rMHEsheW7oLLPZRBWTZYgWz/N
         Uh5fQLBtq7tveXcq25xox7Is60Rg62sI7qou1ELwhpN/nU78po+0B16AsbNX0XeRc6d7
         ShJXzWYnrYMeI9Tj2KrFCGbKAR3Uz1oZ/NBuNlZvf1/VoXUWLRfWyjIAE9atq/XgaGI4
         4z1OtcIgeVCkPBZBOrKuJAFGAReijbvh4umpzQ5s3Z0SEVWKLM8gmbRu0P+aR6BbzHj7
         Y++P0hMDETbzkFN3yKEGszc4JSGz7dCwdu0vrIbq5ctjbslfdz8TuF7kZwm6QfKQ3/p8
         HB+A==
X-Forwarded-Encrypted: i=1; AJvYcCXCAtya1sJZyJpve9C8WRt0TPw2MRavzhK78Jzf5nL0uRj4X4oJkevLgrRY8tFAXSLlA5huhcqt2oXuoNwQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxSv7O8xgcbo+LCSHQ+cLMxg+wTABUBuMidrLiehgC63dUZjXsu
	lDf9mQg9vqt8SP7uiH119ZBTRBH6Q0mZphkW2VTZsaKo2KlI0XLifbxd
X-Gm-Gg: ASbGncsCGExtl4eSwt1/EQBxoQ5QzwKJ2wSVJgBq7dtQ254HHAUQBFfK5fsWoqd6i6Z
	CYiTHwzeE3M3qMpIlnmO8xTUpsWmnM5TVNK65JB1BVH5ttaoY1NfUWGgk7tWtrKf4eYDofj/rLS
	vqSPED0f4H/IL8CJ7i45OiCSqozFMY6cirDXWBLTeeHBufKnilH7sG2F32Rpmu/VPlD+QYuYbjQ
	dMgXuJAupQWqrIbTgd+HPTq6TLgPGbSNU2I6VJgLS5tkuIGgl3+GCiMDK6dvwxxfAu4zxOf18i2
	8qwaOTT2VvUBGXENz4c4XxXMT8HxX87gCG9bCelLMGG0a8SSE50obQxXfoxU0M1Pj2y9t9/bNcv
	+nLVGuB/gewp9zcojCstAtexIXXiriJy528D71F+HV5/WOjBltQFeeVcrtm2ZaPaoA/sWwG7L
X-Google-Smtp-Source: AGHT+IFgI9+UJlRaWTMZvJVKvOi2KSbU5UoaEQKzf5dC8MbcMLHKWJBbkTAIDGnT9gXpw+caRRANUQ==
X-Received: by 2002:a05:600c:828f:b0:475:df91:ddf2 with SMTP id 5b1f17b1804b1-4773c7862cbmr77521625e9.17.1762185661579;
        Mon, 03 Nov 2025 08:01:01 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c48ee52sm165705805e9.2.2025.11.03.08.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:01:01 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: wqu@suse.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 0/2] fs: fully sync all fsese even for an emergency sync
Date: Mon,  3 Nov 2025 19:00:56 +0300
Message-ID: <20251103160056.1154138-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1762142636.git.wqu@suse.com>
References: <cover.1762142636.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qu Wenruo <wqu@suse.com>:
> The first patch is a cleanup related to sync_inodes_one_sb() callback.
> Since it always wait for the writeback, there is no need to pass any
> parameter for it.

I tested this patchset, and it indeed works (in Qemu).

-- 
Askar Safin

