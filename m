Return-Path: <linux-fsdevel+bounces-7921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6814B82D40C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 07:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174E1281766
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 06:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A372257A;
	Mon, 15 Jan 2024 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf8bBeuS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29592563
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-467021612acso1791122137.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jan 2024 22:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705298465; x=1705903265; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Mf8bBeuSPz8JSmgiPizaAemlAYkst2nSdjil6vP7zUIs15SfOimLzWB1dOCxA0PAHI
         VkNjCqRHcO718KPt2xH9waBNTgvpmAj+i9mM3focBGP0VKB49Ru2O9wjLT+I6kQprIru
         mc4n+/vH6tcBpdUlZFbPdXb1cKpLBnvuhT4Xa9Ml/tZs2le6zgcXrxjpd7k8yJRxGk6j
         d934mrNskrBdmsrRrpkMl08TuQP+uJkdU0O05wncqjXr167SNZchc7NuZ6I3KFFGdwNO
         LYwviytVhCa2jYoekrasmHIxMES5aK7Ji2Yo5LvdRKIO4Cr0pPQnW79utzcTJHfkdjQq
         MRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705298465; x=1705903265;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=mF84LTyB6UHpE7WLnlQWtZjEsXb/Bcv8YamPyGHLkzoiHnG7Jg7mFpbB9cqAmjzWN6
         FJ3shK8nVVxRKobntEFQ41Csabq/YV9VU7kdTe7A6ss64B8x/E4umdWo0t5MZJXdmmRA
         D0nLD8eLRQ6FvnyAuGg+oF6MW9E7PAMIuhhR/+ra3h7DatMXePaavdFdKHFiiTqq8ISM
         GSBsbm68fzGbO04CnXlaCf4m5zWewRaz1uBTVpCVpcrJrySoGFik3w/IMe2ybpqngNO5
         zVBoxtN5Ux1GmINFsjUm0IObFHBwr2Gwvy02vAT0add0bxBLNKJexS0NO/obOH0Riu7q
         WyPg==
X-Gm-Message-State: AOJu0YzObK+qvhA7onYrA5y0ccDSiw4a4ieA4egQ2E9pMpfFI743F4dz
	W9C9m1CPXPH1ORsokvWxO9tmlX14J3uTZAN4ld9HHmxJa7mAMQ==
X-Google-Smtp-Source: AGHT+IEhvawr9PX6V/9eWSH9h8xrVVZuEttr70uUilrSfLnE7RCd97R8JHhS1fijIQKSmnEhy9shbO/1PcFuk4hC3VE=
X-Received: by 2002:a67:f9c6:0:b0:469:554f:f8d2 with SMTP id
 c6-20020a67f9c6000000b00469554ff8d2mr532926vsq.35.1705298465439; Sun, 14 Jan
 2024 22:01:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Younger Liu <younger.liucn@gmail.com>
Date: Mon, 15 Jan 2024 14:01:03 +0800
Message-ID: <CAJaTg0uuNVEiyX1ivM-P28=Abi=a49+x8Ah3DTSaiqPEnfONGQ@mail.gmail.com>
Subject: unsubscribe linux-fsdevel
To: fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"



