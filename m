Return-Path: <linux-fsdevel+bounces-72369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A26CECF16C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 23:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E7853014ADF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 22:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04EE31A7F9;
	Sun,  4 Jan 2026 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj23y7v3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB0F27E077
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jan 2026 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767566315; cv=none; b=omUTgYKWRA09dL+CLbjHdH5VEWycznmSZ0U9i3pHUmrDBvyaZJoEnodF9j/6r5lkTeUf3MIlUVGDdD8i/dSuu5k2ZUKnIL9tkYUh3RAnti44QixjjrCkTxiz720ecMyEsNaLfodgJLmIz6BEIyooy1PMWaJ4XGBNgrHbG8YgnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767566315; c=relaxed/simple;
	bh=XSVhgPBiVIu3KnLmmML0TCQN+SOR6Z572SMD910nUeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUTPI3VnC43FXMmLhgP2TgqZDjHBmb9RbvQp0+3JCpqLf6UCvN8OYUhMDkmiZ2eoQszWetMBuNs902cXCtdWf7X8tHB4nUpPKKUx12r/SnlkhFIjAYuKsH+an+VlEZEtS53Xprhq6zdbZ1DD04c4/te6G2UCYY1a7FdaC/G3Ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mj23y7v3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-597c83bb5c2so10649521e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jan 2026 14:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767566311; x=1768171111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Rr+Mn0/zrfLjv3s0jhV3X7HX2vqQhZyD8W4zHn9XBg=;
        b=Mj23y7v3QSyzcsg9pxZvPMpyesNpOx3bP+AUmGvAIYIL2LkxM74wFUHylTgmRjAAwj
         3z/D50GodvmGjtmi9xTpOM5IJtCsUmI4mluCj2ZaqtX96YUZ6xUtPtOwg4UrCWKsNIHi
         /QD3B4fmHhVTgZ0hJcgstp28JsHT57imQRrSWo3IL9IA2uHXTClU/re55sOsZYd1QVAk
         NEdOZSsdNfMfyoGwLDdVSNdit3INGXUKsi8Gj71+xV4Uf80kS5tFqdFo4jGWNjD/3Sr/
         qsDRbe0i7WK3ha7A0KhFDq4m/W8SjOJ5zw4dbUuSCcYMjbKWgWLZ4mcxvTMM5AzTF3pi
         1vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767566311; x=1768171111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Rr+Mn0/zrfLjv3s0jhV3X7HX2vqQhZyD8W4zHn9XBg=;
        b=vBfUGIXS71t2GW19d/6AuIwq4HavWPFc52Mxtb5BQeXla8hN2wUNMzE/SjFSqurZPE
         3STZnl0bo8SZXcEdyKHT2osCMa8WpliG8Y4seZFOnaJBB2izzU8rs19gaEKjqo41MjFl
         MuQseGHLPNDDnSZvNNz9C1dO9QJBI0zwrULVUs5i8oq4vyv05aiBmYiKaUcVpKG3vAHu
         joRO78Elf2WzGUymG5VTi2tFSAxIEKSvTtdDH7xsdllCxNt34Uqa6MoExm29BRYBCH9l
         EfW6RR34qO7CvwZx1+AkXk+/NZ0VNnGIC5nm+/eLoxJ6+jC6hNu3IDtzABMi9Hr0M9uB
         qe1A==
X-Forwarded-Encrypted: i=1; AJvYcCXwwIYUr+kVj9JKT1pUT9kXPL2e30Gcit8xMZKR/ipjbi3dsD0rmwNRrjjGP0KUVIqvl/Mpo5OlbyvcREGD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0OjgtDk4JwBBa6bwU4ezh/X84vADJdujcWdX7IbFJeyIGCuN
	vyYAVI5dTwIOlxXmXKiLzSCT5mvS2zbP3Euho8bKmIkzl2ORWQAX3C8Q
X-Gm-Gg: AY/fxX4ZFVsNjZ02cvjs9WOL7TNl07AsbPaLSS8y1VOEIDJooFAq7wMgPYm09oh4Ls8
	tuEvekWqvw111X/G7AoIhKb2VHf6EM6jzjF6R25ETcEdNzTOC/baM8+NWTrdsYjWRqRXtqQVQ2A
	M2qNai/QQ/g0nWcb/NvGz0uzSITXH3ISbw9ZGPX7lh9GjE49l+debfxO16za5ycAavasavGxOnu
	xaMlaNqns4AZMm7e1tZ8BnldKkdhin4xsaEnNFo46IVNYuvKA10D3EWksfeaYI8N/nPCmqiuh+I
	GGtNEe+/cBuZshZqFqbe5JeSPukLLWrV9R1+oG+2U9ZMEHmrA0DVhGUGU8QaOL6JKqdhGi3J0jE
	sirFFnGc4qXh7QdBQ1YXysOJ0tnGXF3HmmUconevBeKIuVfO2kMDUtpWBJlQ6mj6zELfQlRJYnW
	bwRbyyR8Eb
X-Google-Smtp-Source: AGHT+IHJV5abvVoQOJ7VV/HGXPqeiAPJ4qXmNXrgTp9vZwPp8iK2uYU56RbuyzO7B3l0IkHWYRklEw==
X-Received: by 2002:a05:6512:128c:b0:59a:10d9:72d with SMTP id 2adb3069b0e04-59a17d498fbmr18088324e87.45.1767566310300;
        Sun, 04 Jan 2026 14:38:30 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a185dd1e9sm13776447e87.23.2026.01.04.14.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 14:38:28 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: bernd@bsbernd.com
Cc: bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/6] fuse: LOOKUP_HANDLE operation
Date: Mon,  5 Jan 2026 01:38:23 +0300
Message-ID: <20260104223823.2525337-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b59c5361-c800-4157-89e9-36fb3faaba50@bsbernd.com>
References: <b59c5361-c800-4157-89e9-36fb3faaba50@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bernd Schubert <bernd@bsbernd.com>:
> work on this during my x-mas holidays (feel free to ping from next week
> on), but please avoid posting about this in unrelated threads.

Here is another ping.

-- 
Askar Safin

