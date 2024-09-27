Return-Path: <linux-fsdevel+bounces-30285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B4988B9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D028B20841
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15BE1C32EC;
	Fri, 27 Sep 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9al1Z8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5B381B1;
	Fri, 27 Sep 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470514; cv=none; b=QiHzx6exabIWw/ZyKYeyk0GPkvZsdEoPfUnf42JWsbC4UmL+I1SLo1GoS2pEc13pf2Wo5CAQyrkY8WbDDRFoYX6RnaJQhwV1zXtojClzfx1GfnfflSp3g8WwQvl8NPMhkZawfOTNpN55dnTRjCukc7GOUxTmO9lDAJWtxIydixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470514; c=relaxed/simple;
	bh=Jc3nYk2509qhCNS0ikpWjFw1TBPnAAPbAzygg09FB9o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5dm6PZM8z8CISI9bX9KHp5vNd0DyEPFoFOs/z+t0U5s5mkoeQwPnl74Ao5142KBDyXAxpNBdr+t8z4LCzVTCcinqXNqkuPQHjjNMDvDdSGTY/IYUrLwoeok+M84+Qr4BUoDgHB/jYo6v5x7CyaDwm9VYg+5SAC9iJB+PgoxGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9al1Z8u; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db299608e7so1802465a12.1;
        Fri, 27 Sep 2024 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727470512; x=1728075312; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jc3nYk2509qhCNS0ikpWjFw1TBPnAAPbAzygg09FB9o=;
        b=E9al1Z8um3Vq9KsC7hYsKbKzooR/ZYttvbb1e7LA68h8euRBQCKfhe7YMypL6mX44/
         bg5qObcHqVj535eHuGlf/bPXV2yEK3z4fK1HuYv/J7keYhqC7C85kTWXYU/DO2OOSeZD
         Hn0UOUOv1+5kieqB/wVehvDkSGK4sXnADtECTxsZAHH1jck7LDly4GblGGWGv5AEk+lb
         AUraLq3bYcWk3075YgwbR2kfoS0SSAVmSt3j+z+9VDfV2TZvvFSfLi2T6y0uLhLVxpUp
         gqYODITxjhis845iv6L5zJqBPs4jgMcdfqwD4sY6Rpu6lD23/lOqBe8tIDE5BEBTEcz+
         ARAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727470512; x=1728075312;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jc3nYk2509qhCNS0ikpWjFw1TBPnAAPbAzygg09FB9o=;
        b=ehhMK8KiWr2BQMxRJ5+xdN/wvRhbPbgX3rFf0ANIt8ZowlJD9PbGJjiJjOz0sqmybm
         I5UGa5+HNxXc9ByFlt1Nq1YIgS25AeID+S7u6WPZmuDaMS4rQ19p6pnuBHmbRnBVCzoV
         6GVngEFmPYb92otjI38uAXoE6SV4Q/qtwGRtnrTwnvJllxbT9i2TTG34lGkSO+ZzAKKY
         pXDBmvIkuvlopI3XodTWBah6tuVAfD5HAMDGhZBE2vHBtZ6QHbMw2/UZU7t+TbUyzmNu
         J5Nt2+FzeGSMPRyky8HdKhLHrGfhoN1+yK4821q7mfdQBtoY3DH5PiqgOATBKsf0d35t
         0PpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1McwMMwNoyo03DwCjaHzAtYf1W6sIy8kLGh+zE6LFYSr0y/p22DdWIuHl6u84/3Zy+KCSE9muHpcdkA==@vger.kernel.org, AJvYcCUlnWB8pw+DDfXjnqU1WLtlgq/6wjGnD0WcIdZnlVOIW435XF+iiUXBRdp4loPI7TgzPd+YRPupCr5RePN3@vger.kernel.org, AJvYcCVZjIPiI+nG8Hfk9rQy0Eow5UU2SmgY67aF0mdV/rtLGuXxiYqIt/AUcY+gZD1aidKkQEyQRnY3@vger.kernel.org, AJvYcCW5C9Y8TTbAgU1/f5YWpmEMp05ysvRCvhcOLDwUGJOjaV56aD2cO15ipAyX+rrCjrH4Cd+33w+y8zYy7zVbLQ==@vger.kernel.org, AJvYcCWWUJdEIOMihz5s2yUv4trcK4cHpQfBTGPusULkbHZNqOfDZ3OlpuU9B2vvlNaTtyPtrourXWWHrM+l@vger.kernel.org, AJvYcCWv3JJnKCdeve/kLSrC9AbHNmYBvib2gkAFcev6lKgcjqC3w6fiUI3kIMAxB/MH3MTn3flzU7aTa6c4@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZ06SEy/+MhH+4trAcBlB3lcgCfO9phiVA0EiO2yR66W0cxDn
	z4RoN3/TLPUF84WUeOQrtJ20tomoaK63ChVCsvLMtuD593FBnKyw
X-Google-Smtp-Source: AGHT+IG97WQ0sKf6nP3kVcYM7xIWbrZHObvDCRA4X7I+pJRt7WQ0LRz1ytlfbrB+m9K1oZ0O2AT5Aw==
X-Received: by 2002:a05:6a21:1690:b0:1cf:4422:d18b with SMTP id adf61e73a8af0-1d4fa694d0bmr5811129637.14.1727470512137;
        Fri, 27 Sep 2024 13:55:12 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26536b46sm2025461b3a.193.2024.09.27.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:55:11 -0700 (PDT)
Message-ID: <55cef4bef5a14a70b97e104c4ddd8ef64430f168.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>, Manu Bretelle <chantr4@gmail.com>
Cc: asmadeus@codewreck.org, ceph-devel@vger.kernel.org,
 christian@brauner.io,  ericvh@kernel.org, hsiangkao@linux.alibaba.com,
 idryomov@gmail.com,  jlayton@kernel.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,  marc.dionne@auristor.com,
 netdev@vger.kernel.org, netfs@lists.linux.dev,  pc@manguebit.com,
 smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
 v9fs@lists.linux.dev, willy@infradead.org
Date: Fri, 27 Sep 2024 13:55:06 -0700
In-Reply-To: <2663729.1727470216@warthog.procyon.org.uk>
References: <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <2663729.1727470216@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-27 at 21:50 +0100, David Howells wrote:
> Is it possible for you to turn on some tracepoints and access the traces?
> Granted, you probably need to do the enablement during boot.

Yes, sure, tell me what you need.
Alternatively I can pack this thing in a dockerfile, so that you would
be able to reproduce locally (but that would have to wait till my evening).


