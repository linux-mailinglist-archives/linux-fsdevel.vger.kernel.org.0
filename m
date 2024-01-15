Return-Path: <linux-fsdevel+bounces-8022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1F082E409
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 00:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9521F25255
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC31B7FA;
	Mon, 15 Jan 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clisp.org header.i=@clisp.org header.b="jopVeUAy";
	dkim=permerror (0-bit key) header.d=clisp.org header.i=@clisp.org header.b="jRq4XJZL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC01B7E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=clisp.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=clisp.org
ARC-Seal: i=1; a=rsa-sha256; t=1705361394; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XliavkFrj12YDU+f/FmSOGzzzPUhGmRb1gUq25vT+RPlCYpZh+WZhP2gobodnm0RVs
    HEFvkdzNBckyY7XYK87FRYasn/Ua58PVMiqtxN2KZmq2rSf5orFkzHy3/7gJYSGYmchA
    zjnq4TYKJduKYZD1Wk3ROV6QQdrRe9ISzunU3eG1gOk8EjJ8ou21OYIKEeRNB7sa9NKm
    srwNq2tctpzNcABMC+/2jcQK6Rj3uzg//JMxmBrU/sbkFzIz52AsAtWu+X26mFVzQvkO
    u98OHdEuzs1U1TTwP/y1qlZdKESLWs/7rZGFv6RWHfCwDOniPg/+1RqDauXmSNGmP8Dd
    qiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1705361394;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jVSZ+sBRxyHcRZh0cmL6jH/Juy+sgAHicEX0wlWr0zc=;
    b=g6wNXV0G9h5I3sonxZTxecP0why/B9O1H1tPw4cFsAp18QbQOr/4YUb0SBLOplBlzk
    AANjeK9Si6ozkkFR3GK1yoULPFwy/Cv8877ux6nlGEV/8FL7LmhoPlt7b+VMZ9T6s1VE
    W3wkWt3eW0JOZ+8fPZ/FFoBGS98GP7cMsSskcCPm7c8n7JmjwFyzoJwDagLnkVMX4duP
    N5aG28/T/lOsmZqcPlf0MQS5Mro7+XQBSzrOviJmv7urDnLDdM9K1PefEv+SR6bczbSs
    Z2I53d6JKUZFmMOE3EOrybX8bK3AR+T9mgamkZKLedPMHswkKbg8WCbAJj7uHywnU1SW
    w51Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1705361394;
    s=strato-dkim-0002; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jVSZ+sBRxyHcRZh0cmL6jH/Juy+sgAHicEX0wlWr0zc=;
    b=jopVeUAy/N+00BoZehHpLo/KBcmQApMupwOpPhs3eNFXVRXOBD9nCoCGj2hRldIEt+
    f3jyhSehrlnp+/b32RBdoJTZSk1kJrti32scx2yVdN8f2aLUPk7Oo1rjW4JtiJEYnyDb
    m16LygfXrmCztwtdpXvns/+Ur8vkdXpzi6LXXo831p/sfBrIuEEU1sTiUQw3/J870QDe
    0stWOOKqxbO/l4z6kMz+4ElyuzB97S3EiSqLfXb8ttSVp5hrvxBOKrf1q7I97u0gDCDf
    4njHtLU55vSWCkg/qWpn8wsgvq8jDG+y0HC5fElKDfJeBm3/sIrgGYe1z+UeMoW44Nik
    uouw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1705361394;
    s=strato-dkim-0003; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jVSZ+sBRxyHcRZh0cmL6jH/Juy+sgAHicEX0wlWr0zc=;
    b=jRq4XJZL5Tleb07pneqpSK3hVL+TRpDzWqFOlkVzNi8iSHrQq+y7VT3t5BdBs6/vAJ
    UTK1nDPsI6OQ9QzVTNDA==
X-RZG-AUTH: ":Ln4Re0+Ic/6oZXR1YgKryK8brlshOcZlIWs+iCP5vnk6shH0WWb0LN8XZoH94zq68+3cfpOSiKRZGkz7dVdJFqfXgrss7axLYw=="
Received: from nimes.localnet
    by smtp.strato.de (RZmta 49.10.2 AUTH)
    with ESMTPSA id c5619e00FNTsLQA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 16 Jan 2024 00:29:54 +0100 (CET)
From: Bruno Haible <bruno@clisp.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Cc: Evgeniy Dushistov <dushistov@mail.ru>, linux-fsdevel@vger.kernel.org
Subject: Re: ufs filesystem cannot mount NetBSD/arm64 partition
Date: Tue, 16 Jan 2024 00:29:54 +0100
Message-ID: <2807230.6YUMPnJmAY@nimes>
In-Reply-To: <ZaW6/bFaN9HEANW+@casper.infradead.org>
References: <4014963.3daJWjYHZt@nimes> <20240115223300.GI1674809@ZenIV> <ZaW6/bFaN9HEANW+@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Matthew Wilcox wrote:
> Wouldn't surprise me if netbsd/arm64 had decided to go with 64kB
> PAGE_SIZE and 8kB fragments ...

getpagesize() on NetBSD 9.3/arm64 is 4096.




