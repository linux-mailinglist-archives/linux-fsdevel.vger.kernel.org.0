Return-Path: <linux-fsdevel+bounces-46605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA4A91253
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 06:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FBE189CB7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 04:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162181DD526;
	Thu, 17 Apr 2025 04:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UblB/rj2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6DC7E1
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Apr 2025 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865137; cv=none; b=Gf9IiDTvru/ycM0wW10nK9zUk3aYFYBSzlsImYELaqy7V24mwNnhr7ad4abl6qy3XdByiNvKI6MFydOkXqCheobJRTKIZ9YIhnEQlP2yjuAIsKFogSsOH2nCkNacZ8p4t13h15JuSLvd74ucm5jsJQjThewcjmh5dJyXi0nxO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865137; c=relaxed/simple;
	bh=xyTfxJPjT/FT2RxrfLY+7Sni/T27OxSE8JwnzRMqPaY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rH/Rwpf2b+wkr2AsoaQfzPE588UHOE80UaIrZrcZbQoIDenSt4Z2OOgEW/u4Vb9BO1Z2reBU7djk/JvAgP3KkPl0wvN4CoFDiz0UYgwImomcVEP9d+ilCmURZfDhLCGTFzy8mFrMHIPdpmuTsK9ySTK66CHnsoxIGumgNOWcQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UblB/rj2; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ff37565232so2867147b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 21:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744865133; x=1745469933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hK+UoriaNocNLwlVFNPRQ7NggNZSSb8YUIYC9+NMLvA=;
        b=UblB/rj2tw34xOjF2DI30ieD+dTEck5Vfg8o3QzI/75XZKyxJw+PId05lk6xGWK8qS
         Aersdh4D9dpG7nZkKoiLZrtl7Mr7NBQ2F4EjyDwnVuIgqhvfhmsQkP4Mi+LIIGb2XP20
         FHNElK2q7ptSQchblP74gB+tYF5xjG4HZcfgWkkMBKBrzlaJrgl/e+X/tqKEz46BGoEK
         wRbkH7I+HSwvKi2zKcnHkQjCul2Hft+vdsNNmmcg11DaUznMugpabtDBDerP7pRW7TP6
         0MW9X92Ic5eyp2ozuiP0sV6RaV9z8+91JAt0JP//fcBxVCYJ31N2ata4D0a1xzI8tCgg
         OQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744865133; x=1745469933;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hK+UoriaNocNLwlVFNPRQ7NggNZSSb8YUIYC9+NMLvA=;
        b=MaD0kblKKrFyGnfU9lV4qTopW9FzWgUDspp/3SNCncD0XfOxgFykZLjtuR0Z/oTuSA
         7FExR89q4/f+wVDkxihIyYS/l4rNNbuify7B7Um57hHzIDEGd6rTGrcMCE8YWdAATrRy
         bFjyqs26syfE1LJKNOaNtWBmt/dvbgmstAe8pNfETGtP9uhdqgROX6isz6jZQkXoYQkH
         V9QlT76ZSwOowPpKwQQvKqBvz3fEx4agJQJrFMwtXqWcBNV1Gn/TOWYlQT3qEMqg2M2K
         QcaGfZfldwG5MZEOh7wlUvVMuz8DPfSPSU78T3tFZvU/kgKGh5RXfDtSEIhWjnazcItd
         jZvQ==
X-Gm-Message-State: AOJu0YwLCu1HjY/A343RdPVAEif1hsX0YJmA0n3VoWkPGj55VCHBlOKR
	20dyf11DT0ilmpCiJzinkniirVFSfATemXZO0HNTOoSGt2fOfIimhOK1AiF48f9uFr5W+9LjzU3
	7NQPlWsaik/7bCuknUjXeBuRxhA4TKPWyuTCG+CUjGLw1AbUcVw==
X-Gm-Gg: ASbGnctyb71Ewa0dPSTl5uRusKlouvAXyRzALV4KDrdH8WCJZCSjZroJOMvIZQHGE/h
	0z5nBYODrWULhYSnDzMgV3xHpkywEshbXgP6QxYCS0fzDicRo7Ly6wNyQgGpn+/Ku3WLvq2p+Ty
	tU6O6Hb086/iZOkzMph3k=
X-Google-Smtp-Source: AGHT+IHaaTXDxyzkI34Ogx4z396Q8pYsyPH6u8aitww6kJRPq2b5qvbBdxSj7005/QZyo9PV84jhijIDVkGDz1DLYvU=
X-Received: by 2002:a05:690c:45c4:b0:6fd:33a5:59a with SMTP id
 00721157ae682-706b32d5540mr65290467b3.18.1744865133397; Wed, 16 Apr 2025
 21:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 Apr 2025 00:45:22 -0400
X-Gm-Features: ATxdqUFLjA9f3XxN-vWqT9Z0Rh5C33tqTW6J2RDudx4va0RmWzgc58zP-cWSx6E
Message-ID: <CAHC9VhT=reDcOFbESm+A4iePM3MBm6BkMxneTf2ND=-63-Qm-g@mail.gmail.com>
Subject: Regarding patch "fs: add kern_path_locked_negative()"
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Christian and VFS folks, when touching audit code in a patch,
especially one that is going to be merged into a linux-next tree,
please remember to CC the audit mailing list.

https://lore.kernel.org/all/20250414-rennt-wimmeln-f186c3a780f1@brauner/

-- 
paul-moore.com

