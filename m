Return-Path: <linux-fsdevel+bounces-64455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F14BE8180
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEE41AA3E12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB928312801;
	Fri, 17 Oct 2025 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIsJBmJr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F023126DE
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697582; cv=none; b=TYAhhopisjJTQyDpwvjSl7k6VsAZDk3r3futyT61SmTT5sDK20sm0vOuqATmqXGqdoBvJnhWA4s/LZhcA9fB2IKKRBFqxS8nVvK93x8dDE8iTzQp0fYM8zejYFnaAQqSRLwjhU0qrOnsJC16tg/w6LVe7YjsIyRj8wqNwJrzVDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697582; c=relaxed/simple;
	bh=3icRH0liAsP7sjwZ2zPe1LVJ+1rHNTn97LK8vpGCQW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Adu/uPUUoxCDkxpYwtz1IUa3+poYp3CZ1rkU985FksxixQM4iTYy7Njnb6vvpDfE5siwxiFeZrYWWkXxEH6DH+v9uxtemq+o2HrwtYu1QQlwJnunRkkPlpjuYKShuXNSgt19NndUKYgL5jWxnI+4jBStuo5Rp2mS4ENmAS0537A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIsJBmJr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so1284883f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760697579; x=1761302379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7jEt2bBtS4lkQKEiP8Z3A8t05k/u/Bf60nmYvlGeNY=;
        b=PIsJBmJrMIRiaJc377tUJB/Q7jAPNt+/GfB5DIWte0H+rpzZbktzK6V+z8PoTBEV3n
         PXbatbbxsvCpMeXkPh4Pkvh9x+HOK6mzX+0OzVatQKjGwmZNV11fZy0DnubGUWu7nJ6n
         jasj0SZuwGnlUMILN0xZgaeY076K9PTQujkfuVbgDDdSQScYdhhewD9JZRaz7iP2vrle
         zdS/rqCAViynmb7CQ9RZonSn5DVK1QXDKU5pNP36zNP9FclbCe3nm03cJVXUqgw3fUq8
         SlR5IsNq8+6DmDNdOTasECZ6L6JHpgAA6tHuKzz0GiHqzUiWMXyEmbkzyepPkpPIooHQ
         mHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760697579; x=1761302379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7jEt2bBtS4lkQKEiP8Z3A8t05k/u/Bf60nmYvlGeNY=;
        b=KGcjYNBS0H/cgShMwXqcU/HYVzZl+r3FPVaDOVv3XkSJBk+IziVkJZkom3Bvg4NSjt
         MgU48Bjp5XNt6IQvh74SPWrGsDK1sHWCQEH9T4yrCrNFKrrDxobwNlheHMXw8weUbJVj
         hU21O/NN30cxOYCG+QXsGLzbynwJeUGF3sQB3/akc+G0B0pqSSqG+z4sTkjeoz6YneUy
         YlobP4rz7BQ13wecMDd5kxAZhil07lF72+c45TbbNE66N2OpzdVpl3oEStK5dqnXyiif
         oXNnbrPKU37LJxrx34Vrpz9WCK+SryUN4zR0LlfjyN/8vdYvY7YYhz6/5wfup9R5o7yj
         AS6g==
X-Forwarded-Encrypted: i=1; AJvYcCWMYAOej5GS2y7ijmsbqg7U6j6nLPsThu+1YjQ3Zf2jfVoUdmsVVKNTcbnmPbvgQMjxJUNq+hVfBW9FEA9F@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LCy1rpkfEO5ag0FO3hjnVhmz8d0yYjtiIj/AljobgsrcKPkP
	G5+ZHvbfAzFx+syX9jsIswLvVbVL2RDRFNMwZbupz54GmbhZmypCzkx4
X-Gm-Gg: ASbGncu6e5rBASsSMylzCfwgJOCZw7ySB3E+vAU2WF7T53TP2cvqt7PZpDcnAVPTPiH
	OQ6KEgRoEZgr7ccuZvuh8lIStg1D9j7ZbwpWZiGK43GQj8JBGWJu6iOGxA6Nd+D8nrZvKvh0XlW
	olydaIfGNqQbbywYZl5AVlf7WJSOME2W3zsPe0IwQPSlOLSdbUaNacYSQ3A+U5ZKv6FuXSCGLd3
	GlTY/lsN+o7SBfTMsDboOtdRd5Vq4CJvJ3ixRmj1zHT++T91TNTibloMueX0t3W0qWIi2zwhg7D
	/Qlpz7E4KjAXrWwUvQoQuOgz63ZHpAxU7m55NEcbBS9ZNYHs3aQpGJhxbSCa9ToFfsaGM7RRds/
	Jj9KOnEB2j9e8YifOQ8lPElFeKKM30wjZYDBBA2JPMMUIu2YBOGfHaDeq4cCITHrN6ygbmYBxGp
	YUByhJLO8k9X5OyszXmgZ9TQ==
X-Google-Smtp-Source: AGHT+IEHuo1AdfTtiQhHrCKaYLVYpg367t+Hy0cy8LVgBCFvR9kcQy/2El+YmymF463hMk6d8OPEzg==
X-Received: by 2002:a05:6000:400a:b0:425:769e:515a with SMTP id ffacd0b85a97d-42704d9e8f7mr2460323f8f.42.1760697578950;
        Fri, 17 Oct 2025 03:39:38 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce5e10e8sm40199791f8f.39.2025.10.17.03.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 03:39:38 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: quwenruo.btrfs@gmx.com
Cc: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: Long running ioctl and pm, which should have higher priority?
Date: Fri, 17 Oct 2025 13:39:32 +0300
Message-ID: <20251017103932.1176085-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3a77483d-d8c3-4e1b-8189-70a2a741517e@gmx.com>
References: <3a77483d-d8c3-4e1b-8189-70a2a741517e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qu Wenruo <quwenruo.btrfs@gmx.com>:
> But there is a question concerning me, which should have the higher 
> priority? The long running ioctl or pm?

Of course, pm.

I have a huge btrfs fs on a laptop.

I don't want scrub to prevent suspend, even if that suspend is happening
automatically.

> Furthermore the interruption may be indistinguishable between pm and 
> real user signals (SIGINT etc).

If we interrupted because of signal, ioctl should return EINTR. This is
what all other syscalls do.

If we were cancelled, we should return ECANCELED.

If we interrupted because of process freeze or fs freeze, then... I
don't know what we should do in this case, but definitely not ECANCELED
(because we are not cancelled). EINTR will go, or maybe something else
(EAGAIN?).

Then, userspace program "btrfs scrub" can resume process if it
got EINTR. (But this is totally unimportant for me.)

Also, please CC me when sending any emails about this scrub/trim bug.

-- 
Askar Safin

