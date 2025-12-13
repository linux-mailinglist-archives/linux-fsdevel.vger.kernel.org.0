Return-Path: <linux-fsdevel+bounces-71238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D92ECBA4FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 06:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D64C30A7561
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 05:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71680220F37;
	Sat, 13 Dec 2025 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USOXOh7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6033E182D2
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 05:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765602409; cv=none; b=VdtFxG/vOHO5YsOTpKIPIkiDkgprDwZztXO6OojLRI5mU3/LNUNQC616BRmMF9DgfNzlEevVeU9G32N0S3nekbD7TZuEBGjKKrA3hECYk4hrXJZoYQyPTSyVVHvVLXZoSFfcRTq1I+fQsy4b9D+7Y2pxghujND7Fwg8+JObh3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765602409; c=relaxed/simple;
	bh=t449w8dxUFgPONNcxJEWe21UM9wpgKy8HnqMapgW5DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yse2XJREw3yW0O56amhv48YttkzgEuY4LA0gEIswt9q7U3xC3ULQnBvx1p4XR8iuK5Kp5qfVxT587yOxSr1xXZQlUriIBqxGgk4iqMF9sQSSkN5ydDN0qP72qSRJjAwtv+nWM9z2OF1EdY9yGGysAagJfznqnnea6wbP9omSF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USOXOh7u; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88051279e87so22217206d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 21:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765602407; x=1766207207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t449w8dxUFgPONNcxJEWe21UM9wpgKy8HnqMapgW5DA=;
        b=USOXOh7uAyInCYRGAPrU5XNDShHnApjHlGJnN9vSI7zqSjJWgCMW0tIeYi5MER2etX
         UHxJScvJInBNntSW/FM5++HQUlq/ilVHVNznRa4+0v4rkaark0/tRCuGoskboxudPUlJ
         Bd/WSIT5lQM3Z1sdCHIR5d2y++ycbj6uBWQygfpw78VZMzbeJwy4KiHN3Yq+rRFgTusx
         KDnS5coHOaHEUKuxEDzr99Ru9qZaqGz6NISC/ueEHPGX096sN24fCKnKIu6wDVz5ZpE8
         lLK8P6OG47HT5SAepUe98PBp9BdfH4+QEd37OyEjS6P+77sGc3ZKk3U6NmfZqaEtLXzI
         KusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765602407; x=1766207207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t449w8dxUFgPONNcxJEWe21UM9wpgKy8HnqMapgW5DA=;
        b=eHsCm8UZahKfhTupqt2VPnWaokv4iTWf05P9LXpF2rYH96uNZMXZFHRbrDfeJEZ8pT
         z9Cu254kDhkrnF1N5Z2BRKyQ8saHIESmq+5XeY5q3fG4s1mjPg/wXKY0DdSiRW4cQlwS
         OdOzqzlCvVQ6ZqBg+wGSDcV9PuWRd4ty2W5+/cPTZhHgdZif64wVyg5I0WiLyRZfAApA
         CAAhusSM/fSLTOZo28LuFX8VbFIvEXZhKquBc66GIalXLhmqEiF7SWH3FGzwxWbbktqH
         IWWm4NfYdPesyr7H+BfC0g4L5eJMnmr0FMnzXq4WYEy+l0W1ab61IjV7kzvO+Qxv565G
         UbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUIXdpQibDxrY+qfZjp7EGGtWR21NvdbMmuZ8WVk+BcGz6zXwpAL8YE2CQUA7KXDebwl3xjN+tmsEhzLFr@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ32drbyI6ZsFEpEyPo5d4284xpLPCsahw22UBiinZCcf+TYTw
	hwBYHFN8TZLmnZPCZxwJJziShc90eqKryBhB9iKjR0ehoamhRm0/y7AH
X-Gm-Gg: AY/fxX5zH3ulgwLwAuYvXnns8AgFLDgnIeN/LVIPtvz5f2rgiqchiPPjYQNCpwb2B+3
	+Tb36a6cPqHmYBmySJheodhGxhk0h8yeumgdq6YsmuyCQMdUK+7LvD9S/H1jtVmeEAuV2pvQJDc
	3DzgxgJrpJqzg3mecuyFtbEdnn5xafyGNYsVpcX+4ZsVITGfGsrfFguubA0kWfMkQSYmzEdogdB
	xN/ejiN+pjKHSfQiaD2ZQZqbOx4TJP61nV5+vjZvTmQURlklRW7NmJOnVnZSB03VJv9SPmboaml
	gVrD3s/B4pLI61d5tol7oNwrgXbLeL4NYcZkYfkv84s/bNFNB3Fz/WmpSdP75jYCGActMwg8O9l
	fPDWw4AZMm7ZvtG9cNYKQ2IhAIn3UlmJBGghu1GG5GyXf7RsBQCMTSBCuYHSgFcaludICly9VZD
	Jw8DV0YUqpBXZ/Nz/mu587VgRLO++KW6TsurJEmZfcZYcO+w==
X-Google-Smtp-Source: AGHT+IH7gV+IFAvDDK2OhuNhl2PfBranKC++AHSP8eqD619xjakmIuxA5CfBjDjZJehhciCalhL9zQ==
X-Received: by 2002:a05:6214:2b9d:b0:882:49f4:da25 with SMTP id 6a1803df08f44-8887e132f86mr64018476d6.39.1765602407115;
        Fri, 12 Dec 2025 21:06:47 -0800 (PST)
Received: from dans-laptop.miyazaki.mit.edu ([18.10.130.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b6a80fsm7622486d6.18.2025.12.12.21.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 21:06:46 -0800 (PST)
From: Dan Klishch <danilklishch@gmail.com>
To: legion@kernel.org,
	linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com,
	viro@zeniv.linux.org.uk,
	keescook@chromium.org,
	containers@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	Dan Klishch <danilklishch@gmail.com>
Subject: Re: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount visibility
Date: Sat, 13 Dec 2025 00:06:38 -0500
Message-ID: <20251213050639.735940-1-danilklishch@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1626432185.git.legion@kernel.org>
References: <cover.1626432185.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Alexey,

Would it be possible to revive this patch series?

I wanted to add an additional downstream use case that would benefit
from this work. In particular, I am trying to run the sandbox
sunwalker-box [1] without root privileges and/or inside a container.

The sandbox aims to prevent cross-run communication via side channels,
and PID allocation is one such channel. Therefore, it creates a new PID
namespace and mounts the corresponding procfs instance inside of the
sandbox. This currently works without a real root when procfs is fully
accessible, but obviously fails otherwise.

Thanks,
Dan Klishch

[1] https://github.com/purplesyringa/sunwalker-box/

