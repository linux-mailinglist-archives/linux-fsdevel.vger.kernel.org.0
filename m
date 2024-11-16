Return-Path: <linux-fsdevel+bounces-35015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A839CFF99
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 16:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D186281F85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8118E13CFAD;
	Sat, 16 Nov 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2q/J/57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C388172D
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771633; cv=none; b=QiNLhfMrXyUzF+HnfGhMhEbzFSGfjuOaB6dqKFRHT1YJ319/hPXe2XKSbQbmm2iDs/8qVGcwUG7eaTV/m/2cgbu1I37FNXGtuPcQ0hbzoelb+Fq30psZwu5YYiPzcg0UsvT+OGUWDfi/ib8pEGAXoyPGIpyeUAUWSO8t6aiulv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771633; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=OmUzos5q/iwG40NwcNZ/z0wriYQBuTlswwRgRBfzNZ1cMmFdVMfFj3LmjR5yzZA03g6+cI+16odBXvZtgSKkh+1wkNgVvRlvb72bNJzYRusi+MDDreb8jdlUFiTgiE0NK4eDxgycvag/vkMBbOSbVroXqa6mEw+BwrhOjC8vvO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2q/J/57; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-211eb36e0bcso878345ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 07:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771629; x=1732376429; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=P2q/J/57jmCD20YNzlbRoAMmFnOGoyzunwu67AIYJEAY0gILM7KFMlcT+r9ve/c1ev
         zQaqevl3sMnOzSoxnBwAKYZqV+CGEBZurx402KKdsuZQRIYa4B2WSgWSop84+VYzhBnC
         gKOFaVRJEWYPHJzAWlSDV5+ortSia/LcNAsZwfkvzNXNJ+6iA8ZiTl/CkEONpyqSqlX6
         ZOTpA0AzWoyDHo1hkB2R57WhV+Buzo82Wf2zBEVAzYBuezcSn5Pgkvp1toM2E91YXhoJ
         telkVFlA/MRpQKfbI+A1XhLDDfAVBkO3t+ptKUiXbFwEA7aIuv4B2hct52BZdPt+VJXq
         6v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771629; x=1732376429;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=AYzxyNgX2dZ9INz9BB+lU0EB7YWDrh8M+WR1LTNvJa771mwtt5eyYD5vmYxyzYjcKg
         8WMbDgMpiCDe76q0fgp/Zx1DSR1yLqhNdIXC73tk6jy3B1QrEtAlad8gd410/yw4jddE
         /hOhLCc9B/6+G0n8jJ+XGRgPp/vcBR37gAXV6O/SYADFymv/Nypk806jhOcQtTNhUskR
         uBDq5xvvM6eUAnQp4sRcIiqcWdMFu5Df6WsWk90D4V9WZdLa3SwRFEZpouPw2vGZIpig
         XKdeyNl4fIkCRiFYXLDljRtcJsP5Sh/px13/QQYmtTZW3xjLkCXE69IaDIFPC6651Y7G
         igCw==
X-Gm-Message-State: AOJu0YxOsedYcvoeWMcdVUSmUYYe+/LGlTq6Gnu5au8sWeIUe2QqtSEH
	A7imko8HQmba0PRYSOnmbXbcMzSl6Us650YkL3rWyeyuPVNq03v7K48awQ==
X-Gm-Gg: ASbGncscdxZZOO539w8tTQr+eR52+J+1Ol6jECtrMjhLmT6n/o0786Px7Ji3ZiVqXC2
	+z60vUoAvwzg9cUi/LXRTueIQiIO1VsHJpJya0uk9jO/QW+hK7DszrAxXqfKcz8WjAmxQh581mt
	W+mEILzSoK9KahTiO2a8wgX1fPoM6ahZP0daCqDHwIjY1SNtoL00swBm9m5kUUGUBvQVPjNXMNa
	544DrQZ5ARg1cHsnmNx7/M15NVgHMpSgM0dqDZYazmBOE9DZ1P6a8QRAhOxN1dQxQmiyw==
X-Google-Smtp-Source: AGHT+IEeygEg4c/FsikVOccAzrv9NWlWVO5HzIW1K/5Qq4MGh+H/Kv8uo57UErp/565v+74404oZwg==
X-Received: by 2002:a17:90b:1b4b:b0:2e2:e139:447d with SMTP id 98e67ed59e1d1-2ea151f6a56mr3439436a91.0.1731771629562;
        Sat, 16 Nov 2024 07:40:29 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea3aeb2513sm1196122a91.16.2024.11.16.07.40.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:28 -0800 (PST)
From: "Van. HR" <sonukumar20772@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <0adf78ff24f8074c89daac667ce89dbe09645c06f891952d48b407ebd2727246@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-fsdevel@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:26 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.


