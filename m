Return-Path: <linux-fsdevel+bounces-18518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069848BA134
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52D4284229
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6A51802C5;
	Thu,  2 May 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WQ5ApR9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0E17F37D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680034; cv=none; b=q2nEwZ+4rmTUelOBKvm+xIhr4yeMdCXTcNJ9O4OeUFsaCuZbVzTurZ2T/9JE68YLtZI3ENOQP9di8fJ3Ukac1shdj367FGxUfsuooJCHGdhqM+DCpgnrM+hQHu0ffboFOmBOS23FXrZ/bV7Q5imD2iNVy1zXrqv6xVYzKjtke90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680034; c=relaxed/simple;
	bh=Dz2IS0uGk6KutXwNxxDqdcyx+6SIcL3NOrPBHVlDXX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfLZbRLnuNfII6rgF1Qzd6s6Rll2pwi29I4LI9Tf+8us9C7bapUMhd+yqiYyMiI8lcnFYqPZRvAg5LhNVHT69VvNkwBp/Fg9MdYVaEmZ1wwFxfJz8AcoHuV0hITuQNd+SATwulEgkt4lwhdUJuMJBkyyrlKHsr+HoObawBQUr2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WQ5ApR9V; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 442K0D20006122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 16:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714680015; bh=sb24B9BC3hrQGO6UpuPnK7K5k0AjijhW9KmUQ0N9vUQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=WQ5ApR9VlXqHdlJrMhEWGqwvGNAzTn7wmDToPhF43E//AQGQv5Hyf6TfeaSsi8OK0
	 y+RwAIuhxL975zvpk96yutr8BiiwDKKeHNgBTU5e51pKuP8uqtyKxLGa/Og1+iTyzq
	 mSROkQVzy6Imqi97Sm1RxCP8KG2vd9oSjFF2XSW0yuKy6qVHho0u39Yqs7lQUN+cEP
	 gZHxRp9v+c5XayZTaILEt+eFlkV+bUAOIc3f3Bh/oAzGsGw8URfaXkqCJDWeAX37OD
	 Y4As/kwbeTYIRwH/4BKC8/qMfGyAfnJhK8nkPYfxs0D0ISOI4WzJ35HQvuYIbdl2+7
	 D0gxOjaGA+iJw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AB09815C02BD; Thu,  2 May 2024 16:00:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: torvalds@linux-foundation.org, Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/3] bit more FS_IOC_GETFSUUID, FS_IOC_GETFSSYSFSPATH
Date: Thu,  2 May 2024 16:00:09 -0400
Message-ID: <171467920458.2990800.13769245148014938392.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315035308.3563511-1-kent.overstreet@linux.dev>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Mar 2024 23:52:59 -0400, Kent Overstreet wrote:
> implement FS_IOC_GETFSUUID, FS_IOC_GETFSSYSFSPATH a bit more
> 
> also: https://evilpiepirate.org/git/bcachefs.git/commit/?h=bcachefs-sysfs-ioctls
> 
> Kent Overstreet (3):
>   ext4: Add support for FS_IOC_GETFSSYSFSPATH
> 
> [...]

Applied, thanks!

[3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
      commit: fb092d407262eb4278f3d1ca24da54396a038c62

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

