Return-Path: <linux-fsdevel+bounces-54042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC25AFAA81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 06:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C743AB507
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 04:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41C225A659;
	Mon,  7 Jul 2025 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caFnALio"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE82ACA6F;
	Mon,  7 Jul 2025 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751861301; cv=none; b=IHz2ce81WiODiWndCA4BBwR7OYR5AnpzH1M+SK/5DHJ8wQFJ7rcC6RoCTJKMSQh3tsICBd9A8BOH+2LO6obNUIe37MPFTIHvVMSe1c7/r6Kfl2Y1f2B3RGlbqrJYAtvH4j3g9jNA/VBhQ7EyxUWs+kLMJA8I7Tx2jnxLd15hdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751861301; c=relaxed/simple;
	bh=7kljyLasa4RCWBu+oXf+zibRVKJHm1v8BYaX7xW6azg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhDGk5PJQbFRBUck2BcX16OjLQwutufmyE24C+VgPBOsYTGolm8KSJ+Rgrc2UEQEcjnLkQE/D5EfubuG/nUKYpwYRtESo1mAFGM9eERRag0E0vvANXYpu9yDWC90Z6/0+kvO6Ra9wNVQVzSBibwY6URwIrtV7xPum4BTnVWXJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caFnALio; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747c2cc3419so2104056b3a.2;
        Sun, 06 Jul 2025 21:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751861299; x=1752466099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myoakGvr/PnaCBbS7GuiApsE0/VILHenuI5anvIitlo=;
        b=caFnALioJpnnseww5z7kMJag6/9cpLry/RduR36Inoj4Zgs3tEO3sIp4rw4QnlXVxp
         nnJ8nPlhIeYdVynuzr1cv1FTYAkLMClWB0bdHWo4BuXl4TV5jx5gxZ6h3b7hZCQ2GMJy
         NRZArXklIQjfpBMtJx3r3d8HcPG7PkBxNoj5LI7kni7sWu3Z8mPZKMQYoyG/yiR6OoTe
         ZhT02uRpBMN/u9XlRWB/rmiwe9TgIxlG4CsGGJBeFNlUj6c6kCMyVV/8OK5GjQvjZPD1
         r7mS4fQ6yrfnA7xiHKQsO3OZaRPkYNxRP4aMeBqXwBermpB/UjcK01MccbBz+zKV4nMz
         LPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751861299; x=1752466099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myoakGvr/PnaCBbS7GuiApsE0/VILHenuI5anvIitlo=;
        b=a0k63iTLtMDLszOTGEcTCJze1zm/lX2AgHE+WHoBlKleuOuG93f/l+DDKuDJmSye/c
         zFJygeQqVJpfOrGv041XRUD2AwSzFVN4vGSuaXeIRtO+rgIMrLh1nnZV920KU3oHKQQW
         YgQN4L6ZhW1FQGz9UdshITieaQZEWctmY1zzHABqu4Vpz3HEfl9eDtGL2RRnnV9s7Cng
         Iv4E+U7tYf5+ZnP9TciipiffTiPPH02TuJ3seUeT5/84xloSa3MiNu6lilM9gGvbvTTG
         L+5JDFX8L23Dm2pl4FAj6cCXkCdTvkWW2Nod9l6FzRqmgi7WJFWaMC86+wa1w1nwu518
         wfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+eLzsjOIXYAjO+AC5KtvXikIQBH1djjOZ6i2TVHQVOXXGX7uqCmSSa2ZXfj8FWxGZEGdSDIaKv8e/@vger.kernel.org, AJvYcCVW1o7Q3+sjqt3pZeGddhBuJOzGQtG3pzgZGKf8MJc+iHdH6dDnlaFU19XL6DgBnePzvBQ1fMPxGxRQg5YZ@vger.kernel.org, AJvYcCWNqG0fHyM8QO9FWZErxMXZ1EbwwyccxGfOz5yAdYYwtSVVBiR2ggiioxOmMsaRVNDGFWFqxUDJRKZHEjcp@vger.kernel.org
X-Gm-Message-State: AOJu0YxKR0XptFrLnneAiIAmizg0A32PJRsdC0dia4YwujQ+tMRXTM6R
	+L5R7b2+atEXFf+M1zcUM2zhiijmAEgUEAfxhfqqAlCu7vMS5iOQNu9C
X-Gm-Gg: ASbGncumL38DSO69abFe4opx2YZDAIiwfSTeVWGMMi2UngrYw0Wtp4HD66ehvm9CoBR
	7upqPV5e25TqxZBLlo8uLj9vRpJsxULFwZ+ELhiz0EwaaqY/6N/RXx3zwsKMIXy9IFl3gci/4/K
	Ct8gqmr2S2NUFyrxuzaaikBOZDPx/HXOnpziU61kM3e0Jrb7u7YGDK+kTCahnqB2hZIRSZGPXrb
	I1SqCCAfImWIxC4vRSkLoTqe/G5LOmRHK6j9fXA3b+ySpeIQtn7t+XYCTW+5aItfLOaKHxmHsqu
	85ppBzbxMKzNqtSahR3NExJsqZZnnbUhEfX/M2pPsKNMGi4VKDOet0SxABEtekqcyzca+nqEVPY
	=
X-Google-Smtp-Source: AGHT+IHjcKlgZP5rEIcH8q8oD+vqdyt/ATNmp47t3M4RZoOFNboIAWwmALMF+gViP+z0CkL3f+aLbw==
X-Received: by 2002:a05:6a20:7f99:b0:21c:fa68:c33a with SMTP id adf61e73a8af0-227213b11c9mr11528432637.23.1751861298943;
        Sun, 06 Jul 2025 21:08:18 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce4180970sm7892801b3a.93.2025.07.06.21.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 21:08:18 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: willy@infradead.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid unnecessary ifs_set_range_uptodate() with locks
Date: Mon,  7 Jul 2025 12:08:16 +0800
Message-ID: <20250707040816.3062776-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aGa_HFAupmxO_iri@casper.infradead.org>
References: <aGa_HFAupmxO_iri@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 3 Jul 2025 18:34:20 +0100, Matthew Wilcox wrote:
> On Thu, Jul 03, 2025 at 06:52:44AM -0700, Christoph Hellwig wrote:
> > On Tue, Jul 01, 2025 at 10:48:47PM +0800, alexjlzheng@gmail.com wrote:
> > > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > > 
> > > In the buffer write path, iomap_set_range_uptodate() is called every
> > > time iomap_end_write() is called. But if folio_test_uptodate() holds, we
> > > know that all blocks in this folio are already in the uptodate state, so
> > > there is no need to go deep into the critical section of state_lock to
> > > execute bitmap_set().
> > > 
> > > Although state_lock may not have significant lock contention due to
> > > folio lock, this patch at least reduces the number of instructions.
> > 
> > That means the uptodate bitmap is stale in that case.  That would
> > only matter if we could clear the folio uptodate bit and still
> > expect the page content to survive.  Which sounds dubious and I could
> > not find anything relevant grepping the tree, but I'm adding the
> > linux-mm list just in case.
> 
> Once a folio is uptodate, there is no route back to !uptodate without
> going through the removal of the folio from the page cache.  The read()
> path relies on this for example; once it has a refcount on the folio,
> and has checked the uptodate bit, it will copy the contents to userspace.

I agree, and this aligns with my perspective. Thank you for confirming this.

Jinliang Zheng. :)

