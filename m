Return-Path: <linux-fsdevel+bounces-16501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE789E616
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 01:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9E71C21151
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 23:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6386E158DC6;
	Tue,  9 Apr 2024 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlUcq+VC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C9E158DD2
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705499; cv=none; b=g0yE9Dro8m8AQsYPJ3OrHhj3po7N+x1t7/E4px1R1gi5HXflpc3ZGbKKqKIhvj9Nj/rj2tdwKEnb+V3r97OwgzlE05ylV6M4jiUQTVxVxfa3eSDXw2g0YbdINhkPkIIQiMAsUKb8iRKYjtK7n/A9vgCbQFlDt1N0eUHGVisgxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705499; c=relaxed/simple;
	bh=3+eSqMdb0ix5SMxNX1lb137yW7NgKNVUO3ksXY/YFAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rc1IMze0NxqI260EnazndBp9z1NmT8uKPCq3FCNFcuJYtbL4bQ28ZztzumIxnDPwEDjtv5SM3uVhePsKOkijaMvkP3wow+aamJIB5msLitH32cA6DiF3dVmqSPmzTyo50C2BAUUYLUNrXYUCmVj45tITfIE+leZuFazRBsiBAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlUcq+VC; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e6888358dfso3706891a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712705497; x=1713310297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VkwGNm4RyzOk5++2nzwpGYtLyqTAyKuRboic/aNG1d0=;
        b=LlUcq+VCbNkkGWP9zkn252v2B43D8Bcb9qyy7XH0fIfnUaR3vCJhdKxbh+7PSVhF2m
         Jjpi844LZeGGEiyh8ivRntenDH3Vvfgy6xS/wIY/adlzt5oNbQ/YlAhYbdXvvr+5qakj
         XQ86nzJbP6CR/wRQ1xivOztNgIcaYDNkm0oZluHb7TBuSNw7kps6XiOFDMFBYzW2khJq
         EgmWNbQBMUieTyAkZkClbotFRuF+ijZ8ZrhqexU14wDlz8ql/2A8DYq0nlyXSvA4d+m9
         1XrEZiHX8KNUYI5YIqWGhCUJyp+7gZWy32kyFo8vAhngj3OTHsTzAWVaANhkXeiWrwlh
         QkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712705497; x=1713310297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkwGNm4RyzOk5++2nzwpGYtLyqTAyKuRboic/aNG1d0=;
        b=vkw/dEu9uU/JTsvpuvgawF5e1cXTpCqaLMwWlOfmAGmF5ZcLokQpNvJL3Hec1kkDBd
         dp7WzDzr387XYeXivDuActJ/b6xZQKDje1QOP561cUQYpn9buWxXMTn/51yiS3+ybn63
         gDcCsMCHC0Xt0OTTxETTq3Ws64WfP/CJHR2i6Vps4fnTTEkygyzIs1Jc0phEmbXLRcXG
         NoJq8zVU/5Xq8/iLhOsoujActVJWlvqIIf9yAyPNcR82Qrff1T0B4SZlI6DsDuN8Qr4q
         BRf10rhzwYr+qpm+LXwc6mcVFT5c0ni4uQgvX4sQgD634G+N9DLBwunykJsKjH71AajL
         /u7g==
X-Forwarded-Encrypted: i=1; AJvYcCUVJWKu9/C3+LV924FdKgJT57YKPrysr/jbLOe2PeIUE5EVxCWJRe2aF763fiiEnffS3U2NQycjxYj+fPWkFjut5TrrU0X65xd7Abev3g==
X-Gm-Message-State: AOJu0YxYRh8IJCmtRgPTGnbYjBTM0SV7E3diaZG7NAeWRs8XpMEiK/xq
	YvrmBf9ZuEoWb0EGmGQWQIruj/Css6xYu1cRUqr4W+r8rBZAHNlK
X-Google-Smtp-Source: AGHT+IEOEJxLN/7pjznLJ5nSRlP+okNhoJdPUM4EgviHDRb/twxiJZ8HTiEwNrDjwG7D6P4+KoUnBg==
X-Received: by 2002:a05:6830:6d18:b0:6ea:30b9:c778 with SMTP id dz24-20020a0568306d1800b006ea30b9c778mr704262otb.24.1712705497114;
        Tue, 09 Apr 2024 16:31:37 -0700 (PDT)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id h6-20020a9d7986000000b006ea17d15c9dsm989532otm.59.2024.04.09.16.31.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Apr 2024 16:31:36 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Cc: John Groves <John@Groves.net>,
	John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	John Groves <john@groves.net>
Subject: [PATCH 0/1] sget_dev() minor bug fix
Date: Tue,  9 Apr 2024 18:31:30 -0500
Message-Id: <cover.1712704849.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found this small mess while working on applying Christian Brauner's
very helpful suggestions for get_tree() handling in famfs (for which
v2 is coming soon).

John Groves (1):
  sget_dev() bug fix: dev_t passed by value but stored via stack address

 fs/super.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)


base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
-- 
2.43.0


