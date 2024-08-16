Return-Path: <linux-fsdevel+bounces-26120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB62B954AE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 15:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC870284421
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027911B8EB2;
	Fri, 16 Aug 2024 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b="kDfBHp3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hotelshavens.com (mail.hotelshavens.com [217.156.64.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC401B3749
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.156.64.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814466; cv=none; b=DHAB1G4GCxwQV3+hxR3PfkB6q8fkq8hGNlC/1E6swjuKF+R6ZKowhPN5YL3zDR5s3o8zUuFpfQ3153XrugH1M1Xe8m2sKENQjAO6fnPGrRwagoMvhvRZuozDfzZVhThiMT7pOu2PFzsXNSkbnAAFipMBPzk/HZVW2jfDWuqNF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814466; c=relaxed/simple;
	bh=R+/mL+AZNZBl+rs0Z3enFS+DnnA8mRB+nLyzScAuY9I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ndaOLXfAZqjGCWk/2APq5LdSoBtJr+0+86UXZJlqIPg+lcClAmc6PDE2dh97WLDa++BOabNPizFL9nsUG6IoKfY5v9oc8O1lwEdaqnBBFYeAM/+ZcB/GBoTs9J5/HWreV8Qi8cCxujtNmgzXWSSdbXeA8vY9mtLo7CoK1U/HKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com; spf=pass smtp.mailfrom=hotelshavens.com; dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b=kDfBHp3b; arc=none smtp.client-ip=217.156.64.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotelshavens.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=dkim; d=hotelshavens.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=admin@hotelshavens.com;
 bh=R+/mL+AZNZBl+rs0Z3enFS+DnnA8mRB+nLyzScAuY9I=;
 b=kDfBHp3b3CDupWu5WKofjQfdPiaFOid72FucP8rbM65Af1IazrXB3BFef0DBRJ/mBPhNZVel08Kh
   rpcBGLHK1UiuSCAI4SFb4oNBdzWDtLbH811jDXfhrNOgix7I8pAsiMt4iEBCcE8eaU7BEnOjZKJR
   DCFAWG5a/yDRf8H2Y6Vp39LQgyg9oh5RizPmyQ45cCGmI38iLeWAtjWN/h6X9U6GJZ05YP8dIf/3
   QWTbT2Zx7IxkqduBkBGWhMpQBvZweSStPsRMADa5/Z7N1nwRLl0asBxAofJ0cu2ofl93NF9m2Gnl
   C0iySiDhii/7c1aJOMmr7leaMbLbsIWS1fj1snCFQe29wDX+T6fLLsnD4YnWcrdS460kDeKMh9zB
   XzE6WpoSpPmyKi8AoJiTxNAR727Y0hAGkBPhx2AhIYmqwihY2GR2xtIixLJJIEYs6uO9ZcfO1NgL
   wAyyi7RlxXOD4R3h6wCh/kQ9vtu4xBgKcZzmW9FlTq47ilMM4YJ2GUtKzUu+YywMIgWq3hQUgTC+
   pM7lWIdC/mgMByMs2EO/bo6jluJ+2EjgLpToSGQb0naVqAqiVa/RE4FPfdPwwdVqxUheB07aSwvU
   wbTE8oigrHCRwSmT7BOd0mwXQOgYL9aWvI28KmiMrsg9xin3nCV6DIILOGuK4iTfN7UfsG64kjM=
Reply-To: boris@undpkh.com
From: Boris Soroka <admin@hotelshavens.com>
To: linux-fsdevel@vger.kernel.org
Subject: HI DEAR !
Date: 16 Aug 2024 15:15:39 +0200
Message-ID: <20240816134828.0CE7C5C5F85E24C6@hotelshavens.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

Did you receive my last email message I sent to this Email=20
address: ( linux-fsdevel@vger.kernel.org ) concerning relocating=20
my investment to your country due to the on going war in my=20
country Russia.

Best Regards,
Mr.Boris Soroka.

