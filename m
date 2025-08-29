Return-Path: <linux-fsdevel+bounces-59646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4971CB3BA1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271B01CC0CA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0C2F3636;
	Fri, 29 Aug 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="cdvBIAvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A8229B1F;
	Fri, 29 Aug 2025 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467970; cv=none; b=VIPOcLUyM61YgQ+DQEItoQV2aX5YzKsVynD6ZLdgYODaFVNrB6ZGSqIz10UPgsQSXisZpt/a+q4myaERl2Iw+bti2WdIITXPlFNNSgQPUZXYkY1gUgFLqwY944bJO9Odj0UaymqzDEQH+6sjWxVa+A4PDwPoj/uwL64SEyH3hDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467970; c=relaxed/simple;
	bh=smU766VbQ+pM3zkuP6JoCdhWrVk6Pk5H2G1/VDlBCMQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JWN/2Bu4YAO6gTP5L8/VPRZhNgXWnmPWESedbNNOuWxa5Cf9E4GnQoXkJkxMqrYwh3WlUyzV5k5JiNNYEsdJl8unAsfd2xHeCJhGMC5oG1kYSzwtEAfMl2w+YnHnojZf3O8EK8QQCOHSiWQxdfwTX+wc/Bc6FPLoz8+VGLHkIXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=cdvBIAvO; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id B82E6406C3E0;
	Fri, 29 Aug 2025 11:45:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B82E6406C3E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756467957;
	bh=Cw7k7v8FKc4ViOmRuKB7D0bz9R6W4Hds1d7CD/V9OEA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cdvBIAvOnJa5rJMO1SsvOv1Wg6fZ6enLl/Q341aS50UtgKloVeYtRtbuq4yja4WRx
	 r14xExKqZCO9K33+KSV8TXNa8XuQClmJAyjWATeO8Gb+E1i6MHYrzfTrdAJs7VR7eJ
	 12ARNLsbAxGNIKCGsrPJtLrCDKpcehOM1cfMmNi0=
Date: Fri, 29 Aug 2025 14:45:57 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Christian Brauner <brauner@kernel.org>
cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
In-Reply-To: <20250829-therapieren-datteln-13c31741c856@brauner>
Message-ID: <9d492620-1a58-68c0-2b47-c8b16c99b113@ispras.ru>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru> <5a4513fe-6eae-9269-c235-c8b0bc1ae05b@ispras.ru> <20250829-diskette-landbrot-aa01bc844435@brauner> <e7110cd2-289a-127e-a8c1-f191e346d38d@ispras.ru>
 <20250829-therapieren-datteln-13c31741c856@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Fri, 29 Aug 2025, Christian Brauner wrote:

> > > Even if we fix this there's no guarantee that the kernel will give that
> > > letting the close() of a writably opened file race against a concurrent
> > > exec of the same file will not result in EBUSY in some arcane way
> > > currently or in the future.
> > 
> > Forget Go and execve. Take the two-process scenario from my last email.
> > The program waiting on flock shouldn't be able to observe elevated
> > refcounts on the file after the lock is released. It matters not only
> > for execve, but also for unmounting the underlying filesystem, right?
> 
> What? No. How?: with details, please.

Apologies if there's a misunderstanding on my side, but put_file_access
does file_put_write_access, which in turn does

  mnt_put_write_access(file->f_path.mnt);

and I think elevated refcount on mnt will cause -EBUSY from mnt_hold_writers.
Which is then checked in mnt_make_readonly. I expect it affects unmount too,
just don't see exactly where.

(basically as remember non-lazy unmounting a filesystem with open files errors
out, right? as well as ro-remounting when some files are open for writing)

Alexander

