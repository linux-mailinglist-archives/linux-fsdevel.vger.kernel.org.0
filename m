Return-Path: <linux-fsdevel+bounces-47281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6F6A9B4FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 19:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66ADD1BA3D21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3E628BAA0;
	Thu, 24 Apr 2025 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="fueBOrvY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5828B4ED
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514554; cv=none; b=vDZm0EBlEI/NzE8SJD/Nl0vJ5Y4tmWMt44sYdzr2p8EjY2gZYwuoDxbGCZa+Y353TqeOZwbLvBZNDw/PtTAwIqMxnNJylv2lU5MVfgPqdpmhZjrUOaxY+cEIv1x881dle/0ioyXnftWFzu0z0myaqnB8OtqevGFpQhviUo9hFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514554; c=relaxed/simple;
	bh=gEtDxFoBg8UfBDSO4bw9bE+SefRpBudTlY+cXC2gICk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RBjZzauCe0nPsjJwfIg2cQw3mvPFO/4yUWBH+oO3/4TRPQk3m5a880IlYu4z72vPOanAeYWzB6pSpA31Etu3yMBU+CrzgnFmW4LtB9YxFtle6wZvBIBL0k8UAp7im47spDUyFLDpxy33fo1chdIb4rPyk1Xqzcr0tFuDFyXSVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=fueBOrvY; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2d0364e9231so360288fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1745514551; x=1746119351; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ofCPIfZ9+EaMvkffgBsxaUmBvz1zhM005x/Hz0AKCjM=;
        b=fueBOrvYqKetGFsJP4KnEO5/AldR+xrC4WKSiE2mnjuhrGeV8T1ZkpryJNIVjBlmeH
         c/jKZT8KbqRWLd4ltFJ1H+gRc3e/iShw/kFOgBX17bl8LG9icDdmsj//UdgxBEMBopXU
         KeSXaeC8gVb/Z7xuiKzDHcWYij5EMmxAIp9KzIQWQEJBex+ghmrfx8aTxaczheJs3siz
         rAHHVyT+zee+0ru88skM2lNBdGEPSqz/9io6iKqksaC0CCx9sn3Iqqb+zhoakIjusEb1
         srb+pkHpR133Qv1WQ0O3Rwo0IFGpYN0kzeeBFMMYshf1LgZbgBTxYGZekIpUKmusRcaI
         aQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514551; x=1746119351;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ofCPIfZ9+EaMvkffgBsxaUmBvz1zhM005x/Hz0AKCjM=;
        b=wf0p3trb6Mpt8kFV3X79lRgPxSeQ+nsGSJBKnTY87kc1RqOrbDL8wVY+h+LTHAyz8+
         CxUo7BghDQ6QCJPYdO5eRspZI/9DjTmaR445Wu2GVGSxeLbUBDBbhCx6mvRl0HbIVwjo
         QLOG4jU/qyaNNDEHd6C53KmXg4vQcN2iMYBL/Hy+nM8Ot7XUJlsAiE6HnojLdb3jQkrl
         N5ewN0QC4D+ULkl0QV0RNE3RwM1+EJ2FwNyU4BGdHervR8fLeBaTYNKTDnF8XKChH+nG
         kBqahXBD/Q4NztvMqSKDjgJmOeOlW+/VamB9WR9dGlENgRslHQoQ6M0PJbwV9p95OMLG
         gveQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaP8LZo07DYTz2P0wM/fxpmmfwgxvDGRCwsfLs2dPq6igPvRDJFKh19NvPyvrT1kR6TjZHmRNAVZMlHTyl@vger.kernel.org
X-Gm-Message-State: AOJu0YzET6GKdI5XHeXqPYx5bhJrIFqUATv/n9+Y8XbGE3N6zX/4sbk+
	m/EdoEzHZULCDJc4xegddOITBtNo79g/o9+/UNhgUygA9f9GACcWfa0zablv5JI=
X-Gm-Gg: ASbGncvfmQ03PduAR37Ai/qJYl+c3pSRWoKrs4dlqme5DH5fDYBj32cU6n2YRE/TIql
	dbxKhrt99z3ZAFMZbZf1jcFj8x5FGv/o9+ShbPYurDBOeOBjxfP9+h47d5i/9L19YdQzm/2Myij
	/eOtFunxgmlwFCW1n7j8alxCxIxC2tKHTuJDPJjQgvWqKnoivTMwxajVYtX8E559d+JHv8TVsCX
	3P6JVULjP9nwiugGNwbpC3/Wdb6vuVDRWB1K+ai2hIx6qyE2yffYWcj0aoAOUzvlePPKHqIO3yc
	TO/Xqghi57BIHL6snuOU7Ti2YDPMEKKFLUqNb5ZI2bDgRNjH5pzMdlxWv2RoTBeqVBnGgZp3eJX
	0qyqqTG9WUJBwwKp3mw45
X-Google-Smtp-Source: AGHT+IHfzbOWHwKui1OabrAXGYjzr2d5ISFlGjRQ9EY5vBkPGAITE6m4rnPc7L4SfKgrMN17NIkJWA==
X-Received: by 2002:a05:6870:47a7:b0:2d5:cb3:6b1c with SMTP id 586e51a60fabf-2d96e29c5d7mr2206372fac.14.1745514550731;
        Thu, 24 Apr 2025 10:09:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:a7d5:84b:f3e6:719a? ([2600:1700:6476:1430:a7d5:84b:f3e6:719a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d9737e73b7sm376254fac.26.2025.04.24.10.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:09:09 -0700 (PDT)
Message-ID: <e22924883f6feca167571f472076294232d5addf.camel@dubeyko.com>
Subject: Re: [PATCH] MAINTAINERS: hfs/hfsplus: add myself as maintainer
From: slava@dubeyko.com
To: Yangtao Li <frank.li@vivo.com>, Slava.Dubeyko@ibm.com, 
	glaubitz@physik.fu-berlin.de, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: dsterba@suse.cz, torvalds@linux-foundation.org, willy@infradead.org, 
	jack@suse.com, viro@zeniv.linux.org.uk, josef@toxicpanda.com,
 sandeen@redhat.com, 	linux-kernel@vger.kernel.org, djwong@kernel.org
Date: Thu, 24 Apr 2025 10:09:07 -0700
In-Reply-To: <20250423123423.2062619-1-frank.li@vivo.com>
References: <20250423123423.2062619-1-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-23 at 06:34 -0600, Yangtao Li wrote:
> I used to maintain Allwinner SoC cpufreq and thermal drivers and
> have some work experience in the F2FS file system.
>=20
> I volunteered to maintain the code together with Slava and Adrian.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> =C2=A0MAINTAINERS | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b8d1e41c27f6..c3116274cec3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10459,6 +10459,7 @@ F:	drivers/infiniband/hw/hfi1
> =C2=A0HFS FILESYSTEM
> =C2=A0M:	Viacheslav Dubeyko <slava@dubeyko.com>
> =C2=A0M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> +M:	Yangtao Li <frank.li@vivo.com>
> =C2=A0L:	linux-fsdevel@vger.kernel.org
> =C2=A0S:	Maintained
> =C2=A0F:	Documentation/filesystems/hfs.rst
> @@ -10467,6 +10468,7 @@ F:	fs/hfs/
> =C2=A0HFSPLUS FILESYSTEM
> =C2=A0M:	Viacheslav Dubeyko <slava@dubeyko.com>
> =C2=A0M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> +M:	Yangtao Li <frank.li@vivo.com>
> =C2=A0L:	linux-fsdevel@vger.kernel.org
> =C2=A0S:	Maintained
> =C2=A0F:	Documentation/filesystems/hfsplus.rst

Acked-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

