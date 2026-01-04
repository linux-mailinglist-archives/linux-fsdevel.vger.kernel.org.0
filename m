Return-Path: <linux-fsdevel+bounces-72356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC58CCF0B7B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 08:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E333B303BAB9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A7A2F5A29;
	Sun,  4 Jan 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QULRFEyp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263429DB99
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jan 2026 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767511360; cv=none; b=tq1rDAfgh7E6o5nbFp6On+p2ixtZ7t6fm+Sqjss1wdw5fKHt59ndbbqOvL7krIIbLbO9Mw3ZaxF0hUr6hlr95zobP1xxTwuCq4jtZVn5lxCBs7VFbphhup2POs7Z9MDZnN62X2TKxMZLXNxGPZx0PhIQUb5z9WfrLJm/3YJFMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767511360; c=relaxed/simple;
	bh=GCjZKoaWYpNRaIBwMBwx6d6tkGZjMPIj7ivzeOFTVaE=;
	h=From:Mime-Version:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqV7p5uqKA6eCGgTyIpj+LRv7UYOs1iYKLm5/DH/uZybPTy6VjgV5jqe8s33yFdpibwBsFHNs7jgy5OLam+LMitG91uYwlVn3zA/q8mSkbsCDP8WGdUCg+nMS6B4lp9z/mfaSE1GlEhDhd66ON1b6LTlu32eJnoIYgesk4EVhew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QULRFEyp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so12711264a91.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jan 2026 23:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1767511357; x=1768116157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:references:mime-version
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GCjZKoaWYpNRaIBwMBwx6d6tkGZjMPIj7ivzeOFTVaE=;
        b=QULRFEypWSFlZyYS/8mM/H8yCO1a0qyNbsucZj097/ttgPhVSwFIlo2iEACk9e5mdj
         Or2aJAArpQ3KeC6wVUgBKV3/HivvayxakU7DqGZo5qqym9HwvPye2VbCTfAVersSWxSU
         qAGG3sPspyEX2v/UZYBz0IzWvbGXkcixlmhgFINVnHZ46EAPjlUYp/C04uaDK+uV7Oee
         el499wUh0QRxjqFzVDUT8kgyNjLRIzwFM7gZ7hUG/UOFCasRqhd+xhXTSZdqYhxxKVZ5
         wX/haROylqGv2YLrwh73gHDWEhZD7KbbuDurEl5in3Auutx95DXp4tMKdAHE8p5f+20w
         YoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767511357; x=1768116157;
        h=cc:to:subject:message-id:date:in-reply-to:references:mime-version
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCjZKoaWYpNRaIBwMBwx6d6tkGZjMPIj7ivzeOFTVaE=;
        b=qTAWbjxdghaiBYDqk5RSgqVDPmhc41JlrmN4zb5JtxkpO/QudfL1GW79QRCEbg8ZR+
         /HirwBIyaeDDgw26ykHE22V3cwqmVJpc4G6n6SnxwLMzMt9A0YlFqh02zCPCXkL4yuuc
         viG/N7g/8o8JRxcbxGrU0pJxD6Lz2XtMzx722ouFntnQbv1XSQlkfFb/p21b78oe+LBa
         d6AgtuH7R5POjWLDukD3Q0O10a+/kdPXyxMGMqIDXO+k7F9zWdk0b/W5jGKC96+YlN9V
         gs8YFZBffT/TgDKFw4kSjJrjGzkLzgit+mTvm2ZCeJJIxDPztKduQLy6y9xZ5/wk9Rcn
         KxZw==
X-Forwarded-Encrypted: i=1; AJvYcCW4QudFuGio3y8SXuDj+b56NXjuRGoY/N5oTSMEKg3gYTq7Bj2+6cgI++xtv1JPA7oDxSBGBSZXLaA+hMnH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4l7khv3hrola1ZMDcNUzw1xypwFzcpT8Kdltn5Iwp76p7Rfkr
	/tDDln7NpZ2dDauOfJYvCucd9u7q6vVknXBNS9smTI9glxk5TdsXcL00QDTU6U2XbrBh5nvcekh
	AXM2NYoFFpaH0G4yit02XJF01VKUPSbIbK3QXnTFTPdkz/uBEnH1i
X-Gm-Gg: AY/fxX5m8ImabaxvCzcXxQcrQH5UXGweSho7zKtneGFpDVumEXx3jEe4gd9LILTFGDI
	exEPqkvoJHbqg9eXv9lP8Lnh8dKFgfBAf4YFgg2oufFmMtLia8Tgq9PM/7UKa2jMGxGjweASodx
	mrcxVk5OC0bd0pIZDa1GlofUUBsKFx1jN1CYSuvsA4yv84VWp+DtbJ+faVXoUTW9EHd5p6isnYk
	2merXDRKN6aRInaT372P3HntUy4ZqOMt3gmgJ3sckTDb2FHE7R0vZAwm3JlfAxDJtWb
X-Google-Smtp-Source: AGHT+IGrRtjSkMmZnpTVDjaA2YND+MYeh0Nc/D1MXMarVeB4BLGzeaMBMw8JzEIn4Hl62LQH3iO2g3VqQ7rIL7E+7YQ=
X-Received: by 2002:a17:90b:548c:b0:343:60ab:ca8e with SMTP id
 98e67ed59e1d1-34e921bec08mr45287171a91.17.1767511357257; Sat, 03 Jan 2026
 23:22:37 -0800 (PST)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 3 Jan 2026 23:22:36 -0800
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 3 Jan 2026 23:22:36 -0800
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251223062113.52477-1-zhangtianci.1997@bytedance.com>
 <CAJnrk1aR=fPSXPuTBytnOPtE-0zuxfjMmFyug7fjsDa5T1djRA@mail.gmail.com>
 <CAP4dvsf+XGJQFk_UrGFmgTPfkbchm_izjO31M9rQN+wYU=8zMA@mail.gmail.com> <CAJnrk1Y0+j2xyko83s=b5Jw=maDKp3=HMYbLrVT5S+fJ1e2BNg@mail.gmail.com>
In-Reply-To: <CAJnrk1Y0+j2xyko83s=b5Jw=maDKp3=HMYbLrVT5S+fJ1e2BNg@mail.gmail.com>
Date: Sat, 3 Jan 2026 23:22:36 -0800
X-Gm-Features: AQt7F2orWMuGAdEPC2pUG0mR7EtkQtM37oe8iM0_elt4f1mTnHmw7kyPcY4aRbY
Message-ID: <CAP4dvseWhaeu08NR-q=F5pRyMN5BnmWXHZi4i1L+utdjJTECaQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: add hang check in request_wait_answer()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xieyongji@bytedance.com, 
	zhujia.zj@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Hi Joanne, I apologize for the delayed response. Happy New Year!

> That makes sense. In that case, I think it's cleaner to detect and

> print the corresponding debug statements for this through libfuse

> instead of the kernel.

Yes, you're absolutely right. From the perspective of FUSEDaemon maintainers,
it is appropriate to place such checks in libfuse.

However, from the viewpoint of personnel responsible for maintaining
cluster kernel stability, they are more concerned with whether the
kernel itself is affected.

Additionally, if FUSEDaemon enters a state where it neither responds to kernel
FUSE requests nor can exit during the process exit phase due to certain bugs
(such as when FUSEDaemon incorrectly depends on the mount point it
provides and thus enters a deadlock state), the alerts in libfuse will
become ineffective.

Therefore, I think there is no need for an either-or choice between kernel
alerts and FUSEDaemon alerts.

Thanks,
Tianci

