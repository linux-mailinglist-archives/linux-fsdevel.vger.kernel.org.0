Return-Path: <linux-fsdevel+bounces-56375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB7DB16E45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D85958325B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714029DB96;
	Thu, 31 Jul 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH9Gm8GD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795B14885D;
	Thu, 31 Jul 2025 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953281; cv=none; b=BxnvzlcQo3GIBIVR1jvHswIjvBPdajEPE8eyN0t8ycG0vhaHefMQ+9mHVUvu4HW8q0dxYzE+bZnQEE9hYxB5DDxLS2S9T378Hg/W0DhoYoCawp0xQUm3fRoa82MVS7lTRtO42aOMoCvEQuKVgKvcQSzXen8ZNR5ZkXTUt8q8vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953281; c=relaxed/simple;
	bh=ZZiAY5xnw9jRJ7RHtCbZkPMOJmYquQ1Nqg60SvN2EJE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=pq6DnEhjwVvkGgqsNHjnCn+SO82hrxbdWtQsf4NlUnHlyb9gRHKWkoGSObbTVlUygcTikhoEUcFOT9O/sxQyJoHpZBKgom/cbK7bI8ZguQlbSLh/vK7gMQ/gKPNaGdJEhtw4G7vTtKN65Qr2qq6v+TPPUpvDcTekABEmiWeMJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VH9Gm8GD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23dc5bcf49eso10342965ad.2;
        Thu, 31 Jul 2025 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753953277; x=1754558077; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1QkiO1opBKNudPm4DVYJxOkJ+RH+MAuDqfKwuaQlKak=;
        b=VH9Gm8GDxUtVKLvheAe75tL4pyzw7Wx2goxS+UKX+FIrw1Ff5zD2Ix0fYfMx9sb5v3
         jkGRn0Z5orkOQ2vdTg3A66qFhYHJ2xfEQhcuXAjsgR9qtVhx+xwu4cyA+taECtty7vZJ
         8x0tIi1lG6kD9RZVzPa+rjwdmcpUuCqZT5k47as3OUYeJCjhQuHN7q0Xwo3lMu5bEnwv
         UCuSTVuODdePes0g1O+pf/f23F3BCGYQrALSJbwOKbQ8yOZMXn0nCmQAu4NXO5gwmAN3
         pILZwtVXWVYRqLBoPLAS6oCaHJ8AWCKHMcaQzpF5eOCeC3prpr4cgtPBDK+Ek+P8ehVu
         9WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753953277; x=1754558077;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QkiO1opBKNudPm4DVYJxOkJ+RH+MAuDqfKwuaQlKak=;
        b=PSmd7JMjkBnKSQ5aIFw09JJnMaNGV7gjaKux3IQI0ZDl3uHdux59qAoJXZ4dQEVxvR
         7VQepPgLiTZNWfO2wUdCCJDYDHx0W+N6VMpgFlvJPc3tUdvsY1UYSHk/Fd8UcrJuTONS
         kMECQk5sRc27c+/M0pbgp5q0aJNwdYMa5Fzk/slala2uZMl8bgMYXRFnS1mu9zcUXhij
         DfweM1S/F8FranZ62LPSfVVyoIXt+VrFIeutvp7D15dQ0oUftrM58W+BwK4cvkLBGmuW
         hKUp93RCaP2ysvBlhKiG4o7rNUFQyIJArpZLnzL28ret4ajibTS0ZJEHfEjOSSANBdHK
         0j5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8s/LYMIYcqZeVHnqcv8Y8vDgDzzRRv9A2CYqbMI4heRawdErMB+M+oogoyr0/TjS15fWRxbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywahrfw8SpmTsAnHF3a1xAyKwHmUEHoDFhI3ucshLPhK1VWuv8n
	zjxnNjcDny2wPLgAHZaect7d2QW8DXCFLhv+4reUeiPhZaYI/ZG7nuIb4zbGubfK
X-Gm-Gg: ASbGnct1EOi/JZowW4u0UKdRd2VBAEwQQKZMWdrjvYJCzPobdvimi8qwgknqD1yh4JW
	r6ZaE/vJZIzZ69HdsazyD3mGEj2I2y0B5ix32bT6ZW/IyRljqZnRg4Oh+GsNKcp1xSZaSjq4aiY
	o06kmtKVAT393x1YJOf33bkZhwCAyiUV94SW6Inry2wTbayXr2QnrLEN+Y3vSzno4TMrPtwq11P
	B1BwQQW4+CjYvP2apWy20aI+bq7KoEoo4PiZSb2XdosAFeJFZbQo+OQr6h2c1Gc51M38jG3ixQj
	+82wpkM2Q0ajqXzvovpSCrEuXQc6MMEu/i5JbAU1KalwezCOTq3GjB39J14E56dSGelmmfCYJqx
	HtN49/mmBHR/e5dU=
X-Google-Smtp-Source: AGHT+IF1V2bL0Y0Fv6L+0I4stEiip2tMvLw4sZjsHFFkTNIrWKbwf02b4+XoSC1p8U34YOE3ZvKqAQ==
X-Received: by 2002:a17:902:d4c1:b0:240:3f36:fa78 with SMTP id d9443c01a7336-24096a97f96mr109235975ad.21.1753953276854;
        Thu, 31 Jul 2025 02:14:36 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8ab0c40sm12440175ad.180.2025.07.31.02.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:14:36 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix broken data integrity guarantees for O_SYNC writes
In-Reply-To: <20250730102840.20470-2-jack@suse.cz>
Date: Thu, 31 Jul 2025 14:35:10 +0530
Message-ID: <871ppwspbt.fsf@gmail.com>
References: <20250730102840.20470-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Jan Kara <jack@suse.cz> writes:

> Commit d279c80e0bac ("iomap: inline iomap_dio_bio_opflags()") has broken
> the logic in iomap_dio_bio_iter() in a way that when the device does
> support FUA (or has no writeback cache) and the direct IO happens to
> freshly allocated or unwritten extents, we will *not* issue fsync after
> completing direct IO O_SYNC / O_DSYNC write because the
> IOMAP_DIO_WRITE_THROUGH flag stays mistakenly set. Fix the problem by
> clearing IOMAP_DIO_WRITE_THROUGH whenever we do not perform FUA write as
> it was originally intended.
>
> CC: John Garry <john.g.garry@oracle.com>
> CC: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> Fixes: d279c80e0bac ("iomap: inline iomap_dio_bio_opflags()")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>


Nice catch. It's been there since v6.15 I guess. Looks like it didn't
get caught in xfstests either then. 

We have generic/737, but looks like it only covers O_SYNC dio writes. Let
me enhance that to cover O_DYSNC dio writes too.

Looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

