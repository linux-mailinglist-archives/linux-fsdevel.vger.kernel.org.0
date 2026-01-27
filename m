Return-Path: <linux-fsdevel+bounces-75591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOctKCOWeGnmrAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 11:40:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5E92F19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 11:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F7E23044A4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646A434251A;
	Tue, 27 Jan 2026 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PlASQXNv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA4342507
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510275; cv=pass; b=cc3idzODXgsoOJtj9CzCryOn6tOtz2M7+MgR6J0+HcPJKKLoyIUgXOykp8NlaWhJY/15y/KIiah8Fl4jV3iIaj+exyeXKksqX2MR8hJlIeJIUbsIA1kib60QMy2MT9s+g4dmv5Kf4OKOElTGrr3ENAqT/IhbrKntIcSikgI4x3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510275; c=relaxed/simple;
	bh=WqPkvZ8KHcRfRYdzliNwWh2JqKb+7oynYZqyX7Rfp+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fR7oZeFw2TW7i0+3na6bo4QC/0kmj6UBRYJ5LB6qS9gfZkEdYhMxPNXVxAfNX3ckW4YulGm2an9YKq3yfAamjuoQQFE3A9/vcqg7APe6PGmlfzELEFxqBsLChY7gyZMwQlcF1GVFBCuxAnqvWihzcbmF2wobZ2GOsx+U2CwQmdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=PlASQXNv; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5014e1312c6so35027671cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 02:37:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769510272; cv=none;
        d=google.com; s=arc-20240605;
        b=H2h6lnGsk/tzhJkBAw7Q1uIL66eETpldPyoRd2xBSsA/lKb4eWF+Yh+S0J1wptnGVf
         4LuwJQnGsNr2/Fob7yjjnXOnabZAk3ONZlS9SDlxAgI3bKPMZ6flQ4eE/vVScA9eGQ60
         c1dF2i4Xg4GyqCRpL2nNlRHIscEXrdW8CmyW6Ml5sZ6hKEIiclrDxMRQO4rwT6DRw4LB
         EAFSZOUKAGBN52QA6Lmca0vusjFWejduBPUhh/TZD0cpPzCtGEgTJNTcX+sxx6N3ZVXj
         hFIAYdbMYaHg4p2uql01MHw/CO5/9lDzlw+BwDI8mD3BCwZEBZywcXAGFvfies/ieSxc
         xW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WqPkvZ8KHcRfRYdzliNwWh2JqKb+7oynYZqyX7Rfp+k=;
        fh=N4E6HkQvjimOTMdnqP/vlUXQqYiQOXQD7XByIUaFesI=;
        b=e5edhWFtPZ7u3cT4942+Votr52CBlcKTaEgFF78bTcGSPhz0Sscdkbij/YUqXoAl8l
         TvExMucW7ieq/gT4ye8s7wVJe2G6NffvGPaKGqkl6McJMtTSTcbttySpiTQ8QrZXNMyQ
         //ktnJKSJlcrrApsElZI1t66fqoUIJ/DeHzSffRDrmLdyxAfpBu2lf0+IWw5aYgA0XaF
         HfsojjXvM+TuadE0mkbbMbKflWcQZLAyRQTDkG6EAbJIQlSCwhyYOCCna57TrPv12vfX
         d71HwLrH9mbM8Itv4QXoe8o3zgEB4/tVQ5lsNfAY3HSBp58PKTnfOLDlZRNjTVFe6hBd
         et8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1769510272; x=1770115072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WqPkvZ8KHcRfRYdzliNwWh2JqKb+7oynYZqyX7Rfp+k=;
        b=PlASQXNvANpNnHx7pQDss88mvmgXEzzLdzhyOEXa0a9xCkm5qmVa1wPa7mZY1AKNMR
         /+njSimb+uMFkmmS1MWkMJRLtVx7tcmhxyHH7i2Wnxy+1gar7eRWoWsVRVvHCgZSihlM
         BtqiO+ibe/zHlk6rOdc6en8+XLxwc0Qh5LKR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510272; x=1770115072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqPkvZ8KHcRfRYdzliNwWh2JqKb+7oynYZqyX7Rfp+k=;
        b=vG05CKZdvzhjfXTmU/ma7Whd6SgcbP/2fHzb70J2dZvny/s4T5fP7YklMSi1WpqDp0
         ZmiwRiIh+gODVWc8MmWLMwDmItdWw3DJsskz/4x6iJhSBOo4RU45L9+3HK0IPweNt/y5
         iEPP5LUpYRmBnXj4JqDtmoI/PLxOiiK6spEYlp5CYBjYOCgdJ8uw4SjiP6rqk6vj2fPP
         jZE+/lyBcdcL6feDjNxmZFHgnmvTRgFxmoSbATBdFtPMsnLnv7BagDRegkitWGa7iPux
         WYrCXfCYkWzeprimP/hN/YaUEfHqfljGkRnJZRWjB9Tq68/0lcDcj82Z1AhQjzY6J/8N
         EyPg==
X-Gm-Message-State: AOJu0Yy8p67yKxb6Bo/M0OR15pKYeq52GnoZekEheC+I7Oteb1nKr456
	SIEUX/lj5yyDipASdvB3771tjH342uCpu5KH0ZkX4RUHFwwdo5C0bH26okbnDit91quMhdIVG+b
	Hics/CHBQbMe54BoxWxbSaecFJsrT8DenmGzy1ifk2w==
X-Gm-Gg: AZuq6aILpjiay+2jnbsCEyuao2A4TZHlyjaBAUJDDfpCR59kFPvV1iOCum0+NSfiDJu
	G3JmKnEzuBGXOUMShuOyK06Wzq5Xfl6rbCeXFDg+Ws/FSV14sHbjPnfIDVdGat7R6vUrjX9Nc6Q
	Ov8/wPfk6fg1k6lAnQtCxlnkr3Sho5Pjv86PpVdZ8Ml1kgH1/DbL5U4Oz+SwYEn2hnl66iwn7A2
	y598cZNZybyDiBmcldGaorWIU1Ha99K0J+WSrzogcAM4N0jRxyo3Fb3RiCjIjeZXvnwp4A=
X-Received: by 2002:ac8:7f07:0:b0:503:2f21:6358 with SMTP id
 d75a77b69052e-5032f9f0ffbmr13767741cf.39.1769510272502; Tue, 27 Jan 2026
 02:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251225110318.46261-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20251225110318.46261-1-zhangtianci.1997@bytedance.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 27 Jan 2026 11:37:41 +0100
X-Gm-Features: AZwV_QgkNoyGPsJwcsG5StOe16tRb4cohuOufFQuLjYWOQcSRj7esuNs5HmWz-w
Message-ID: <CAJfpeguDR4RqfNgaGSxSA9GKtFD7605pMo80fM4EEGV42bi80g@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix the bug of missing EPOLLET event wakeup
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geng Xueyu <gengxueyu.520@bytedance.com>, Wang Jian <wangjian.pg@bytedance.com>, 
	Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75591-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,bytedance.com:email,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 0FF5E92F19
X-Rspamd-Action: no action

On Thu, 25 Dec 2025 at 12:03, Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Users using Go have reported an issue to us:
> When performing read/write operations with goroutines,
> since fuse's file->f_ops->poll is not empty,

Another one of those historical mistakes...

> read/write operations are conducted via epoll.
> Additionally, goroutines use the EPOLLET wake-up mode.
>
> Currently, the implementation of fuse_file_poll has
> the following problem:
> After receiving EAGAIN during read/write operations,

Why is read/write returning EAGAIN?

Thanks,
Miklos

