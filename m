Return-Path: <linux-fsdevel+bounces-19421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CF98C56A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DCD1C21937
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44F47A57;
	Tue, 14 May 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="qplWiqQe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B77A1411D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692267; cv=none; b=QqcBQy5SlHheUMpxY6HE427XKvpMS1B5XVnXDY3rTkJWdoYnxKVgMUTLo0wwie/VHSmeIYVNgbyFOzJfiiAMYGWXcVxzGfwuXMwfL0h2O9yN7PqYOYtjePlzwf1RnGJLOzleSI6DDOKAJ28qae4K/JZo35zEszlbZ7AMfWmxQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692267; c=relaxed/simple;
	bh=SBU3Dn+uiffK4cL2FBZejyE3a4P+czn5wzsBjqBLlro=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ukt2XlvDgv97KCuAbaPrUvI/ZLl0dziecvr+rRkxne5Pac9CVbl0E+NXg51MEbiapkFScedYimDWaMXLOqc01d77GHxKbenM8r1P0MrCXkH8TJ0POUfq2nA890XXErHx2BjLC4qdEKemlNSl7jAYAUjTksP4EpkDCU3lEPlnI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=qplWiqQe; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-792b934de39so486043685a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1715692262; x=1716297062; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x0TOXDRcIcAvX4cL5a1t2CHh3s078BY1DYLliyj4ZeI=;
        b=qplWiqQe9TXZTm93F/zcbcQAMWmGIE8RgapQiCJocGL8Lc7g1H3WPZRkCoJFKpdWU+
         CdIXHwUaLLhHbXH0QV6TcQuLnqAMRmTtCujgZf+sh2mQUJU9Q/5ynEOeck4s/QeCzAbc
         /butmApX6sQ9h5IN00EB8UdSMbfXq3NmIHJWcFmtRLnlldnU2xWM7KpidJCS0HUJiBQF
         ISYebmXJ5WO0WfHr5hLtf6KQVfVQQTDD4N8dPJj/rhjlsN4luzCzoQ2KOAxygtttNXrM
         0sRk3odnMo8tA/SehsR4S/5k+GArqwNnaIX+gRFBsmPkhSIhAioB55HNlkOFgUz2HL1S
         tHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692262; x=1716297062;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0TOXDRcIcAvX4cL5a1t2CHh3s078BY1DYLliyj4ZeI=;
        b=Wi7bmBKu8/WfemhgKxOXiD8Vat5M9nOLxofTwi65Xa1S9kvv0yM3SEchcrj4vpdePB
         v34YdxelhxXNQihcsQL9FpRBvTdmUvk9cUsl2gdDWCdd5sz8Y5aROsQ879AU5thZNfbc
         ma7g2H8oQrCCl1DNPDzZMo9N+u7Wr2+hqtM+/UORuqTPaMO3XmYU8wH8/8lfQi2nxdWH
         JvgCPUIKJfjxmkorsFtcICR1NvddHaQgFRt/ez1qBYmxLa1ajbCMfRmI1Kk4pi/cS3wA
         TpLJ6ukBt0UB0/WpHRD3j8mfSBD5vVbIScg65NhW0Ewd8GV8JPwOWC8Rh2ncKD7Ez6Qk
         D8Og==
X-Forwarded-Encrypted: i=1; AJvYcCXs/oNU7ajfm5WzVGHMPaQsKWh30fa/VJ8P1wJyPA3G9IoYSVhgt0tgrPLUXsItanmkuT+B7ERc/y0Ln6S9U0qKfM0xP8aA4HxgHSlcEA==
X-Gm-Message-State: AOJu0YxRe9qyCqrvEBOHcGkc96EFs5/ov5Ff+X5QwdQPvhjlIEp8QEmF
	hatkXCkxLxzemAtZr3w9nHHiun24duyfOCAwdZWVs8GBNpjQEErSJO4HZ4GU2SZNNxYnJvbu/gi
	+ynJyxLpuiLE62ZyKUj622AeWLpB+vOyRefgc
X-Google-Smtp-Source: AGHT+IEaixFVUPMGq2fGQzyMpXTbXALXAEvt+68Fiu+45Ym8lO9CB+yULAWB+qMa23S8LcxRwi+w+H1a7GNgIF3UM2c=
X-Received: by 2002:a05:620a:5d90:b0:790:a508:ede0 with SMTP id
 af79cd13be357-792c75ff55emr1332409585a.64.1715692262048; Tue, 14 May 2024
 06:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 14 May 2024 09:10:50 -0400
Message-ID: <CAOg9mSQBdCRjQYkPEdFFX0Hd43atzOsVALrxa=2NRSGjvkw9Xw@mail.gmail.com>
Subject: [GIT PULL] orangefs: fix out-of-bounds fsid access
To: Linus Torvalds <linus971@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"

The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-6.10-ofs1

for you to fetch changes up to 53e4efa470d5fc6a96662d2d3322cfc925818517:

  orangefs: fix out-of-bounds fsid access (2024-05-06 10:10:36 -0400)

----------------------------------------------------------------
orangefs: fix out-of-bounds fsid access

Small fix to quiet warnings from string fortification helpers,
suggested by Arnd Bergmann.

----------------------------------------------------------------
Mike Marshall (1):
      orangefs: fix out-of-bounds fsid access

 fs/orangefs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

