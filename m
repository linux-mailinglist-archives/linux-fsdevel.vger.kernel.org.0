Return-Path: <linux-fsdevel+bounces-49946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC9BAC6194
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993701BC03C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 06:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AD121147A;
	Wed, 28 May 2025 06:07:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A49D53C;
	Wed, 28 May 2025 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412457; cv=none; b=ZJY/X1hKNdFX3gPRV8QRFflPIoRsKB9pJ/RNOPMcPYGuUQTfSuNQEMkVp1Xn/sZJrO5+yeOez/M6dJVuEehmVKhHW8nGC998HizV3tesHgaoeO7k/Q8xs8tKbdA7hz2OU8PvY48cDiVCctGyWZ6KUc0V5ybQlZ3+C9yQlaewqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412457; c=relaxed/simple;
	bh=0eeyiMm8PSjk1e3e3J370/EICWfoD7N86Wv/+6uPxV4=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PPu01FHYJNB9gS223waERANhouf9kT0o4VwHEOHj5x57zs/SZo/fmgyv9TPTRarVNltxMV0Ofn+deOjwNgiMqFjX0Y3G4OEyd8gMpQN8C6/4AjaCDgfZM/K9memABCDVbfdMbPnL8IaGozpAToLuASH8+P3q94mvhpOQRL9Pmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b2e8559.dip0.t-ipconnect.de [91.46.133.89])
	by mail.itouring.de (Postfix) with ESMTPSA id C2D8AC939;
	Wed, 28 May 2025 08:07:33 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 8F90E60191E20;
	Wed, 28 May 2025 08:07:33 +0200 (CEST)
Subject: Re: [PATCH v2] eventpoll: Fix priority inversion problem
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
To: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org,
 Joe Damato <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Jens Axboe <axboe@kernel.dk>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>
References: <20250523061104.3490066-1-namcao@linutronix.de>
 <3475f3f1-4109-b6ac-6ea6-dadcdec8db1f@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <4df97d81-cbea-4fad-66a5-28202903775f@applied-asynchrony.com>
Date: Wed, 28 May 2025 08:07:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3475f3f1-4109-b6ac-6ea6-dadcdec8db1f@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-05-28 07:57, Holger Hoffstätte wrote:
> It seems the condition (!n) in __ep_remove is not always true and the WARN_ON triggers.

This should of course read "not always false", sorry.

-h

