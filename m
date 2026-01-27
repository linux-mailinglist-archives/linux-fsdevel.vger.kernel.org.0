Return-Path: <linux-fsdevel+bounces-75583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDPsFDReeGlwpgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:41:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0018907AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67DAD303F574
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 06:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8FD32B990;
	Tue, 27 Jan 2026 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hK011wb5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238F329E44
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496088; cv=pass; b=YdC6ACc55Dk3KWWSh4BZMDET1JFooZkweiCELE8557OLGWJYwzIVqXEfCJIm8Yj0pEpYuyhhTk3rVhMDR4pTJMIRiqEGGt1LsDGjSg8OcVm8j2bnEWwYzpzDaE0+XqAGHfLVutyFMB/HgASeC6LUidWEHgnEstafwTMDIXhWpIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496088; c=relaxed/simple;
	bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3FqbLbFf+vKvNM2TRuYak7903D36riN2yU+kMVqWB+w0vO53a8SxvBElpvx223GDEL7t4896mbktsCuHPK3uArv6HanbcLYyJpof2aMWfOYyY0IyN5918ph95+4iQgnXGtBnCVVaAodzcEzNfYfBfy0nFjiPBf1ajpIwQ09484=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hK011wb5; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-352e2c59264so3629743a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 22:41:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769496086; cv=none;
        d=google.com; s=arc-20240605;
        b=SKN57ce0iDVDPBiPnNIogzkwSM2PoWdJdZSPZMhW6YPd0/wgRugVXvguJrd0ye1Nnp
         uiQXXmtYjSKzLBqIQ2gjRxWQ2FwLIjUsWldRrKGVeK2DVlWtgR+Tu1TaKGeZMIORCSVQ
         tmMW9n+1wLM+3OdNbjxkTIDiWY7PEvvtxrnMWQC+hIxBZWnejHsz+TDxSFJEhZtYorGx
         ggtO2mATYDkXRuemvgj/9nNZhX2UmQ61FlHn+djQOfUOlQWQCNsN+re0+zfzCZJHyY7A
         tx3I5XAzZEXcsYeYa9Ck/Qe/NSH7yR3Hy5+0Idn00N8F5iobGJwfWT34zttAc5Qxp3fn
         VRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        fh=7pJV4O57jO2TeDnt+1T2CXGOOi/iLFLudG2QbkzwHzk=;
        b=encSmJ6nYaOmu1JR8JIK42HxEoc46u6LdN0BsfDwm+Pd02QfDFj0dzjPUUUMaGMBeA
         9vjwd9i12tMxblETx+4zKeXSPqKhpsHglrXtsGxi66qpXdUUJP5g5hBHkWNW0pqHbIuC
         SHF2XFMX91F9CC9dl6GRhD/DOMrwLRTGkUygyJ2Hskm23RThnqLlcjNrFl9nlLLbWLqi
         1U8octDT9drYs/rjYKPx6j3CZhswWaqZNbW6RKnsZuLqtVMphoqc4WeMyxPiExhoM8l6
         oUJbrM4OomYk7Rm2lI6OBP+EcqGJnIRN0DdapfWLxrs1X/u690+lwDUgqm+mFeDq8lHe
         yU4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1769496086; x=1770100886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        b=hK011wb5jbAQtCfepPtcMbiyDNmdf6Tw8/VaNc4XMLWI5MKi/T1S6fPZ7ZeKTh4kfz
         HxiGdE1e6MkHOSGgMMV+qbulBrpe1mKJmDCXoAEpbkd0zcPW8weaE3tv62180+edZZGj
         NTw4tFhkSExfP2QuBclv0Xjir3cDnoYYHsKdXFIkcyw28wdgJII/ZUhAuxHaNkzEK9uP
         FNdpGD3AxCd6yhc/MWh6wq5hfmbOczniLy9jcxaagO8Is6CTQ7nDs2UONI8hMKn3Kkxh
         QjUEVKIuiwcJYwVNhec5fLAmPvlbDoq/zPsDWf+zHcEB4AwEuLGM+VSirNlkdnTTt3NE
         yh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769496086; x=1770100886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        b=MneD0ORB6Z212iEd+3y19s4HDY92/sMDwRpE35HiyzM8Zu9PIYoSvYWFZxvcWG69MD
         QXMULjhiJnxUN6+omoMNguURibdHc3KHmf/pGNUEmq7pAXLgss7c5vKA8nfhsVSeM5mp
         Ig+cRZig8Lvf9SEhDTkcnuUJlC/3BhpZBLDt6YI0OIHmgokIwnCX0jCF5j0awhV0K9Zz
         Ju2hXsCBLztDbZWlxlxRW50ZVq5PvS65+lZ7OExWlBGiDK0XkrYC0ylg/uL/3IZTS5mG
         Ov34ncRvCVWRRQYb5G1nbKLjg+A/AhoV+kI9ZbrMValyhgruJlaN65wnPkG4HDAWSZaK
         H1wQ==
X-Gm-Message-State: AOJu0Yx8rWkhwSPQ9QDp6ijGpF82rLzOclMwH66H6ibB68PpnK7albxd
	XXHC11i/RXEfpIzSs/aswYrzkB3gqT4GH/9rtyVqK89MIEBH/wmkvW/CuTB0zt8ozCO2+eoV2Ot
	kwiu84gjXsrzEaajk3KGhGqZ6+ZqIpWb1yq81sPyg2Q==
X-Gm-Gg: AZuq6aL1bWQI4oXw9OtW+H46Ibst/0S15GlnSuin/ILnkMH/Q3+ytaf/mg4CztT6hLx
	SfqwcawT+A1QRIXBMofRgTu/0+yKCHgBnIqA7hPiGGGu0JcGjFDYeTCi/NCNbLiVRA19J8pJv6i
	9pxQdlatAFYCyF3RJMmftu04Z/lkuh3IsfEHPHup6pVzVkyOQZ7t77MyEcetgbE6EP77M6Es6FT
	r5t1Sm8gsqlwesKA0dlxsrEWOCT/U8zzCLMxgJ6F1WFYYnMOJkpGIGFlx8OlhzsfCIVC7rG7FJF
	O5C4lFDAE5h/AGv0yx2txiE=
X-Received: by 2002:a17:90b:3c89:b0:352:ba0f:fb28 with SMTP id
 98e67ed59e1d1-353fecdcfa0mr808877a91.1.1769496086506; Mon, 26 Jan 2026
 22:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251225110318.46261-1-zhangtianci.1997@bytedance.com> <CAP4dvsczdjAp7MLMp+qY_HkgGH3OoHYBJ29-c76vVHp9hgFdZQ@mail.gmail.com>
In-Reply-To: <CAP4dvsczdjAp7MLMp+qY_HkgGH3OoHYBJ29-c76vVHp9hgFdZQ@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Tue, 27 Jan 2026 14:41:13 +0800
X-Gm-Features: AZwV_QhwiEOSfv_VV-rhFZykpWQsUlOxZ8vdhnDt5awq-fMPGViFCxBTxj6EAEk
Message-ID: <CAP4dvsfqtcE3U8ahh28NL4rttHSAk8aCyPvb3AkQ8GYMgLqw5Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix the bug of missing EPOLLET event wakeup
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geng Xueyu <gengxueyu.520@bytedance.com>, Wang Jian <wangjian.pg@bytedance.com>, 
	Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75583-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangtianci.1997@bytedance.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0018907AB
X-Rspamd-Action: no action

gently ping...

