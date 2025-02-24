Return-Path: <linux-fsdevel+bounces-42435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BCBA42640
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E565B16BFDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0381F1A83E7;
	Mon, 24 Feb 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haadp9GU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4352D2571DA;
	Mon, 24 Feb 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410745; cv=none; b=EzCfQyCZjb+X2E21B4HFzvBepL8p/z8qc2HJ19h4XCe8y0b56JyMPTIA/XmyB8humJYFazb+gYgFgugnWCnAm08e16oj587KgrQboRnlDWqsi3R0PHuItpOyfXZlo9X+EMWrYzjsjiyhTPIZTXb/R+4VUW1m+WVAon1jMzSomhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410745; c=relaxed/simple;
	bh=krAMUD2jS9jCEEz+rn7iQ1DYd+ZjNcJ2ciQY4ybjJ18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RQ2rxW6mJ7D7YhFHYshN6xntDhhVnVaeNg6cSmKPevD9J6vGFC6izgOtrEhoU3G/puSMVWYzr2XNFbAtU3euYN0HPLTKfaZY3B/DNq/HgWpzJ5QEC3bIugOJYfdijctOL1oLo0xnrxYvz+blbJKLYe3gCO17rOCfHMRYIWewPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haadp9GU; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2bcdf5ea8faso2307120fac.2;
        Mon, 24 Feb 2025 07:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740410742; x=1741015542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LK6RdHoQKdH3EpiJb5QWP6V4egccM/Y0BpmitxzGnEE=;
        b=haadp9GUtQfkX47B38IILNfyNEGSgvBkf1T/CQ4INMimvm98FL3+/6DXcvJ4gapWck
         TjzCASozH74fcIhU5LC37v0Debx6UFKfOc/RXzjONlmYG4CZB/KzDE/i5klRmeUJ/WXF
         vpJByKD21MQz/q25F/utc9mSMTJMbyD2eXtH4AvLyoye4dzxz4CGlh5i0OKwCToPtnRw
         +AIncYKLDSv50SPX1k5QFzxv4rbOu80a+tR8dzBu5faOazW07c7zqiV2rcmvhSgprpYR
         IpoclF8VXeN1NNhyRkLUVGxGmCUm+GksIMF1FKb+8hvr8wqSVN6FG1WIQyGw3Pjul3K1
         IaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410742; x=1741015542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK6RdHoQKdH3EpiJb5QWP6V4egccM/Y0BpmitxzGnEE=;
        b=xHFUkEZFXqCuudxvrMMxcOhviJhUowJwDw/rlR3H/vtYZOCQrGq/9wR7SNYl8JyO/g
         7UCuc+kzSknV3V87QFvdWenFmGWGdyTq4yaEArhw5AbQ5FCNGuZQzWDtzymkuKhE0Pn9
         aa1XCQRaKP8MhNUEDdybvaJNfMHbP3afUmynmJLYluQv2wm2pbZ3hGSRYQeMU+6gfNC1
         xMwYENfrpIO/8yWdRJR0IfRi/TzAV8aX2JPjKwlPAMQgmcCMxMZ3SlE/WD14TjZCxIcq
         9VQYIQtUBHlNiewuFxJndDxbM5c8UP8vdofoRZXlPpN30zsTlTOX5mkAbHsYetj5qcSf
         l8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuBzOGiTrwNZ1e6L6DHQ8d81qHxOw62w9fNo7HnZMadiXrLF19cq3Ay0QVvMD0bVLHxWq37mn6qn8yLeb+XA==@vger.kernel.org, AJvYcCX4AFR3SDi065DUQKRGPkrj2mnvfDE8JPQJ0R31pWnyEJ0JaiKMtfqS9bYN9KEHmNi1Bg7DlZ5nkJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+sSQ9mhPh9Qz9vPlU+zHJ3l/snLBI6v92yeG2oMRMdjzC33q9
	eN7SnJzxiGU+4MfOznQo4bs4WVk6fUmYWoQpOdHRTGLWa7jfnjmf
X-Gm-Gg: ASbGncvMl59bJbzN081rDh8cf9sKYozdD3kSKMguoQQSYUsvGrASHHIo2Bl14uK6GXd
	ArTcl0h7zW5nwUVrYieNjgGeG6NN2/TBcyOf1RbppX/22fHVd3C9zRHxwy5x0gDg2U///VCWYVL
	FxW7Ee2+sMZ8yK8kwMkP35HUmH8F3VaAbHinF0OAi455yixQ/BznHT4VjepQ6WE5783KQrLpcu+
	lsI4mxteeOsxBp3Ikdm1/BeYnmfuc8B13Idzi419ILWLCJNeM9gA4uwdxxBtqKUOT9NUOBW4dI5
	4hidCh7UWss6Y7YnLhjFropbBbOcCceM003SsHQMszVF9pT5fxJgyg==
X-Google-Smtp-Source: AGHT+IHXTOWEqzcqrYmLmNHEWXjIANdS7SkI/VxCGwV2UXbOVtO6m5FKOoKlzuZIjamVm9SrU/GhxQ==
X-Received: by 2002:a05:6871:6a5:b0:2bc:9915:aeaa with SMTP id 586e51a60fabf-2bd514e6553mr10820583fac.5.1740410742051;
        Mon, 24 Feb 2025 07:25:42 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:9bc:7b3d:b287:e40a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b9548878b9sm8265355fac.20.2025.02.24.07.25.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 07:25:41 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Stefan Hajnoczi <shajnocz@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	John Groves <John@Groves.net>,
	John Groves <jgroves@micron.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>
Subject: famfs port to fuse - questions
Date: Mon, 24 Feb 2025 09:25:35 -0600
Message-Id: <20250224152535.42380-1-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miklos et. al.:

Here are some specific questions related to the famfs port into fuse [1][2]
that I hope Miklos (and others) can give me feedback on soonish.

This work is active and serious, although you haven't heard much from me
recently. I'm showing a famfs poster at Usenix FAST '25 this week [3].

I'm generally following the approach in [1] - in a famfs file system,
LOOKUP is followed by GET_FMAP to retrieve the famfs file/dax metadata.
It's tempting to merge the fmap into the LOOKUP reply, but this seems like
an optimization to consider once basic function is established.

Q: Do you think it makes sense to make the famfs fmap an optional,
   variable sized addition to the LOOKUP response?

Whenever an fmap references a dax device that isn't already known to the
famfs/fuse kernel code, a GET_DAXDEV message is sent, with the reply
providing the info required to open teh daxdev. A file becomes available
when the fmap is complete and all referenced daxdevs are "opened".

Q: Any heartburn here?

When GET_FMAP is separate from LOOKUP, READDIRPLUS won't add value unless it
receives fmaps as part of the attributes (i.e. lookups) that come back in
its response - since a READDIRPLUS that gets 12 files will still need 12
GET_FMAP messages/responses to be complete. Merging fmaps as optional,
variable-length components of the READDIRPLUS response buffers could
eventualy make sense, but a cleaner solution intially would seem to be
to disable READDIRPLUS in famfs. But...

* The libfuse/kernel ABI appears to allow low-level fuse servers that don't
  support READDIRPLUS...
* But libfuse doesn't look at conn->want for the READDIRPLUS related
  capabilities
* I have overridden that, but the kernel still sends the READDIRPLUS
  messages. It's possible I'm doing something hinky, and I'll keep looking
  for it.
* When I just return -ENOSYS to READDIRPLUS, things don't work well. Still
  looking into this.

Q: Do you know whether the current fuse kernel mod can handle a low-level
   fuse server that doesn't support READDIRPLUS? This may be broken.

Q: If READDIRPLUS isn't actually optional, do you think the same attribute
   reply merge (attr + famfs fmap) is viable for READDIRPLUS? I'd very much
   like to do this part "later".

Q: Are fuse lowlevel file systems like famfs expected to use libfuse and its
   message handling (particularly init), or is it preferred that they not
   do so? Seems a shame to throw away all that api version checking, but
   turning off READDIRPLUS would require changes that might affect other
   libfuse clients. Please advise...

Note that the intended use cases for famfs generally involve large files
rather than *many* files, so giving up READDIRPLUS may not matter very much,
at least in the early going.

I'm hoping to get an initial RFC patch set out in a few weeks, but these
questions address [some of] the open issues that need to be [at least
initially] resolved first.


Regards,
John

[1] https://lore.kernel.org/linux-fsdevel/20241029011308.24890-1-john@groves.net/
[2] https://lwn.net/Articles/983105/
[3] https://www.usenix.org/conference/fast25/poster-session

